set term png
set output "P6-20-21-b-fig3.png"

set title "Gràfica de la convergència del càlcul de la integral 3"
set xlabel "N" 
set ylabel "Valor integral 3(picometres^2)"
!set key outside 
set grid xtics
set grid ytics
!set logscale 

set key bottom
set format x "%1.0tx10^{%S}" ; set format y "%1.0tx10^{%S}"

plot "P6-20-21-b-res.dat" i 2 u 1:2 t"Valor integral 3(picometres^2)"