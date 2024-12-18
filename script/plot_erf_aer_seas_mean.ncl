load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

;;...................................................................
;; add global mean
;;...................................................................
undef ("global_mean")
function global_mean(va,gridarea)
begin

   vv = va

   vv_avg = dim_avg_n_Wrap(vv,0)
   gm_avg = sum(vv_avg*gridarea)/sum(gridarea)

return(gm_avg)
end



begin

  colormap = "BlAqGrYeOrReVi200"
  colormap = "BlueWhiteOrangeRed"

  avg_period = "seas"

  myfont = 0.03
 
  MYCASE = getenv("mycase") 
  MYPATH = getenv("mypath") 
 
  file1 = MYPATH + "/" + "PP_" + MYCASE + "_" + avg_period + ".nc"

  vars = (/"TTAEF", "SWAEF", "LWAEF", \
	   "TTIND", "SWIND", "LWIND", \
           "TTDIR", "SWDIR", "LWDIR", \
           "TTCDIR","SWCDIR","LWCDIR",\
	   "TTALB", "SWALB", "LWALB"  /)

  dim0 = dimsizes(vars)

  file2 = addfile(file1, "r")
  lat = file2->lat
  lon = file2->lon

  gridarea = area_global_rectilinear_grid(lat, lon, False)

  res             	      = True
  res@gsnDraw     	      = False
  res@gsnFrame    	      = False
  res@cnFillOn                = True              ; color plot desired
  res@cnLinesOn               = False             ; turn off contour lines
  res@cnLineLabelsOn          = False             ; turn off contour labels
  res@cnFillMode              = "RasterFill"      ; turn raster on
  res@cnMissingValFillColor   = "White"
  res@lbLabelBarOn            = True      ; Will turn on in panel later
;  res@pmLabelBarParallelPosF  = 0.026
;  res@pmLabelBarOrthogonalPosF= 0.15
  res@lbOrientation           = "vertical"        ; vertical label bar
  res@pmLabelBarHeightF       = 0.4
  res@pmLabelBarWidthF        = 0.1

  res@tmXTOn               = False
  res@tmYROn               = False
  res@tiMainFontHeightF    = myfont     ;;0.022
  res@tmYLLabelFontHeightF = myfont*0.9 ;;0.022
  res@tmXBLabelFontHeightF = myfont*0.9 ;;0.022
  res@lbLabelFontHeightF   = myfont*0.8 ;;0.020

  res@mpProjection         = "Robinson"       ; choose projection
  res@mpFillOn             = False
  res@mpPerimOn            = False             ; turn off box around plot
  res@mpGridAndLimbOn      = True
  res@mpGridLatSpacingF    = 30.0
  res@mpGridLonSpacingF    = 60.0
  res@mpGridLineThicknessF = 0.5
; res@mpGridAndLimbDrawOrder = "PreDraw"
; res@mpMinLonF           = -30.
; res@mpMaxLonF           = 330.
  res@mpCenterLonF         = 180.     ; This is necessary to get the correct map
; res@mpCenterLatF         = -90.     ; This is necessary to get the correct map

  res@txFont           = "helvetica"
  res@gsnCenterStringFontHeightF  = myfont*0.9 ;;0.02
  res@gsnLeftStringFontHeightF  = myfont*0.9 ;;0.02
  res@gsnRightStringFontHeightF = myfont*0.9 ;;0.02

;  res@gsnMajorLatSpacing   = 45
;  res@gsnMajorLonSpacing   = 90
;  res@gsnMinorLatSpacing   = 15
;  res@gsnMinorLonSpacing   = 10

  OUTDir  = "./"
  wtype = "pdf"
 ;wtype@wkPaperSize     = "A4"
 ;wtype@wkOrientation   = "landscape"    ;;pictures displayed along the length

  res@cnLevelSelectionMode = "ExplicitLevels"
  res@gsnAddCyclic         = True
  res@lbLabelAutoStride    = False
  res@lbLabelStride        = 1
  res@lbLabelFont          = "helvetica"
  res@lbLabelFontHeightF   = myfont * 0.8
  res@lbLabelFontThicknessF = 1.0


  do i = 0, dim0-1

     wks = gsn_open_wks(wtype,OUTDir+"fig_map_"+MYCASE+"_PD-PI_"+avg_period+"_"+vars(i))

     var = file2->$vars(i)$

 
     res@tiMainString         = "PD - PI" ;;PD-PI: "+vars(i)
     res@gsnRightString       = "W m~S~-2~N~" ;;var@units

     gsn_define_colormap(wks, colormap)

     res@cnLevels = (/-20.,-10.,-5.,-2.,-1.,1.,2.,5.,10.,20./)

     nm = 4

     plot = new(nm,graphic) 

     str_mon = (/ "DJF", "MAM", "JJA", "SON" /)

     do im = 0, nm-1 
        glb = global_mean(var(im:im,:,:),gridarea)  
        res@gsnCenterString = sprintf("%8.3f",glb) 
        res@tiMainString = str_mon(im)
        res@gsnLeftString = vars(i)
        plot(im) = gsn_csm_contour_map(wks,var(im,:,:),res)
     end do

     ;; draw panel with white space added

     resP = True
     resP@gsnPanelMainFontHeightF = 0.016
     resP@gsnPanelMainString = var@long_name
     resP@gsnPanelYWhiteSpacePercent = 5
     resP@gsnPanelXWhiteSpacePercent = 5
     gsn_panel(wks,plot,(/2,2/),resP)

     ;;draw(plot)
     ;;frame(wks)

     delete(var)
;    delete(res@cnLevels)

  end do

  delete(file1)
  delete(file2)

end
