
c       MARTA XIULAN ARIBÓ HERRERA
c       Calcul d'integrals a partir els mètodes de montecarlo cru i sampleig
  
c-------------------------COS DEL PROGRAM APRINCIPAL--------------------
c----------------------- DECLARACIÓ DE VARIABLES -----------------------
        implicit none
        integer iseed,i, ndat,c
        parameter (iseed = 20158541) !per donar valors aleatoris
        parameter (ndat = 1000000)
        double precision pi,L
        parameter ( pi = 4.d0*atan(1.d0))
        parameter (L = 16.d0) !micrometres
        double precision f1,g,p,fo !funcions declarades com external
        external f1,g,p,fo
        double precision I1,Integral1,e1,error1,a1,b1,x1 !integral 1
        double precision xnums(ndat), a2,b2,M ! apartat 1.b)
        double precision I2,Integral2,e2,error2,x2 !integral2
        double precision I3,Integral3,e3,error3,x3 !integral3
        open (1,file = "P6-20-21-b-res.dat") !fitxer on guardem dades
        Write (1,*)"PRACTICA 6"
        call srand(iseed)


c----------------------------APARTAT 1A).  -----------------------------
c       Integració a partir del mètode de montecarlo cru
c-----------------------------------------------------------------------
        a1 = 0.d0 !límits d'integració
        b1 = 3.d0*pi/2.d0
        Integral1 = 0.d0
        e1 = 0.d0
c        WRITE (1,200)"N","INTEGRAL","ERROR"

        write(1,"(a12)") "APARTAT 1A"
        write(1,"(a1,15x,a10,15x,a10)") "N","Integral","Error"
        do i = 1,1000000
            x1 = (b1-a1)*rand()+a1
            Integral1 = Integral1 + (b1-a1)*f1(x1)
            e1 = e1 + ((b1-a1)*f1(x1))**2
            if (mod(i,10000).EQ.0) then
                I1 = Integral1/dble(i)
                error1 = sqrt((e1/dble(i))-(I1**2))/sqrt(dble(i))
                write(1,*)i,I1,error1
            endif
        enddo

        write(1,"(a1)")
        write(1,"(a1)")

        call system ("gnuplot -p plot1.gnu") !gràfica

c----------------------------APARTAT 1B).  -----------------------------
c       Generació de 1000000 valors aleatoris amb una densitat de probabilitat
c        p(x)
c-----------------------------------------------------------------------
        a2 = - L/2.d0
        b2 = + L/2.d0
        M = 0.15d0 ! a ull per la gràfica
        call acceptrebuig(ndat,xnums,a2,b2,M,p) !creem una llista de numeros aleatoris

c        print*,xnums
c----------------------------APARTAT 1C).  -----------------------------
c       Calcul de la integral g(x)*p(x) a partir dels nombres aleatoris creats
c       a partir de l'apartat anterior de p(x)
c-----------------------------------------------------------------------
        a2 = - L/2.d0 !límits
        b2 = + L/2.d0
        Integral2 = 0.d0 !valors inicials pel sumatori
        e2 = 0.d0
        write(1,"(a12)") "APARTAT 1C"
        write(1,"(a1,15x,a10,15x,a10)") "N","Integral","Error"
        do i = 1,ndat !integració
            Integral2 = Integral2 + g(xnums(i))
            e2 = e2 + g(xnums(i))**2

            if ((mod(i,10000)).EQ.0) then
                I2 = Integral2/dble(i)
                error2 = sqrt(e2/dble(i)-I2**2)/sqrt(dble(i))
                write(1,*)i,I2,error2
            endif
        enddo
        write(1,"(a1)")
        write(1,"(a1)")

        call system ("gnuplot -p plot2.gnu") !gràfica
c---------------------------- APARTAT 2 FERMIONS -----------------------------
C       Calcul de la normalització d'una funció d'ona amb tres variables
c       utilitzant els valors aleatoris creats a l'apartat 1b).
c-----------------------------------------------------------------------
        c = 1 !comptador extern
        e3 = 0.d0 !valors inicials per la integracio
        Integral3 = 0.d0
        write(1,"(a12)") "APARTAT 2"
        write(1,"(a1,15x,a10,15x,a10)") "N","Integral","Error"
        do i = 1, 250000 !integracio
            x1 = xnums(c)
            x2 = xnums(c+1)
            x3 = xnums(c+2)
            Integral3 = Integral3+(fo(x1,x2,x3)**2/(p(x1)*p(x2)*p(x3)))
            e3 = e3 + (fo(x1,x2,x3)**4/(p(x1)*p(x2)*p(x3))**2)
            if ((mod(i,1000)).EQ.0) then
                I3= Integral3/dble(i)
                error3 = sqrt((e3/dble(i))-I3**2)/sqrt(dble(i))
                write (1,*) i,I3,error3
            endif
            c= c+3
        enddo

        call system ("gnuplot -p plot3.gnu") !gràfica 

        close(1)

        END PROGRAM 

c------------------------- RUTINES I SUBRUTINES ------------------------

c-----------------------Funció de la primera integral------------------------
        double precision function f1(x)
        implicit none
        double precision x
            f1 = x**3*sin(x)**3
        return
        end function
c-----------------------Funció de la segona integral------------------------
        double precision function g(x)
        implicit none
        double precision x,L,pi
        parameter ( pi = 4.d0*atan(1.d0))
        parameter (L = 16.d0) !micrometres

            g = sin(8.d0*pi*(x-(L/2.d0))/L)**2

        return
        end function
    
c-----------------------Densitat de probabilitat p(x)------------------------
        double precision function p(x)
        implicit none
        double precision x,L,pi
        parameter ( pi = 4.d0*atan(1.d0))
        parameter (L = 16.d0) !micrometres
            p = (2.d0/L)*sin(pi*(x-(L/2.d0))/L)**2
        return
        end function 
c----------------------- Funció d'ona ----------------------------------
        double precision function fo(x1,x2,x3)
        implicit none
        integer i,k,j
        double precision x1,x2,x3
        double precision f1,f2, pi,L,x(3)
        parameter ( pi = 4.d0*atan(1.d0))
        parameter (L = 16.d0) !micrometres
        
        x(1) = x1 !els posem dins d'un vector per treballar millor
        x(2) = x2
        x(3) = x3
        fo = 1.d0
        do i = 1,3,1 !bucle per crear la funció d'ona
            do j = 1,3,1
                do k = 1,3,1
                    if (j.LT.k) then !condició
            fo = fo*sin(pi*(x(i)-L/2.d0)/L)*
     1(cos(pi*(x(j)-L/2.d0)/L)- cos(pi*(x(k)-L/2.d0)/L))
                    endif
        enddo
        enddo
        enddo
        
        return
        end function 

c--------------------------- SUBRUTINA ACCEPT REBUIG -------------------
c       Subrutina que retorna una llista xnums creats de forma aleatoria
c-----------------------------------------------------------------------

        subroutine acceptrebuig(ndat,xnums,a,b,M,fun) 
            implicit none
            integer ndat, i, comptador, iseed
            double precision xnums(ndat),fun,a,b,M,p,x
            double precision x1,x2
            !generem dos numeros aleatoris
            !generador de numeros aleatoris associats al nostre NIUB
            i = 0
            do while (i.LT.ndat+1)
                x1 = rand()
                x2 = rand()
                x = ((b-a)*x1) + a
                p = M*x2
                if (fun(x).GE.p) then
                xnums(i) = x
                    i = i + 1
                endif
            enddo
        end subroutine acceptrebuig








