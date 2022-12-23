set term png
set output "P6-20-21-b-fig1.png"

set title "Gràfica de la convergència del càlcul i l'error estimat de la integral 1"
set xlabel "N" 
set ylabel "Error(picometres)"
!set key outside 
set grid xtics
set grid ytics
set logscale 

set key top
set format x "%1.0tx10^{%S}" ; set format y "%1.0tx10^{%S}"

valor_real =  (122./27. - (21.*(pi**2)/4.))
plot [10**4:1.5*10**6][10**-2:10] "P6-20-21-b-res.dat" i 0 u 1:(abs(valor_real-$2)) t"Error real", "P6-20-21-b-res.dat" u 1:3 t"Error estimat"