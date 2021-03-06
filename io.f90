MODULE IO
USE MPIINFO
USE DECLARATION
USE FLOW_OPERATIONS
use ISO_C_BINDING
USE TRANSFORM
contains


SUBROUTINE OUTWRITEGRIDB
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNODE112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='GRID.plt',EXIST=HEREV)

if (herev)then



else
if (n.eq.0)then

NullPtr = 0
      Debug   = 0
      FileType = 1
      VIsDouble = 1
      IMax    = imaxN
      JMax    = IMAXE
      KMax    = 0
      ZoneType = 5
      SolTime = 360.0
      StrandID = 0
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0
NULCHAR = CHAR(0)


ierr =  TecIni112('SIMPLE DATASET'//NULCHAR, &
                    'X Y Z'//NULCHAR, &
                    'GRID.plt'//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)


 ierr= TecZne112('GRID1'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Null, &
                    Null, &
                    ShrConn)




	
    allocate(xbin(imaxn))
    allocate(ybin(imaxn))
    allocate(zbin(imaxn))
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
        DO I=1,IMAXN
	READ(96,*)j,x,y,z
	xbin(i)=x/scaler
	ybin(i)=y/scaler
 	Zbin(i)=Z/scaler
	END DO

    CLOSE(96)


    ierr = TECDAT112(imaxn,xbin,1)  !!! why not xbin instead of xbin(1) ??
   
    ierr = TECDAT112(imaxn,ybin,1)

     ierr = TECDAT112(imaxn,zbin,1)
   
    deallocate(xbin,YBIN,zbin)
    OPEN(98,FILE='STAR.cel',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(8,1))
    icon=0
     cv=0
		DO K=1,iMAXE
               
 		read(98,*)i,Icon(1,1),icon(2,1),icon(3,1),icon(4,1),Icon(5,1),icon(6,1),icon(7,1),icon(8,1)
    
		ierr = TECNODE112(8,icon)
    !cv=cv+4
        	
		END DO
 		close(98)
		!ierr = TECNOD112(icon)
		deallocate(icon)	
         
        
  ierr = TECEND112()


END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
end if	
	

	
	

END SUBROUTINE OUTWRITEGRIDB



SUBROUTINE OUTWRITEGRIDB2D
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNODE112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='GRID.plt',EXIST=HEREV)

if (herev)then



else
if (n.eq.0)then

NullPtr = 0
      Debug   = 0
      FileType = 1
      VIsDouble = 1
      IMax    = imaxN
      JMax    = IMAXE
      KMax    = 0
      ZoneType = 3
      SolTime = 360.0
      StrandID = 0
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0
NULCHAR = CHAR(0)


ierr =  TecIni112('SIMPLE DATASET'//NULCHAR, &
                    'X Y'//NULCHAR, &
                    'GRID.plt'//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)


 ierr= TecZne112('GRID1'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Null, &
                    Null, &
                    ShrConn)




	
    allocate(xbin(imaxn))
    allocate(ybin(imaxn))
    
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
        DO I=1,IMAXN
	READ(96,*)j,x,y
	xbin(i)=x/scaler
	ybin(i)=y/scaler
 	
	END DO

    CLOSE(96)


    ierr = TECDAT112(imaxn,xbin,1)  !!! why not xbin instead of xbin(1) ??
   
    ierr = TECDAT112(imaxn,ybin,1)

    
   
    deallocate(xbin,YBIN)
    OPEN(98,FILE='STAR.cel',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(4,1))
    icon=0
     cv=0
		DO K=1,iMAXE
               
 		read(98,*)i,Icon(1,1),icon(2,1),icon(3,1),icon(4,1)
    
		ierr = TECNODE112(4,icon)
    !cv=cv+4
        	
		END DO
 		close(98)
		!ierr = TECNOD112(icon)
		deallocate(icon)	
         
        
  ierr = TECEND112()


END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
end if	
	

	
	

END SUBROUTINE OUTWRITEGRIDB2D
SUBROUTINE OUTWRITE3N
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


KMAXE=XMPIELRANK(N)



! DUMG=KMAXE
! call mpi_barrier(mpi_comm_world,IERROR)
! 
! CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
! IMAXP=DUML

! ALLOCATE(ICELL(IMAXE))
! ICELL=0

! DO I=1,KMAXE
!   ICELL(I)=IELEM(N,I)%IHEXGL
! END DO


! IF (N.EQ.0)THEN
! 	ALLOCATE(ICELLA(IMAXP*ISIZE))
! 	 ICELLA=0
! 
! END IF
! 
! call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)
! 
! ! if (n.eq.0)then
! ! write(1000+n,*)icella(:)
! ! 
! ! 
! ! end if
! 
! call mpi_barrier(mpi_comm_world,IERROR)
! deallocate (icell)




if (n.eq.0)then


allocate(xbin(imaxe))
allocate(variables(8))

 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="OUT_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	

end if



IF (ITESTCASE.EQ.3)THEN
	nvar1=2
if (n.eq.0)ierr =  TecIni112('sols1'//NULCHAR, &
                    'solution,sols2'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
END IF


	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 5
!       if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = 0.0
!       else
!       SolTime = IT
! 
!       end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


!  ALLOCATE(VALUESA(IMAXP*ISIZE))
!   allocate(xbin(imaxe))
! 	VALUESA=0.0
! 
!  END IF
! 
!   call mpi_barrier(MPI_COMM_WORLD,IERROR)
!   ALLOCATE(VALUESS(imaxp))
!   VALUESS=0.0
    
   


!   IF (ITESTCASE.LT.3)THEN
!     DO I=1,KMAXE
!       VALUESS(I)=U_C(I)%VAL(1,1)
!     END DO
! 
!     call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
! 
!     IF (N.EQ.0)THEN
!     do i=1,imaxp*isize
! 	if (icella(i).gt.0)then
! 	xbin(icella(i))=valuesa(i)
! 	end if
!     end do
    xbin(1:imaxe)=xmpie(1:imaxe)
	  

    ierr = TECDAT112(imaxe,XBIN,1)


    ierr = TECDAT112(imaxe,XBIN,1)

  ierr = TECEND112()
    deallocate(xbin,variables, valuelocation)
    END IF

     CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
! 
!   END IF
! 
! 
! 
! 
!     
! 
! 
! 
! 
! 
!   
! 
! 
! 
!   IF (ITESTCASE.ge.3)THEN
! 			  do j=1,nvar1
! 				  
! 				    if (j.eq.1)then
! 				    
! 				    DO I=1,KMAXE
! 				      
! 				      VALUESS(I)=U_C(I)%VAL(1,1)
! 				    END DO
! 				    else
! 				    if (j.lt.6)then
! 				    DO I=1,KMAXE
! 				      VALUESS(I)=U_C(I)%VAL(1,j)/U_C(I)%VAL(1,1)
! 				    END DO
! 				    end if
! 				    end if
! 				    if (j.eq.6)then
! 
! 				      DO I=1,KMAXE
! 											VARIABLES(1)=U_C(I)%VAL(1,1)
! 											VARIABLES(2)=(U_C(I)%VAL(1,2)/VARIABLES(1))
! 											VARIABLES(3)=(U_C(I)%VAL(1,3)/VARIABLES(1))
! 											VARIABLES(4)=(U_C(I)%VAL(1,4)/VARIABLES(1))
! 											VARIABLES(5)=U_C(I)%VAL(1,5)
! 									    VARIABLES(6)=((GAMMA-1.0))*((VARIABLES(5))-0.5*VARIABLES(1)*(((VARIABLES(2)**2.0)+(VARIABLES(3)**2.0)+(VARIABLES(4)**2.0))))
! 									    VALUESS(I)=VARIABLES(6)
! 
! 				    END DO
! 
! 				    
! 				    end if 
! 
! 				    IF (TURBULENCE.NE.1)THEN
! 					      IF (PASSIVESCALAR.GT.0)THEN
! 						      IF (J.EQ.7)THEN
! 						      DO I=1,KMAXE
! 							VALUESS(I)=U_CT(I)%VAL(1,1)
! 						      END DO
! 						      end if
! 					      END IF
! 				    END IF
!     
! 
! 					  if (turbulence.eq.1)then
! 								if (j.eq.7)then
! 										do i=1,kmaxe
! 														leftv(1:5)=U_C(I)%VAL(1,1:5)
! 														rightv(1:5)=leftv(1:5)
! 										  Call SUTHERLANDIi(N,LEFTV,RIGHTV,VISCL,LAML,PRES,RRES,GAMMA,VISC,BETAAS,SUTHER,PRANDTL)
! 												  Variables(1)=Viscl(1)/VISC
! 												  VALUESS(I)=VARIABLES(1)
! 									      end do
! 								end if
! 								if (j.eq.8)then
! 								  do i=1,kmaxe
! 				      leftv(1:5)=U_C(I)%VAL(1,1:5)
! 				      rightv(1:5)=leftv(1:5)
! 							Call SUTHERLANDII(N,LEFTV,RIGHTV,VISCL,LAML,PRES,RRES,GAMMA,VISC,BETAAS,SUTHER,PRANDTL)
! 							 EDDYFL(1)=IELEM(N,i)%WALLDIST
! 							  IF (TURBULENCEMODEL.EQ.1)THEN
! 							 EDDYFL(2)=U_CT(i)%VAL(1,1)*U_C(i)%VAL(1,1)
! 							 EDDYFL(3)=0
! 							  
! 							  END IF
! 							  IF (TURBULENCEMODEL.EQ.2)THEN
! 							 EDDYFL(2)=U_CT(i)%VAL(1,1)
! 							 EDDYFL(3)=U_CT(i)%VAL(1,2)
! 							  
! 							  END IF
! 							EDDYFL(4:6)=ILOCAL_RECON3(i)%GRADS(1,1:3)
! 							EDDYFL(7:9)=ILOCAL_RECON3(i)%GRADS(2,1:3)
! 							EDDYFL(10:12)=ILOCAL_RECON3(i)%GRADS(3,1:3)
! 							IF (TURBULENCEMODEL.EQ.2)THEN
! 							EDDYFL(13:15)=ILOCAL_RECON3(i)%GRADS(4,1:3)
! 							EDDYFL(16:18)=ILOCAL_RECON3(i)%GRADS(5,1:3)
! 							END IF
! 							EDDYFR=EDDYFL
! 							
! 							call EDDYVISCOo(N,VISCL,LAML,TURBMV,ETVM,LEFTV,RIGHTV,EDDYFL,EDDYFR)
! 							Variables(8) =  (VISCL(3))/VISC	
! 			VALUESS(I)=VARIABLES(8)
! 
! 								  end do
! 								end if
!    
! 							if (turbulencemodel.eq.2)then
! 							    if ((j.eq.9))then
! 							      DO I=1,KMAXE
! 								VALUESS(I)=U_CT(I)%VAL(1,1)
! 							      END DO
! 
! 							    end if
! 							    if ((j.eq.10))then
! 							      DO I=1,KMAXE
! 								VALUESS(I)=U_CT(I)%VAL(1,2)
! 							      END DO
! 
! 							    end if
! 							end if
! 
! 							IF (passivescalar.gt.0)THEN
! 								      IF (J.EQ.NVAR1-1)THEN
! 								    DO I=1,KMAXE
! 								      VALUESS(I)=U_CT(I)%VAL(1,turbulenceequations+passivescalar)
! 								    END DO
! 								      END IF
! 							 END IF
! 
! 
! 					  end if !turbulence
! 
! 
! 				    IF (IVORTEX.EQ.1)THEN
! 					      IF (J.EQ.NVAR1)THEN
! 						    DO I=1,KMAXE
! 						      VALUESS(I)=IELEM(N,i)%VORTEX
! 						    END DO
! 					    END IF
! 				    END IF
! 
! 
! 
! 
!       
!       CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
! 
!     
!     call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
! 
!      
! !       print*,"writing output var",j,nvar1,n
! 
!     
!     IF (N.EQ.0)THEN
!     do i=1,imaxp*isize
! 	if (icella(i).gt.0)then
! 	xbin(icella(i))=valuesa(i)
! 	end if
!     end do
!     
!     ierr = TECDAT112(imaxe,xbin,1)
!     END IF
!     
!       
! !       print*,"writing 1r",n
!       
!   end do
! 
! 
! 
!   END IF
!   IF (N.EQ.0)THEN
!   ierr = TECEND112()
!   DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
!   deallocate(out1)
!   END IF
!   DEALLOCATE (VALUESS)
!   
! 
! 
! 
! 
! 
! 
! 
! 
! 
! 
! 
!   CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
! 
! 
! 
! 
! 
! 
! ! 
! !     allocate(xbin(imaxe))
! !     ALLOCATE(FBIN(1,IMAXE))
! ! 
! !  
! !     do i=1,1
! !     fbin(i,:)=10.0
! !     end do
! !     
! !     do i=1,1
! !     xbin(:)=fbin(i,:)
! ! 
! !     ierr = TECDAT112(imaxe,xbin,1)  !!! why not xbin instead of xbin(1) ??
! !    end do
! 
! 		
!          
!         
!  deallocate(variables)









	
	
	
	
	

	
	

END SUBROUTINE OUTWRITE3N


SUBROUTINE OUTWRITE3vb
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
!       write(400+n,*)"edw2"
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO

! write(400+n,*)"edw3"
IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

! write(400+n,*)"edw4"
call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if
! write(400+n,*)"edw5"
call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)

! write(400+n,*)"edw6"


if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="OUT_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	

end if
call mpi_barrier(mpi_comm_world,IERROR)
 IF (ITESTCASE.LE.2)THEN
  NVAR1=2
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'solution1,SOLUTION2'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=7+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,k,omega'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,mu'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,k,omega'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,mu'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF

	

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 5
      
      SolTime = T
      
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0

 



 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    IF (ITESTCASE.LE.2)THEN
    DO I=1,KMAXE
      VALUESS(i)=U_C(I)%VAL(1,1)!0.0
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(imaxe,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
    DO I=1,KMAXE
      VALUESS(i)=n
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(imaxe,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
    
    
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(1,kkd)
		  if ((kkd.ge.2).and.(kkd.le.4))then
		  VALUESS(i)=U_C(I)%VAL(1,kkd)/U_C(I)%VAL(1,1)
		  end if
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		DO I=1,KMAXE
		  leftv(1:5)=U_C(I)%VAL(1,1:5)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(5)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,turbulenceequations+passivescalar)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  DO I=1,KMAXE
		      VALUESS(i)=ielem(n,i)%vortex(1)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,kkd)
		  END DO
		
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  end if
    
    
    end if
    
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3vb


SUBROUTINE OUTWRITE3v
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="OUT_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
		OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')

end if
call mpi_barrier(mpi_comm_world,IERROR)
 IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="solution"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
  
  if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  end if
  
      ELSE
     
     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
   end if
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=7+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","VORTEX","K","OMEGA"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED, [9] = CELLCENTERED,[10] = CELLCENTERED)'
	  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","VORTEX","MU"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED, [9] = CELLCENTERED)'
	  end if
              
              end if
              if (turbulenceequations.eq.0)then
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","VORTEX"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED)'
	  end if
              
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	                if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","VORTEX","K","OMEGA"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED)'
	  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                              if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","VORTEX","MU"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED)'
	  end if
             
              end if
              if (turbulenceequations.eq.0)then
                              if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","VORTEX"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
	  end if
              
              end if
	    
	    
	    
	    
	    end if
	   
 END IF

	IF (N.EQ.0)THEN
	    WRITE(97,*) ', SOLUTIONTIME=',T
	    END IF

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







Valuelocation(:)=0

 





 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    IF (ITESTCASE.LE.2)THEN
    DO I=1,KMAXE
      VALUESS(i)=U_C(I)%VAL(1,1)!0.0
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    
			WRITE(97,*)XBIN(1:IMAXE)
			
    
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(1,kkd)
		  if ((kkd.ge.2).and.(kkd.le.4))then
		  VALUESS(i)=U_C(I)%VAL(1,kkd)/U_C(I)%VAL(1,1)
		  end if
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		DO I=1,KMAXE
		  leftv(1:5)=U_C(I)%VAL(1,1:5)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(5)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,turbulenceequations+passivescalar)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  DO I=1,KMAXE
		      VALUESS(i)=ielem(n,i)%vortex(1)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,kkd)
		  END DO
		
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  end if
    
    
    end if
    
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  CLOSE(97)
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3v



SUBROUTINE OUTWRITE3v2d
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="OUT_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
		OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')

end if
call mpi_barrier(mpi_comm_world,IERROR)
 IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="solution"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=5+PASSIVESCALAR
  if (passivescalar.gt.0)then
  
  if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
  end if
  
      ELSE
     
     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED)'
   end if
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=7+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","K","OMEGA"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED, [9] = CELLCENTERED)'
	  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","MU"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED)'
	  end if
              
              end if
              if (turbulenceequations.eq.0)then
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
	  end if
              
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	                if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","VORTEX","K","OMEGA"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED)'
	  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                              if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","VORTEX","MU"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
	  end if
             
              end if
              if (turbulenceequations.eq.0)then
                              if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","VORTEX"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
	  end if
              
              end if
	    
	    
	    
	    
	    end if
	   
 END IF

	IF (N.EQ.0)THEN
	    WRITE(97,*) ', SOLUTIONTIME=',T
	    END IF

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







Valuelocation(:)=0

 





 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    IF (ITESTCASE.LE.2)THEN
    DO I=1,KMAXE
      VALUESS(i)=U_C(I)%VAL(1,1)!0.0
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    
			WRITE(97,*)XBIN(1:IMAXE)
			
    
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(1,kkd)
		  if ((kkd.ge.2).and.(kkd.le.3))then
		  VALUESS(i)=U_C(I)%VAL(1,kkd)/U_C(I)%VAL(1,1)
		  end if
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		DO I=1,KMAXE
		  leftv(1:4)=U_C(I)%VAL(1,1:4)
		  CALL CONS2PRIM2d(N)
		  VALUESS(i)=leftv(4)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,turbulenceequations+passivescalar)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  DO I=1,KMAXE
		      VALUESS(i)=ielem(n,i)%vortex(1)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,kkd)
		  END DO
		
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:IMAXE)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  end if
    
    
    end if
    
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  CLOSE(97)
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3v2d

SUBROUTINE OUTWRITE3vb2d
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="OUT_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	

end if

 IF (ITESTCASE.LE.2)THEN
  NVAR1=3
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'sol1,sol2,sol3'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=7+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,passivescalar,vortex,k,omega'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,passivescalar,vortex,mu'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,passivescalar,vortex'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,vortex,k,omega'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,vortex,mu'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                     'Density,U,V,energy,Pressure,vortex'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF

	
	
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 3
      
      SolTime = T
      
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    IF (ITESTCASE.LE.2)THEN
    DO I=1,KMAXE
      VALUESS(i)=U_C(I)%VAL(1,1)!0.0
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(imaxe,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
    DO I=1,KMAXE
      VALUESS(i)=ielem(n,i)%admis
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(imaxe,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
    
    DO I=1,KMAXE
      VALUESS(i)=n
    END DO
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(imaxe,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
    
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(1,kkd)
		  if (kkd.ge.2.and.kkd.le.3)then
		  VALUESS(i)=U_C(I)%VAL(1,kkd)/U_C(I)%VAL(1,1)
		  end if
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		DO I=1,KMAXE
		  leftv(1:4)=U_C(I)%VAL(1,1:4)
		  CALL CONS2PRIM2D(N)
		  VALUESS(i)=leftv(4)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,turbulenceequations+passivescalar)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  DO I=1,KMAXE
		      VALUESS(i)=ielem(n,i)%vortex(1)
		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  DO I=1,KMAXE
		      VALUESS(i)=U_CT(I)%VAL(1,kkd)
		  END DO
		
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(imaxe,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  end if
    
    
    end if
    
    
    
!     read_ucns

     
    
    
    
  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3vb2d




SUBROUTINE CHECKRES
IMPLICIT NONE
LOGICAL::HERE
INTEGER::I,J,K,L,ITER
 CHARACTER(LEN=20)::PROC,RESTFILE

 	RESTFILE='RESTART.dat'
	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	INQUIRE (FILE=RESTFILE,EXIST=HERE)
	IF (HERE) THEN
	OPEN(1083+N,FILE=RESTFILE,FORM='UNFORMATTED',STATUS='OLD',ACTION='READ')
	if (rungekutta.ne.5)then
	READ(1083+N)ITER,RES_TIME
	else
	READ(1083+N)ITER
	end if
	
	RESTART=ITER
	CLOSE(1083+N)
	ELSE
	RESTART=0
        average_restart=0
	RES_TIME=0.0
	END IF

	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

END SUBROUTINE CHECKRES

SUBROUTINE OPEN_ARBITRARY(N,IMAXE,IMAXN,IMAXB)
	IMPLICIT NONE
	INTEGER,INTENT(INOUT)::IMAXE,IMAXN,IMAXB
	INTEGER::I,J,K,IOS,IOX,IOZ,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,IOY
	CHARACTER(LEN=12)::PROC,VRTFILE,CELFILE,BNDFILE
	integer,ALLOCATABLE,dimension(:)::isent
	INTEGER,INTENT(IN)::N
		WRITE(PROC,FMT='(I10)') N
		CELFILE='STAR.cel'
		VRTFILE='STAR.vrt'
		BNDFILE='STAR.bnd'

	ALLOCATE(ISENT(3))

	IF (N.EQ.0)THEN
		OPEN(8,FILE=CELFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ',IOSTAT=IOS)
		OPEN(9,FILE=VRTFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ',IOSTAT=IOX)
		OPEN(10,FILE=BNDFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ',IOSTAT=IOY)
	I=0
	J=0
	K=0

	
	DO 
		READ(8,*,IOSTAT=IOS)I
		IF (IOS.NE.0) THEN
			EXIT
		END IF
		
	END DO
		IMAXE=i
	DO 
		READ(9,*,IOSTAT=IOX)J
		IF (IOX.NE.0) THEN
			EXIT
		END IF
		
	END DO
		IMAXN=J
	DO 
		READ(10,*,IOSTAT=IOY)K
		IF (IOY.NE.0) THEN
			EXIT
		END IF
 		
	END DO
	 		IMAXB=K
		

	CLOSE(8)
	CLOSE(9)
 	CLOSE(10)

	ISENT(1)=IMAXE
	ISENT(2)=IMAXN
	ISENT(3)=IMAXB

	

	END IF
	call MPI_Bcast( isent, 3, MPI_integer, 0 ,MPI_COMM_WORLD,IERROR )

	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	IMAXE=ISENT(1)
	IMAXN=ISENT(2)
	IMAXB=ISENT(3)
	DEALLOCATE(ISENT)
	
	
	END SUBROUTINE OPEN_ARBITRARY







SUBROUTINE OPEN_INPUT(N,ITT)
	IMPLICIT NONE
	INTEGER,INTENT(INOUT)::ITT
	INTEGER,INTENT(IN)::N
	CHARACTER(LEN=12)::VRTFILE,CELFILE
		CELFILE='STAR.cel'
		VRTFILE='STAR.vrt'
		OPEN(8,FILE=CELFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ')
		OPEN(9,FILE=VRTFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ')
		OPEN(15,FILE='UCNS3D.DAT',FORM='FORMATTED',STATUS='OLD',ACTION='READ')
	END SUBROUTINE OPEN_INPUT

SUBROUTINE CLOSE_INPUT(N,ITT)
 IMPLICIT NONE
 	INTEGER,INTENT(INOUT)::ITT
 	INTEGER,INTENT(IN)::N	
 	CLOSE(8)
 	CLOSE(9)
 	CLOSE(15)
 END SUBROUTINE CLOSE_INPUT



SUBROUTINE READ_UCNS3D

	IMPLICIT NONE

 	Integer :: INV
 	Real :: angledum
	CHARACTER(48)::STAMP1


	 READ(15,*)
    READ(15,*)
    READ(15,*)
    READ(15,*)
    ! Main Solver Settings
    READ(15,'(13x,A4)')iosolver
    READ(15,'(14x,A5)')ioturbulence
    READ(15,'(11x,A6)')iorestart
    READ(15,'(13x,A6)')ioaverage
    READ(15,'(9x,A8)')iometis
    READ(15,'(9x,F9.5)')SCALER
    READ(15,'(10x,A4)')iomemory
    READ(15,*) 
    READ(15,*) 
    ! Initial and Freestream Conditions
    READ(15,'(10x,A4)')ioic
    READ(15,'(6x,A7)')iobc
    READ(15,'(6x,F18.1)')Reynolds
    READ(15,'(8x,F9.5)')CharLength
    READ(15,'(5x,F9.5,F9.5,F9.5)')ufreestream,VVEL,WVEL
    READ(15,'(7x,F9.5)')RRES
    READ(15,'(5x,F9.5)')PRES
    READ(15,'(7x,F9.5)')AOA
    READ(15,'(7x,F9.5,F9.5,F9.5)')vectorx,vectory,vectorz
    READ(15,'(9x,F9.5)')GAMMA
    READ(15,'(6x,F9.5)')PRANDTL
    READ(15,*) 
    READ(15,*)
    ! Scalar Transport
    READ(15,'(16x,I2)')passivescalar
    READ(15,'(15x,F9.5)')SCHMIDT_LAM
    READ(15,'(16x,F9.5)')SCHMIDT_TURB
    READ(15,*) 
    READ(15,*)
    ! Spatial Scheme
    READ(15,'(15x,A6)')ioscheme
    READ(15,'(14x,I2)')spatialorder
    READ(15,'(14x,A6)')iocompact
    READ(15,'(11x,A7)')ioriemann
    READ(15,'(11x,A9)')iolimiter
    READ(15,'(9x,A6)')iorelax
    READ(15,'(8x,A8)')iopoly
    READ(15,'(12x,A7)')iogaussian
    READ(15,*) 
    READ(15,*)
    ! Temporal Discretization
    READ(15,'(15x,A4)')iotemporal
    READ(15,'(9x,F11.9)')timestep
    READ(15,'(8x,I4)')upperlimit
    READ(15,'(7x,F9.5)')CFL
    READ(15,'(11x,F9.5)')CFLMAX
    READ(15,*) 
    READ(15,*)
    ! Solution Control
    READ(15,'(11x,F15.11)')reSLIMIT
    READ(15,'(12x,I11)')NTMAX
    READ(15,'(9x,F9.5)')OUT_TIME
    READ(15,*) 
    READ(15,*)
    ! Output Control
    READ(15,'(9x,F9.5)')IEVERY
    READ(15,'(9x,F9.5)')IEVERYAV
    READ(15,'(13x,F9.5)')IEVERY2
    READ(15,'(10x,I9)')IFORCE
    READ(15,*)
    READ(15,*)
	    
	
	 IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      CALL DATE_and_time(STAMP1)
      WRITE(63,*)"AZURE Parallel Computation Start",STAMP1
      END IF

	!$OMP MASTER
	IF (NPROBES.GT.0)THEN
	IF (DIMENSIONA.EQ.3)THEN
	ALLOCATE(PROBEC(1:NPROBES,1:3))
	
	DO INV=1,NPROBES
	
	READ(15,*)PROBEC(INV,1),PROBEC(INV,2),PROBEC(INV,3)
	
	END DO
	ELSE
	ALLOCATE(PROBEC(1:NPROBES,1:2))
	
	DO INV=1,NPROBES
	
	READ(15,*)PROBEC(INV,1),PROBEC(INV,2)
	
	END DO
	END IF
	END IF
	!$OMP END MASTER
	
! 	alpha_inf1=beta_i1/beta_starinf-kappa_sst**2/(sigma_om1*sqrt(beta_starinf))  !Only constants
! 	alpha_inf2=beta_i2/beta_starinf-kappa_sst**2/(sigma_om2*sqrt(beta_starinf))  !Only constants
									



CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

if (governingequations.le.2)then
    if (dimensiona.eq.3)then
    nof_variables=5;dims=3
    else
    nof_variables=4;dims=2
    end if
else
 nof_variables=1
    if (dimensiona.eq.3)then
    dims=3
    else
    dims=2
    end if
 
 
 
end if


turbulenceequations=0
if (turbulence .eq.1) then
	if (turbulencemodel .eq. 1) then
		turbulenceequations=1
	else if (turbulencemodel .eq. 2) then
		turbulenceequations=2
	end if 
end if

if (turbulence.eq.0)then
turbulencemodel=0
end if


if (governingequations .eq. 1) then
  ITESTCASE = 4
  
  IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Navier-Stokes Solver Engaged'
      CLOSE(63)
   END IF
  
end if


if (governingequations .eq. 2) then
  ITESTCASE = 3
  turbulence = 0
  OUTSURF = 0
  IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Euler Solver Engaged'
      CLOSE(63)
   END IF
end if

if (governingequations .eq. 3) then
  ITESTCASE = 1
  turbulence = 0
    IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Linear Solver Engaged Sinewave'
      CLOSE(63)
   END IF
  
end if

if (governingequations .eq. 4) then
  ITESTCASE = 2
  turbulence = 0  
    IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Linear Solver Engaged SquareWave'
      CLOSE(63)
   END IF
  
 end if
 
if((governingequations.ne.1).and.(governingequations.ne.2).and.(governingequations.ne.3).and.(governingequations.ne.4))Then
  ITESTCASE=4
 
end if


If (ITESTCASE .eq. 4) Then
IVORTEX = 1
else
IVORTEX = 0
End if



if (swirl.eq.1)then
uvel=ZERO
end if

if (swirl.eq.0)then
uvel=ufreestream
end if

If (AOA .NE. 0.0D0) Then

angledum=(AOA*PI)/180.0d0
UVEL = COS(angledum)*ufreestream*VECTORX
WVEL = SIN(angledum)*ufreestream*VECTORZ
VVEL = SIN(angledum)*ufreestream*VECTORY



end if





! Set pressure
if ( PRES .lt. 0 ) PRES = RRES/GAMMA	
! Set dynamic free-stream viscosity
VISC = (RRES*ufreestream*CharLength)/Reynolds

firstorder = 0
! 1st order
If  (spatiladiscret .eq. 1 ) Then

  IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'----1st Order in Space|LINEAR Scheme'
      CLOSE(63)
   END IF

IORDER = spatialorder-1
TYPESTEN = 1
ISCHEME = 3
! firstorder is 1st order convective and 2nd order viscous
if (spatialorder.eq.1) then 
firstorder = 1;iorder=1
else
firstorder = 0
end if
IWENO =0
WENWRT = 1
IEXTEND = 3

end if
! MUSCL-TVD
If  (spatiladiscret .eq. 2 ) Then

  IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'----MUSCL Scheme Engaged----'
	if (ITESTCASE .eq. 4) Then
	write(63,*)'----Reynolds Number:',(RRES*ufreestream*CharLength)/VISC
	end if
      CLOSE(63)
   END IF
TYPESTEN = 1
ISCHEME = 3
IWENO = -1
WENWRT = 1
IEXTEND = 3

end if

If  (spatiladiscret .eq. 0 ) Then

  IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'----NO LIMITER----'
	if (ITESTCASE .eq. 4) Then
	write(63,*)'----Reynolds Number:',(RRES*ufreestream*CharLength)/VISC
	end if
      CLOSE(63)
   END IF
TYPESTEN = 1
ISCHEME = 3
IWENO = 0
WENWRT = 1
IEXTEND = 3

end if



! WENO 
If  (spatiladiscret .eq. 3) Then

 IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'----WENO Scheme Engaged'
      if (ITESTCASE .eq. 4) Then
      write(63,*)'----Reynolds Number:',(RRES*ufreestream*CharLength)/VISC
      end if
      CLOSE(63)
   END IF


   IF (DIMENSIONA.EQ.2)THEN
	if (EES.EQ.0)THEN
      TYPESTEN = 5
	End if
	if (EES.EQ.1)THEN
      TYPESTEN = 9
	End if
	if (EES.EQ.2)THEN
      TYPESTEN = 9
	End if
	
	if (EES.EQ.3)THEN
      TYPESTEN = 5
	End if
  
  
  ELSE
      if (EES.EQ.0)THEN
      TYPESTEN = 7
	End if
	if (EES.EQ.1)THEN
      TYPESTEN = 15
	End if
	if (EES.EQ.2)THEN
      TYPESTEN = 15
	End if
	if (EES.EQ.3)THEN
      TYPESTEN = 7
	End if
  
  
  
!   if (EES.EQ.1)THEN
! TYPESTEN = 15
!   ELSE
!   TYPESTEN=9
!   END IF
  
  
  
  
  END IF
  
!   write(100+n,*)typesten,"edw1"
  
  
ISCHEME = 3
IWENO = 1
IEXTEND = 18
!WENWRT = 1
end if	
! Spatial order 
if (( spatialorder .eq. 1 ) .or. (spatialorder .eq. 2)) then
IORDER = 1
ELSE
IORDER = spatialorder - 1
END IF

 IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Order of Accuracy in space:',spatialorder
      CLOSE(63)
   END IF

! Gaussian Quadrature Rule

if (guassianquadra.eq.0)then
IGQRULES=min(iorder,6)

else

if (guassianquadra.gt.1)then
IGQRULES = guassianquadra-1
else
IGQRULES =guassianquadra

end if

End if
! Temporal order
RUNGEKUTTA = temporder 

if ( iboundary .eq. 0 ) then 
IPERIODICITY = -3 
end if
if ( iboundary .eq. 1 ) then 
IPERIODICITY = 1 
end if


! WENO reconstruction
WENWRT=wenocnschar
LWCI1=wenocentralweight
ISPLIT = 1	
IWEIGHTLSQR = 0	
QRDE = 2
ISSF = 3


CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
 IF (N.EQ.0)THEN
      OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
      write(63,*)'Total Number of Processes:',isize
      CLOSE(63)
   END IF


NPROC=isize-1
 
UNWOU = 3
BETAAS=1.5d0
SUTHER=0.412158681d0



if (dimensiona.eq.2)emetis=5


if (fastest.eq.1)ischeme=1

if (rungekutta.ge.10)then

IGQRULES=1
end if
	

	END SUBROUTINE READ_UCNS3D


SUBROUTINE READ_INPUT(N,XMPIELRANK,XMPINRANK,XMPIE,XMPIN,IELEM,INODE,IMAXN,IMAXE,IBOUND,IMAXB,XMPINNUMBER,SCALER,inoder)
	IMPLICIT NONE
	TYPE(ELEMENT_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IELEM
	TYPE(NODE_NE),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::inoder
	TYPE(NODE_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::INODE
	INTEGER,ALLOCATABLE,DIMENSION(:,:,:),INTENT(INOUT)::XMPINNUMBER
	INTEGER,INTENT(IN)::N,IMAXN,IMAXE
	INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIE,XMPIN
	TYPE(BOUND_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IBOUND
	INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIELRANK,XMPINRANK
	INTEGER,INTENT(INOUT)::IMAXB
	REAL,INTENT(INOUT)::SCALER
	integer,allocatable,dimension(:)::nodep,nodec
	INTEGER::I,J,JI,K,LM,IEX,KMAXN,KK,KMAXE,print_out,kk2,shap,nodal,iftrue,kxk2
	INTEGER,DIMENSION(8)::IDV
	INTEGER::IT1,IT2,IT3,IT4,IT5,IT6,IT7,IT8,ITX,INX,IT55,in,out
	REAL::X,Y,Z

	

	KK=0; I=0; J=0; LM=0 ;kk2=1
	XMIN(N)=tolbig; YMIN(N)=tolbig; ZMIN(N)=tolbig
	XMAX(N)=-tolbig; YMAX(N)=-tolbig; ZMAX(N)=-tolbig
	CALL OPEN_INPUT(N,ITT)
        !OPEN(82,FILE="STAR.epart",FORM='FORMATTED',STATUS='OLD',ACTION='READ')
	KMAXE=XMPIELRANK(N)
	
	
 	if (dimensiona.eq.3)then


	ALLOCATE(iNODEr(n:n,imaxn))
	INODER(n,1:imaxn)%NUMBEROFNEIB=0
	INODER(n,1:imaxn)%ITOR=0
	DO J=1,IMAXE
	
	if (xmpie(j).eq.n)then

	KK=KK+1
	
	

	rEAD(8,*) ITX,IDV(1),IDV(2),IDV(3),IDV(4),IDV(5),IDV(6),IDV(7),IDV(8)

	    
		
				
	
	  do kxk2=1,8
	  inoder(n,idv(kxk2))%itor=idv(kxk2)
	 
	  end do
	  ielem(n,kk)%IHEXGL=itx
		IF ((IDV(5).NE.IDV(6)).AND.(IDV(6).NE.IDV(7)).AND.(IDV(7).NE.IDV(8)).AND.(IDV(3).NE.IDV(4)))THEN
		shap=1	;nodal=8
		IELEM(N,KK)%ISHAPE=shap
		ielem(n,kk)%ifca=6
		IELEM(N,KK)%nonodes=nodal
		allocate(ielem(n,kk)%nodes(nodal))
		ielem(n,kk)%nodes(1:nodal)=idv(1:nodal)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		
		
		END IF
		IF ((IDV(3).EQ.IDV(4)).AND.(IDV(5).EQ.IDV(6)).AND.(IDV(6).EQ.IDV(7)).AND.(IDV(7).EQ.IDV(8)))THEN
		shap=2	;nodal=4!TETRAHEDRAL ELEMENT
		IELEM(N,KK)%ISHAPE=shap
		allocate(ielem(n,kk)%nodes(nodal))
		IELEM(N,KK)%nonodes=nodal
		ielem(n,kk)%ifca=4
		ielem(n,kk)%nodes(1:3)=idv(1:3)
		ielem(n,kk)%nodes(4)=idv(5)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		END IF
		IF ((IDV(3).NE.IDV(4)).AND.(Idv(5).EQ.Idv(6)).AND.(IDV(6).EQ.IDV(7)).AND.(IDV(7).EQ.IDV(8)))THEN
		shap=3	;nodal=5!PYRAMIDAL ELEMENT
		IELEM(N,KK)%ISHAPE=shap
		allocate(ielem(n,kk)%nodes(nodal))
		ielem(n,kk)%ifca=5
		IELEM(N,KK)%nonodes=nodal
		ielem(n,kk)%nodes(1:nodal)=idv(1:nodal)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		END IF
		IF ((IDV(3).EQ.IDV(4)).AND.(IDV(5).NE.IDV(6)).AND.(IDV(7).EQ.IDV(8)))THEN
		shap=4	;nodal=6!PRISM ELEMENT
		IELEM(N,KK)%ISHAPE=shap
		ielem(n,kk)%ifca=5
		IELEM(N,KK)%nonodes=nodal
		allocate(ielem(n,kk)%nodes(nodal))
		ielem(n,kk)%nodes(1:3)=idv(1:3)
		ielem(n,kk)%nodes(4:6)=idv(5:7)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		END IF
		  
		
			
	
	
	else
	rEAD(8,*)


	end if 
	end do
	







	
	

	
	
	
	
 	else
	ALLOCATE(iNODEr(n:n,imaxn))
	INODER(:,:)%NUMBEROFNEIB=0
	INODER(:,:)%ITOR=0
	DO J=1,IMAXE
	
	if (xmpie(j).eq.n)then

	KK=KK+1
	
	

	rEAD(8,*) ITX,IDV(1),IDV(2),IDV(3),IDV(4)
	do kxk2=1,4
	  inoder(n,idv(kxk2))%itor=idv(kxk2)
	  
	  end do
	ielem(n,kk)%IHEXGL=itx
		IF ((IDV(3).NE.IDV(4)))THEN
		shap=5	;nodal=4	!QUADRILATERAL
		IELEM(N,KK)%ISHAPE=shap
		IELEM(N,KK)%nonodes=nodal
		allocate(ielem(n,kk)%nodes(nodal))
		ielem(n,kk)%ifca=4
		ielem(n,kk)%nodes(1:nodal)=idv(1:nodal)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		Else
		
		shap=6	;nodal=3!TRIANGULAR
		IELEM(N,KK)%ISHAPE=shap
		allocate(ielem(n,kk)%nodes(nodal))
		IELEM(N,KK)%nonodes=nodal
		ielem(n,kk)%ifca=3
		ielem(n,kk)%nodes(1:NODAL)=idv(1:nodal)
		allocate(ielem(n,kk)%SURF(ielem(n,kk)%ifca))
		
		END IF
		


	 

	  else
	rEAD(8,*)



	end if 
	end do
	end if

	
	
	

	
	  
      


	      if (dimensiona.eq.3)then
	      DO j=1,IMAXN

	      IF (INODER(N,J)%ITOR.gt.0)THEN


		READ(9,*)INX,X,Y,Z
		x=x/scaler; y=y/scaler;  z=z/scaler
		XMIN(N)=MIN(XMIN(N),X)
		YMIN(N)=MIN(YMIN(N),Y)
		ZMIN(N)=MIN(ZMIN(N),Z)
		XMAX(N)=MAX(XMAX(N),X)
		YMAX(N)=MAX(YMAX(N),Y)
		ZMAX(N)=MAX(ZMAX(N),Z)
		
		
		  ALLOCATE(INODER(N,J)%CORD(1:3))
		  INODER(N,J)%CORD(1)=X
		  INODER(N,J)%CORD(2)=Y
		  INODER(N,J)%CORD(3)=Z
		  
		
		
		
		else
		read(9,*)
		end if
		
		
		!print_out = KMaxE/5


		END DO
		else
		 DO j=1,IMAXN


		  IF (INODER(N,J)%ITOR.gt.0)THEN
		  

		    
! -------------------FOR DEBUGGING ONLY -----------------------------------------!
! 		READ(9,'(I14,1X,3ES16.9)')INX,X,Y,Z
! -------------------FOR DEBUGGING ONLY -----------------------------------------!
		READ(9,*)INX,X,Y
		x=x/scaler; y=y/scaler
		XMIN(N)=MIN(XMIN(N),X)
		YMIN(N)=MIN(YMIN(N),Y)
		
		XMAX(N)=MAX(XMAX(N),X)
		YMAX(N)=MAX(YMAX(N),Y)
		
		
		
		  ALLOCATE(INODER(N,J)%CORD(1:2))
		  INODER(N,J)%CORD(1)=X
		  INODER(N,J)%CORD(2)=Y
		  Else

		  read(9,*)
		  end if
		
		
		
		
		
		
		!print_out = KMaxE/5


		END DO



		end if
	
	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	 CALL CLOSE_INPUT(N,ITT)






	x=xmax(n);CALL MPI_ALLREDUCE(x,XMax,1,MPI_DOUBLE_PRECISION,MPI_Max,MPI_COMM_WORLD,IERROR)
	x=Ymax(n);CALL MPI_ALLREDUCE(x,ymax,1,MPI_DOUBLE_PRECISION,MPI_Max,MPI_COMM_WORLD,IERROR)
	x=Zmax(n);CALL MPI_ALLREDUCE(x,zmax,1,MPI_DOUBLE_PRECISION,MPI_max,MPI_COMM_WORLD,IERROR)
	x=xmin(n);CALL MPI_ALLREDUCE(x,XMIN,1,MPI_DOUBLE_PRECISION,MPI_Min,MPI_COMM_WORLD,IERROR)
	x=ymin(n);CALL MPI_ALLREDUCE(x,yMIN,1,MPI_DOUBLE_PRECISION,MPI_Min,MPI_COMM_WORLD,IERROR)
	x=zmin(n);CALL MPI_ALLREDUCE(x,zMIN,1,MPI_DOUBLE_PRECISION,MPI_Min,MPI_COMM_WORLD,IERROR)
		


! DUMMYOUT=TIMEC5
! DUMMYIN=0.0
! CALL MPI_ALLREDUCE(DUMMYOUT,DUMMYIN,1,MPI_DOUBLE_PRECISION,MPI_MAX,MPI_COMM_WORLD,IERROR)
! !CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
! TIMEC5=DUMMYIN








XPER = XMAX(N) - XMIN(N)
YPER = YMAX(N) - YMIN(N)
ZPER = ZMAX(N) - ZMIN(N)



	IF (N.EQ.0) then
	OPEN(63,FILE='history.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
	 WRITE(63,*)XPER,YPER,ZPER,"PERIODICS"
     	write(63,*)"MIN",XMIN(N),YMIN(N),ZMIN(N)
    	write(63,*)"MAX",XMAX(N),YMAX(N),ZMAX(N)
	CLOSE(63)
	END IF
	

	  
	END SUBROUTINE READ_INPUT





SUBROUTINE READ_INPUT_PERIOD(N,XMPIELRANK,XMPINRANK,XMPIE,XMPIN,IELEM,INODE,IMAXN,IMAXE,IBOUND,IMAXB,XMPINNUMBER,SCALER)
TYPE(ELEMENT_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IELEM
	TYPE(NODE_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::INODE
	INTEGER,ALLOCATABLE,DIMENSION(:,:,:),INTENT(INOUT)::XMPINNUMBER
	INTEGER,INTENT(IN)::N,IMAXN,IMAXE
	INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIE,XMPIN
	TYPE(BOUND_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IBOUND
	INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIELRANK,XMPINRANK
	INTEGER,INTENT(INOUT)::IMAXB
	REAL,INTENT(INOUT)::SCALER
	integer,allocatable,dimension(:)::nodep,nodec
	INTEGER::I,J,JI,K,LM,IEX,KMAXN,KK,KMAXE,print_out,kk2,shap,nodal,iftrue,kxk2
	INTEGER,DIMENSION(8)::IDV
	INTEGER::IT1,IT2,IT3,IT4,IT5,IT6,IT7,IT8,ITX,INX,IT55,in,out
	REAL::X,Y,Z


CALL OPEN_INPUT(N,ITT)


IF (DIMENSIONA.EQ.3)THEN
DO j=1,IMAXN


		  IF (INODER(N,J)%ITOR.gt.0)THEN
		READ(9,*)INX,X,Y,Z
		x=x/scaler; y=y/scaler ; Z=Z/scaler
		      IF (INODER(N,J)%NUMBEROFNEIB.EQ.0)THEN		
		      
		      
			ALLOCATE(INODER(N,J)%CORD(1:3))
! 			  if ((j.eq.709).or.(j.eq.710).or.(j.eq.693).or.(j.eq.692))then
! 			  write(1300+n,*)j,x,y,z
! 			  end if
			INODER(N,J)%CORD(1)=X
			INODER(N,J)%CORD(2)=Y
			INODER(N,J)%CORD(3)=Z
		      END IF
		  
		  else
		  
		  READ(9,*)
		  end if
END DO

ELSE
DO j=1,IMAXN


		  IF (INODER(N,J)%ITOR.gt.0)THEN
		READ(9,*)INX,X,Y
		x=x/scaler; y=y/scaler
		      IF (INODER(N,J)%NUMBEROFNEIB.EQ.0)THEN		
		      
		      
			ALLOCATE(INODER(N,J)%CORD(1:2))
			INODER(N,J)%CORD(1)=X
			INODER(N,J)%CORD(2)=Y
		      END IF
		  Else
		  read(9,*)
		  end if
END DO





END IF



CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	 CALL CLOSE_INPUT(N,ITT)






END SUBROUTINE READ_INPUT_PERIOD



SUBROUTINE stenprint(n)
integer,intent(in)::n
integer::i,j,k,inv,ismp,l,i1,i2,i3,i4,i5,i6,i7,i8,ixx
if (nprobes.gt.0)then
DO INV=1,NPROBES
				  WRITE(100+N,*)"EDW1",INV
				IF (PROBEI(N,inv).NE.0) THEN
				      DO ISMP=1,typesten
					WRITE(100+N,*)"EDW2",INV,ISMP
					DO  L=1,NUMNEIGHBOURS
					  IF (ILOCALSTENCIL(N,PROBEI(N,inv),ISMP,L).GT.0)THEN
					  write(100+n,*)"edw3",inv,ismp,l,ILOCALSTENCIL(N,PROBEI(N,inv),ISMP,L),xmpie(ILOCALSTENCIL(N,PROBEI(N,inv),ISMP,L))
					    OPEN(8,FILE='STAR.cel',FORM='FORMATTED',STATUS='OLD',ACTION='READ')
					    DO I=1,IMAXE
					    if (dimensiona.eq.3)then  
					    READ(8,*)IXX,I5,i6,i8,i7,i1,i2,i4,i3
					    else
					    READ(8,*)IXX,I1,i2,i3,i4

					    end if
						IF (IXX.EQ.ILOCALSTENCIL(N,PROBEI(N,inv),ISMP,L))THEN
						if (dimensiona.eq.3)then  
						WRITE(10+inv,"(8i9)")I6,I2,I1,I5,i8,i4,i3,i7
						else
						  WRITE(10+inv,"(4i9)")I1,i2,i3,i4

						end if
						if (l.eq.NUMNEIGHBOURS)then
						  WRITE(10+inv,*)
						end if
					      END IF
						 
					    END DO
					    CLOSE(8)
					  end if
					END DO
				      END DO
				   END IF
				  WRITE(100+N,*)"EDW11",INV
			    END DO
 			  

end if

 CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
end subroutine stenprint









Subroutine WallDistance(N,ielem,imaxe,XMPIELRANK)

Implicit None

TYPE(ELEMENT_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IELEM
INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIELRANK !,XMPINRANK
INTEGER,INTENT(IN)::N,IMAXE
Integer :: countwall,KmaxE,Countwallglobal,i,l,icpu,doyouhavewall,howmanyhavewall,counterall,j
Integer :: counterall2,wall1,wall2,wall3,wall4,wall5,wall6,IOY,wl1,wl2,wl3,wl4,k
Real,allocatable,dimension(:,:) :: WallElemArrayCord,WallElemArrayCordGlobal
Real :: Distance
CHARACTER(LEN=12)::BNDFILE,VRTFILE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Type :: Wallboundary
	    Integer :: GlobalID,wbid,wb1,wb2,wb3,wb4,NumNodes!,wbdescr
	    Real :: Wallx,Wally,Wallz
End Type
Type(Wallboundary),Allocatable,Dimension(:):: Wallbnd
Type :: NodesWall
	    Integer :: ID
	    Real :: wnx,wny,wnz
End Type
Type(NodesWall),Allocatable,Dimension(:):: Wallvrt
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! How many element for this block have wall
KMAXE=XMPIELRANK(N)
 countwall = 0
 Do i=1,KmaxE
    if (ielem(n,i)%interior.eq.1)then
    Do l=1,IELEM(N,I)%IFCA
	if (ielem(n,i)%ibounds(l).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(l))%icode.eq.4)then
	  countwall = countwall + 1
	      end if
	      
	End If
    End Do
    end if
End Do
! How many for all cpu blocks
CALL MPI_ALLREDUCE(countwall,Countwallglobal,1,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,IERROR)
CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
!  Print*,Countwallglobal,'total wall elements',N
Allocate(Wallbnd(Countwallglobal))

 countwall = 0
BNDFILE='STAR.bnd'
VRTFILE='STAR.vrt'
OPEN(10,FILE=BNDFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ',IOSTAT=IOY)
! Find the nodes id of the wall globally from the bnd file
 countwall = 0

DO I=1,IMAXB
	READ(10,*)wall1,wall2,wall3,wall4,wall5,wall6
	    If (wall6 .eq. 4) then	! wall face
		countwall = countwall + 1
		Wallbnd(countwall)%wbid = wall1 ; Wallbnd(countwall)%wb1 = wall2 ; Wallbnd(countwall)%wb2 = wall3 
		Wallbnd(countwall)%wb3 = wall4  ;Wallbnd(countwall)%wb4 = wall5  
	    End If
END DO
 CLOSE(10)

Allocate(Wallvrt(IMAXN))
OPEN(11,FILE=VRTFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ')
! Read Node coordinates and store
Do i = 1,imaxn
  Read(11,*)Wallvrt(i)%ID,Wallvrt(i)%wnx,Wallvrt(i)%wny,Wallvrt(i)%wnz
End Do
  Close(11)
! Compute and store wall face centers globally
Do i = 1,Countwallglobal

	wl1 = Wallbnd(i)%wb1 ;wl2 = Wallbnd(i)%wb2 ;wl3 = Wallbnd(i)%wb3 ;wl4 = Wallbnd(i)%wb4 ;
	IF (Wl4.EQ.Wl3)THEN
	WALLBND(I)%WALLX=(wallvrt(wl1)%wnx+Wallvrt(wl2)%wnx+wallvrt(wl3)%wnx)/3.0
	wallbnd(i)%wally=(wallvrt(wl1)%wny+wallvrt(wl2)%wny+wallvrt(wl3)%wny)/3.0
	wallbnd(i)%wallz=(wallvrt(wl1)%wnz+wallvrt(wl2)%wnz+wallvrt(wl3)%wnz)/3.0


	ELSE
	Wallbnd(i)%Wallx = (Wallvrt(wl1)%wnx + Wallvrt(wl2)%wnx + Wallvrt(wl3)%wnx + Wallvrt(wl4)%wnx)/4.0
	Wallbnd(i)%Wally = (Wallvrt(wl1)%wny + Wallvrt(wl2)%wny + Wallvrt(wl3)%wny + Wallvrt(wl4)%wny)/4.0
	Wallbnd(i)%Wallz = (Wallvrt(wl1)%wnz + Wallvrt(wl2)%wnz + Wallvrt(wl3)%wnz + Wallvrt(wl4)%wnz)/4.0
	END IF
End Do
! Find distance from element barycenter to the nearest wall for this block.
KMAXE=XMPIELRANK(N)
Do i=1,KmaxE
    Distance=TOLBIG 
	Do k = 1,Countwallglobal
	      If ( Distance .gt. (sqrt(((Wallbnd(k)%Wallx-Ielem(N,i)%xxc)**2) &
				     + ((Wallbnd(k)%Wally-Ielem(N,i)%yyc)**2)&
				     + ((Wallbnd(k)%Wallz-Ielem(N,i)%zzc)**2)))) Then
		Distance = sqrt(((Wallbnd(k)%Wallx-Ielem(N,i)%xxc)**2)&
			       +((Wallbnd(k)%Wally-Ielem(N,i)%yyc)**2)&
			       +((Wallbnd(k)%Wallz-Ielem(N,i)%zzc)**2))
		Ielem(N,i)%WallDist = Distance
		 IF (IELEM(N,I)%WALLDIST.LT.HYBRIDIST)THEN
		    IELEM(N,I)%HYBRID=1
		 END IF
		
	      End If
	End Do
End Do

DeAllocate(Wallbnd)
DeAllocate(Wallvrt)

End Subroutine


Subroutine WallDistance2d(N,ielem,imaxe,XMPIELRANK)

Implicit None

TYPE(ELEMENT_NUMBER),ALLOCATABLE,DIMENSION(:,:),INTENT(INOUT)::IELEM
INTEGER,ALLOCATABLE,DIMENSION(:),INTENT(IN)::XMPIELRANK !,XMPINRANK
INTEGER,INTENT(IN)::N,IMAXE
Integer :: countwall,KmaxE,Countwallglobal,i,l,icpu,doyouhavewall,howmanyhavewall,counterall,j
Integer :: counterall2,wall1,wall2,wall3,wall4,wall5,wall6,IOY,wl1,wl2,wl3,wl4,k
Real,allocatable,dimension(:,:) :: WallElemArrayCord,WallElemArrayCordGlobal
Real :: Distance
CHARACTER(LEN=12)::BNDFILE,VRTFILE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Type :: Wallboundary
	    Integer :: GlobalID,wbid,wb1,wb2,wb3,wb4,NumNodes!,wbdescr
	    Real :: Wallx,Wally,Wallz
End Type
Type(Wallboundary),Allocatable,Dimension(:):: Wallbnd
Type :: NodesWall
	    Integer :: ID
	    Real :: wnx,wny,wnz
End Type
Type(NodesWall),Allocatable,Dimension(:):: Wallvrt
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! How many element for this block have wall
KMAXE=XMPIELRANK(N)
 countwall = 0
 Do i=1,KmaxE
    if (ielem(n,i)%interior.eq.1)then
    Do l=1,IELEM(N,I)%IFCA
	if (ielem(n,i)%ibounds(l).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(l))%icode.eq.4)then
	  countwall = countwall + 1
	      end if
	       
	End If
    End Do
    end if
End Do
! How many for all cpu blocks
CALL MPI_ALLREDUCE(countwall,Countwallglobal,1,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,IERROR)
CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

!  Print*,Countwallglobal,'total wall elements',N
Allocate(Wallbnd(Countwallglobal))

 countwall = 0
BNDFILE='STAR.bnd'
VRTFILE='STAR.vrt'
OPEN(10,FILE=BNDFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ',IOSTAT=IOY)
! Find the nodes id of the wall globally from the bnd file
 countwall = 0

DO I=1,IMAXB
	READ(10,*)wall1,wall2,wall3,wall4,wall5,wall6
	    If (wall6 .eq. 4) then	! wall face
		countwall = countwall + 1
		Wallbnd(countwall)%wbid = wall1 ; Wallbnd(countwall)%wb1 = wall2 ; Wallbnd(countwall)%wb2 = wall3 
		Wallbnd(countwall)%wb3 = wall4  ;Wallbnd(countwall)%wb4 = wall5  
	    End If
END DO
 CLOSE(10)
! WRITE(200+N,*)COUNTWALL,"EDW KOITA POSA ELEMENTS ME TOIXO"
 
Allocate(Wallvrt(IMAXN))
OPEN(11,FILE=VRTFILE,FORM='FORMATTED',STATUS='OLD',ACTION='READ')
! Read Node coordinates and store
Do i = 1,imaxn
  Read(11,*)Wallvrt(i)%ID,Wallvrt(i)%wnx,Wallvrt(i)%wny
End Do
  Close(11)
! Compute and store wall face centers globally
Do i = 1,Countwallglobal

	wl1 = Wallbnd(i)%wb1 ;wl2 = Wallbnd(i)%wb2 ;wl3 = Wallbnd(i)%wb3 ;wl4 = Wallbnd(i)%wb4 ;
	
	WALLBND(I)%WALLX=(wallvrt(wl1)%wnx+Wallvrt(wl2)%wnx)/2.0
	wallbnd(i)%wally=(wallvrt(wl1)%wny+wallvrt(wl2)%wny)/2.0
	


	
End Do

! WRITE(200+N,*)"EDW KOITA POSA ELEMENTS ME TOIXO"
! Find distance from element barycenter to the nearest wall for this block.
KMAXE=XMPIELRANK(N)
Do i=1,KmaxE
    Distance=TOLBIG 
	Do k = 1,Countwallglobal
	      If ( Distance .gt. (sqrt(((Wallbnd(k)%Wallx-Ielem(N,i)%xxc)**2) &
				     + ((Wallbnd(k)%Wally-Ielem(N,i)%yyc)**2)))) Then
		Distance = sqrt(((Wallbnd(k)%Wallx-Ielem(N,i)%xxc)**2)&
			       +((Wallbnd(k)%Wally-Ielem(N,i)%yyc)**2))
		Ielem(N,i)%WallDist = Distance
		
		 IF (IELEM(N,I)%WALLDIST.LT.HYBRIDIST)THEN
		    IELEM(N,I)%HYBRID=1
		 END IF
		
	      End If
	End Do
! 	WRITE(200+N,*)"EDW1",I,IELEM(N,I)%WALLDIST
End Do

DeAllocate(Wallbnd)
DeAllocate(Wallvrt)

End Subroutine


SUBROUTINE OUTWRITEGRIDBs
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='SURF.plt',EXIST=HEREv)



if (herev)then
if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	inog(l)=1
	inog(m)=1
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
deallocate(inog)
end if








else


if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	inog(l)=1
	inog(m)=1
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2

NullPtr = 0
      Debug   = 0
      FileType = 1
      VIsDouble = 1
      IMax    = igf2
      JMax    = totwalls
      KMax    = 0
      ZoneType = 3
      SolTime = 360.0
      StrandID = 0
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0
NULCHAR = CHAR(0)


ierr =  TecIni112('SIMPLE DATASET'//NULCHAR, &
                    'X Y Z'//NULCHAR, &
                    'SURF.plt'//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)


 ierr= TecZne112('WALLS'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Null, &
                    Null, &
                    ShrConn)




	
    allocate(xbin(igf2))
    allocate(ybin(igf2))
    allocate(zbin(igf2))
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	igf2=0
        DO I=1,IMAXN
	READ(96,*)j,x,y,z
	    
      if (inog(i).eq.1)then
      igf2=igf2+1
      inog(i)=igf2
      
	xbin(igf2)=x/scaler
	ybin(igf2)=y/scaler
 	Zbin(igf2)=Z/scaler
	end if
	END DO

    CLOSE(96)


    ierr = TECDAT112(igf2,xbin,1)  !!! why not xbin instead of xbin(1) ??
   
    ierr = TECDAT112(igf2,ybin,1)

     ierr = TECDAT112(igf2,zbin,1)
   
    deallocate(xbin,YBIN,zbin)
    OPEN(98,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(4,totwalls))
    icon=0
     cv=0
		igf2=0
		DO K=1,iMAXB
               
 		read(98,*)igf,i,j,l,m,o
		  if (o.eq.4)then
		  igf2=igf2+1
		  icon(1,igf2)=inog(i)
		  icon(2,igf2)=inog(j)
		  icon(3,igf2)=inog(l)
		  icon(4,igf2)=inog(m)
    
		end if
    !cv=cv+4
        	
		END DO
	    
 		close(98)
		ierr = TECNOD112(icon)
		!ierr = TECNOD112(icon)
		deallocate(icon)	
		deallocate(inog)
         
        
  ierr = TECEND112()


END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
	end if
	

	
	

END SUBROUTINE OUTWRITEGRIDBs



SUBROUTINE OUTWRITEGRIDs
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='SURF.plt',EXIST=HEREv)



if (herev)then
if ((n.eq.0).and.(totwalls.gt.0))then



OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	inog(l)=1
	inog(m)=1
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
deallocate(inog)
end if








else


if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	inog(l)=1
	inog(m)=1
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
	OPEN(97,FILE='SURF.plt',FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
	WRITE(97,*)'TITLE="GRID"'
	WRITE(97,*)'FILETYPE=GRID'
	WRITE(97,*)'VARIABLES="X","Y","Z"'
	WRITE(97,*)'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'







	
    allocate(xbin(igf2))
    allocate(ybin(igf2))
    allocate(zbin(igf2))
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	igf2=0
        DO I=1,IMAXN
	READ(96,*)j,x,y,z
	    
      if (inog(i).eq.1)then
      igf2=igf2+1
      inog(i)=igf2
      
	xbin(igf2)=x/scaler
	ybin(igf2)=y/scaler
 	Zbin(igf2)=Z/scaler
	end if
	END DO

    CLOSE(96)

    
	WRITE(97,*)XBIN(1:IGF2)
	WRITE(97,*)YBIN(1:IGF2)
	WRITE(97,*)ZBIN(1:IGF2)
    
   
   
    deallocate(xbin,YBIN,zbin)
    OPEN(98,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(4,totwalls))
    icon=0
     cv=0
		igf2=0
		DO K=1,iMAXB
               
 		read(98,*)igf,i,j,l,m,o
		  if (o.eq.4)then
		  igf2=igf2+1
		  icon(1,igf2)=inog(i)
		  icon(2,igf2)=inog(j)
		  icon(3,igf2)=inog(l)
		  icon(4,igf2)=inog(m)
    
		end if
    !cv=cv+4
        	
		END DO
	    
 		close(98)
 		
 		DO I=1,IGF2
 		WRITE(97,*)ICON(1:4,I)
 		END DO
 		
	
		deallocate(icon)	
		deallocate(inog)
         
        CLOSE(97)
  
END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
	end if
	

	
	

END SUBROUTINE OUTWRITEGRIDs



SUBROUTINE OUTWRITEGRIDs2D
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='SURF.plt',EXIST=HEREv)



if (herev)then
if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
deallocate(inog)
end if








else


if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
OPEN(97,FILE='SURF.plt',FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
WRITE(97,*)'TITLE="GRID"'
	WRITE(97,*)'FILETYPE=GRID'
	WRITE(97,*)'VARIABLES="X","Y"'
	WRITE(97,*)'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FELINE,','DATAPACKING = BLOCK'







	
    allocate(xbin(igf2))
    allocate(ybin(igf2))
    
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	igf2=0
        DO I=1,IMAXN
	READ(96,*)j,x,y
	    
      if (inog(i).eq.1)then
      igf2=igf2+1
      inog(i)=igf2
      
	xbin(igf2)=x/scaler
	ybin(igf2)=y/scaler
 	
	end if
	END DO

    CLOSE(96)

    
	WRITE(97,*)XBIN(1:IGF2)
	WRITE(97,*)YBIN(1:IGF2)
	
    
   
   
    deallocate(xbin,YBIN)
    OPEN(98,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(2,totwalls))
    icon=0
     cv=0
		igf2=0
		DO K=1,iMAXB
               
 		read(98,*)igf,i,j,l,m,o
		  if (o.eq.4)then
		  igf2=igf2+1
		  icon(1,igf2)=inog(i)
		  icon(2,igf2)=inog(j)
		  
    
		end if
    !cv=cv+4
        	
		END DO
	    
 		close(98)
 		
 		DO I=1,IGF2
 		WRITE(97,*)ICON(1:2,I)
 		END DO
 		
	
		deallocate(icon)	
		deallocate(inog)
         
        CLOSE(97)
  
END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
	end if
	

	
	

END SUBROUTINE OUTWRITEGRIDs2D



SUBROUTINE OUTWRITEGRIDBs2d
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
INTEGER,DIMENSION(70)::IVALID
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
     

INQUIRE (FILE='SURF.plt',EXIST=HEREv)



if (herev)then
if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2
deallocate(inog)
end if








else


if ((n.eq.0).and.(totwalls.gt.0))then
OPEN(96,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
allocate (inog(imaxn))
inog(:)=0
do i=1,imaxb
	read(96,*)igf,k,j,l,m,o
	if (o.eq.4)then
	inog(k)=1
	inog(j)=1
	
	end if
end do
 close(96)
igf2=0
do i=1,imaxn
      if (inog(i).eq.1)then
      igf2=igf2+1
      end if

end do
	
itotalb=igf2

NullPtr = 0
      Debug   = 0
      FileType = 1
      VIsDouble = 1
      IMax    = igf2
      JMax    = totwalls
      KMax    = 0
      ZoneType = 1
      SolTime = 360.0
      StrandID = 0
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0
NULCHAR = CHAR(0)


ierr =  TecIni112('SIMPLE DATASET'//NULCHAR, &
                    'X Y'//NULCHAR, &
                    'SURF.plt'//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)


 ierr= TecZne112('WALLS'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Null, &
                    Null, &
                    ShrConn)




	
    allocate(xbin(igf2))
    allocate(ybin(igf2))
   
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	igf2=0
        DO I=1,IMAXN
	READ(96,*)j,x,y
	    
      if (inog(i).eq.1)then
      igf2=igf2+1
      inog(i)=igf2
      
	xbin(igf2)=x/scaler
	ybin(igf2)=y/scaler
 	
	end if
	END DO

    CLOSE(96)


    ierr = TECDAT112(igf2,xbin,1)  !!! why not xbin instead of xbin(1) ??
   
    ierr = TECDAT112(igf2,ybin,1)

    
   
    deallocate(xbin,YBIN)
    OPEN(98,FILE='STAR.bnd',FORM='FORMATTED',STATUS='old',ACTION='read')
	  allocate(icon(2,totwalls))
    icon=0
     cv=0
		igf2=0
		DO K=1,iMAXB
               
 		read(98,*)igf,i,j,l,m,o
		  if (o.eq.4)then
		  igf2=igf2+1
		  icon(1,igf2)=inog(i)
		  icon(2,igf2)=inog(j)
		 
    
		end if
    !cv=cv+4
        	
		END DO
	    
 		close(98)
		ierr = TECNOD112(icon)
		!ierr = TECNOD112(icon)
		deallocate(icon)	
		deallocate(inog)
         
        
  ierr = TECEND112()


END IF





	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
	end if
	

	
	

END SUBROUTINE OUTWRITEGRIDBs2d


SUBROUTINE OUTWRITEGRID(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,i6,i7,i8,DECOMF,KD
INTEGER::INX,I,K,J,M,O,P,Q,JK
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
 




if (n.eq.0)then 

ICPUID=N
	KK=0
	WRITE(PROC3,FMT='(I10)') IXXFF
	OUTFILE='GRID.dat'
! 	OUTFILE='OUT.'//TRIM(ADJUSTL(PROC3))
	
	
	IF (N.EQ.0)THEN
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	
	
	WRITE(97,*)'TITLE="GRID"'
	WRITE(97,*)'FILETYPE=GRID'
	WRITE(97,*)'VARIABLES="X","Y","Z"'
	WRITE(97,*)'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEBRICK,','DATAPACKING = BLOCK'
	
	
	
	DO I=1,IMAXN
		READ(96,*)j,X
		WRITE(97,*)X/SCALER
	END DO

	CLOSE(96)
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	DO I=1,IMAXN
		READ(96,*)j,X,Y
		WRITE(97,*)Y/SCALER
	END DO
	CLOSE(96)
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	DO I=1,IMAXN
		READ(96,*)j,X,Y,Z
		WRITE(97,*)Z/SCALER
	END DO
	CLOSE (97)
	CLOSE(96)

	END IF	
	
	OPEN(96,FILE='STAR.cel',FORM='FORMATTED',STATUS='old',ACTION='read')
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='old',ACTION='WRITE',POSITION='APPEND')
	do i=1,imaxe
	      read(96,*)ix,I5,I6,I8,I7,I1,I2,I4,I3
	      write(97,*)I6,I2,I1,I5,I8,I4,I3,I7
	end do
	close(96)
	close(97)
END IF
END SUBROUTINE OUTWRITEGRID


SUBROUTINE OUTWRITEGRID2d(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,i6,i7,i8,DECOMF,KD
INTEGER::INX,I,K,J,M,O,P,Q,JK
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE
 




if (n.eq.0)then 

ICPUID=N
	KK=0
	WRITE(PROC3,FMT='(I10)') IXXFF
	OUTFILE='GRID.dat'
! 	OUTFILE='OUT.'//TRIM(ADJUSTL(PROC3))
	
	
	IF (N.EQ.0)THEN
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	
	
	WRITE(97,*)'TITLE="GRID"'
	WRITE(97,*)'FILETYPE=GRID'
	WRITE(97,*)'VARIABLES="X","Y"'
	WRITE(97,*)'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	
	
	
	DO I=1,IMAXN
		READ(96,*)j,X
		WRITE(97,*)X/SCALER
	END DO

	CLOSE(96)
	OPEN(96,FILE='STAR.vrt',FORM='FORMATTED',STATUS='old',ACTION='read')
	DO I=1,IMAXN
		READ(96,*)j,X,Y
		WRITE(97,*)Y/SCALER
	END DO
	CLOSE(96)
	
	CLOSE (97)
	

	END IF	
	
	OPEN(96,FILE='STAR.cel',FORM='FORMATTED',STATUS='old',ACTION='read')
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='old',ACTION='WRITE',POSITION='APPEND')
	do i=1,imaxe
	      read(96,*)ix,I1,I2,I3,I4
	      write(97,*)I1,I2,I3,I4
	end do
	close(96)
	close(97)
	
END IF
END SUBROUTINE OUTWRITEGRID2d


SUBROUTINE OUTWRITE3vSb
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD

end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'solution'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,k,omega,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,mu,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,k,omega,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,mu,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 3
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(1,1)
					  ENDDO
					  END IF


		      
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(1,KKD)
						if ((kkd.ge.2).and.(kkd.le.4))then
						valuess(i)=U_C(IBOUND_T(I))%VAL(1,kkd)/U_C(IBOUND_T(I))%VAL(1,1)
						end if	
					  ENDDO
					  END IF
		
		     
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
					IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						leftv(1:5)=U_C(IBOUND_T(I))%VAL(1,1:5)
						CALL CONS2PRIM(N)
						VALUESS(i)=leftv(5)
						
					  ENDDO
					  END IF
		     
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(i)=U_CT(IBOUND_T(I))%VAL(1,turbulenceequations+passivescalar)
												
					  ENDDO
					  END IF
		  
		  
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  
		  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(i)=ielem(n,IBOUND_T(I))%vortex(1)
												
					  ENDDO
					  END IF
		  
		  
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
		  
		   IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(i)=u_ct(IBOUND_T(I))%val(1,kkd)
												
					  ENDDO
					  END IF
		  
		  
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  do kkd=1,3
		  
				      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						
					 ICONSI=IBOUND_T(I)
					 ICONSIDERED=IBOUND_T2(I)
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y(ICONSI,ICONSIDERED)
					 CASE(3)
					 call SHEAR_Z(ICONSI,ICONSIDERED)
					 END SELECT
				       		VALUESS(i)=SHEAR_TEMP					
					  ENDDO
					  END IF
		  
		  
		  
		  
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vSb


SUBROUTINE OUTWRITE3vSb2d
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN

DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD

end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'solution'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,k,omega,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,mu,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,k,omega,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,mu,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 1
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=zero

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=zero
    
   
IF (ITESTCASE.LE.2)THEN
		     
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(1,1)
					  ENDDO
					  END IF
    
    
     
    
    
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		     IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(1,kkd)
							    if ((kkd.ge.2).and.(kkd.le.3))then
			      valuess(i)=U_C(IBOUND_T(I))%VAL(1,kkd)/U_C(IBOUND_T(I))%VAL(1,1)
			      end if	
						
						
					  ENDDO
		  END IF
		
		
		      
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					  leftv(1:4)=U_C(IBOUND_T(I))%VAL(1,1:4)
				    CALL CONS2PRIM2d(N)
				    VALUESS(i)=leftv(4)
					end do	
			      end if	
			
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  
		  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					VALUESS(i)=U_Ct(IBOUND_T(I))%VAL(1,turbulenceequations+passivescalar)
					end do	
			      end if	
		  
		  
		   
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					VALUESS(i)=ielem(n,IBOUND_T(I))%vortex(1)
					end do	
			      end if	
		 
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		   IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					VALUESS(i)=u_ct(IBOUND_T(I))%val(1,kkd)
					end do	
			      end if
		  
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  do kkd=1,2
			    IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					  ICONSI=IBOUND_T(I)
					  ICONSIDERED=IBOUND_t2(i)
					  select case(kkd)
					 case(1)
					 
					 call SHEAR_X2d(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y2d(ICONSI,ICONSIDERED)
					 
					 END SELECT
					VALUESS(i)=SHEAR_TEMP
					end do	
			      end if
		 
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vSb2d



SUBROUTINE OUTWRITE3vS
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD
OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
end if








		
   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  end if





IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  
  
   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="solution"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 
                    
                    
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  end if
     ELSE
     
     
     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
  end if
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      
                    
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","k","omega","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED,[13] = CELLCENTERED)'
  end if
                    
                    
                    
              end if
              if (turbulenceequations.eq.1)then
              
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","MU","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.0)then
              
                if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED,[11] = CELLCENTERED)'
  end if
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","k","omega","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.1)then
              
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","M","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED,[11] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.0)then
         
               if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED)'
  end if
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







     

Valuelocation(:)=0





 


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(1,1)
				END IF
		      end do
		      end if
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    WRITE(97,*)XBIN(1:TOTWALLS)
    
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(1,kkd)
				if ((kkd.ge.2).and.(kkd.le.4))then
		  valuess(icount_wall)=U_C(IBOUND(N,i)%which)%VAL(1,kkd)/U_C(IBOUND(N,i)%which)%VAL(1,1)
		  end if	
				END IF
		      end do
		      end if
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		 WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
    
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    leftv(1:5)=U_C(IBOUND(N,i)%which)%VAL(1,1:5)
				    CALL CONS2PRIM(N)
				    VALUESS(icount_wall)=leftv(5)
				  
				END IF
		      end do
		      end if
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		 WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		   IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=U_Ct(IBOUND(N,i)%which)%VAL(1,turbulenceequations+passivescalar)
				  
				END IF
		      end do
		      end if
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=ielem(n,IBOUND(N,i)%which)%vortex(1)
				  
				END IF
		      end do
		      end if
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=u_ct(IBOUND(N,i)%which)%val(1,kkd)
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,3
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
					ICONSI=IBOUND(N,i)%which
					 ICONSIDERED=IBOUND(N,i)%FACE
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y(ICONSI,ICONSIDERED)
					 CASE(3)
					 call SHEAR_Z(ICONSI,ICONSIDERED)
					 END SELECT
				       		VALUESS(icount_wall)=SHEAR_TEMP		
				       
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vS


SUBROUTINE OUTWRITE3vS2d
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD
	OPEN(97,FILE=outfile,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
	




end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="SOLUTION"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
 
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 
                    
                     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
  end if
     ELSE
      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED)'
  end if
!      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
!                     'Density,U,V,energy,Pressure'//NULCHAR, &
!                     out1//NULCHAR, &
!                     '.'//NULCHAR, &
!                     FileType, &
!                     Debug, &
!                     VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","K","OMEGA","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED, [11] = CELLCENTERED)'
  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","M","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED)'
  end if
              
              end if
              if (turbulenceequations.eq.0)then
               if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED)'
  end if
              
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	             if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","K","OMEGA","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED)'
  end if
! 	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
!                     'Density,U,V,energy,Pressure,vortex,k,omega,ssx,ssy'//NULCHAR, &
!                     out1//NULCHAR, &
!                     '.'//NULCHAR, &
!                     FileType, &
!                     Debug, &
!                     VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","MU","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED)'
  end if
              
              end if
              if (turbulenceequations.eq.0)then
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED)'
	
  end if
              
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 1
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





!  ierr= TecZne112('GRID2'//NULCHAR, &
!                     ZoneType, &
!                     IMax, &
!                     JMax, &
!                     kmax, &
!                     ICellMax, &
!                     JCellMax, &
!                     KCellMax, &
!                     SolTime, &
!                     StrandID, &
!                     ParentZn, &
!                     IsBlock, &
!                     NFConns, &
!                     FNMode, &
!                     0, &
!                     0, &
!                     0, &
!                     Null, &
!                     Valuelocation, &
!                     Null, &
!                     ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(1,1)
				END IF
		      end do
		      end if
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    WRITE(97,*)XBIN(1:TOTWALLS)
!     ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(1,kkd)
				if ((kkd.ge.2).and.(kkd.le.3))then
		  valuess(icount_wall)=U_C(IBOUND(N,i)%which)%VAL(1,kkd)/U_C(IBOUND(N,i)%which)%VAL(1,1)
		  end if	
				END IF
		      end do
		      end if
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
    
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    leftv(1:4)=U_C(IBOUND(N,i)%which)%VAL(1,1:4)
				    CALL CONS2PRIM2d(N)
				    VALUESS(icount_wall)=leftv(4)
				  
				END IF
		      end do
		      end if
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		   IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=U_Ct(IBOUND(N,i)%which)%VAL(1,turbulenceequations+passivescalar)
				  
				END IF
		      end do
		      end if
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=ielem(n,IBOUND(N,i)%which)%vortex(1)
				  
				END IF
		      end do
		      end if
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=u_ct(IBOUND(N,i)%which)%val(1,kkd)
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,2
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
					ICONSI=IBOUND(N,i)%which
					 ICONSIDERED=IBOUND(N,i)%FACE
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X2d(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y2d(ICONSI,ICONSIDERED)
					 
					 END SELECT
				       		VALUESS(icount_wall)=SHEAR_TEMP		
				       
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
 
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vS2d




SUBROUTINE OUTWRITE3vbav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(13))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="VOL_AVER_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	

end if
call mpi_barrier(mpi_comm_world,IERROR)

  NVAR1=11
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'R_mean,U_mean,V_mean,W_mean,P_mean,U_rms,V_rms,W_rms,UV,UW,WV'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 

	

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 5
      
      SolTime = T
      
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0

 



 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    
    
    		do kkd=1,5
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(5,kkd)
		  if ((kkd.ge.2).and.(kkd.le.4))then
		  VALUESS(i)=U_C(I)%VAL(5,kkd)/U_C(I)%VAL(5,1)
		  end if
		  if (kkd.eq.5)then
		   leftv(1:5)=U_C(I)%VAL(5,1:5)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(5)
		  
		  end if
		  
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
		do kkd=1,6
    		DO I=1,KMAXE
		  
		  VALUESS(i)=U_C(I)%RMS(kkd)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		END DO
    
		  
    
    
      
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3vbav

SUBROUTINE OUTWRITE3vb2Dav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="VOL_AVER_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	

end if
call mpi_barrier(mpi_comm_world,IERROR)

  NVAR1=7
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'R_mean,U_mean,V_mean,P_mean,U_rms,V_rms,UV'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 

	

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 3
      
      SolTime = T
      
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0

 



 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    
    
    		do kkd=1,4
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(5,kkd)
		  if ((kkd.ge.2).and.(kkd.le.3))then
		  VALUESS(i)=U_C(I)%VAL(5,kkd)/U_C(I)%VAL(5,1)
		  end if
		  if (kkd.eq.4)then
		   leftv(1:4)=U_C(I)%VAL(5,1:4)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(4)
		  
		  end if
		  
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
		do kkd=1,3
    		DO I=1,KMAXE
		  
		  VALUESS(i)=U_C(I)%RMS(kkd)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(imaxe,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		END DO
    
		  
    
    
      
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3vb2Dav



SUBROUTINE OUTWRITE3vav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(13))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="VOL_AVER_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
 WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="R_mean","U_mean","V_mean","W_mean","P_mean","U_rms","V_rms","W_rms","UV","UW","WV"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED)'
end if
call mpi_barrier(mpi_comm_world,IERROR)

  
  
      
  
  
 

	

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))









 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    
    
    		do kkd=1,5
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(5,kkd)
		  if ((kkd.ge.2).and.(kkd.le.4))then
		  VALUESS(i)=U_C(I)%VAL(5,kkd)/U_C(I)%VAL(5,1)
		  end if
		  if (kkd.eq.5)then
		   leftv(1:5)=U_C(I)%VAL(5,1:5)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(5)
		  
		  end if
		  
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
		do kkd=1,6
    		DO I=1,KMAXE
		  
		  VALUESS(i)=U_C(I)%RMS(kkd)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		END DO
    
		  
    
    
      
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3vav

SUBROUTINE OUTWRITE3v2Dav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD
REAL,allocatable,DIMENSION(:)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)
allocate(variables(10))

KMAXE=XMPIELRANK(N)

DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then





 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="VOL_AVER_"//TRIM(ADJUSTL(PROC3))//".plt"!//TRIM(ADJUSTL(PROC4))
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
	OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')

end if
call mpi_barrier(mpi_comm_world,IERROR)


  
  IF (N.EQ.0)THEN
        WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="R_mean","U_mean","V_mean","P_mean","U_rms","V_rms","UV"'
	WRITE(97,*) 'Zone N=',IMAXN,',E=',IMAXE,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  END IF


  NVAR1=7
  
  
  
  
 

	

	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = imaxn
      JMax    = IMAXe
      KMax    = 0
      ZoneType = 3
      
      SolTime = T
      
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0

 






 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe))
	VALUESA=ZERO

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO
    
   


    
    
    		do kkd=1,4
		DO I=1,KMAXE
		  VALUESS(i)=U_C(I)%VAL(5,kkd)
		  if ((kkd.ge.2).and.(kkd.le.3))then
		  VALUESS(i)=U_C(I)%VAL(5,kkd)/U_C(I)%VAL(5,1)
		  end if
		  if (kkd.eq.4)then
		   leftv(1:4)=U_C(I)%VAL(5,1:4)
		  CALL CONS2PRIM(N)
		  VALUESS(i)=leftv(4)
		  
		  end if
		  
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*) XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
		do kkd=1,3
    		DO I=1,KMAXE
		  
		  VALUESS(i)=U_C(I)%RMS(kkd)
		END DO
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*) XBIN(1:IMAXE)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		END DO
    
		  
    
    
      
    
    
    

     
    
    
    
  IF (N.EQ.0)THEN
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







         
        
 deallocate(variables)


	
	

END SUBROUTINE OUTWRITE3v2Dav



SUBROUTINE OUTWRITE3vSbav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_AV"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD

end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'solution'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,k,omega,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,mu,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,passivescalar,vortex,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,k,omega,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,mu,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,W,energy,Pressure,vortex,ssx,ssy,ssz'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 3
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN

		      
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(5,1)
					  ENDDO
					  END IF
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(5,KKD)
						if ((kkd.ge.2).and.(kkd.le.4))then
					      valuess(i)=U_C(IBOUND_T(I))%VAL(5,kkd)/U_C(IBOUND_T(I))%VAL(5,1)
					      end if	
						
						
					  ENDDO
					  END IF
		
		
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					        leftv(1:5)=U_C(IBOUND_T(I))%VAL(5,1:5)
						
						CALL CONS2PRIM(N)
				    VALUESS(i)=leftv(5)
						
						
						
					  ENDDO
					  END IF
		     
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		  
					IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					        
				    VALUESS(i)=U_Ct(IBOUND_T(I))%VAL(5,turbulenceequations+passivescalar)
						
						
						
					  ENDDO
					  END IF
		  
		  
		   
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					        
				    VALUESS(i)=ielem(n,IBOUND_T(I))%vortex(1)
						
						
						
					  ENDDO
					  END IF
		  
		  
		  
		 
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					        
				    VALUESS(i)=u_ct(IBOUND_T(I))%val(1,kkd)
						
						
						
					  ENDDO
					  END IF
		  
		  
		
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,3
		  
				      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
					        
				    
						
						ICONSI=IBOUND_T(I)
					 ICONSIDERED=IBOUND_T2(I)
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X_av(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y_av(ICONSI,ICONSIDERED)
					 CASE(3)
					 call SHEAR_Z_av(ICONSI,ICONSIDERED)
					 END SELECT
				       		VALUESS(icount_wall)=SHEAR_TEMP		
						
					  ENDDO
					  END IF
		  
		  
		  
		  
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vSbav


SUBROUTINE OUTWRITE3vSb2dav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_av"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD

end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'solution'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
  
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     ELSE
     
     if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,k,omega,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,mu,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,passivescalar,vortex,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,k,omega,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,mu,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              end if
              if (turbulenceequations.eq.0)then
              if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
                    'Density,U,V,energy,Pressure,vortex,ssx,ssy'//NULCHAR, &
                    out1//NULCHAR, &
                    '.'//NULCHAR, &
                    FileType, &
                    Debug, &
                    VIsDouble)
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 1
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





 ierr= TecZne112('GRID2'//NULCHAR, &
                    ZoneType, &
                    IMax, &
                    JMax, &
                    kmax, &
                    ICellMax, &
                    JCellMax, &
                    KCellMax, &
                    SolTime, &
                    StrandID, &
                    ParentZn, &
                    IsBlock, &
                    NFConns, &
                    FNMode, &
                    0, &
                    0, &
                    0, &
                    Null, &
                    Valuelocation, &
                    Null, &
                    ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN

		      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(5,1)
					  ENDDO
					  END IF
		     
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						VALUESS(I)=U_C(IBOUND_T(I))%VAL(5,KKD)
						if ((kkd.ge.2).and.(kkd.le.3))then
						valuess(i)=U_C(IBOUND_T(I))%VAL(5,kkd)/U_C(IBOUND_T(I))%VAL(5,1)
						end if	
					  ENDDO
					  END IF
		     
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
		      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						leftv(1:4)=U_C(IBOUND_T(I))%VAL(5,1:4)
						CALL CONS2PRIM2d(N)
					  VALUESS(i)=leftv(4)
					  ENDDO
					  END IF
		      
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		ierr = TECDAT112(totwalls,xbin,1)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		    IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						
						
					  VALUESS(i)=U_CT(IBOUND_T(I))%VAL(5,turbulenceequations+passivescalar)
					  ENDDO
					  END IF
		  
		  
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		   IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						
						
					  VALUESS(i)=ielem(n,IBOUND_T(I))%vortex(1)
					  ENDDO
					  END IF
		
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
					  IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						
						
					  VALUESS(i)=u_ct(IBOUND_T(I))%val(5,kkd)
					  ENDDO
					  END IF
		  
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,2
				      IF (TOTIW.GT.0)THEN
					  DO I=1,TOTIW
						ICONSI=IBOUND_T(I)
					 ICONSIDERED=IBOUND_T2(I)
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X2d_av(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y2d_av(ICONSI,ICONSIDERED)
					 
					 END SELECT
				       		VALUESS(i)=SHEAR_TEMP		
						
					  
					  ENDDO
					  END IF
		 
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  ierr = TECDAT112(totwalls,xbin,1)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  ierr = TECEND112()
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vSb2dav


SUBROUTINE OUTWRITE3vSav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_av"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD
OPEN(97,FILE=OUTFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
end if








		
   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  end if





IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  
  
   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="solution"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 
                    
                    
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED)'
  end if
     ELSE
     
     
     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
  end if
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	      
                    
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","k","omega","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED,[13] = CELLCENTERED)'
  end if
                    
                    
                    
              end if
              if (turbulenceequations.eq.1)then
              
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","MU","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.0)then
              
                if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","passivescalar","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED,[11] = CELLCENTERED)'
  end if
              end if
	    else
	    if (turbulenceequations.eq.2)then
	      
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","k","omega","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED, [11] = CELLCENTERED,[12] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.1)then
              
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","M","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED,[11] = CELLCENTERED)'
  end if
              end if
              if (turbulenceequations.eq.0)then
         
               if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","W","energy","Pressure","VORTEX","ssx","ssy","ssz"'
	WRITE(97,*) 'Zone N=',Itotalb,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED,[7] = CELLCENTERED,[8] = CELLCENTERED,[9] = CELLCENTERED,'
	WRITE(97,*) '[10] = CELLCENTERED)'
  end if
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







     

Valuelocation(:)=0





 


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(5,1)
				END IF
		      end do
		      end if
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    WRITE(97,*)XBIN(1:TOTWALLS)
    
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,5
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(5,kkd)
				if ((kkd.ge.2).and.(kkd.le.4))then
		  valuess(icount_wall)=U_C(IBOUND(N,i)%which)%VAL(5,kkd)/U_C(IBOUND(N,i)%which)%VAL(5,1)
		  end if	
				END IF
		      end do
		      end if
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		 WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
    
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    leftv(1:5)=U_C(IBOUND(N,i)%which)%VAL(5,1:5)
				    CALL CONS2PRIM(N)
				    VALUESS(icount_wall)=leftv(5)
				  
				END IF
		      end do
		      end if
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		 WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		   IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=U_Ct(IBOUND(N,i)%which)%VAL(5,turbulenceequations+passivescalar)
				  
				END IF
		      end do
		      end if
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=ielem(n,IBOUND(N,i)%which)%vortex(1)
				  
				END IF
		      end do
		      end if
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=u_ct(IBOUND(N,i)%which)%val(5,kkd)
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,3
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
					ICONSI=IBOUND(N,i)%which
					 ICONSIDERED=IBOUND(N,i)%FACE
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X_av(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y_av(ICONSI,ICONSIDERED)
					 CASE(3)
					 call SHEAR_Z_av(ICONSI,ICONSIDERED)
					 END SELECT
				       		VALUESS(icount_wall)=SHEAR_TEMP		
				       
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		   WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
  
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vSav


SUBROUTINE OUTWRITE3vS2dav
use ISO_C_BINDING
IMPLICIT NONE

! EXTERNAL TecIni112
! EXTERNAL TecZne112
! EXTERNAL TECDAT112
! EXTERNAL TECNODE112
! EXTERNAL  TECEND112

! 

INTEGER::KMAXE,KK,KFK,ICPUID,L,IHGT,IHGJ,kkd
REAL::X,Y,Z,DENOMINATOR,TUY,TVX,TWX,TUZ,TVZ,TWY,SNORM,ONORM,nx,ny,nz,ssx,ssy,ssz,ssp,tauyx,tauzx,tauzy
REAL,ALLOCATABLE,DIMENSION(:)::IFINT,TFINT,NDR,NDS
INTEGER::INEEDT,JJ,IX,IX1,I1,I2,I3,I4,I5,DECOMF,KD,im
REAL,DIMENSION(8)::VARIABLES
REAL,DIMENSION(3,3)::AVORT,TVORT,SVORT,OVORT
INTEGER::INX,I,K,J,M,O,P,Q,JK,imax,jmax,kmax,igf,igf2,DUMG,DUML,IMAXP,nvar1,icount_wall
LOGICAL::HEREV
REAL,DIMENSION(5)::TOTAL
 CHARACTER(LEN=20)::PROC,OUTFILE,PROC3,SURFILE,proc4
integer::ierr,cv,TecIni112,TecZne112,TECDAT112,TECNOD112,TECEND112,ITGFD
real,allocatable,dimension(:)::xbin,ybin,zbin
real,allocatable,dimension(:,:)::FBIN
integer,allocatable,dimension(:,:)::icon
INTEGER,ALLOCATABLE,DIMENSION(:)::Valuelocation,inog,ICELL,ICELLA
real,ALLOCATABLE,DIMENSION(:)::valuess,VALUESA
character(LEN=:),allocatable::out1
character*1 NULCHAR
 
      Integer::   Debug,III,NPts,NElm

  
      Real::    SolTime
      Integer:: VIsDouble, FileType,ILOOP
      Integer:: ZoneType,StrandID,ParentZn,IsBlock
      Integer:: ICellMax,JCellMax,KCellMax,NFConns,FNMode,ShrConn
      POINTER   (NullPtr,Null)
      Integer:: Null(*)


 KMAXE=XMPIELRANK(N)
! 
DUMG=TOTIW
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

ILOOP=0

! IF (TOTIW.GT.0)THEN
!     
!    DO I=1,TOTIW
! 	k=IBOUND_T(I)
! 	do i1=k,k
! 	DO J=1,IELEM(N,k)%IFCA
! 	if (ielem(n,k)%percorg(j).eq.-4)then
! 	iloop=iloop+1
! 	ICELL(Iloop)=IELEM(N,IBOUND_T(k))%indexi(j)
! 	go to 1043
! 	end if
! 	end do
! 	END DO
! 	1043 continue
!   ENDDO
! END IF
IF (TOTIW.GT.0)THEN
DO I=1,KMAXE
  if (ielem(n,i)%interior.eq.1)then
	DO j=1,IELEM(N,I)%IFCA
	  if (ielem(n,i)%ibounds(J).gt.0)then
	      if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
		  iloop=iloop+1
		    ICELL(Iloop)=ibound(n,ielem(n,i)%ibounds(j))%inum
	      END IF
	  end if
	END DO
   end if
END DO
end if

IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

! if (n.eq.0)then
! write(1000+n,*)icella(:)
! 
! 
! end if

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)




if (n.eq.0)then



 NullPtr = 0
      Debug   = 0
      FileType = 2
VIsDouble = 1

NULCHAR = CHAR(0)

WRITE(PROC3,FMT='(I10)') IT
	!proc4=".plt"
	OUTFILE="SURF_av"//TRIM(ADJUSTL(PROC3))//'.plt'
	ITGFD=len_trim(OUTFILE)
	allocate(character(LEN=itgfd) ::out1)
	out1=OUTFILE(1:itgfd)
! 	out1=out1//CHAR(0)
! 	write(100+n,*)OUTFILE,"EDW1",OUT1,ITGFD
	OPEN(97,FILE=outfile,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
	




end if



IF (ITESTCASE.LE.2)THEN
  NVAR1=1
  
                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="SOLUTION"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED)'
  end if
 
  
  
 END IF
 IF (ITESTCASE.EQ.3)THEN
 NVAR1=6+PASSIVESCALAR
  if (passivescalar.gt.0)then
 
                    
                     if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED)'
  end if
     ELSE
      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED)'
  end if
!      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
!                     'Density,U,V,energy,Pressure'//NULCHAR, &
!                     out1//NULCHAR, &
!                     '.'//NULCHAR, &
!                     FileType, &
!                     Debug, &
!                     VIsDouble)
     
     
     
     END IF
 END IF
 IF (ITESTCASE.EQ.4)THEN
 NVAR1=10+PASSIVESCALAR+turbulenceequations
	    if (passivescalar.gt.0)then
	      if (turbulenceequations.eq.2)then
	                    if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","K","OMEGA","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED, [11] = CELLCENTERED)'
  end if
	      
              end if
              if (turbulenceequations.eq.1)then
                   if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","M","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED)'
  end if
              
              end if
              if (turbulenceequations.eq.0)then
               if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","passivescalar","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED)'
  end if
              
              
              end if
	    else
	    if (turbulenceequations.eq.2)then
	             if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","K","OMEGA","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED, [10] = CELLCENTERED)'
  end if
! 	      if (n.eq.0)ierr =  TecIni112('sols'//NULCHAR, &
!                     'Density,U,V,energy,Pressure,vortex,k,omega,ssx,ssy'//NULCHAR, &
!                     out1//NULCHAR, &
!                     '.'//NULCHAR, &
!                     FileType, &
!                     Debug, &
!                     VIsDouble)
              end if
              if (turbulenceequations.eq.1)then
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","MU","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED,'
	WRITE(97,*) '[9] = CELLCENTERED)'
  end if
              
              end if
              if (turbulenceequations.eq.0)then
                      if (n.eq.0)then
	WRITE(97,*) 'FILETYPE=SOLUTION'
	WRITE(97,*)'VARIABLES="Density","U","V","energy","Pressure","VORTEX","SSX","SSY"'
	WRITE(97,*) 'Zone N=',ITOTALB,',E=',totwalls,',ZONETYPE = FEQUADRILATERAL,','DATAPACKING = BLOCK'
	WRITE(97,*) ',VARLOCATION = ([1] = CELLCENTERED,[2] = CELLCENTERED,[3] = CELLCENTERED,[4] = CELLCENTERED,'
	WRITE(97,*) '[5] = CELLCENTERED, [6] = CELLCENTERED, [7] = CELLCENTERED, [8] = CELLCENTERED)'
	
  end if
              
              
              end if
	    
	    
	    
	    
	    end if
 
 
 END IF
	
	

if (n.eq.0)then
allocate (Valuelocation(nvar1))







      IMax    = itotalb
      JMax    = totwalls
      KMax    = 0
      ZoneType = 1
      if (( RUNGEKUTTA .LT. 5).or.( RUNGEKUTTA .eq. 11)) Then
      SolTime = T
      else
      SolTime = IT

      end if
      StrandID = 1
      ParentZn = 0
      IsBlock = 1
      ICellMax = 0
      JCellMax = 0
      KCellMax = 0
      NFConns = 0
      FNMode = 0
      ShrConn = 0

Valuelocation(:)=0





!  ierr= TecZne112('GRID2'//NULCHAR, &
!                     ZoneType, &
!                     IMax, &
!                     JMax, &
!                     kmax, &
!                     ICellMax, &
!                     JCellMax, &
!                     KCellMax, &
!                     SolTime, &
!                     StrandID, &
!                     ParentZn, &
!                     IsBlock, &
!                     NFConns, &
!                     FNMode, &
!                     0, &
!                     0, &
!                     0, &
!                     Null, &
!                     Valuelocation, &
!                     Null, &
!                     ShrConn)


 ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(totwalls))
	VALUESA=0.0

 END IF

  call mpi_barrier(MPI_COMM_WORLD,IERROR)
  ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0
    
   
IF (ITESTCASE.LE.2)THEN
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(5,1)
				END IF
		      end do
		      end if
    
    call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i))=valuesa(i)
	end if
    end do
    WRITE(97,*)XBIN(1:TOTWALLS)
!     ierr = TECDAT112(totwalls,xbin,1)
    END IF

     
    CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    END IF
    
    IF (ITESTCASE.ge.3)THEN
		do kkd=1,4
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    valuess(icount_wall)=u_c(IBOUND(N,i)%which)%val(5,kkd)
				if ((kkd.ge.2).and.(kkd.le.3))then
		  valuess(icount_wall)=U_C(IBOUND(N,i)%which)%VAL(5,kkd)/U_C(IBOUND(N,i)%which)%VAL(5,1)
		  end if	
				END IF
		      end do
		      end if
		
		
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
		 
		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		end do
    
    
		      IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				    leftv(1:4)=U_C(IBOUND(N,i)%which)%VAL(5,1:4)
				    CALL CONS2PRIM(N)
				    VALUESS(icount_wall)=leftv(4)
				  
				END IF
		      end do
		      end if
    
    
    
		call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		IF (N.EQ.0)THEN
		do i=1,imaxp*isize
		    if (icella(i).gt.0)then
		    xbin(icella(i))=valuesa(i)
		    end if
		end do
		WRITE(97,*)XBIN(1:TOTWALLS)
		END IF

		
		CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
    
		  if (passivescalar.gt.0)then
		   IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=U_Ct(IBOUND(N,i)%which)%VAL(5,turbulenceequations+passivescalar)
				  
				END IF
		      end do
		      end if
		  
		  
		  	  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  
		  end if
    
		  if (itestcase.eq.4)then
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=ielem(n,IBOUND(N,i)%which)%vortex(1)
				  
				END IF
		      end do
		      end if
		  
		  
		  
! 		  DO I=1,KMAXE
! 		      VALUESS(i)=ielem(n,i)%vortex(1)
! 		  END DO
		  
		  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  
		  if (turbulence.eq.1)then
		  do kkd=1,turbulenceequations
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
				       VALUESS(icount_wall)=u_ct(IBOUND(N,i)%which)%val(5,kkd)
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  if (turbulence.eq.1)then
		  do kkd=1,2
		  
		  IF (TOTIW.GT.0)THEN
		      icount_wall=0	
		      DO I=1,n_boundaries
			      if ((ibound(n,i)%icode.eq.4).and.(IBOUND(N,i)%which.gt.0)) then
				    icount_wall=icount_wall+1
					ICONSI=IBOUND(N,i)%which
					 ICONSIDERED=IBOUND(N,i)%FACE
					select case(kkd)
					 case(1)
					 
					 call SHEAR_X2d_av(ICONSI,ICONSIDERED)
					 CASE (2)
					 call SHEAR_Y2d_av(ICONSI,ICONSIDERED)
					 
					 END SELECT
				       		VALUESS(icount_wall)=SHEAR_TEMP		
				       
				  
				END IF
		      end do
		      end if
		  
				  
		  call MPI_GATHER(VALUESS,IMAXP,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

		  IF (N.EQ.0)THEN
		  do i=1,imaxp*isize
		      if (icella(i).gt.0)then
		      xbin(icella(i))=valuesa(i)
		      end if
		  end do
		  WRITE(97,*)XBIN(1:TOTWALLS)
		  END IF

		  
		  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
		  end do
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  end if
    
    
    end if





!   END IF
!    end if

  IF (N.EQ.0)THEN
 
  DEALLOCATE(XBIN,VALUESA,VALUELOCATION,ICELLA)
  deallocate(out1)
  END IF
  DEALLOCATE (VALUESS)
  











  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)







	
	
	

	
	

END SUBROUTINE OUTWRITE3vS2dav






SUBROUTINE GRID_WRITE
IMPLICIT NONE
IF (TECPLOT.EQ.1)THEN
if (dimensiona.eq.3)then
call outwritegridb
ELSE
call outwritegridb2D
END IF
ELSE
if (dimensiona.eq.3)then
  call outwritegrid(n)
  
  eLSE
  call outwritegrid2D(n)

  END IF
  
  END IF


END SUBROUTINE GRID_WRITE


SUBROUTINE SURF_WRITE
IMPLICIT NONE
IF (TECPLOT.EQ.1)THEN
   if (dimensiona.eq.3)then
call OUTWRITEGRIDBs
ELSE
call OUTWRITEGRIDBs2d
END IF
ELSE
 if (dimensiona.eq.3)then
call OUTWRITEGRIDs
ELSE
call OUTWRITEGRIDs2d
END IF

END IF



END SUBROUTINE SURF_WRITE


SUBROUTINE VOLUME_SOLUTION_WRITE
IMPLICIT NONE

call mpi_barrier(mpi_comm_world,IERROR)

				  IF (N.EQ.0)THEN
				  OPEN(63,FILE='history.txt',FORM='FORMATTED',STATUS='old',ACTION='WRITE',POSITION='APPEND')
				  WRITE(63,*)"started writing output",T
				  CLOSE(63)
				  END IF

IF (TECPLOT.EQ.1)THEN
   if (dimensiona.eq.3)then
!     write(400+n,*)"edw"
call OUTWRITE3vb
eLSE

call OUTWRITE3vb2D
END IF
ELSE
  if (dimensiona.eq.3)then

call OUTWRITE3v
eLSE

 call OUTWRITE3v2D
END IF

END IF



IF (N.EQ.0)THEN
				  OPEN(63,FILE='history.txt',FORM='FORMATTED',STATUS='old',ACTION='WRITE',POSITION='APPEND')
				  WRITE(63,*)"finished writing output",T
				  CLOSE(63)
				  END IF


call mpi_barrier(mpi_comm_world,IERROR)


END SUBROUTINE VOLUME_SOLUTION_WRITE



SUBROUTINE surface_SOLUTION_WRITE
IMPLICIT NONE

IF (TECPLOT.EQ.1)THEN
   if (dimensiona.eq.3)then

call OUTWRITE3vsb
eLSE

call OUTWRITE3vsb2D
END IF
ELSE
  if (dimensiona.eq.3)then

call OUTWRITE3vs
eLSE

call OUTWRITE3vs2D
END IF

END IF


END SUBROUTINE surface_SOLUTION_WRITE

SUBROUTINE VOLUME_SOLUTION_WRITE_av
IMPLICIT NONE

IF (TECPLOT.EQ.1)THEN
   if (dimensiona.eq.3)then

call OUTWRITE3vbav
eLSE

call OUTWRITE3vb2Dav
END IF
ELSE
  if (dimensiona.eq.3)then

call OUTWRITE3vav
eLSE

call OUTWRITE3v2Dav
END IF

END IF


END SUBROUTINE VOLUME_SOLUTION_WRITE_av



SUBROUTINE surface_SOLUTION_WRITE_av
IMPLICIT NONE

IF (TECPLOT.EQ.1)THEN
   if (dimensiona.eq.3)then

call OUTWRITE3vsbav
eLSE

call OUTWRITE3vsb2Dav
END IF
ELSE
  if (dimensiona.eq.3)then

call OUTWRITE3vsav
eLSE

call OUTWRITE3vs2Dav
END IF

END IF


END SUBROUTINE surface_SOLUTION_WRITE_av

SUBROUTINE forces
IMPLICIT NONE


   if (dimensiona.eq.3)then

call computeforce(n)
eLSE

call computeforce2d(n)
END IF



END SUBROUTINE forces



SUBROUTINE RESIDUAL_COMPUTE
IMPLICIT NONE


   if (dimensiona.eq.3)then

call CALCULATE_RESIDUAL(n)
eLSE

call CALCULATE_RESIDUAL2D(n)
END IF

END SUBROUTINE RESIDUAL_COMPUTE




SUBROUTINE CHECKPOINTING
IMPLICIT NONE


   if (dimensiona.eq.3)then

call CHECKPOINT(n)
eLSE

call CHECKPOINT2D(n)
END IF

END SUBROUTINE CHECKPOINTING


SUBROUTINE CHECKPOINTING_av
IMPLICIT NONE


   if (dimensiona.eq.3)then

call CHECKPOINTav(n)
eLSE

call CHECKPOINTav2D(n)
END IF

END SUBROUTINE CHECKPOINTING_av


SUBROUTINE CHECKPOINT(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER,ALLOCATABLE,DIMENSION(:)::ICELL,ICELLA
REAL,ALLOCATABLE,DIMENSION(:)::VALUESA,VALUESS
REAL,ALLOCATABLE,DIMENSION(:,:)::xbin
INTEGER::I,K,KMAXE,J,JK,ICPUID,nvar,IMAXP,DUMG,DUML,jj
CHARACTER(LEN=20)::PROC,RESTFILE,PROC3
REAL,ALLOCATABLE,DIMENSION(:)::IGINT,TGINT
 KMAXE=XMPIELRANK(N)


ICPUID=N
	RESTFILE='RESTART.dat'
	IF (N.EQ.0)THEN
	OPEN(1086,FILE=RESTFILE,FORM='UNFORMATTED',STATUS='REPLACE',ACTION='WRITE')
	if ((rungekutta .ge. 5).and.(rungekutta .lt. 11)) then
	write(1086)it,ZERO
	      write(1086)INITIALRES(1)
	      write(1086)INITIALRES(2)
	      write(1086)INITIALRES(3)
	      write(1086)INITIALRES(4)
	      write(1086)INITIALRES(5)
	      if ( turbulence .eq. 1) then
	      if (turbulencemodel.eq.1)then
	      write(1086)INITIALRES(6)
	      end if
	      if (turbulencemodel.eq.2)then
	      write(1086)INITIALRES(6)
	      write(1086)INITIALRES(7)
	      end if
	      end if
	      
	      
	ELSE
	WRITE (1086)IT,T
	      
	end if
	end if
	
	KMAXE=XMPIELRANK(N)
    
DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)

IF (N.EQ.0) then
ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe,5+turbulenceequations+passivescalar))
	VALUESA=ZERO

 END IF
ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO

  
  
IF (TURBULENCE.EQ.1)THEN
do jj=1,5+turbulenceequations+passivescalar
 DO I=1,KMAXE
      IF (jj.gt.5) THEN

		      VALUESS(I)=U_CT(I)%VAL(1,jj-5)
      Else
	VALUESS(I)=U_C(I)%VAL(1,jj)
      end if
 END DO
    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
end do
ELSE
do jj=1,5
 DO I=1,KMAXE
	VALUESS(I)=U_C(I)%VAL(1,jj)
 END DO
    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
end do

END IF

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN

    DO I=1,IMAXE
    WRITE(1086)XBIN(i,1:5+TURBULENCEEQUATIONS+PASSIVESCALAR)
    END DO

    DEALLOCATE(XBIN,ICELLA,VALUESA)
    close(1086)
    END IF
    
DEALLOCATE(VALUESS)


END SUBROUTINE CHECKPOINT


SUBROUTINE CHECKPOINT2D(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER,ALLOCATABLE,DIMENSION(:)::ICELL,ICELLA
REAL,ALLOCATABLE,DIMENSION(:)::VALUESA,VALUESS
REAL,ALLOCATABLE,DIMENSION(:,:)::xbin
INTEGER::I,K,KMAXE,J,JK,ICPUID,nvar,IMAXP,DUMG,DUML,jj
CHARACTER(LEN=20)::PROC,RESTFILE,PROC3
REAL,ALLOCATABLE,DIMENSION(:)::IGINT,TGINT
 KMAXE=XMPIELRANK(N)


ICPUID=N


if (itestcase.ge.2)then

	RESTFILE='RESTART.dat'
	IF (N.EQ.0)THEN
	OPEN(1086,FILE=RESTFILE,FORM='UNFORMATTED',STATUS='REPLACE',ACTION='WRITE')
	if ((rungekutta .ge. 5).and.(rungekutta .lt. 11)) then
	write(1086)it,ZERO
	      write(1086)INITIALRES(1)
	      write(1086)INITIALRES(2)
	      write(1086)INITIALRES(3)
	      write(1086)INITIALRES(4)
	     
	      if ( turbulence .eq. 1) then
	      if (turbulencemodel.eq.1)then
	      write(1086)INITIALRES(5)
	      end if
	      if (turbulencemodel.eq.2)then
	      write(1086)INITIALRES(5)
	      write(1086)INITIALRES(6)
	      end if
	      end if
	      
	      
	ELSE
	WRITE (1086)IT,T
	      
	end if
	end if
	
	KMAXE=XMPIELRANK(N)
    
DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)

call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)

IF (N.EQ.0) then
ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe,4+turbulenceequations+passivescalar))
	VALUESA=ZERO

 END IF
ALLOCATE(VALUESS(imaxp))
  VALUESS=ZERO

  
  
IF (TURBULENCE.EQ.1)THEN
do jj=1,4+turbulenceequations+passivescalar
 DO I=1,KMAXE
      IF (jj.gt.4) THEN

		      VALUESS(I)=U_CT(I)%VAL(1,jj-4)
      Else
	VALUESS(I)=U_C(I)%VAL(1,jj)
      end if
 END DO
    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
end do
ELSE
do jj=1,4
 DO I=1,KMAXE
	VALUESS(I)=U_C(I)%VAL(1,jj)
 END DO
    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)
    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
end do

END IF

  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN

    DO I=1,IMAXE
    WRITE(1086)XBIN(i,1:4+TURBULENCEEQUATIONS+PASSIVESCALAR)
    END DO

    DEALLOCATE(XBIN,ICELLA,VALUESA)
    close(1086)
    END IF
    
DEALLOCATE(VALUESS)

end if

END SUBROUTINE CHECKPOINT2D




SUBROUTINE CHECKPOINTAV(N)  !Modified on 22/6/2013
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER,ALLOCATABLE,DIMENSION(:)::ICELL,ICELLA
REAL,ALLOCATABLE,DIMENSION(:)::VALUESA,VALUESS
REAL,ALLOCATABLE,DIMENSION(:,:)::xbin
INTEGER::I,K,KMAXE,J,JK,ICPUID,nvar,IMAXP,DUMG,DUML,jj
 CHARACTER(LEN=20)::PROC,RESTFILE,PROC3
 REAL,ALLOCATABLE,DIMENSION(:)::IGINT,TGINT
 KMAXE=XMPIELRANK(N)



ICPUID=N
	RESTFILE='RESTARTav.dat'
	IF (N.EQ.0)THEN
	OPEN(1086,FILE=RESTFILE,FORM='UNFORMATTED',STATUS='REPLACE',ACTION='WRITE')
	
	
	end if
	
	KMAXE=XMPIELRANK(N)
    
DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)


call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)

IF (N.EQ.0) then
ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe,(5+turbulenceequations+passivescalar+6+passivescalar)))
	VALUESA=0.0

 END IF
ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0

do jj=1,5+turbulenceequations+passivescalar+6+passivescalar
 DO I=1,KMAXE
      
      if (jj.le.5+turbulenceequations+passivescalar)then
      IF (jj.le.5) THEN
	  VALUESS(I)=U_C(I)%VAL(5,jj)
		      
      Else

	VALUESS(I)=U_CT(I)%VAL(5,jj-5)

      end if
      end if
      if (jj.gt.5+turbulenceequations+passivescalar)then

       VALUESS(I)=U_C(i)%RMS(jj-(5+turbulenceequations+passivescalar))

      end if
      
 END DO

    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
    
 end do
CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN

    DO I=1,IMAXE
     WRITE(1086)I
!     DO NVAR=1,5+TURBULENCEEQUATIONS+PASSIVESCALAR
    WRITE(1086)XBIN(I,1:5+TURBULENCEEQUATIONS+PASSIVESCALAR+6+PASSIVESCALAR)
!     END DO
    END DO
      
    DEALLOCATE(XBIN,ICELLA,VALUESA)

      close(1086)
    END IF
    

DEALLOCATE(VALUESS)
	

END SUBROUTINE CHECKPOINTAV


SUBROUTINE CHECKPOINTAV2d(N)  !Modified on 22/6/2013
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER,ALLOCATABLE,DIMENSION(:)::ICELL,ICELLA
REAL,ALLOCATABLE,DIMENSION(:)::VALUESA,VALUESS
REAL,ALLOCATABLE,DIMENSION(:,:)::xbin
INTEGER::I,K,KMAXE,J,JK,ICPUID,nvar,IMAXP,DUMG,DUML,jj
 CHARACTER(LEN=20)::PROC,RESTFILE,PROC3
 REAL,ALLOCATABLE,DIMENSION(:)::IGINT,TGINT
 KMAXE=XMPIELRANK(N)



ICPUID=N
	RESTFILE='RESTARTav.dat'
	IF (N.EQ.0)THEN
	OPEN(1086,FILE=RESTFILE,FORM='UNFORMATTED',STATUS='REPLACE',ACTION='WRITE')
	
	
	end if
	
	KMAXE=XMPIELRANK(N)
    
DUMG=KMAXE
call mpi_barrier(mpi_comm_world,IERROR)

CALL MPI_ALLREDUCE(DUMG,DUML,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,IERROR)
IMAXP=DUML

ALLOCATE(ICELL(IMAXP))
ICELL=0

DO I=1,KMAXE
  ICELL(I)=IELEM(N,I)%IHEXGL
END DO


IF (N.EQ.0)THEN
	ALLOCATE(ICELLA(IMAXP*ISIZE))
	 ICELLA=0

END IF

call MPI_GATHER(ICELL,IMAXP,MPI_INTEGER,icella,imaxp,mpi_integer,0,MPI_COMM_WORLD,IERROR)


call mpi_barrier(mpi_comm_world,IERROR)
deallocate (icell)

IF (N.EQ.0) then
ALLOCATE(VALUESA(IMAXP*ISIZE))
  allocate(xbin(imaxe,(4+turbulenceequations+passivescalar+3+passivescalar)))
	VALUESA=0.0

 END IF
ALLOCATE(VALUESS(imaxp))
  VALUESS=0.0

do jj=1,4+turbulenceequations+passivescalar+3+passivescalar
 DO I=1,KMAXE
      
      if (jj.le.4+turbulenceequations+passivescalar)then
      IF (jj.le.4) THEN
	  VALUESS(I)=U_C(I)%VAL(5,jj)
		      
      Else

	VALUESS(I)=U_CT(I)%VAL(5,jj-4)

      end if
      end if
      if (jj.gt.4+turbulenceequations+passivescalar)then

       VALUESS(I)=U_C(i)%RMS(jj-(4+turbulenceequations+passivescalar))

      end if
      
 END DO

    call MPI_GATHER(VALUESS,imaxp,MPI_DOUBLE_PRECISION,VALUESA,imaxp,mpi_DOUBLE_PRECISION,0,MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN
    do i=1,imaxp*isize
	if (icella(i).gt.0)then
	xbin(icella(i),jj)=valuesa(i)
	end if
    end do
    end if
    
    
 end do
CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)

    IF (N.EQ.0)THEN

    DO I=1,IMAXE
     WRITE(1086)I
!     DO NVAR=1,5+TURBULENCEEQUATIONS+PASSIVESCALAR
    WRITE(1086)XBIN(I,1:4+TURBULENCEEQUATIONS+PASSIVESCALAR+3+PASSIVESCALAR)
!     END DO
    END DO
      
    DEALLOCATE(XBIN,ICELLA,VALUESA)

      close(1086)
    END IF
    

DEALLOCATE(VALUESS)
	

END SUBROUTINE CHECKPOINTAV2d


SUBROUTINE PROBING
IMPLICIT NONE
INTEGER::INV
CHARACTER(LEN=120)::PROB,PROBFILE,PROC3
LOGICAL::HERES

			IF (NPROBES.GT.0)THEN
			    
			    DO INV=1,NPROBES
			    IF (PROBEI(N,INV).NE.0) THEN
			      WRITE(PROB,FMT='(I10)') INV
			      PROBFILE='PROBE.'//TRIM(ADJUSTL(PROB))

			      INQUIRE (FILE=PROBFILE,EXIST=HEREs)
			    IF (HEREs==.TRUE.) THEN
				OPEN(3000+N,FILE=PROBFILE,FORM='FORMATTED',STATUS='OLD',ACTION='WRITE',POSITION='APPEND')
				
				
				ELSE
				OPEN(3000+N,FILE=PROBFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
				
				END IF
				IF (PASSIVESCALAR.EQ.0)THEN
	WRITE(3000+N,'(1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')T,U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,2)/U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,3)/U_C(PROBEI(N,INV))%VAL(1,1),U_C(PROBEI(N,INV))%VAL(1,4)/U_C(PROBEI(N,INV))%VAL(1,1)
				ELSE
	WRITE(3000+N,'(1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')T,U_C(PROBEI(N,INV))%VAL(1,1),&
	  U_C(PROBEI(N,INV))%VAL(1,2)/U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,3)/U_C(PROBEI(N,INV))%VAL(1,1),U_C(PROBEI(N,INV))%VAL(1,4)/U_C(PROBEI(N,INV))%VAL(1,1)&
	,U_CT(PROBEI(N,INV))%VAL(1,1)/U_C(PROBEI(N,INV))%VAL(1,1)


				END IF
				CLOSE(3000+N)
				
		    
			      END IF     
			    END DO
			  END IF

END SUBROUTINE PROBING


SUBROUTINE PROBING2D
IMPLICIT NONE
INTEGER::INV
CHARACTER(LEN=120)::PROB,PROBFILE,PROC3
LOGICAL::HERES

			IF (NPROBES.GT.0)THEN
			    
			    DO INV=1,NPROBES
			    IF (PROBEI(N,INV).NE.0) THEN
			      WRITE(PROB,FMT='(I10)') INV
			      PROBFILE='PROBE.'//TRIM(ADJUSTL(PROB))

			      INQUIRE (FILE=PROBFILE,EXIST=HEREs)
			    IF (HEREs==.TRUE.) THEN
				OPEN(3000+N,FILE=PROBFILE,FORM='FORMATTED',STATUS='OLD',ACTION='WRITE',POSITION='APPEND')
				
				
				ELSE
				OPEN(3000+N,FILE=PROBFILE,FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
				
				END IF
				IF (PASSIVESCALAR.EQ.0)THEN
	WRITE(3000+N,'(1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')T,U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,2)/U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,3)/U_C(PROBEI(N,INV))%VAL(1,1)
				ELSE
	WRITE(3000+N,'(1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')T,U_C(PROBEI(N,INV))%VAL(1,1),&
	  U_C(PROBEI(N,INV))%VAL(1,2)/U_C(PROBEI(N,INV))%VAL(1,1),&
	U_C(PROBEI(N,INV))%VAL(1,3)/U_C(PROBEI(N,INV))%VAL(1,1)&
	,U_CT(PROBEI(N,INV))%VAL(1,1)/U_C(PROBEI(N,INV))%VAL(1,1)


				END IF
				CLOSE(3000+N)
				
		    
			      END IF     
			    END DO
			  END IF

END SUBROUTINE PROBING2D



SUBROUTINE COMPUTEFORCE(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::I,K,J,KMAXE,gqi_points,nnd
CHARACTER(LEN=12)::PROC,RESTFILE,PROC3
REAL::DRAG,LIFT,CD,CL,RX,PX,EX,surface_temp,RTEMP
REAL::FORCEXFR,SSX,CDF,LIFTF,DRAGF,FRICTIONF,TAUYX,TAUZX,TAUZY,SSY,SSZ,CF,TAUXX,TAUYY,TAUZZ
REAL::UX,UY,UZ,VX,VY,VZ,WX,WY,WZ
 REAL,DIMENSION(2)::CI,CO
 logical::heref
 INTEGER::IM
 REAL::TSOLR,TSOLU,TSOLE,TSOLV,TSOLW,TSOLP,SSP
FORCEX=zero; FORCEY=zero; FORCEZ=zero;  FORCEXFR=zero
 CD=zero
 CL=zero
 CI(:)=zero
 CO(:)=zero
 KMAXE=XMPIELRANK(N)
 
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:FORCEX,FORCEY,FORCEZ)
DO I=1,kmaxe
		if (ielem(n,i)%interior.eq.1)then	
		    do j=1,ielem(n,i)%ifca
		      if (ielem(n,i)%ibounds(j).gt.0)then
			  if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
			      ANGLE1=IELEM(N,I)%FACEANGLEX(j)
			      ANGLE2=IELEM(N,I)%FACEANGLEY(j)
			      NX=(COS(ANGLE1)*SIN(ANGLE2))
			      NY=(SIN(ANGLE1)*SIN(ANGLE2))
			      NZ=(COS(ANGLE2))
			      
			  SSX=zero; SSP=zero; SSY=zero; SSZ=zero
			  
				select case(ielem(n,i)%types_faces(j))
				case (5)
					  gqi_points=qp_quad
					  NND=4
				      do K=1,nnd
					VEXT(k,1:dims)=INODER(N,IELEM(N,I)%NODES_FACES(J,K))%CORD(1:dims)
				      END DO
					  
					  call  QUADRATUREQUAD3D(N,IGQRULES)
					  surface_temp=IELEM(N,I)%SURF(J)
					  
				  
				case(6)
					gqi_points=qp_triangle
					NND=3
					do K=1,nnd
					  VEXT(k,1:dims)=INODER(N,IELEM(N,I)%NODES_FACES(J,K))%CORD(1:dims)
					END DO
					    
					call QUADRATURETRIANG(N,IGQRULES)
 					    surface_temp=IELEM(N,I)%SURF(J)
 					    
 					    
					  
				end select
				  
				  
				  do im=1,gqi_points
				  if (ielem(n,i)%ggs.eq.1)then
				  
				  VORTET1(1:3,1:3) = ILOCAL_RECON3(I)%GRADS(1:3,1:3)
				  ux = Vortet1(1,1);uy = Vortet1(1,2);uz = Vortet1(1,3)
				  vx = Vortet1(2,1);vy = Vortet1(2,2);vz = Vortet1(2,3)
				  wx = Vortet1(3,1);wy = Vortet1(3,2);wz = Vortet1(3,3)
				  
				  else
				  
				  vortet1(1,1:3)=ILOCAL_RECON3(i)%ULEFTV(1:3,2,J,IM)
				  vortet1(2,1:3)=ILOCAL_RECON3(i)%ULEFTV(1:3,3,J,IM)
				  vortet1(3,1:3)=ILOCAL_RECON3(i)%ULEFTV(1:3,4,J,IM)
				  ux = Vortet1(1,1);uy = Vortet1(1,2);uz = Vortet1(1,3)
				  vx = Vortet1(2,1);vy = Vortet1(2,2);vz = Vortet1(2,3)
				  wx = Vortet1(3,1);wy = Vortet1(3,2);wz = Vortet1(3,3)
				  
				  
				  end if
				  LEFTV(1:5)=ILOCAL_RECON3(I)%ULEFT(:,j,im)
				  RIGHTV(1:5)=ILOCAL_RECON3(I)%ULEFT(:,j,im)
				    call cons2prim2(n)
				    px=leftv(5)
				    CALL SUTHERLAND(N,LEFTV,RIGHTV)
				  
				  
				  TAUXX=2.0d0*ux
				  TAUYY=2.0d0*vy
				  TAUZZ=2.0d0*wz
				  TAUYX=(UY + VX)
				  TAUZX=(WX + UZ)
				  TAUZY=(VZ + WY)
				  SSX=SSX-((VISCL(1)*((NY*TAUYX)+(NZ*TAUZX)))*WEQUA2D(im))
				  SSY=SSY-((VISCL(1)*((NX*TAUYX)+(NZ*TAUZY)))*WEQUA2D(im))
				  SSZ=SSZ-((VISCL(1)*((NX*TAUZX)+(NY*TAUZY)))*WEQUA2D(im))
				  ssp=ssp+(px*WEQUA2D(im))
				   end do
				   
				   
				  SSP=ssp-PRES	
				  
				  FORCEX=FORCEX+(((SSP)*(surface_temp)*NX))+((SSX)*surface_temp)
				  FORCEY=FORCEY+(((SSP)*(surface_temp)*NY))+((SSY)*surface_temp)
				  FORCEZ=FORCEZ+(((SSP)*(surface_temp)*NZ))+((SSZ)*surface_temp)

					    
					    
			END IF
		      end if
		    end do
		end if

			
		
END DO					 
!$OMP END DO
	

		
	
	
!$OMP BARRIER 
!$OMP MASTER 
	FORCEX=FORCEX*VECTORX
	FORCEY=FORCEY*VECTORY
	FORCEZ=FORCEZ*VECTORZ
        RTEMP=((AOA/180.0d0)*PI)
	LIFTF=(FORCEZ*COS(RTEMP))+(FORCEy*COS(RTEMP))-(FORCEX*SIN(RTEMP))
	DRAGF=(FORCEX*COS(RTEMP))+(FORCEy*SIN(RTEMP))+(FORCEZ*SIN(RTEMP))
	CL=(2.0D0*LIFTF)/((RRES)*(ufreestream**2))
	CD=(2.0D0*DRAGF)/((RRES)*(ufreestream**2))


	CO(1)=CL
	CO(2)=CD
	CALL MPI_ALLREDUCE(CO(1:2),CI(1:2),2,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
	CL=CI(1)
	CD=CI(2)
	
	IF (N.EQ.0) THEN
	INQUIRE (FILE='FORCE.dat',EXIST=HEREf)
		IF (HEREf) THEN
		OPEN(50+N,FILE='FORCE.dat',FORM='FORMATTED',STATUS='OLD',ACTION='WRITE',POSITION='APPEND')
		ELSE
	OPEN(50+N,FILE='FORCE.dat',FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
		END IF
	WRITE(50+N,'(I14,1X,E14.7,1X,E14.7,1X,E14.7)')it,T,CL,CD
	
	CLOSE(50+N)
	END IF		
	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
!$OMP END MASTER 
!$OMP BARRIER 
	
	
	
	
	
	

END SUBROUTINE COMPUTEFORCE


SUBROUTINE COMPUTEFORCE2d(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::I,K,J,KMAXE,gqi_points,nnd
CHARACTER(LEN=12)::PROC,RESTFILE,PROC3
REAL::DRAG,LIFT,CD,CL,RX,PX,EX,surface_temp,RTEMP
REAL::FORCEXFR,SSX,CDF,LIFTF,DRAGF,FRICTIONF,TAUYX,TAUZX,TAUZY,SSY,SSZ,CF,TAUXX,TAUYY,TAUZZ
REAL::UX,UY,UZ,VX,VY,VZ,WX,WY,WZ
 REAL,DIMENSION(2)::CI,CO
 logical::heref
 INTEGER::IM
 REAL::TSOLR,TSOLU,TSOLE,TSOLV,TSOLW,TSOLP,SSP
FORCEX=zero; FORCEY=zero; FORCEZ=zero;  FORCEXFR=zero
 CD=zero
 CL=zero
 CI(:)=zero
 CO(:)=zero
 KMAXE=XMPIELRANK(N)
 
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:FORCEX,FORCEY,FORCEZ)
DO I=1,kmaxe
		if (ielem(n,i)%interior.eq.1)then	
		    do j=1,ielem(n,i)%ifca
		      if (ielem(n,i)%ibounds(j).gt.0)then
			  if (ibound(n,ielem(n,i)%ibounds(j))%icode.eq.4)then
			      nx=IELEM(N,I)%FACEANGLEX(j)
			      ny=IELEM(N,I)%FACEANGLEY(j)
			      
			      
			  SSX=zero; SSP=zero; SSY=zero; 
			  
				
					  gqi_points=qp_line
					  NND=2
				      do K=1,nnd
					VEXT(k,1:dims)=INODER(N,IELEM(N,I)%NODES_FACES(J,K))%CORD(1:dims)
				      END DO
					  
					  call  QUADRATURELINE(N,IGQRULES)
					  surface_temp=IELEM(N,I)%SURF(J)
					  
				  
							  
				  
				  do im=1,gqi_points
				  if (ielem(n,i)%ggs.eq.1)then
				  
				  VORTET1(1:2,1:2) = ILOCAL_RECON3(I)%GRADS(1:2,1:2)
				  ux = Vortet1(1,1);uy = Vortet1(1,2)
				  vx = Vortet1(2,1);vy = Vortet1(2,2)
				
				  
				  else
				  
				  vortet1(1,1:2)=ILOCAL_RECON3(i)%ULEFTV(1:2,2,J,IM)
				  vortet1(2,1:2)=ILOCAL_RECON3(i)%ULEFTV(1:2,3,J,IM)
				  
				 ux = Vortet1(1,1);uy = Vortet1(1,2)
				  vx = Vortet1(2,1);vy = Vortet1(2,2)
				
				  
				  
				  end if
				  LEFTV(1:4)=ILOCAL_RECON3(I)%ULEFT(:,j,im)
				  RIGHTV(1:4)=ILOCAL_RECON3(I)%ULEFT(:,j,im)
				    call cons2prim2d2(n)
				    px=leftv(4)
				    CALL SUTHERLAND2d(N,LEFTV,RIGHTV)
				  
				  
				  TAUXX=2.0d0*ux
				  TAUYY=2.0d0*vy
				  TAUYX=(UY + VX)
				  
				  SSX=SSX-((VISCL(1)*((NY*TAUYX)))*WEQUA2D(im))
				  SSY=SSY-((VISCL(1)*((NX*TAUYX)))*WEQUA2D(im))
				  
				  ssp=ssp+(px*WEQUA2D(im))
				   end do
				   
				   
				  SSP=ssp-PRES	
				  
				  FORCEX=FORCEX+(((SSP)*(surface_temp)*NX))+((SSX)*surface_temp)
				  FORCEY=FORCEY+(((SSP)*(surface_temp)*NY))+((SSY)*surface_temp)
				  

					    
					    
			END IF
		      end if
		    end do
		end if

			
		
END DO					 
!$OMP END DO
	

		
	
	
!$OMP BARRIER 
!$OMP MASTER 
	FORCEX=FORCEX*VECTORX
	FORCEY=FORCEY*VECTORY
	
        RTEMP=((AOA/180.0d0)*PI)
	LIFTF=(FORCEy*COS(RTEMP))-(FORCEX*SIN(RTEMP))
	DRAGF=(FORCEX*COS(RTEMP))+(FORCEy*SIN(RTEMP))
	CL=(2.0D0*LIFTF)/((RRES)*(ufreestream**2))
	CD=(2.0D0*DRAGF)/((RRES)*(ufreestream**2))


	CO(1)=CL
	CO(2)=CD
	CALL MPI_ALLREDUCE(CO(1:2),CI(1:2),2,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
	CL=CI(1)
	CD=CI(2)
	
	IF (N.EQ.0) THEN
	INQUIRE (FILE='FORCE.dat',EXIST=HEREf)
		IF (HEREf) THEN
		OPEN(50+N,FILE='FORCE.dat',FORM='FORMATTED',STATUS='OLD',ACTION='WRITE',POSITION='APPEND')
		ELSE
	OPEN(50+N,FILE='FORCE.dat',FORM='FORMATTED',STATUS='NEW',ACTION='WRITE')
		END IF
	WRITE(50+N,'(I14,1X,E14.7,1X,E14.7,1X,E14.7)')it,T,CL,CD
	
	CLOSE(50+N)
	END IF		
	CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	
	
!$OMP END MASTER 
!$OMP BARRIER 
	
	
	
	
	
	

END SUBROUTINE COMPUTEFORCE2d


SUBROUTINE CALCULATE_RESIDUAL(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::I,KMAXE
real::suml3,dum_resi

KMAXE=XMPIELRANK(N)

ALLRES(:)=ZERO


IF ((ITESTCASE.LE.4).AND.(TURBULENCE.NE.1))THEN
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:ALLRES)
DO I=1,KMAXE
    ALLRES(1:5)=ALLRES(1:5)+(rhs(i)%VAL(1:5)**2)
END DO
!$OMP END DO

!$OMP MASTER
DO I=1,5
SUML3=ALLRES(I)
DUM_RESI=ZERO
CALL MPI_ALLREDUCE(SUML3,DUM_RESI,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
ALLRES(I)=DUM_RESI/IMAXE

END DO


DO I=1,5
IF (INITIALRES(I).LE.ALLRES(I))THEN
INITIALRES(I)=ALLRES(I)
END IF
ALLRES(I)=ALLRES(I)/INITIALRES(I)

END DO
!$OMP END MASTER




END IF

IF (TURBULENCE.EQ.1)THEN
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:ALLRES)
DO I=1,KMAXE
    ALLRES(1:5)=ALLRES(1:5)+(rhs(i)%VAL(1:5)**2)
    ALLRES(6:5+TURBULENCEEQUATIONS)=ALLRES(6:5+TURBULENCEEQUATIONS)+(RHST(I)%VAL(1:TURBULENCEEQUATIONS)**2)
END DO
!$OMP END DO

!$OMP MASTER
DO I=1,7
SUML3=ALLRES(I)
DUM_RESI=ZERO
CALL MPI_ALLREDUCE(SUML3,DUM_RESI,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
ALLRES(I)=DUM_RESI/IMAXE

END DO



DO I=1,7
IF (INITIALRES(I).LE.ALLRES(I))THEN
INITIALRES(I)=ALLRES(I)
END IF
ALLRES(I)=ALLRES(I)/INITIALRES(I)

END DO

if (turbulenceequations.eq.1) allres(7)=1.0d0
!$OMP END MASTER

END IF



!$OMP MASTER
IF (N.EQ.0)THEN
IF ((ITESTCASE.LE.4).AND.(TURBULENCE.NE.1))THEN

	    OPEN(67,FILE='residual.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
	    WRITE(67,'(I14,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')IT,ALLRES(1),ALLRES(2),ALLRES(3),ALLRES(4),ALLRES(5)
	    CLOSE(67)

ELSE

	    OPEN(67,FILE='residual.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
	    WRITE(67,'(I14,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')IT,ALLRES(1),ALLRES(2),ALLRES(3),ALLRES(4),ALLRES(5),ALLRES(6),ALLRES(7)
	    CLOSE(67)



END IF

END IF 


if ((ALLRES(1).lt.reslimit).AND.(ALLRES(2).lt.reslimit).AND.(ALLRES(3).lt.reslimit).AND.(ALLRES(4).lt.reslimit).AND.(ALLRES(5).lt.reslimit))then
 kill=1
 end if



!$OMP END MASTER

 









End Subroutine


SUBROUTINE CALCULATE_RESIDUAL2D(N)
IMPLICIT NONE
INTEGER,INTENT(IN)::N
INTEGER::I,KMAXE
real::suml3,dum_resi
KMAXE=XMPIELRANK(N)

ALLRES(:)=ZERO


IF ((ITESTCASE.LE.4).AND.(TURBULENCE.NE.1))THEN
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:ALLRES)
DO I=1,KMAXE
    ALLRES(1:4)=ALLRES(1:4)+(rhs(i)%VAL(1:4)**2)
END DO
!$OMP END DO

!$OMP MASTER
DO I=1,4
SUML3=ALLRES(I)
DUM_RESI=ZERO
CALL MPI_ALLREDUCE(SUML3,DUM_RESI,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
ALLRES(I)=DUM_RESI/IMAXE

END DO


DO I=1,4
IF (INITIALRES(I).LE.ALLRES(I))THEN
INITIALRES(I)=ALLRES(I)
END IF
ALLRES(I)=ALLRES(I)/INITIALRES(I)

END DO
!$OMP END MASTER




END IF

IF (TURBULENCE.EQ.1)THEN
!$OMP BARRIER 
!$OMP DO SCHEDULE(GUIDED) REDUCTION(+:ALLRES)
DO I=1,KMAXE
    ALLRES(1:4)=ALLRES(1:4)+(rhs(i)%VAL(1:4)**2)
    ALLRES(5:4+TURBULENCEEQUATIONS)=ALLRES(5:4+TURBULENCEEQUATIONS)+(RHST(I)%VAL(1:TURBULENCEEQUATIONS)**2)
END DO
!$OMP END DO

!$OMP MASTER
DO I=1,nof_variables+turbulenceequations
SUML3=ALLRES(I)
DUM_RESI=ZERO
CALL MPI_ALLREDUCE(SUML3,DUM_RESI,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
ALLRES(I)=DUM_RESI/IMAXE

END DO



DO I=1,nof_variables+turbulenceequations
IF (INITIALRES(I).LE.ALLRES(I))THEN
INITIALRES(I)=ALLRES(I)
END IF
ALLRES(I)=ALLRES(I)/INITIALRES(I)

END DO
!$OMP END MASTER

END IF



!$OMP MASTER
IF (N.EQ.0)THEN
IF ((ITESTCASE.LE.4).AND.(TURBULENCE.NE.1))THEN

	    OPEN(67,FILE='residual.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
	    WRITE(67,'(I14,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')IT,ALLRES(1),ALLRES(2),ALLRES(3),ALLRES(4)
	    CLOSE(67)

ELSE

	    OPEN(67,FILE='residual.txt',FORM='FORMATTED',ACTION='WRITE',POSITION='APPEND')
	    WRITE(67,'(I14,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7,1X,E14.7)')IT,ALLRES(1),ALLRES(2),ALLRES(3),ALLRES(4),ALLRES(5)
	    CLOSE(67)



END IF

END IF 


 if ((ALLRES(1).lt.reslimit).AND.(ALLRES(2).lt.reslimit).AND.(ALLRES(3).lt.reslimit).AND.(ALLRES(4).lt.reslimit))then
 kill=1
 end if

!$OMP END MASTER







End Subroutine

SUBROUTINE CALCULATE_ERROR(N)
	IMPLICIT NONE
	INTEGER,INTENT(IN)::N
	INTEGER::I,K,KMAXE
	REAL::EXACT,DUMMYOUT,DUMMYIN
	REAL::APROXIMATE
	KMAXE=XMPIELRANK(N)
	  !$OMP MASTER
	  CALL MPI_BARRIER(MPI_COMM_WORLD,IERROR)
	  !$OMP END MASTER
	  !$OMP BARRIER
			!$OMP DO REDUCTION (+:L1NORM)
			DO I=1,KMAXE
				IF (ITESTCASE.Le.3)THEN
				EXACT=U_E(I)%VAL(1,1)
				APROXIMATE=U_C(I)%VAL(1,1)
! 					IF ((ABS(APROXIMATE-EXACT)).GT.L0NORM(N,1))THEN
! 					L0NORM(N,1)=ABS(APROXIMATE-EXACT)
! 					END IF
					L1NORM=L1NORM+((ABS(APROXIMATE-EXACT)))
				END IF
 			END DO
 			!$OMP END DO 
 			!$OMP DO REDUCTION (MAX:L0NORM)
			DO I=1,KMAXE
				IF (ITESTCASE.Le.3)THEN
				EXACT=U_E(I)%VAL(1,1)
				APROXIMATE=U_C(I)%VAL(1,1)
					IF ((ABS(APROXIMATE-EXACT)).GT.L0NORM)THEN
					L0NORM=ABS(APROXIMATE-EXACT)
					END IF
! 					L1NORM(N,1)=L1NORM(N,1)+((ABS(APROXIMATE-EXACT)))
				END IF
 			END DO
 			!$OMP END DO 
 			
 			!$OMP MASTER
 			DUMMYOUT=L1NORM
 			CALL MPI_ALLREDUCE(DUMMYOUT,DUMMYIN,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,IERROR)
 			L1NORM=DUMMYIN
 			DUMMYOUT=L0NORM
 			CALL MPI_ALLREDUCE(DUMMYOUT,DUMMYIN,1,MPI_DOUBLE_PRECISION,MPI_MAX,MPI_COMM_WORLD,IERROR)
 			L0NORM=DUMMYIN
 			
			OPEN(30,FILE='Errors.txt',FORM='FORMATTED',ACTION='write',position='append')
			write(30,*)L0NORM,"LINF NORM"
			write(30,*)L1NORM/IMAXE,"L1 NORM"
			close(30)
			!$OMP END MASTER
			!$OMP BARRIER

END SUBROUTINE CALCULATE_ERROR


END MODULE IO
