
! This file contains functions that represents f(x) of the integral

! Function for f(x) = e^cos(kx)
double precision function f_x(x, k) result(y) 
    double precision, intent(in) :: x, k
    y = exp(cos(k * x))
end function f_x

! Function represents f''(x) of above function f(x)
! f''(x) = k^2 * (-e^cos(k * x)) * (cos(k * x) - sin^2(k * x))
! Used in absolute error calculation
double precision function fpp(x, k) result(ypp)
    double precision, intent(in) :: x, k
    ypp = (k**2) * (-exp(cos(k * x))) * (cos(k * x) - sin(k * x)**2)
end function fpp