
program gq
    ! Variables 
    implicit none
    double precision, dimension(:), allocatable :: w, f, x
    double precision, parameter :: PI = acos(-1d0) ! Constant for PI
    double precision, parameter, dimension(2) :: k = (/PI, PI**2/) ! Both instances of k
    double precision :: integral_approx, prev_approx = 0d0, abs_err
    integer :: n = 1, i, j


    ! File Variables
    character(len=10) :: file_id
    character(len=50) :: file_name

    ! Iterate through both instances of k
    do j = 1, 2
        ! Open file to store data
        write(file_id, '(i10)') j
        file_name = '../../data/gq_data' // trim(adjustl(file_id)) // '.txt'
        open(j, file = trim(file_name))

        
        ! Complete Gauss quadtrature for different values of n
        do while (n <= 3000)
            ! print n to show progress
            print *, n

            ! Allocate data for array
            allocate(w(0:n), f(0:n), x(0:n))

            ! Determine points and weights
            call lglnodes(x, w, n)

            integral_approx = 0d0
            ! Complete Gauss Approximation
            do i = 0, n
                ! Calculate f and combine sum
                f(i) = f_x(x(i), k(j))
                integral_approx = integral_approx + f(i) * w(i)
            end do 

            ! Calculate Error as difference between previous and current approximation
            abs_err = dabs(integral_approx - prev_approx)

            ! Write data to file
            write(j, "(i4, a, ES18.8, a, ES18.8)") n, ",", abs_err, ",", integral_approx

            ! Prepare for next iteration
            deallocate(x, f, w)
            n = n + 1
            prev_approx = integral_approx
        end do 


        ! Clean up
        close(j)    ! Close data file
        n = 1 ! Reset n 
        prev_approx = 0d0
    end do

    contains
        include '../functions.f90'
        include 'lglnodes.f90'

end program gq
