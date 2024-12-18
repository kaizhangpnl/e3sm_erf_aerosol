load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

;;...........................................................
;; Script to print table of anthropogenic aerosol forcing
;;...........................................................

begin

  MYCASE = getenv("mycase") 
  MYPATH = getenv("mypath") 

  avg_period = "ANN" 
 
  ;;...........................................................
  ;; input data
  ;;...........................................................

  fna = MYPATH + "/" + "PP_" + MYCASE + "_" + avg_period + ".nc"

  casename = MYCASE + "_" + avg_period 

  if (.not. isfilepresent(fna)) then
      print("No such file: "+fna)
      exit 
  end if

  flo = addfile(fna,"r") 
  lat = flo->lat
  lon = flo->lon
  gridarea = area_global_rectilinear_grid(lat, lon, False)

  region_lobnd = (/-90, -60, -30, 30, 60/)
  region_hibnd = (/-60, -30, 30,  60, 90/)

  region_name  = (/ "Global mean", \
                    "SH Polar (90S-60S)  ", \
                    "SH Mid-lat (60S-30S)", \
                    "Tropical (30S-30N)  ", \
                    "NH Mid-lat (30N-60N)", \
                    "NH Polar (60N-90N)  " /)

  ;;................................
  ;; top of model
  ;;................................

  vars = (/"TTAEF","SWAEF","LWAEF","SWCAEF","LWCAEF", \
  	   "SWIND","LWIND","TTIND","SWDIR","LWDIR", \
     	   "TTDIR","SWCDIR","LWCDIR","TTCDIR", \
  	   "SWALB","LWALB","TTALB"/)

  dim0 = dimsizes(vars)
  dim1 = dimsizes(region_name)
  data = new((/dim0,dim1/), double)

  do i = 0, dim0-1
     tmp = flo->$vars(i)$(0,:,:)
     do j = 0, dim1-2
  	a = closest_val(region_lobnd(j),lat)
        b = closest_val(region_hibnd(j),lat)
        data(i,j+1) = sum(tmp(a:b,:)*gridarea(a:b,:))/sum(gridarea(a:b,:))
     end do
     data(i,0) = sum(tmp(:,:)*gridarea(:,:))/sum(gridarea(:,:)) 
     delete(tmp)
  end do

  txt = new((/dim0+1,dim1+1/),"string") 
  txt(0,0) = "Variables"
  txt(0,1:dim1) = region_name
  txt(1:dim0,0) = vars
  txt(1:dim0,1:dim1) = sprintf("%18.4f",data(:,:))

  write_table("RF_tom_mean_"+casename, "w", \
	      [/txt(:,0),txt(:,1),txt(:,2),txt(:,3),txt(:,4),txt(:,5),txt(:,6)/], \
	      "%s %s %s %s %s %s %s")

  ;;................................
  ;; surface 
  ;;................................

  vars = (/"TTAEFs", "SWAEFs", "LWAEFs",  "SWCAEFs", "LWCAEFs", \
           "SWINDs", "LWINDs", "TTINDs",  "SWDIRs",  "LWDIRs",  \
           "TTDIRs", "SWCDIRs","LWCDIRs", "TTCDIRs",            \
           "SWALBs", "LWALBs", "TTALBs"                         /)

  dim0 = dimsizes(vars)
  dim1 = dimsizes(region_name)
  data = new((/dim0,dim1/), double)

  do i = 0, dim0-1
     tmp = flo->$vars(i)$(0,:,:)
     do j = 0, dim1-2
        a = closest_val(region_lobnd(j),lat)
        b = closest_val(region_hibnd(j),lat)
        data(i,j+1) = sum(tmp(a:b,:)*gridarea(a:b,:))/sum(gridarea(a:b,:))
     end do
     data(i,0) = sum(tmp(:,:)*gridarea(:,:))/sum(gridarea(:,:))
     delete(tmp)
  end do

  txt = new((/dim0+1,dim1+1/),"string")
  txt(0,0) = "Variables"
  txt(0,1:dim1) = region_name
  txt(1:dim0,0) = vars
  txt(1:dim0,1:dim1) = sprintf("%18.4f",data(:,:))

  write_table("RF_srf_mean_"+casename, "w", \
              [/txt(:,0),txt(:,1),txt(:,2),txt(:,3),txt(:,4),txt(:,5),txt(:,6)/], \
              "%s %s %s %s %s %s %s")

end


