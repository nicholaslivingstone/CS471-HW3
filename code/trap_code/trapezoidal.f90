! Nicholas Livingstone
! CS471 Fall 2020 UNM

program trapezoidal
    ! Variables
    implicit none
    double precision :: abs_err = 1D0, sum = 0, xi, approx, prev_approx = 1d0
    double precision, parameter :: X_L = -1d0, X_R = 1d0, max_err = 10D-16
    double precision, parameter :: PI = acos(-1.d0) ! Constant PI 
    double precision, parameter, dimension(2) :: k = (/PI, PI**2/) ! array of k parameters
    real(kind = 8) :: h
    integer :: n = 1, i, j

    ! File Variables
    character(len=10) :: file_id
    character(len=50) :: file_name
    

    do j = 1,2
        ! Setup file-name & open based on which k is being tested
        ! Taken from: https://stackoverflow.com/q/22694626
        write(file_id, '(i10)') j
        file_name = '../../data/trap_data' // trim(adjustl(file_id)) // '.txt'
        open(j, file = trim(file_name))
        
        ! Loop over different values of x
        do while (n < 5000)

            ! Complete Trapezoidal approximation 

            h = (X_R - X_L)/n

            ! Calculate summation term
            do i = 1, (n - 1)
                xi = X_L + (i * h)
                sum = sum + f_x(xi, k(j))
            end do

            ! Calculate integral approximation using Composite Trapezoidal Rule formula
            approx = h * ((f_x(X_L, k(j)) + f_x(X_L + n * h, k(j)))/2 + sum)

            ! Calculate Error
            abs_err = abs(prev_approx - approx)
            
            ! Write Data to file
            write(j, "(i6, a, ES12.6, a, ES17.11)") n, ",", abs_err, ",", approx

            ! Clean up for next iteration
            n = n + 1 ! Iterate n for the next loop 
            sum = 0d0 ! Reset sum to zero
            prev_approx = approx
        end do
        
        close(j)        !close file
        abs_err = 1d0   !reset error
        n = 1           ! reset n
        prev_approx = 0  ! reset previous error
    end do

    
    contains
        include '../functions.f90'

end program trapezoidal

