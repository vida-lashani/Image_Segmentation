# Image_Segmentation
Lung Segmentation using Distance Regularized Level Set Evolution (DRLSE)

This MATLAB code implements the Distance Regularized Level Set Evolution (DRLSE) method for segmenting lung MRI images. DRLSE is a technique used for contour extraction and object segmentation, designed to avoid the need for re-initialization by maintaining the regularity of the level set function during evolution.

Overview
The method works by evolving a contour (represented by a level set function, phi) to capture the boundaries of the lungs. Unlike traditional Level Set Evolution (LSE), this approach adds a distance regularization term to the energy function, ensuring stable evolution and eliminating the need for re-initialization.

Main Features
DRLSE Algorithm: Uses a regularized distance term to maintain contour smoothness and stability.
Energy Function Components:
Regularization term 
𝑅
𝑝
(
𝜙
)
R 
p
​
 (ϕ) (weighted by mu)
Length term 
𝐿
𝑔
(
𝜙
)
L 
g
​
 (ϕ) (weighted by lambda)
Area term 
𝐴
𝑔
(
𝜙
)
A 
g
​
 (ϕ) (weighted by alpha)
Visualization: Generates 2D contour maps and 3D surface plots for visualizing segmentation progress and results.
Parameters
You can adjust the following parameters to fine-tune the segmentation process:

mu: Weight for the regularization term.
lambda: Weight for the length term (controls the smoothness of the contour).
alpha: Weight for the area term (controls the expansion or shrinkage of the contour).
epsilon: Dirac delta function threshold (controls boundary sharpness).
sigma: Standard deviation of the Gaussian filter applied to the image.
maxiter: Maximum number of iterations for the evolution process.
timestep: Step size for the gradient descent optimization.
Steps for Segmentation
Preprocessing: Apply a Gaussian filter to smooth the MRI image.
Initialization: Initialize the phi matrix to define the starting region for contour evolution.
Edge Detection: Use the edge indicator function to guide the contour evolution toward object boundaries.
Contour Evolution: The contour evolves by minimizing the energy function over a specified number of iterations.
Output: Display the final segmented lung boundaries and the corresponding 3D phi matrix.
