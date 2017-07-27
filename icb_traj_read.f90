PROGRAM icb_traj_read
  ! read iceberg trajectory files
  USE netcdf
  IMPLICIT NONE
  INTEGER :: ji
  INTEGER :: narg, iargc, ierr
  INTEGER :: ndim_n, ndim_k
  INTEGER :: id, ncid
  INTEGER, DIMENSION (:,:), ALLOCATABLE :: icb_number
  INTEGER, DIMENSION (:), ALLOCATABLE :: icb_year, icb_stp

  REAL(KIND=8), DIMENSION(:), ALLOCATABLE :: dlon, dlat, dday
  
  CHARACTER(LEN=80) :: cf_name
  CHARACTER(LEN=80) :: cldum

  narg=iargc()
  IF ( narg == 0 ) THEN
    PRINT *, ' USAGE : icb_traj_read ICB_TRAJ-file'
    STOP
  ENDIF
  CALL getarg(1,cf_name)
  ierr = NF90_OPEN(cf_name, NF90_NOWRITE,ncid)
  ierr = NF90_INQ_DIMID(ncid,'n',id) ; ierr=NF90_INQUIRE_DIMENSION(ncid,id,len=ndim_n)
  ierr = NF90_INQ_DIMID(ncid,'k',id) ; ierr=NF90_INQUIRE_DIMENSION(ncid,id,len=ndim_k)

  ALLOCATE ( icb_number(ndim_k, ndim_n) , dlon(ndim_n), dlat(ndim_n), dday(ndim_n) )
  ALLOCATE ( icb_year( ndim_n) , icb_stp(ndim_n))
  ierr = NF90_INQ_VARID( ncid,'iceberg_number',id) ; ierr = NF90_GET_VAR(ncid,id,icb_number)
  ierr = NF90_INQ_VARID( ncid,'timestep',id) ; ierr = NF90_GET_VAR(ncid,id,icb_stp)
  ierr = NF90_INQ_VARID( ncid,'year',id) ; ierr = NF90_GET_VAR(ncid,id,icb_year)
  ierr = NF90_INQ_VARID( ncid,'lon',id) ; ierr = NF90_GET_VAR(ncid,id,dlon)
  ierr = NF90_INQ_VARID( ncid,'lat',id) ; ierr = NF90_GET_VAR(ncid,id,dlat)
  ierr = NF90_INQ_VARID( ncid,'day',id) ; ierr = NF90_GET_VAR(ncid,id,dday)
  PRINT *, ' DIMENSIONS : '
  PRINT *, '     n = ', ndim_n
  PRINT *, '     k = ', ndim_k
  PRINT *, ' VARIABLES :  '
  
  DO ji=1,ndim_n
!    IF ( icb_number(1,ji) == 0 )  THEN
    PRINT '(5i10,3f12.4)', icb_number(:,ji),icb_stp(ji),icb_year(ji),dday(ji), dlon(ji), dlat(ji)
!    ENDIF
  ENDDO
  
  
  
  

 ierr = NF90_CLOSE(ncid)
END PROGRAM icb_traj_read
