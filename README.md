# Effective Aerosol Forcing Diagnostics for E3SM 

## Overview   

Scripts in this repository can be used to calculate/decompose the effective radiative forcing of anthropogenic aerosols (ERFaer). The method follows 
[Ghan et al. (2013)](https://acp.copernicus.org/articles/13/9971/2013/). 

The decomposed forcing fields will be plotted in a multi-row figure with the net, shortwave (SW), and longwave (LW) forcing: 

1. Total ERFaer 
3. ERFaer due to aerosol-cloud interactions (ACI). This term includes indirect aerosol effect and semi-direct aerosol effect. 
2. ERFaer due to aerosol-radiation interactions (ARI). This is also often called direct aerosol effect. 
4. Clear-sky ARI 
5. Residual aerosol forcing (RES, including surface albedo effect, impact of water vapor, and Planck feedback) 

More details can be found in 
[Zhang et al. (2022)](https://acp.copernicus.org/articles/22/9129/2022/). 

## Example 

Demo figures can be found at : https://github.com/kaizhangpnl/e3sm_erf_aerosol/tree/main/demo/E3SMv1_nudged_pdpi 

### Summary figure  

The following figure shows the global distributions of decomposed net (left column), shortwave (middle column), and longwave (right column) effective aerosol forcing (∆F) at the top of model (TOM). The forcing is calculated based on a pair of [nudged simulations](https://github.com/kaizhangpnl/nudging_e3sm) with PD and PI aerosol/precursor emissions. 

ALL indicates the total ∆F calculated from the difference between CTRL and E1850 (ALL=ARI+ACI+RES). ACI indicates the ∆F caused by aerosol-cloud interactions (2nd row), ARI the ∆F caused by aerosol-radiation interactions (3rd row), and RES (bottom row) the residual forcing. The clear-sky direct aerosol effect (4th row) is also shown. See [Zhang et al. (2022)](https://acp.copernicus.org/articles/22/9129/2022/) for details. 

<img src="https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/demo/ERFaer_TOM_E3SMv1.png" width="600" class="inline" />

### Summary table  

The [following table](https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/demo/E3SMv1_nudged_pdpi/table_erf_aer) shows the global and regional mean effective aerosol forcing at the top of model and at the surface. 

<img src="https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/demo/ERFaer_TOM_E3SMv1_table.png" width="600" class="inline" />


## Simulation configuration    

### E3SMv1 and E3SMv2 

https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/E3SMv2.md

### E3SMv3 

https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/E3SMv3.md

### E3SMv4 

TO BE INCLUDED.  

## Main script 

The main script is [diag_aer_forcing.csh](https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/script/diag_aer_forcing.csh), which will use NCO and CDO to extract/merge/average the data and call the following NCL scripts to calculate/decompse the forcing: 

1. cal_erf_aer_time_mean_all.ncl (calculate/decompose forcing) 
2. make_table_erf_aer_ann_mean.ncl (create a summary table) 
3. plot_erf_aer_ann_mean_all.ncl (plot top-of-model (TOM) forcing)  
4. plot_erf_aer_ann_mean_all_surf.ncl (plot surface (SUR) forcing) 
5. plot_erf_aer_seas_mean.ncl (plot seasonal mean TOM forcing)  


## Requirement 

1. NCO (https://nco.sourceforge.net/) 
2. CDO (https://code.mpimet.mpg.de/projects/cdo/) 
3. NCL (https://www.ncl.ucar.edu/) 

## Reference 

1. Ghan, S. J.: Technical Note: Estimating aerosol effects on cloud radiative forcing, 
Atmos. Chem. Phys., 13, 9971–9974, https://doi.org/10.5194/acp-13-9971-2013, 2013. 
2. Wang, H., Easter, R. C., Zhang, R., Ma, P.-L., Singh, B., Zhang, K., et al. (2020). Aerosols in the E3SM Version 1: New developments and their impacts on radiative forcing. Journal of Advances in Modeling Earth Systems, 12, e2019MS001851. https://doi.org/10.1029/2019MS001851
3. Zhang, K. et al. Effective radiative forcing of anthropogenic aerosols in E3SM version 1: 
historical changes, causality, decomposition, and parameterization sensitivities, 
Atmos. Chem. Phys., 22, 9129–9160, https://doi.org/10.5194/acp-22-9129-2022, 2022.

## Contact

Kai Zhang (kai.zhang@pnnl.gov) 




