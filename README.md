# Montecarlo-Method
Using Montecarlo to compute one-dimensional and multi-dimensional integrals.

## 1D integrals

We use Montecarlo routine to calculate the next defined integral:

$$I_1 = \int_0^{3\pi/2} x^3 \sin^3(x) dx$$

And its error.

Next, we compute the the value of the next integral

$$I_2 = \int_{-L/2}^{L/2} g(x) p(x)dx$$

where

$$g(x) = \sin^2 \left( \frac{8\pi(x-L/2)}{L}\right)$$

via generating random numbers according to $g(x)$.

## Fermions

We consider a three fermion system where the wave function can be expressed as

$\phi(x_1,x_2,x_3)= \prod^3 _{i=1} \sin\left(\frac{\pi(x_i-L/2)}{L}\right) \prod_{j<k=1,3} \left(\left(\cos \frac{\pi(x_j-L/2)}{L} \right)-\left(\cos \frac{\pi(x_k-L/2)}{L} \right)\right)$
# Compilation and execution of the program
This program was written in _Fortran_ 77 and the graphics were plotted with _Gnuplot_.
## Linux and Mac
### Compilation

```
gfortran -name_of_the_file.f -o name_of_the_output_file.out
```
### Execution
```
./name_of_the_output_file.out
```

## Windows
### Compilation
```
gfortran -name_of_the_file.f -o name_of_the_output_file.exe
```
### Execution
```
./name_of_the_output_file.exe
```
