 
import torch
import torch.nn as nn
import torchvision
from torchvision import transforms
from PIL import Image
import streamlit as st
import random
import mysql.connector  # For MySQL integration

# Set random seeds for reproducibility
def set_seeds(seed_value=42):
    torch.manual_seed(seed_value)
    random.seed(seed_value)
    torch.cuda.manual_seed_all(seed_value)
    if torch.backends.cudnn.is_available():
        torch.backends.cudnn.deterministic = True
        torch.backends.cudnn.benchmark = False

# Device setup
device = "cuda" if torch.cuda.is_available() else "cpu"

# Step 1: Get pretrained weights for ViT-Base
pretrained_vit_weights = torchvision.models.ViT_B_16_Weights.DEFAULT

# Step 2: Setup a ViT model instance with pretrained weights
pretrained_vit = torchvision.models.vit_b_16(weights=pretrained_vit_weights).to(device)

# Step 3: Freeze the base parameters
for parameter in pretrained_vit.parameters():
    parameter.requires_grad = False

# Step 4: Change the classifier head
class_names = [
    'Bacterialblight', 'Blast', 'Brown Spot', 'Hispa',
    'Leaf smut', 'narrow brown leaf spot', 'Rice__healthy',
    'Sheath blight', 'Tungro'
]
set_seeds()
pretrained_vit.heads = nn.Linear(in_features=768, out_features=len(class_names)).to(device)

# Set model to evaluation mode
pretrained_vit.eval()

# Define image transformations
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Prediction function
def get_pred_label_prob_and_image(model, class_names, image_path, device):
    # Load and transform the image
    image = Image.open(image_path).convert("RGB")
    image = transform(image).unsqueeze(0).to(device)
    
    # Make prediction
    with torch.no_grad():
        outputs = model(image)  # Model output
        if outputs.size(1) != len(class_names):
            raise ValueError(f"Model output does not match the number of class names: "
                             f"{outputs.size(1)} != {len(class_names)}")
        probabilities = torch.nn.functional.softmax(outputs, dim=1)
        class_idx = torch.argmax(probabilities, dim=1).item()
        prob = probabilities[0][class_idx].item()
    
    # Return predicted class and probability
    return class_names[class_idx], prob, image_path

# Function to get prevention and symptom information from MySQL
def get_prevention_and_symptom(disease_name):
    try:
        # Establish the connection to the database
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='rice_prevention'
        )

        if connection.is_connected():
            cursor = connection.cursor()

            # SQL query to fetch disease prevention and symptoms
            prevention_query = "SELECT disease_prevention FROM pest_control WHERE disease_name = %s"
            cursor.execute(prevention_query, (disease_name,))
            prevention_result = cursor.fetchone()

            symptom_query = "SELECT Symptom FROM pest_control WHERE disease_name = %s"
            cursor.execute(symptom_query, (disease_name,))
            symptom_result = cursor.fetchone()

            return prevention_result[0] if prevention_result else None, symptom_result[0] if symptom_result else None

    except mysql.connector.Error as e:
        st.error(f"Error connecting to MySQL: {e}")
        return None, None

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Streamlit App
st.set_page_config(page_title="Crop Disease Detection", page_icon="🌾", layout="centered")

# Add custom CSS for styling
st.markdown(
    """
    <style>
    body {
        background-color: #f5f5f5;
        color: #333;
    }
    .stButton > button {
        background-color: #4CAF50;
        color: white;
        font-size: 16px;
        padding: 10px 20px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    .stButton > button:hover {
        background-color: #45a049;
    }
    .title {
        font-size: 40px;
        font-weight: bold;
        text-align: center;
        color: #4CAF50;
    }
    .response-box {
        margin-top: 20px;
        background-color: #2b2b2b;
        color: #ffffff;
        padding: 15px;
        border-radius: 10px;
    }
    </style>
    """,
    unsafe_allow_html=True
)

# Header
st.markdown('<h1 class="title">Crop Disease Detection 🌾</h1>', unsafe_allow_html=True)

# Upload image file
uploaded_file = st.file_uploader("Upload an image of the crop:", type=["jpg", "png", "jpeg"])

if uploaded_file:
    # Display uploaded image
    image = Image.open(uploaded_file).convert("RGB")
    st.image(image, caption="Uploaded Image", use_column_width=True)

    # Prediction button
    if st.button("Predict Disease"):
        with st.spinner('Predicting...'):
            try:
                # Call the prediction function
                class_label, class_prob, img_path = get_pred_label_prob_and_image(
                    model=pretrained_vit,
                    class_names=class_names,
                    image_path=uploaded_file,
                    device=device
                )
                prevention, symptom = get_prevention_and_symptom(class_label)

                # Display results
                st.markdown(
                    f"""
                    <div class="response-box">
                        <h3>Prediction Results:</h3>
                        <p><strong>Disease:</strong> {class_label}</p>
                        <p><strong>Probability:</strong> </p>
                        <p><strong>Prevention:</strong> {prevention if prevention else "No prevention data available."}</p>
                        <p><strong>Symptom:</strong> {symptom if symptom else "No symptom data available."}</p>
                    </div>
                    """,
                    unsafe_allow_html=True
                )
            except Exception as e:
                st.error(f"Prediction failed. Error: {str(e)}")

# Footer
st.markdown("<p style='text-align: center; color: gray;'>© 2024 Crop Disease Detection App</p>", unsafe_allow_html=True)

