
## general introduction
The codes in this folder are CPU version. It generally takes hours to run for N = 10^3 particles. To save time, one can run the GPU version at
https://github.com/statisticalmechanics/scatter/tree/master/code_gpu ,
which normally takes minutes for the same task.

The three pieces of codes here are program that uses 
CPU to calculate the diffraction pattern of an arbitrary 
sample. Variables and principles are based on the paper
https://arxiv.org/abs/2010.06126
(referred to as THE PAPER below).

## whitexray.cpp

This piece of code is based on Laue method, where an x-ray beam with continuous frequency spectrum is used, and a single crystal is used as sample. Details 
has been introduced in THE PAPER, section 6.1 & 5.1.

- files needed:
	- config.xyz: sample file, being put in the same
	folder as the executable file. Go to 
	https://github.com/statisticalmechanics/scatter/tree/master/xyz
	and download "test_sample.xyz", rename it to be
	"config.xyz" and put it in the same folder as the
	executable.
- parameters:
	* 1 Front (0) of Back (1)_:
	This asks whether the transmission method or 
	back-reflection method, as described at FIG. 6 
	in THE PAPER. Input 0 means transmission method 
	and 1 means back-reflection method.
	* 2 Input LOWER limit for wavelength_:
	* 3 Input UPPER limit for wavelength_:
	As Laue method uses white x-rays which contains 
	waves in a frequency range, this parameter specifies
	the range for adopted frequency, in unit of “sigma”, 
	the length of atomic diameters.
	* 4 Input number of particles_:
	Number of particles in the sample system. 
	* 5 Input x_Resolution_:
	* 6 Input y_Resolution_:
	The size of screen, the unit can be everything.
	* 7 Input distance (D)_:
	The distance between the screen and the sample,
	as illustrated in FIG.6 in THE PAPER.
	The unit should consist with the previous two input
	values.
	
- Output:
	“Ixy.dat”, which contains many lines, each line represent
	a point on screen, and there are three columns: the first
	column is the x coordinate on screen, the second is the y
	coordinate, and the third is the intensity.

## powder_even.cpp

This piece of code is based on powder method, where a powder sample is used for diffraction experiment, and a graph of Intensity vs twotheta (the diffraction angle) is expected. Details has been introduced in THE PAPER, section 8.

- files needed:
	- config.xyz: sample file, being put in the same
	folder as the executable file. Go to 
	https://github.com/statisticalmechanics/scatter/tree/master/xyz
	and download "test_sample.xyz", rename it to be
	"config.xyz" and put it in the same folder as the
	executable.
- parameters:
	* 1 Input number of particles, any value bigger than
	10000 is illegal_:
	Number of particles in the sample system. 
	* 2 Input number of points on a sphere_:
	Specify the number of directions the tiny single 
	crystals will have in a polycrystal sample.
	* 3 Input wavelength_:
	Wavelength chosen, in unit of “sigma”, the length 
	of atomic diameters.
	* 4 Input increment for theta_:
	The increment for the diffraction angle. i.e. 2\theta,
	the value on the x-axis.
- Output:
	"Sq.dat", each line represents a theta value for the 
	x-axis of the result figure, the first column is the
	theta value, the second column is the intensity.

## cubic_q.cpp

This piece of code is based on chooding q vectors on
a cubic lattice, as illustrated in section 7.3 in 
THE PAPER.

- files needed:
	- config.xyz: sample file, being put in the same
	folder as the executable file. Go to 
	https://github.com/statisticalmechanics/scatter/tree/master/xyz
	and download "test_sample.xyz", rename it to be
	"config.xyz" and put it in the same folder as the
	executable.
- parameters:
	* 1 Input configurations_:
	The number of configurations.
	* 2 Input length for x direction_:
	* 3 Input length for y direction_:
	* 4 Input length for z direction_:
	These three parameters are L, the linear dimension of the cubic 
	simulation box, as described in THE PAPER. And ∆q is calculated 
	from this value, also illustrated in paper, at section 7.3.
	* 5 Input number of particles, any value bigger than 10000 is illegal_:
	How many atoms we have in our sample.
	* 6 Input upper bound for x side length of q cubic, any value bigger than %d is illegal_:
	* 7 Input upper bound for y side length of q cubic, any value bigger than %d is illegal_:
	* 8 Input upper bound for z side length of q cubic, any value bigger than %d is illegal_:
	These three parameters are n_x, n_y, n_z, also described in section 7.3.
	* 9 Input resolution for drawing S(q) vs q_:
	This is also described in THE PAPER, section 7.3: “When reporting the result of S(q), 
	one can assign q’s into bins of equal size or just use the 
	original q values visited by the lattice points.” And this 
	parameter “resolution” means “size of bins”.
- Output:
	- “out.xyz”, contains coordinate of q vectors and related 
	S(q) values. The first three columns are coordinates for q 
	vectors.
	- “out.q”, contains the same information as the previous 
	one, but only magnitude of q is presented.
	- “out.q.draw”, contains the averaged S(q) values based 
	on similar q values. 

## visulization
To visualize the result, use the matplot function in python. The scripts can be downloaded here:
https://github.com/statisticalmechanics/scatter/tree/master/drawing
You may need to modify the code in order to have a visible result.
