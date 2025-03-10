# Load necessary library
library(ggplot2)

# Load the data from the GROMACS output file
data <- read.table('ala-2.dat')

# Extract phi (φ) and psi (ψ) angles
phi <- data[, 2]  # Assuming φ is in the second column
psi <- data[, 3]  # Assuming ψ is in the third column

# Create a data frame for plotting
ramachandran_data <- data.frame(phi = phi, psi = psi)

# Define the allowed regions as polygons
alpha_helix <- data.frame(
  x = c(-180, -100, -100, -180, -180),
  y = c(-180, -180, -30, -30, -180)
)

beta_sheet <- data.frame(
  x = c(-180, -180, -50, -50, -180),
  y = c(50, 180, 180, 50, 50)
)

left_handed_helix <- data.frame(
  x = c(50, 180, 180, 50, 50),
  y = c(-180, -180, 50, 50, -180)
)

# Create the Ramachandran plot
ggplot() +
  geom_point(data = ramachandran_data, aes(x = phi, y = psi), alpha = 0.5, size = 2) +
  geom_polygon(data = alpha_helix, aes(x = x, y = y), fill = "blue", alpha = 0.2) +
  geom_polygon(data = beta_sheet, aes(x = x, y = y), fill = "green", alpha = 0.2) +
  geom_polygon(data = left_handed_helix, aes(x = x, y = y), fill = "red", alpha = 0.2) +
  theme_minimal() +
  labs(title = "Ramachandran Plot with Allowed Regions",
       x = "Phi (φ) angle (degrees)",
       y = "Psi (ψ) angle (degrees)") +
  xlim(-180, 180) +
  ylim(-180, 180) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.5) +
  geom_vline(xintercept = 0, color = "black", linewidth = 0.5) +
  theme(panel.grid.major = element_line(color = "gray", linewidth = 0.2))