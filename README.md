# Effective Aerosol Forcing Diagnostics for E3SM 

## Overview   

Scripts in this repository can be used to calculate/decompose the effective radiative forcing of anthropogenic aerosols (ERFaer). The method follows 
[Ghan et al. (2013)](https://acp.copernicus.org/articles/13/9971/2013/). 

The decomposed forcing fields will be plotted in a multi-row figure with the net, shortwave (SW), and longwave (LW) forcing: 

1. Total ERFaer 
3. ERFaer due to aerosol-cloud interactions (ACI). This term includes indirect aerosol effect and semi-direct aerosol effect. 
2. ERFaer due to aerosol-cloud interactions (ARI). This is also often called direct aerosol effect. 
4. Clear-sky ARI 
5. Residual aerosol forcing (RES, including surface albedo effect, impact of water vapor, and Planck feedback) 

More details can be found in 
[Zhang et al. (2022)](https://acp.copernicus.org/articles/22/9129/2022/). 


## Example 

Demo figures can be found at : https://github.com/kaizhangpnl/e3sm_erf_aerosol/tree/main/demo/E3SMv1_nudged_pdpi 

The following figure shows the global distributions of decomposed net (left column), shortwave (middle column), and longwave (right column) effective aerosol forcing (∆F) at the top of model (TOM). The forcing is calculated based on a pair of nudged simulations with PD and PI aerosol/precursor emissions. 

ALL indicates the total ∆F calculated from the difference between CTRL and E1850 (ALL=ARI+ACI+RES). ACI indicates the ∆F caused by aerosol-cloud interactions (2nd row), ARI the ∆F caused by aerosol-radiation interactions (3rd row), and RES (bottom row) the residual forcing. The clear-sky direct aerosol effect (4th row) is also shown. See [Zhang et al. (2022)](https://acp.copernicus.org/articles/22/9129/2022/) for details. 

<img src="https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/demo/ERFaer_TOM_E3SMv1.png" width="600" class="inline" />


<img src="https://github.com/kaizhangpnl/e3sm_erf_aerosol/blob/main/demo/ERFaer_TOM_E3SMv1_table.png" width="600" class="inline" />


## Simulation configuration    

The following setup works only for E3SMv1 and E3SMv2, with updated MAM4 aerosol module ([Zhang et al. (2022)](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001851)). 

The namelist control needs to be added to user_nl_eam.  

## A double call to radiation  

```
 !!..................................................................
 !! for aerosol forcing diagnsotics (decomposition) 
 !! 
 !! this will activate a second call to radiation without aerosols 
 !!..................................................................

 rad_diag_1 = 'A:Q:H2O', 'N:O2:O2', 'N:CO2:CO2', 'A:O3:O3', 'N:N2O:N2O', 'N:CH4:CH4', 'N:CFC11:CFC11', 'N:CFC12:CFC12'
```

## Aerosol budget/optics diagnostics 

```
 !!..................................................................
 !! for aerosol budget diagnostics, set the following the true 
 !!..................................................................

 history_amwg           = .true.
 history_aerosol        = .true.
 history_aero_optics    = .true.
 history_verbose        = .true.

```


## Emission (PD) 

```
 !!..................................................................
 !! for PD emission (2010) the first simulation 
 !!..................................................................

 ext_frc_cycle_yr               = 2010
 ext_frc_specifier              = 'SO2         -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_elev_1850-2014_c180205.nc',
         'SOAG        -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_soag_elev_1850-2014_c180205.nc',
         'bc_a4       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_elev_1850-2014_c180205.nc',
         'num_a1      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_elev_1850-2014_c180205.nc',
         'num_a2      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_elev_1850-2014_c180205.nc',
         'num_a4      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_elev_1850-2014_c180205.nc',
         'pom_a4      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_elev_1850-2014_c180205.nc',
         'so4_a1      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_elev_1850-2014_c180205.nc',
         'so4_a2      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_elev_1850-2014_c180205.nc'
 ext_frc_type           = 'CYCLICAL'
 srf_emis_cycle_yr              = 2010
 srf_emis_specifier             = 'DMS       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DMSflux.2010.1deg_latlon_conserv.POPmonthlyClimFromACES4BGC_c20190220.nc',
         'SO2       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_surf_1850-2014_c180205.nc',
         'bc_a4     -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_surf_1850-2014_c180205.nc',
         'num_a1    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_surf_1850-2014_c180205.nc',
         'num_a2    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_surf_1850-2014_c180205.nc',
         'num_a4    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_surf_1850-2014_c180205.nc',
         'pom_a4    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_surf_1850-2014_c180205.nc',
         'so4_a1    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_surf_1850-2014_c180205.nc',
         'so4_a2    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_surf_1850-2014_c180205.nc'
 srf_emis_type          = 'CYCLICAL'
```


## Emission (PI) 

```
 !!..................................................................
 !! for PI emission (1850) the second simulation 
 !!  
 !! ext_frc_cycle_yr and srf_emis_cycle_yr should be changed 
 !!..................................................................

 ext_frc_cycle_yr               = 1850 
 ext_frc_specifier              = 'SO2         -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_elev_1850-2014_c180205.nc',
         'SOAG        -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_soag_elev_1850-2014_c180205.nc',
         'bc_a4       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_elev_1850-2014_c180205.nc',
         'num_a1      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_elev_1850-2014_c180205.nc',
         'num_a2      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_elev_1850-2014_c180205.nc',
         'num_a4      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_elev_1850-2014_c180205.nc',
         'pom_a4      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_elev_1850-2014_c180205.nc',
         'so4_a1      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_elev_1850-2014_c180205.nc',
         'so4_a2      -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_elev_1850-2014_c180205.nc'
 ext_frc_type           = 'CYCLICAL'
 srf_emis_cycle_yr              = 1850
 srf_emis_specifier             = 'DMS       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DMSflux.2010.1deg_latlon_conserv.POPmonthlyClimFromACES4BGC_c20190220.nc',
         'SO2       -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_surf_1850-2014_c180205.nc',
         'bc_a4     -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_surf_1850-2014_c180205.nc',
         'num_a1    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_surf_1850-2014_c180205.nc',
         'num_a2    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_surf_1850-2014_c180205.nc',
         'num_a4    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_surf_1850-2014_c180205.nc',
         'pom_a4    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_surf_1850-2014_c180205.nc',
         'so4_a1    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_surf_1850-2014_c180205.nc',
         'so4_a2    -> /compyfs/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_surf_1850-2014_c180205.nc'
 srf_emis_type          = 'CYCLICAL'
```

## Reference 

1. Ghan, S. J.: Technical Note: Estimating aerosol effects on cloud radiative forcing, 
Atmos. Chem. Phys., 13, 9971–9974, https://doi.org/10.5194/acp-13-9971-2013, 2013. 
2. Wang, H., Easter, R. C., Zhang, R., Ma, P.-L., Singh, B., Zhang, K., et al. (2020). Aerosols in the E3SM Version 1: New developments and their impacts on radiative forcing. Journal of Advances in Modeling Earth Systems, 12, e2019MS001851. https://doi.org/10.1029/2019MS001851
3. Zhang, K. et al. Effective radiative forcing of anthropogenic aerosols in E3SM version 1: 
historical changes, causality, decomposition, and parameterization sensitivities, 
Atmos. Chem. Phys., 22, 9129–9160, https://doi.org/10.5194/acp-22-9129-2022, 2022.

## Contact

Kai Zhang (kai.zhang@pnnl.gov) 




