      subroutine HOO_DMBE4_init()
c     M.R. Pastrana, L.A.M. Quintales, J. Brandas, and A.J.C.
c      Varandas, J. Phys. Chem. v. 94, p. 8037 (1990).
      return
      end
cmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmc
      SUBROUTINE HOO_DMBE4_pes(X,F)
C   This is the DMBE IV potential energy surface for H + O2
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION X(3)
      COMMON/COEFF_HOO_DMBE4/C(52)
      COMMON/THRBOD_HOO_DMBE4/POLQ,DECAY1,DECAY2,DECAY3,R1,R2,R3
      COMMON/REFGEO_HOO_DMBE4/R10,R20,R30
      COMMON/TEST_HOO_DMBE4/ITEST
C     ****************************************************************
c  
c  Atom sequence:  H(1)-O(2)-O(3)
c  Now, X(1) is the distance of H-O(2), X(2) is H-O(3), X(3) is O-O
c
c     R1=X(1)
c     R2=X(2)
c     R3=X(3)
c=======dyna
      R1=X(3)
      R2=X(1)
      R3=X(2)
c=======dyna
      Q1=1.0D0/DSQRT(3.0D0)*(R1+R2+R3)
      Q2=1.0D0/DSQRT(2.0D0)*(R2-R3)
      Q3=1.0D0/DSQRT(6.0D0)*(2.0D0*R1-R2-R3)
      F=VOO_HOO_DMBE4(R1)+VOH_HOO_DMBE4(R2)+VOH_HOO_DMBE4(R3)+
     $THREBQ_HOO_DMBE4(Q1,Q2,Q3)+
     1  EXDIS_HOO_DMBE4(R1,R2,R3)+ELECT_HOO_DMBE4(R1,R2,R3)
      F =F + 0.19157D0
      RETURN
      END
      FUNCTION THREBQ_HOO_DMBE4(Q1,Q2,Q3)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/COEFF_HOO_DMBE4/C(52)
      COMMON/THRBOD_HOO_DMBE4/POLQ,DECAY1,DECAY2,DECAY3,R1,R2,R3
      COMMON/REFGEO_HOO_DMBE4/R10,R20,R30
C     ****************************************************************
      Q12=Q1*Q1
      Q13=Q12*Q1
      Q14=Q13*Q1
      Q15=Q14*Q1
      Q16=Q15*Q1
      Q22=Q2*Q2
      Q32=Q3*Q3
      TQ1=Q22+Q32
      TQ2=Q32-3.0D0*Q22
      TQ3=Q22-Q32
      TQ12=TQ1*TQ1
      TQ13=TQ12*TQ1
      TQ22=TQ2*TQ2
      S1=R1-R10
      S2=R2-R20
      S3=R3-R30
      POLQ=C(1)*Q1+C(2)*Q12+C(3)*TQ1+C(4)*Q13+C(5)*Q1*TQ1+
     1C(6)*Q3*TQ2+C(7)*Q14+C(8)*Q12*TQ1+C(9)*TQ1**2+C(10)*Q1*Q3*TQ2+
     2C(11)*Q3+C(12)*Q1*Q3+C(13)*TQ3+C(14)*Q12*Q3+C(15)*Q1*TQ3+
     3C(16)*Q3*TQ1+C(17)*Q13*Q3+C(18)*Q12*TQ3+C(19)*Q1*Q3*TQ1+
     4C(20)*Q32*TQ2+C(21)*TQ1*TQ3+C(22)+C(23)*Q15+C(24)*Q13*TQ1+
     5C(25)*Q1*TQ12+C(26)*Q12*Q3*TQ2+C(27)*Q3*TQ1*TQ2+C(28)*Q14*Q3+
     6C(29)*Q13*TQ3+C(30)*Q12*Q3*TQ1+C(31)*Q1*Q32*TQ2+C(32)*Q1*TQ1*TQ3+
     7C(33)*Q3*TQ12+C(34)*Q3*TQ2*TQ3+C(35)*Q16+C(36)*Q14*TQ1+
     8C(37)*Q12*TQ12+C(38)*Q13*Q3*TQ2+C(39)*Q1*Q3*TQ1*TQ2+C(40)*TQ13+
     9C(41)*Q32*TQ22+C(42)*Q15*Q3+C(43)*Q14*TQ3+C(44)*Q13*Q3*TQ1+
     AC(45)*Q12*Q32*TQ2+C(46)*Q12*TQ1*TQ3+C(47)*Q1*Q3*TQ12+
     BC(48)*Q1*Q3*TQ2*TQ3+C(49)*Q32*TQ1*TQ2+C(50)*TQ12*TQ3
      DECAY1=1.0D0-DTANH(C(51)*S1)
      DECAY2=1.0D0-DTANH(C(52)*S2)
      DECAY3=1.0D0-DTANH(C(52)*S3)
      THREBQ_HOO_DMBE4=POLQ*DECAY1*DECAY2*DECAY3
      RETURN
      END
      FUNCTION VOH_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
C     ****************************************************************
      VOH_HOO_DMBE4=EHFOH_HOO_DMBE4(R)+DISOH_HOO_DMBE4(R)
      RETURN
      END
      FUNCTION EHFOH_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION ASV(4)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
C     ****************************************************************
      DATA D,ASV/0.13825385D0,2.6564788D0,1.7450528D0,0.71014391D0,
     1           2.5453276D0/
C     ****************************************************************
      X=R-RMOH
      R2=X*X
      R3=R2*X
      EHFOH_HOO_DMBE4=-D*(1.0D0+ASV(1)*X+ASV(2)*R2+ASV(3)*R3)*DEXP(-ASV(
     $4)*X)
      RETURN
      END
      FUNCTION DISOH_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/DISPC_HOO_DMBE4/COO(10),COH(10)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
C     ****************************************************************
      DISOH_HOO_DMBE4=DISP_HOO_DMBE4(R,COH(6),COH(8),COH(10),R0OH,RMOH)
      RETURN
      END
      FUNCTION VOO_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
C     ****************************************************************
      VOO_HOO_DMBE4=EHFOO_HOO_DMBE4(R)+DISOO_HOO_DMBE4(R)
      RETURN
      END
      FUNCTION EHFOO_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DIMENSION ASV(4)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
C     ****************************************************************
      DATA D,ASV/0.14291202D0,3.6445906D0,3.9281238D0,2.0986689D0,
     1           3.3522498D0/
C     ****************************************************************
      X=R-RMOO
      R2=X*X
      R3=R2*X
      EHFOO_HOO_DMBE4=-D*(1.0D0+ASV(1)*X+ASV(2)*R2+ASV(3)*R3)*DEXP(-ASV(
     $4)*X)
      RETURN
      END
      FUNCTION DISOO_HOO_DMBE4(R)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/DISPC_HOO_DMBE4/COO(10),COH(10)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
C     ****************************************************************
      DISOO_HOO_DMBE4=DISP_HOO_DMBE4(R,COO(6),COO(8),COO(10),R0OO,RMOO)
      RETURN
      END
      FUNCTION CEF_HOO_DMBE4(CAS,RK01,RK11,RK02,RK12,RE1,RE2,R1,R2)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      CEF_HOO_DMBE4=0.5D0*CAS*((1.0D0-RK01*DEXP(-RK11*(R1-RE1)))*DTANH(
     $RK12*R2)+
     1  (1.0D0-RK02*DEXP(-RK12*(R2-RE2)))*DTANH(RK11*R1))
      RETURN
      END
      FUNCTION EXDIS_HOO_DMBE4 (R1,R2,R3)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/DISPC_HOO_DMBE4/COO(10),COH(10)
      COMMON/RKVAL_HOO_DMBE4/RK0OO(10),RK1OO(10),RK0OH(10),RK1OH(10)
      COMMON/DISCO_HOO_DMBE4/CEFOO(10),CEFOH2(10),CEFOH3(10),CEDOO(10),
     $CEDOH2(10)
      COMMON/DISCO2_HOO_DMBE4/CEDOH3(10)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
C     ****************************************************************
      DO 10 IN=6,10,2
      CEFOO(IN)=CEF_HOO_DMBE4(COO(IN),RK0OH(IN),RK1OH(IN),RK0OH(IN),
     $RK1OH(IN),
     1   RMOH,RMOH,R2,R3)
      CEDOO(IN)=CEFOO(IN)-COO(IN)
      CEFOH2(IN)=CEF_HOO_DMBE4(COH(IN),RK0OO(IN),RK1OO(IN),RK0OH(IN),
     $RK1OH(IN),
     1   RMOO,RMOH,R1,R3)
      CEDOH2(IN)=CEFOH2(IN)-COH(IN)
      CEFOH3(IN)=CEF_HOO_DMBE4(COH(IN),RK0OO(IN),RK1OO(IN),RK0OH(IN),
     $RK1OH(IN),
     1   RMOO,RMOH,R1,R2)
      CEDOH3(IN)=CEFOH3(IN)-COH(IN)
   10 CONTINUE
      EXDIS_HOO_DMBE4=DISP_HOO_DMBE4(R1,CEDOO(6),CEDOO(8),CEDOO(10),R0OO
     $,RMOO)
     1     +DISP_HOO_DMBE4(R2,CEDOH2(6),CEDOH2(8),CEDOH2(10),R0OH,RMOH)
     2     +DISP_HOO_DMBE4(R3,CEDOH3(6),CEDOH3(8),CEDOH3(10),R0OH,RMOH)
      RETURN
      END
      FUNCTION ELECT_HOO_DMBE4(R1,R2,R3)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/POLAR_HOO_DMBE4/C4,C5
      COMMON/RKVAL_HOO_DMBE4/RK0OO(10),RK1OO(10),RK0OH(10),RK1OH(10)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
      COMMON/DAMPC_HOO_DMBE4/ADAMP(10),BDAMP(10)
      COMMON/WELECT_HOO_DMBE4/C4OHR2,C5OHR2,C4OHR3,C5OHR3,C4OO,C5OO,
     $TERM4,TERM5
C     ****************************************************************
      C42=C4
      C43=C4
      C52=C5
      C53=C5
      R23=R2**3
      R24=R23*R2
      R33=R3**3
      R34=R33*R3
      R14=R1**4
      R15=R14*R1
      R25=R24*R2
      R35=R34*R3
      RMQ=RMOH**4
      RMQ5=0.50D0/RMQ
      RMR3=RMQ5*R34
      RMR2=RMQ5*R24
      RMR33=RMQ5*R33
      RMR23=RMQ5*R23
      TAO=DTANH(RK1OO(4)*R1)
      TAH2=DTANH(RK1OH(4)*R2)
      TAH3=DTANH(RK1OH(4)*R3)
      EX3=DEXP(-RK1OH(4)*(R3-RMOH))
      EX2=DEXP(-RK1OH(4)*(R2-RMOH))
      R3E3=RMR3*EX3
      R2E2=RMR2*EX2
      CRE43=C4*R3E3
      CRE42=C4*R2E2
      CRE53=C5*R3E3
      CRE52=C5*R2E2
      C4OHR2=CRE43*TAO
      C5OHR2=CRE53*TAO
      C4OHR3=CRE42*TAO
      C5OHR3=CRE52*TAO
      C4OO=CRE43*TAH2+CRE42*TAH3
      C5OO=CRE53*TAH2+CRE52*TAH3
      RROH2=2.0D0*R2/(RMOH+2.5D0*R0OH)
      RROH3=2.0D0*R3/(RMOH+2.5D0*R0OH)
      RROO=2.0D0*R1/(RMOO+2.5D0*R0OO)
      TERM4=C4OO/R14*(1.0D0-DEXP(-ADAMP(4)*RROO-BDAMP(4)*RROO**2))**4+
     1 C4OHR2/R24*(1.0D0-DEXP(-ADAMP(4)*RROH2-BDAMP(4)*RROH2**2))**4+
     2 C4OHR3/R34*(1.0D0-DEXP(-ADAMP(4)*RROH3-BDAMP(4)*RROH3**2))**4
      TERM5=C5OO/R15*(1.0D0-DEXP(-ADAMP(5)*RROO-BDAMP(5)*RROO**2))**5+
     1 C5OHR2/R25*(1.0D0-DEXP(-ADAMP(5)*RROH2-BDAMP(5)*RROH2**2))**5+
     2 C5OHR3/R35*(1.0D0-DEXP(-ADAMP(5)*RROH3-BDAMP(5)*RROH3**2))**5
      ELECT_HOO_DMBE4=TERM4+TERM5
      RETURN
      END
      FUNCTION DISP_HOO_DMBE4(R,C6,C8,C10,R0,RM)
C     ****************************************************************
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/DAMPC_HOO_DMBE4/ADAMP(10),BDAMP(10)
C     ****************************************************************
      R6=R**6
      R8=R6*R*R
      R10=R8*R*R
      RR=2.0D0*R/(RM+2.5D0*R0)
      D6=(1.0D0-DEXP(-ADAMP(6)*RR-BDAMP(6)*RR*RR))**6
      D8=(1.0D0-DEXP(-ADAMP(8)*RR-BDAMP(8)*RR*RR))**8
      D10=(1.0D0-DEXP(-ADAMP(10)*RR-BDAMP(10)*RR*RR))**10
      DISP_HOO_DMBE4=-C6/R6*D6-C8/R8*D8-C10/R10*D10
      RETURN
      END
      BLOCK DATA HO2DAT_HOO_DMBE4
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/COEFF_HOO_DMBE4/C(52)
      COMMON/DISPC_HOO_DMBE4/COO(10),COH(10)
      COMMON/DIATDI_HOO_DMBE4/R0OO,RMOO,R0OH,RMOH
      COMMON/RKVAL_HOO_DMBE4/RK0OO(10),RK1OO(10),RK0OH(10),RK1OH(10)
      COMMON/POLAR_HOO_DMBE4/C4,C5
      COMMON/DAMPC_HOO_DMBE4/ADAMP(10),BDAMP(10)
      COMMON/REFGEO_HOO_DMBE4/R10,R20,R30
C     ***************************************************************
      DATA C/
     1  .49040645D+01, -.86748216D+01,  .50555792D+01,  .42941301D+01,
     1 -.41874792D+01,  .13461379D+00, -.99064922D+00,  .13358488D+01,
     1  .13495231D+01, -.18529696D+00, -.23534213D+02,  .24289930D+02,
     1 -.50209026D+01, -.10365484D+02,  .46692224D+01, -.14747138D+01,
     1  .23119718D+01, -.18247842D+01, -.28472166D+00,  .51036509D+00,
     1  .19124083D+00,  .45405729D+01,  .11087611D+00, -.19990481D+00,
     1 -.37356178D+00,  .46142042D-01, -.20565580D+00, -.27015963D+00,
     1  .34085281D+00,  .28321162D+00, -.11558481D+00, -.29448886D+00,
     1 -.52932488D+00,  .58159523D-01, -.48649560D-02,  .11949167D-01,
     1  .21409804D-01, -.20620608D-02,  .30177088D-01,  .27880291D-01,
     1  .88458711D-02,  .13137410D-01, -.24705619D-01, -.31085889D-01,
     1  .34317857D-02,  .52593878D-01,  .79500714D-01, -.79782216D-02,
     2  .31164575D-01, -.28737598D-01,  .98201698D+00,  .62000000D+00/
      DATA R0OO,RMOO,R0OH,RMOH/5.661693D0,2.2818D0,6.294894D0,1.8344D0/
      DATA COO/0.0D0,0.0D0,0.0D0,0.0D0,0.D0,15.40D0,0.0D0,235.219943D0,
     1         0.0D0,4066.23929D0/
      DATA COH/0.0D0,0.0D0,0.0D0,0.0D0,0.D0,10.00D0,0.0D0,180.447673D0,
     1         0.0D0,3685.25842D0/
      DATA C4,C5/-0.92921D0,-1.79000D0/
      DATA RK0OO/0.0D0,0.0D0,0.0D0,0.0D0,0.0D0,-.27847758D0,0.0D0,
     1           -.46815641D0,0.0D0,-1.20506384D0/
      DATA RK1OO/0.0D0,0.0D0,0.0D0,3.35224980D0,3.35224980D0,
     1           0.95273753D0,0.0D0,0.94148408D0,0.0D0,0.72379129D0/
      DATA RK0OH/0.0D0,0.0D0,0.0D0,0.0D0,0.0D0,0.02465005D0,0.0D0,
     1           0.05036950D0,0.0D0,0.06294371D0/
      DATA RK1OH/0.0D0,0.0D0,0.0D0,2.54532760D0,2.54532760D0,
     1           0.68758097D0,0.0D0,0.82542359D0,0.0D0,0.94034225D0/
      DATA ADAMP/0.0D0,0.0D0,0.0D0,5.0079875D0,3.8428294D0,3.0951333D0,
     1           0.0D0,2.1999000D0,0.0D0,1.6880714D0/
      DATA BDAMP/0.0D0,0.0D0,0.D0,10.6645006D0,9.6758155D0,8.7787895D0,
     1           0.0D0,7.2265123D0,0.0D0,5.9487108D0/
      DATA R10,R20,R30/2.5143000D0,2.6469057D0,2.6469057D0/
      END

