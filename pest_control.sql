-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2024 at 10:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rice_prevention`
--

-- --------------------------------------------------------

--
-- Table structure for table `pest_control`
--

CREATE TABLE `pest_control` (
  `disease_name` varchar(255) NOT NULL,
  `disease_prevention` text NOT NULL,
  `id` int(11) NOT NULL,
  `Symptom` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pest_control`
--

INSERT INTO `pest_control` (`disease_name`, `disease_prevention`, `id`, `Symptom`) VALUES
('Bacterialblight', 'Use resistant varieties, avoid excess nitrogen, ensure good drainage.', 1, 'Bacterial blight syndrome exhibits three types of symptoms: leaf blight, kresek (the seedling blight or wilt phase) and the pale-yellow leaf.\r\nThe disease has been referred to as “bacterial leaf blight” to indicate that the “leaf blight” phase of the syndrome is the most distinct and commonly observed symptom.\r\nSeedlings in the nursery show circular, yellow spots in the margin, that enlarge, coalesce leading to drying of foliage.\r\n“Kresek” symptom is seen in seedlings, 1-2 weeks after transplanting.\r\nThe bacteria enter through the cut wounds in the leaf tips, become systemic and cause death of entire seedling.\r\nIn grown up plants water soaked, translucent lesions appear near the leaf margin.\r\nThe lesions enlarge both in length and width with a wavy margin and turn straw yellow within a few days, covering the entire leaf.\r\nAs the disease advances, the lesions cover the entire lamina which turns white or straw coloured.\r\nMilky or opaque dew drops containing bacterial masses are formed on'),
('Blast', 'Plant resistant varieties, apply balanced fertilization, and maintain proper water levels.', 2, 'All aboveground parts of the rice plant (leaves, leaf collar, culm, culm nodes, neck, and panicle) are attacked by the fungus\r\ninitial symptoms are white to gray-green lesions or spots with brown borders\r\nSmall specks originate on leaves - subsequently enlarge into spindle shaped spots(0.5 to 1.5cm length, 0.3 to 0.5cm width) with ashy center.  \r\nolder lesions elliptical or spindle-shaped and whitish to gray with necrotic borders Several spots coalesce to  form big irregular patches.\r\nnodal infection causes the culm to break at the infected node\r\nInternodal infection also occurs at the base of the plant which causes white panicles similar to that induced by yellow stem borer or water deficit\r\nLesions on the neck are grayish brown and causes the girdling of the neck and the panicle to fall over\r\nIf infection of the neck occurs before milk stage, no grain is formed, but if infection occurs later, grains of poor quality are formed\r\nLesions on the branches of the panicles and on the spikel'),
('Brown Spot', 'Ensure proper soil nutrition, avoid drought stress, and use fungicides if necessary.', 3, 'The fungus attacks the crop from seedling to milky stage in main field\r\nSymptoms appear as minute spots on the coleoptile, leaf blade, leaf sheath, and glume, being most prominent on the leaf blade and glumes.\r\nThe spots become cylindrical or oval, dark brown with yellow halo.\r\nThe several spots coalesce and the leaf dries up.\r\nThe seedlings die and affected nurseries can be often recognised from a distance by scorched appearance.\r\nDark brown or black spots also appear on glumes leading to grain discoloration.\r\nIt causes failure of seed germination, seedling mortality and reduces the grain quality and weight.'),
('Hispa', 'Apply insecticides, promote natural enemies, and practice crop rotation.', 4, 'Adults feed on chlorophyll by scraping and causing white parallel streaks.\r\nGrubs tunnel through leaf tissues and make blisters near leaf tips.\r\nWhitish and membranous leaves. .'),
('Leaf smut', 'Use resistant varieties and maintain field sanitation.', 5, 'Individual rice grain transformed into a mass of yellow fruiting bodies\r\nGrowth of velvetty spores that enclose floral parts\r\nInfected grain has greenish smut balls with a velvetty appearance.\r\nThe smut ball appears small at first and grows gradually up to the size of 1 cm.\r\nIt is seen in between the hulls and encloses the floral parts.\r\nOnly few grains in a panicle are usually infected and the rest are normal.\r\nAs the fungi growth intensifies, the smut ball bursts and becomes orange then later yellowish-green or greenish-black in color.\r\nInfection usually occurs during the reproductive and ripening stages, infecting a few grains in the panicle and leaving the rest healthy.'),
('Narrow brown leaf spot', 'Use resistant varieties, apply proper fertilization, and manage irrigation properly.', 6, 'The fungus attacks the crop from seedling to milky stage in main field\r\nSymptoms appear as minute spots on the coleoptile, leaf blade, leaf sheath, and glume, being most prominent on the leaf blade and glumes.\r\nThe spots become cylindrical or oval, dark brown with yellow halo.\r\nThe several spots coalesce and the leaf dries up.\r\nThe seedlings die and affected nurseries can be often recognised from a distance by scorched appearance.\r\nDark brown or black spots also appear on glumes leading to grain discoloration.\r\nIt causes failure of seed germination, seedling mortality and reduces the grain quality and weight.'),
('Rice_healthy', 'Maintain good crop management practices including proper irrigation and pest control.', 7, ' '),
('Sheath blight', 'Deep summer ploughing. Use healthy/certified seeds. Destroy infected crop debris. Seed treatment with streptocyclin @ 250 ppm (2.5 g/10 kg seeds). Application of any copper fungicides @ 2 g/lit along with streptocyclin at the rate of 250 ppm (2.5 g/10 lit water).', 8, 'Initial symptoms are noticed on leaf sheaths near water level. On the leaf sheath oval or elliptical or irregular greenish grey spots are formed. As the spots enlarge, the centre becomes greyish white with an irregular blackish brown or purple brown border.'),
('Tungro', 'Use resistant varieties, control vector insects, and practice proper field hygiene.', 9, 'Symptoms of tungro disease include: Stunted growth, Mottling, and Yellow-orange discoloration of the leaves. \r\nLeafhoppers, particularly the Nephotettix virescens species, transmit the viruses to rice plants. The spread of the disease is influenced by the interaction between the viruses and the insect vectors, the environment, and crop management practices. ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pest_control`
--
ALTER TABLE `pest_control`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pest_control`
--
ALTER TABLE `pest_control`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
