## Simulation configuration for E3SMv1 and E3SMv2

The following setup works for E3SMv1 and E3SMv2, with the updated MAM4 aerosol module ([Wang et al. (2020)](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019MS001851)). 

The namelist control needs to be added to user_nl_eam.  

### A double call to radiation  

```
 !!..................................................................
 !! for aerosol forcing diagnsotics (decomposition) 
 !! 
 !! this will activate a second call to radiation without aerosols 
 !!..................................................................

 rad_diag_1 = 'A:Q:H2O', 'N:O2:O2', 'N:CO2:CO2', 'A:O3:O3', 'N:N2O:N2O', 'N:CH4:CH4', 'N:CFC11:CFC11', 'N:CFC12:CFC12'
```

### Aerosol budget/optics diagnostics 

This is not for the forcing calculation, but would be useful for additional aerosol budget and optical property analysis. 

```
 !!..................................................................
 !! for aerosol budget diagnostics, set the following the true 
 !!..................................................................

 history_amwg           = .true.   !! default 
 history_aerosol        = .true.   !! for detailed mass budget analysis 
 history_aero_optics    = .true.   !! for detailed aerosol optical property analysis 
 history_verbose        = .true.   !! for detailed mass budget analysis (mass for individual modes) 

```
