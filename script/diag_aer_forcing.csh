#!/bin/csh 
#---------------------------------------------------------------------
# Master script to calculate and plot the aerosol forcing diagnostics 
#
# Calls the following NCL scripts: 
#
#   cal_erf_aer_time_mean_all.ncl      : calculate/decompose forcing 
#   make_table_erf_aer_ann_mean.ncl    : create a summary table 
#   plot_erf_aer_ann_mean_all.ncl      : plot top-of-model (TOM) forcing    
#   plot_erf_aer_ann_mean_all_surf.ncl : plot surface (SUR) forcing  
#   plot_erf_aer_seas_mean.ncl         : plot seasonal mean TOM forcing   
#
# Required data:  
#   . Climo files from simulation with PD aerosol/precursor emissions
#   . Climo files from simulation with PI aerosol/precursor emissions
#
# Required tools:
#   . CDO
#   . NCO 
#   . NCL
#
# Contact: Kai Zhang (kai.zhang@pnnl.gov) 
#---------------------------------------------------------------------

 set echo 

###################################
## set case name
###################################
setenv C1 run.F2010.pi.compy
setenv C2 run.F2010.pd.compy
 
setenv mycase "F2010_pdpi" 

###################################
## set path
###################################
setenv myscratch /compyfs/${user}/e3sm_scratch
setenv myarchive /compyfs/${user}/e3sm_scratch/archive
setenv P1 ${myscratch}/${C1}/climo/ # PI climo files, regridded to latlon grid 
setenv P2 ${myscratch}/${C2}/climo/ # PD climo files, regridded to latlon grid 
setenv Q1 ${myscratch}/${C1}/post/erftest/ # PI output data 
setenv Q2 ${myscratch}/${C1}/post/erftest/ # PD output data 
setenv Q3 ${myscratch}/${C1}/post/erftest/ # output data 
setenv AA ${myarchive}

###################################
## optional flags
###################################
setenv create_data_radflux  "T"
setenv create_data_erf_aero "T"
setenv archive_data         "F" 

mkdir -p ${Q1}
mkdir -p ${Q2}
mkdir -p ${Q3}

foreach yy (2010)

###################################
## extract/merge/average radflux data 
###################################

if($create_data_radflux == "T") then 

   echo ' ' 
   echo ' ' 
   echo '============= ' $yy ' =============' 
   echo ' ' 
   echo ' ' 
   
   foreach mm (01 02 03 04 05 06 07 08 09 10 11 12) ## ANN DJF JJA SON MAM) 
   
      echo ' ' 
      echo ' ' 
      echo '--- ' $mm ' ---'
      echo ' ' 
      echo ' ' 
   
      ###################################
      ## select vars
      ###################################
   
      echo ' ' 
      echo ' selecting data '
      echo ' ' 
  
      setenv F1 ${P1}/${C1}_${mm}_*.nc 
      setenv F2 ${P2}/${C2}_${mm}_*.nc 
   
      setenv O3 ${Q1}/TB_EFF_AERFOR_${C1}_${yy}-${mm}.nc   
      setenv O4 ${Q2}/TB_EFF_AERFOR_${C2}_${yy}-${mm}.nc   
  
      rm -f $O3 
      rm -f $O4
 
      setenv vlist "AODVIS,FSNT,FLNT,FSNTC,FLNTC,FSNT_d1,FLNT_d1,FSNTC_d1,FLNTC_d1,FSNS,FLNS,FSNSC,FLNSC,FSNS_d1,FLNS_d1,FSNSC_d1,FLNSC_d1" 

      ncks -v $vlist $F1 $O3 >& err1_ncks_${mm} & 
      ncks -v $vlist $F2 $O4 >& err2_ncks_${mm} & 
  
      wait 
 
      setenv O5 ${Q1}/TC_EFF_AERFOR_${C1}_${yy}-${mm}.nc   
      setenv O6 ${Q2}/TC_EFF_AERFOR_${C2}_${yy}-${mm}.nc   
  
      rm -f $O5 
      rm -f $O6
 
      cdo setdate,${yy}-${mm}-01 $O3 $O5 >& err1_setdate_${mm} & 
      cdo setdate,${yy}-${mm}-01 $O4 $O6 >& err2_setdate_${mm} & 
   
   end # mm 
   
   wait 
   
   echo ' '
   echo ' '
   echo '--- averaging ---'
   echo ' '
   echo ' '
  
   ###################################
   ## merge files
   ###################################
   
   echo ' ' 
   echo ' merge files '
   echo ' ' 
   
   setenv O1 ${Q1}/EFF_AERFOR_${C1}_${yy}_monmean.nc 
   setenv O2 ${Q2}/EFF_AERFOR_${C2}_${yy}_monmean.nc 
   
   rm -f $O1 
   rm -f $O2

   ncrcat -h ${Q1}/TC_EFF_AERFOR_${C1}_${yy}-??.nc ${O1} >& err1_ncrcat & 
   ncrcat -h ${Q2}/TC_EFF_AERFOR_${C2}_${yy}-??.nc ${O2} >& err2_ncrcat & 
   
   wait 
   
   ###################################
   ## annual means
   ###################################
   
   echo ' ' 
   echo ' annual means '
   echo ' ' 
   
   setenv O3 ${Q1}/EFF_AERFOR_${C1}_${yy}_yearmonmean.nc  
   setenv O4 ${Q2}/EFF_AERFOR_${C2}_${yy}_yearmonmean.nc  
   
   rm -f $O3 
   rm -f $O4
 
   # number of days considered 
   
   cdo yearmonmean ${O1} ${O3} >& err1_cdo_yearmonmean & 
   cdo yearmonmean ${O2} ${O4} >& err2_cdo_yearmonmean & 
   
   wait 
   
   ###################################
   ## seasonal means
   ###################################
   
   echo ' ' 
   echo ' seasonal means '
   echo ' ' 
   
   setenv O5 ${Q1}/EFF_AERFOR_${C1}_${yy}_yseasmean.nc  
   setenv O6 ${Q2}/EFF_AERFOR_${C2}_${yy}_yseasmean.nc  
   
   rm -f $O5 
   rm -f $O6
 
   cdo yseasmean ${O1} ${O5} >& err1_cdo_yseasmean & 
   cdo yseasmean ${O2} ${O6} >& err2_cdo_yseasmean & 
   
   wait
   
   ###################################
   ## cleanup 
   ###################################
   
   echo ' ' 
   echo ' clean up '
   echo ' ' 
   
   rm -f ${Q1}/T* 
   rm -f ${Q2}/T* 
   
   cat err* > log
   rm err* 
   
   echo ' ' 
   echo ${Q1} 
   ls ${Q1} 
   echo ' ' 
   echo ${Q2} 
   ls ${Q2} 
   echo ' ' 
   echo ' ' 
   echo ' ' 

endif # create_data_radflux 


###################################
## create forcing diag data 
###################################

if($create_data_erf_aero == "T") then 

   ###################################
   ## monthly mean
   ###################################
   
   setenv O1 ${Q1}/EFF_AERFOR_${C1}_${yy}_monmean.nc 
   setenv O2 ${Q2}/EFF_AERFOR_${C2}_${yy}_monmean.nc 
   
   setenv file_pi $O1 
   setenv file_pd $O2
   setenv mypath  $Q3
   setenv mytime  "monthly"
 
   ncl cal_erf_aer_time_mean_all.ncl
   
   ###################################
   ## annual mean 
   ###################################
   
   setenv O3 ${Q1}/EFF_AERFOR_${C1}_${yy}_yearmonmean.nc  
   setenv O4 ${Q2}/EFF_AERFOR_${C2}_${yy}_yearmonmean.nc  
   
   setenv file_pi $O3 
   setenv file_pd $O4
   setenv mypath  $Q3
   setenv mytime  "ANN"
   
   ncl cal_erf_aer_time_mean_all.ncl
   
   ###################################
   ## seasonal mean 
   ###################################
   
   setenv O5 ${Q1}/EFF_AERFOR_${C1}_${yy}_yseasmean.nc  
   setenv O6 ${Q2}/EFF_AERFOR_${C2}_${yy}_yseasmean.nc  
   
   setenv file_pi $O5 
   setenv file_pd $O6
   setenv mypath  $Q3
   setenv mytime  "seas"
   
   ncl cal_erf_aer_time_mean_all.ncl

endif # create_data_erf_aero 


###################################
## archive data
###################################

if($archive_data == "T") then 

   setenv A1 ${AA}/${C1} 
   setenv A2 ${AA}/${C2} 
   setenv A3 ${AA}/data_AIE
   
   mkdir -p ${A1}
   mkdir -p ${A2}
   mkdir -p ${A3}
   
   cp ${Q1}/*.nc ${A1} 
   cp ${Q2}/*.nc ${A2} 
   cp ${Q3}/*.nc ${A3} 
   
   ln -s ${A1} 
   ln -s ${A2}
   ln -s ${A3}

endif # archive_data

###################################
## make plot
###################################

setenv mypath  $Q3

ncl make_table_erf_aer_ann_mean.ncl     >& err_make_table_erf_aer_ann_mean    & 
ncl plot_erf_aer_ann_mean_all.ncl       >& err_plot_erf_aer_ann_mean_all      & 
ncl plot_erf_aer_ann_mean_all_surf.ncl  >& err_plot_erf_aer_ann_mean_all_surf & 
ncl plot_erf_aer_seas_mean.ncl          >& err_plot_erf_aer_seas_mean         & 

wait 

end # yy 

wait


