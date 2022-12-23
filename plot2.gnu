set term png
set output "P6-20-21-b-fig2.png"

set title "Gràfica de la convergència del càlcul i l'error estimat de la integral 2"
set xlabel "N" 
set ylabel "Valor integral 2 (picometres)"
!set key outside 
set grid xtics
set grid ytics
!set logscale 

set key bottom
set format x "%1.0tx10^{%S}" ; set format y "%1.0tx10^{%S}"

plot "P6-20-21-b-res.dat" i 1 u 1:2 t"Valor integral 2"