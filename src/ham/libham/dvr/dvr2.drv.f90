!
! Testing the following subroutines: 
!     DVR2(), DVR2SF(), DVR2RF()       
!

program test_dvr2
   implicit none
   integer, parameter :: N=100, M=10
   logical :: DVR2, DVR2SF, DVR2RF
   external :: pot
   double precision :: X1(N),H1(N, N),Y1(N),G1(N,N)
   double precision :: X10(N),H2(N,N)
   double precision :: X20(M),E20(M),H3(M,M)
   double precision :: X0(M),E0(M),H0(M,M)
   character(len=128) :: fname='t1.dat'
   integer :: i, j

   call random_number(X1)
   call random_number(H1)

   do i = 1, N
      do j = i, N
         H1(i,j)=H1(j,i)
      end do
   end do
   G1(1:N,1:N) = H1(1:N,1:N)

   print *
   print *, ' Testing DVR2 ......'
   if( DVR2(N,X1,H1,pot,M,X0,E0,H0)) then
     print *, ' DVR X0:', X0
     print *, ' Eig0:', E0
     print *, ' Hmatrix:', H0
   else
     print *, ' Error in DVR2!'
   end if
     
!   X1(1:N,1:N) = Y1(1:N,1:N)
   H1(1:N,1:N) = G1(1:N,1:N)

   print *
   print *, ' Testing DVR2SF ......'
   if( DVR2SF(N,X1,H1,pot,M,X20,E20,H3,fname)) then
     print *, ' Diff DVR X0:', X20-X0
     print *, ' Diff Eig0:', E20-E0
     print *, ' Diff Hmatrix:', H3-H0
   else
     print *, ' Error in DVR2SF!'
   end if

   X20=0;E20=0;H3=0
   print *
   print *, ' Testing DVR2RF ......'
   if( DVR2RF(M,X20,E20,H3,fname)) then
     print *, ' Diff DVR X0:', X20-X0
     print *, ' Diff Eig0:', E20-E0
     print *, ' Diff Hmatrix:', H3-H0
   else
     print *, ' Error in DVR2RF!'
   end if

end program


subroutine pot(N, R, VR)
   integer, intent(IN) :: N
   double precision, intent(IN) :: R(N) 
   double precision, intent(OUT) :: VR(N)

   VR(1:N) = 0.0D0
   VR(1:N) = R(1:N)
end 


