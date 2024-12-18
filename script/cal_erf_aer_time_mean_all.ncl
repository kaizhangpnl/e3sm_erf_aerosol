load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;; NCL script to calculate/decompose the anthropogenic aerosol forcing  
;;
;; Reference: 
;;
;; Ghan, S. J.: Technical Note: Estimating aerosol effects on cloud radiative forcing, 
;; Atmos. Chem. Phys., 13, 9971–9974, https://doi.org/10.5194/acp-13-9971-2013, 2013. 
;;
;; Zhang, K. et al. Effective radiative forcing of anthropogenic aerosols in E3SM version 1: 
;; historical changes, causality, decomposition, and parameterization sensitivities, 
;; Atmos. Chem. Phys., 22, 9129–9160, https://doi.org/10.5194/acp-22-9129-2022, 2022.
;;
;; Kai Zhang (kai.zhang@pnnl.gov) 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

begin

  INPUTA = getenv("file_pd") ;; PD 
  INPUTB = getenv("file_pi") ;; PI 
  MYCASE = getenv("mycase") 
  MYPATH = getenv("mypath") 
  MYTIME = getenv("mytime") 

  timestr = MYTIME

  MYFILE  = "PP_" + MYCASE + "_" + timestr

  fna = INPUTA 
  fnb = INPUTB 

  print(" file : " + fna) 
  print(" file : " + fnb) 

  if(isfilepresent(fna) .and. isfilepresent(fnb)) then 

     fla = addfile(fna,"r")
     flb = addfile(fnb,"r")
 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
     ;; FSNT : Net solar flux at top of model	            
     ;; FLNT : Net longwave flux at top of model	    
     ;; FSNTC: Clearsky net solar flux at top of model      
     ;; FLNTC: Clearsky net longwave flux at top of model   
     ;; *_d1 : Radiative fluxes without aerosols	    
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

     a_FSNT     = fla->FSNT
     a_FLNT     = fla->FLNT
     a_FSNTC    = fla->FSNTC
     a_FLNTC    = fla->FLNTC
     a_FSNT_d1  = fla->FSNT_d1
     a_FLNT_d1  = fla->FLNT_d1
     a_FSNTC_d1 = fla->FSNTC_d1
     a_FLNTC_d1 = fla->FLNTC_d1
     a_FSNS     = fla->FSNS
     a_FLNS     = fla->FLNS
     a_FSNSC    = fla->FSNSC
     a_FLNSC    = fla->FLNSC
     a_FSNS_d1  = fla->FSNS_d1
     a_FLNS_d1  = fla->FLNS_d1
     a_FSNSC_d1 = fla->FSNSC_d1
     a_FLNSC_d1 = fla->FLNSC_d1

     b_FSNT     = flb->FSNT
     b_FLNT     = flb->FLNT
     b_FSNTC    = flb->FSNTC
     b_FLNTC    = flb->FLNTC
     b_FSNT_d1  = flb->FSNT_d1
     b_FLNT_d1  = flb->FLNT_d1
     b_FSNTC_d1 = flb->FSNTC_d1
     b_FLNTC_d1 = flb->FLNTC_d1
     b_FSNS     = flb->FSNS
     b_FLNS     = flb->FLNS
     b_FSNSC    = flb->FSNSC
     b_FLNSC    = flb->FLNSC
     b_FSNS_d1  = flb->FSNS_d1
     b_FLNS_d1  = flb->FLNS_d1
     b_FSNSC_d1 = flb->FSNSC_d1
     b_FLNSC_d1 = flb->FLNSC_d1

     ;;...............................
     ;; SW 
     ;;...............................

     dS = a_FSNT
     dS = a_FSNT - b_FSNT

     dSs = a_FSNS
     dSs = a_FSNS - b_FSNS

     dS_clean = a_FSNT_d1
     dS_clean = a_FSNT_d1 - b_FSNT_d1

     dSs_clean = a_FSNS_d1
     dSs_clean = a_FSNS_d1 - b_FSNS_d1

     dSC = a_FSNTC
     dSC = a_FSNTC - b_FSNTC

     dSCs = a_FSNSC
     dSCs = a_FSNSC - b_FSNSC

     dSC_clean = a_FSNTC_d1
     dSC_clean = a_FSNTC_d1 - b_FSNTC_d1

     dSCs_clean = a_FSNSC_d1
     dSCs_clean = a_FSNSC_d1 - b_FSNSC_d1

     ;;...............................
     ;; LW 
     ;;...............................

     dL = a_FLNT 
     dL = -1. * (a_FLNT - b_FLNT) 

     dLs = a_FLNS 
     dLs = -1. * (a_FLNS - b_FLNS) 

     dL_clean = a_FLNT_d1
     dL_clean = -1. * (a_FLNT_d1 - b_FLNT_d1) 

     dLs_clean = a_FLNS_d1
     dLs_clean = -1. * (a_FLNS_d1 - b_FLNS_d1) 

     dLC = a_FLNTC
     dLC = -1. * (a_FLNTC - b_FLNTC) 

     dLCs = a_FLNSC
     dLCs = -1. * (a_FLNSC - b_FLNSC) 

     dLC_clean = a_FLNTC_d1
     dLC_clean = -1. * (a_FLNTC_d1 - b_FLNTC_d1) 

     dLCs_clean = a_FLNSC_d1
     dLCs_clean = -1. * (a_FLNSC_d1 - b_FLNSC_d1) 

     ;;...............................
     ;; total effect 
     ;;...............................

     TTAEF = a_FSNT 
     TTAEF = a_FSNT - a_FLNT - (b_FSNT - b_FLNT) 
     TTAEF@long_name = "Total ERFaer (TOM)"

     TTAEFs = a_FSNS 
     TTAEFs = a_FSNS - a_FLNS - (b_FSNS - b_FLNS) 
     TTAEFs@long_name = "Total ERFaer (SRF)"

     SWAEF = dS
     SWAEF@long_name = "SW ERFaer (TOM)"

     SWAEFs = dSs
     SWAEFs@long_name = "SW ERFaer (SRF)" 

     SWCAEF = dSC
     SWCAEF@long_name = "SW clear-sky (TOM)"

     SWCAEFs = dSCs
     SWCAEFs@long_name = "SW clear-sky (SRF)" 

     LWAEF = dL
     LWAEF@long_name = "LW ERFaer (TOM)" 

     LWAEFs = dLs
     LWAEFs@long_name = "LW ERFaer (SRF)"

     LWCAEF = dLC
     LWCAEF@long_name = "LW clear-sky (TOM)"

     LWCAEFs = dLCs
     LWCAEFs@long_name = "LW clear-sky (SRF)"

     ;;...............................
     ;; indirect effect 
     ;;...............................

     SWIND = a_FSNT  
     SWIND = dS_clean - dSC_clean
     SWIND@long_name = "SW IND (TOM)"

     SWINDs = a_FSNS  
     SWINDs = dSs_clean - dSCs_clean
     SWINDs@long_name = "SW IND (SRF)" 

     LWIND = a_FLNT  
     LWIND = dL_clean - dLC_clean
     LWIND@long_name = "LW IND (TOM)"

     LWINDs = a_FLNS  
     LWINDs = dLs_clean - dLCs_clean
     LWINDs@long_name = "LW IND (SRF)"

     TTIND = a_FLNT  
     TTIND = SWIND + LWIND 
     TTIND@long_name = "Total IND (TOM)"

     TTINDs = a_FLNS  
     TTINDs = SWINDs + LWINDs
     TTINDs@long_name = "Total IND (SRF)"

     ;;...............................
     ;; direct effect 
     ;;...............................

     SWDIR  = a_FSNT 
     SWDIR  = dS - dS_clean
     SWDIR@long_name = "SW DIR (TOM)"

     SWDIRs  = a_FSNS
     SWDIRs  = dSs - dSs_clean
     SWDIRs@long_name = "SW DIR (SRF)"

     SWCDIR = a_FSNTC 
     SWCDIR = dSC - dSC_clean
     SWCDIR@long_name = "SW clear-sky DIR (TOM)"

     SWCDIRs = a_FSNSC 
     SWCDIRs = dSCs - dSCs_clean
     SWCDIRs@long_name = "SW clear-sky DIR (SRF)"

     LWDIR = a_FSNT 
     LWDIR = dL - dL_clean
     LWDIR@long_name = "LW DIR (TOM)"

     LWDIRs = a_FSNS 
     LWDIRs = dLs - dLs_clean
     LWDIRs@long_name = "LW DIR (SRF)"

     LWCDIR = a_FSNT 
     LWCDIR = dLC - dLC_clean
     LWCDIR@long_name = "LW clear-sky DIR (TOM)"

     LWCDIRs = a_FSNS 
     LWCDIRs = dLCs - dLCs_clean
     LWCDIRs@long_name = "LW clear-sky DIR (SRF)"

     TTDIR   = SWDIR
     TTDIR   = SWDIR + LWDIR
     TTDIR@long_name = "Total DIR (TOM)"

     TTDIRs   = SWDIRs
     TTDIRs   = SWDIRs + LWDIRs
     TTDIRs@long_name = "Total DIR (SRF)"

     TTCDIR   = SWCDIR
     TTCDIR   = SWCDIR + LWCDIR
     TTCDIR@long_name = "Total clear-sky DIR (TOM)"

     TTCDIRs   = SWCDIRs
     TTCDIRs   = SWCDIRs + LWCDIRs
     TTCDIRs@long_name = "Total clear-sky DIR (SRF)"

     ;;...............................
     ;; residual effect
     ;;...............................

     SWALB = dSC_clean
     LWALB = dLC_clean

     SWALBs = dSCs_clean
     LWALBs = dLCs_clean

     TTALB = SWALB
     TTALB = SWALB + LWALB 
     SWALB@long_name = "SW RES (TOM)"
     LWALB@long_name = "LW RES (TOM)"
     TTALB@long_name = "Total RES (TOM)" 

     TTALBs = SWALBs
     TTALBs = SWALBs + LWALBs
     SWALBs@long_name = "SW RES (SRF)"
     LWALBs@long_name = "LW RES (SRF)"
     TTALBs@long_name = "Total RES (SRF)" 

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
     ;; output
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

     fno = MYPATH + "/" + MYFILE + ".nc" 

     if (isfilepresent(fno)) then
         system("rm " + fno) 
     end if

     print(" ") 
     print(" ") 
     print(" output : " + fno) 
     print(" ") 
     print(" ") 

     flo = addfile(fno,"c") 

     flo->TTAEF=TTAEF
     flo->SWAEF=SWAEF
     flo->LWAEF=LWAEF

     flo->TTAEFs=TTAEFs
     flo->SWAEFs=SWAEFs
     flo->LWAEFs=LWAEFs

     flo->SWCAEF=SWCAEF
     flo->LWCAEF=LWCAEF

     flo->SWCAEFs=SWCAEFs
     flo->LWCAEFs=LWCAEFs

     flo->SWIND=SWIND
     flo->LWIND=LWIND
     flo->TTIND=TTIND

     flo->SWINDs=SWINDs
     flo->LWINDs=LWINDs
     flo->TTINDs=TTINDs

     flo->SWDIR=SWDIR
     flo->LWDIR=LWDIR
     flo->TTDIR=TTDIR

     flo->SWDIRs=SWDIRs
     flo->LWDIRs=LWDIRs
     flo->TTDIRs=TTDIRs

     flo->SWCDIR=SWCDIR
     flo->LWCDIR=LWCDIR
     flo->TTCDIR=TTCDIR

     flo->SWCDIRs=SWCDIRs
     flo->LWCDIRs=LWCDIRs
     flo->TTCDIRs=TTCDIRs

     flo->SWALB=SWALB
     flo->LWALB=LWALB
     flo->TTALB=TTALB

     flo->SWALBs=SWALBs
     flo->LWALBs=LWALBs
     flo->TTALBs=TTALBs

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
     ;; print information 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

     ;;...............................
     ;; gridarea
     ;;...............................

     lat = fla->lat
     lon = fla->lon
     gridarea = area_global_rectilinear_grid(lat, lon, False)

     ;;...............................
     ;; global and monthly mean
     ;;...............................

     nt = dimsizes(SWIND(:,0,0)) 

     do it = 0, nt-1 

        tt_SWIND = sum(SWIND(it,:,:)*gridarea)/sum(gridarea)
        tt_LWIND = sum(LWIND(it,:,:)*gridarea)/sum(gridarea)

        tt_SWDIR = sum(SWDIR(it,:,:)*gridarea)/sum(gridarea)
        tt_LWDIR = sum(LWDIR(it,:,:)*gridarea)/sum(gridarea)

        tt_SWALB = sum(SWALB(it,:,:)*gridarea)/sum(gridarea)
        tt_LWALB = sum(LWALB(it,:,:)*gridarea)/sum(gridarea)

        tt_TTAEF = sum(TTAEF(it,:,:)*gridarea)/sum(gridarea)
        tt_SWAEF = sum(SWAEF(it,:,:)*gridarea)/sum(gridarea)
        tt_LWAEF = sum(LWAEF(it,:,:)*gridarea)/sum(gridarea)


        txt = new((/20/),"string") 
        txt = " "

        txt( 0) = " " 
        txt( 1) = " " 
        txt( 2) = fna
        txt( 3) = fnb
        txt( 4) = " " 
        txt( 5) = "SWIND : " + sprintf("%8.3f",tt_SWIND)
        txt( 6) = "LWIND : " + sprintf("%8.3f",tt_LWIND)
        txt( 7) = "SWDIR : " + sprintf("%8.3f",tt_SWDIR)
        txt( 8) = "LWDIR : " + sprintf("%8.3f",tt_LWDIR)
        txt( 9) = "SWALB : " + sprintf("%8.3f",tt_SWALB)
        txt(10) = "LWALB : " + sprintf("%8.3f",tt_LWALB)
        txt(11) = "TTAEF : " + sprintf("%8.3f",tt_TTAEF)
        txt(12) = "SWAEF : " + sprintf("%8.3f",tt_SWAEF)
        txt(13) = "LWAEF : " + sprintf("%8.3f",tt_LWAEF)
        txt(14) = " "

        print(" ") 
        print(" ") 
        print(" "+fna) 
        print(" "+fnb) 
        print(" ") 
        print("SWIND : " + sprintf("%8.3f",tt_SWIND)) 
        print("LWIND : " + sprintf("%8.3f",tt_LWIND)) 
        print("SWDIR : " + sprintf("%8.3f",tt_SWDIR)) 
        print("LWDIR : " + sprintf("%8.3f",tt_LWDIR)) 
        print("SWALB : " + sprintf("%8.3f",tt_SWALB)) 
        print("LWALB : " + sprintf("%8.3f",tt_LWALB)) 
        print("TTAEF : " + sprintf("%8.3f",tt_TTAEF))
        print("SWAEF : " + sprintf("%8.3f",tt_SWAEF))
        print("LWAEF : " + sprintf("%8.3f",tt_LWAEF))
        print(" ") 
        print(" ") 

        asciiwrite("info_"+MYFILE+"_"+it, txt ) 

     end do ;; do it 

  else

     print(" ================================== ") 
     print(" ")
     print(" ")
     print(" not found : "+ fna ) 
     print(" not found : "+ fnb ) 
     print(" ")
     print(" ")
     print(" ================================== ") 

  end if ;; if(isfilepresent(fna) .and. isfilepresent(fnb))

end


