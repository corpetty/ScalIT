!
! MPI 2 version of ja4 module
! Need Parallel IO
!

program test_mja4
   use mja4
   implicit none
   double precision :: ct1, ct2     
   
   if (MInit()) then
      if (myid==rootID) then
         call CPU_Time(ct1)
         print *, '*********************************************'
         print *, '     Calculate H0 for Tetratomic Molecule     '
         print *, '*********************************************' 
         print *, '     Read Input Paramaters from STD Input    '
      
         call printJA4()
      end if

      call McalSaveH0()

      call McalSaveHGM()

      if (myID==rootID) then
         call CPU_Time(ct2)
         print *
         print *, ' CPU Time for the program:', ct2-ct1
         print *, '************     Finish the Program ****************'
         print *
      end if
   else
       print *, '  Error in allocating memory in Init()'
   end if

   call MFinal()

end 

