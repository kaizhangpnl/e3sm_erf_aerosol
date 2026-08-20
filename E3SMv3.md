## Simulation configuration for E3SMv3

The following setup works for E3SMv3, with the updated MAM5 aerosol module. 

The namelist control needs to be added to user_nl_eam.  

### A double call to radiation  

```
 !!..................................................................
 !! for aerosol forcing diagnsotics (decomposition) 
 !! 
 !! this will activate a second call to radiation without aerosols 
 !!..................................................................

 rad_diag_1 = 'A:H2OLNZ:H2O', 'N:O2:O2',
         'N:CO2:CO2', 'A:O3:O3',
         'A:N2OLNZ:N2O', 'A:CH4LNZ:CH4',
         'N:CFC11:CFC11', 'N:CFC12:CFC12'
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

### Emission (PD) 

```
 !!..................................................................
 !! for PD emission (2010) the first simulation 
 !!..................................................................

 !..............................
 ! elevated
 !..............................
 ext_frc_cycle_yr               = 2010
 ext_frc_specifier              = 'NO2 -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_NO2_aircraft_vertical_2010_clim_1.9x2.5_c20230213.nc',
         'SO2         -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_elev_1x1_2010_clim_c20190821.nc',
         'SOAG0       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/emissions-cmip6_e3sm_SOAG0_elev_2010_clim_1.9x2.5_c20230213.nc',
         'bc_a4       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_elev_1x1_2010_clim_c20190821.nc',
         'num_a1      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_elev_1x1_2010_clim_c20190821.nc',
         'num_a2      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_elev_1x1_2010_clim_c20190821.nc',
         'num_a4      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_elev_1x1_2010_clim_c20190821.nc',
         'pom_a4      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_elev_1x1_2010_clim_c20190821.nc',
         'so4_a1      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_elev_1x1_2010_clim_c20190821.nc',
         'so4_a2      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_elev_1x1_2010_clim_c20190821.nc'
 ext_frc_type           = 'CYCLICAL'
 !..............................
 ! surface
 !..............................
 srf_emis_cycle_yr              = 2010
 srf_emis_specifier             = 'C10H16 -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_MTERP_surface_2010_clim_1.9x2.5_c20230213.nc',
         'C2H4      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C2H4_surface_2010_clim_1.9x2.5_c20230213.nc',
         'C2H6      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C2H6_surface_2010_clim_1.9x2.5_c20230213.nc',
         'C3H8      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C3H8_surface_2010_clim_1.9x2.5_c20230213.nc',
         'CH2O      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH2O_surface_2010_clim_1.9x2.5_c20230213.nc',
         'CH3CHO    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH3CHO_surface_2010_clim_1.9x2.5_c20230213.nc',
         'CH3COCH3  -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH3COCH3_surface_2010_clim_1.9x2.5_c20230213.nc',
         'CO        -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CO_surface_2010_clim_1.9x2.5_c20230213.nc',
         'DMS       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DMSflux.2010.1deg_latlon_conserv.POPmonthlyClimFromACES4BGC_c20190220.nc',
         'E90       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions_E90_surface_2010_clim_1.9x2.5_c20230213.nc',
         'ISOP      -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_ISOP_surface_2010_clim_1.9x2.5_c20230213.nc',
         'ISOP_VBS  -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_ISOP_surface_2010_clim_1.9x2.5_c20230213.nc',
         'NO        -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_NO_surface_2010_clim_1.9x2.5_c20230213.nc',
         'SO2       -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_surf_1x1_2010_clim_c20190821.nc',
         'SOAG0     -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/emissions-cmip6_e3sm_SOAG0_surf_2010_clim_1.9x2.5_c20230213.nc',
         'bc_a4     -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_surf_1x1_2010_clim_c20190821.nc',
         'num_a1    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_surf_1x1_2010_clim_c20190821.nc',
         'num_a2    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_surf_1x1_2010_clim_c20190821.nc',
         'num_a4    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_surf_1x1_2010_clim_c20190821.nc',
         'pom_a4    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_surf_1x1_2010_clim_c20190821.nc',
         'so4_a1    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_surf_1x1_2010_clim_c20190821.nc',
         'so4_a2    -> $DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_surf_1x1_2010_clim_c20190821.nc'
 srf_emis_type          = 'CYCLICAL'
 !..............................
 ! oxidants
 !..............................
 tracer_cnst_cycle_yr           = 2015
 tracer_cnst_datapath           = '$DIN_LOC_ROOT/atm/cam/chem/trop_mozart_aero/oxid'
 tracer_cnst_file               = 'oxid_1.9x2.5_L26_1850-2015_c20181106.nc'
 tracer_cnst_filelist           = ''
 tracer_cnst_specifier          = 'prsd_O3:O3','prsd_NO3:NO3','prsd_OH:OH'
 tracer_cnst_type               = 'CYCLICAL'
```

### Emission (PI) 

```
 !!..................................................................
 !! for PI emission (1850) the second simulation 
 !!  
 !! ext_frc_cycle_yr and srf_emis_cycle_yr should be changed 
 !!..................................................................
 !..............................
 ! elevated
 !..............................
 ext_frc_cycle_yr               = 1850
    ext_frc_specifier              = 'NO2    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_NO2_aircraft_vertical_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'SO2    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_elev_1850-2014_c180205.nc',
            'SOAG0  -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/emissions-cmip6_e3sm_SOAG0_elev_1850-2014_1.9x2.5_c20230201.nc',
            'bc_a4       -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_elev_1850-2014_c180205.nc',
            'num_a1      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_elev_1850-2014_c180205.nc',
            'num_a2      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_elev_1850-2014_c180205.nc',
            'num_a4      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_elev_1850-2014_c180205.nc',
            'pom_a4      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_elev_1850-2014_c180205.nc',
            'so4_a1      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_elev_1850-2014_c180205.nc',
            'so4_a2      -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_elev_1850-2014_c180205.nc'
 ext_frc_type           = 'CYCLICAL'

 !..............................
 ! surface
 !..............................
 srf_emis_cycle_yr              = 1850
    srf_emis_specifier             = 'C2H4     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C2H4_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'C2H6     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C2H6_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'C3H8     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_C3H8_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'CH2O     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH2O_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'CH3CHO   -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH3CHO_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'CH3COCH3 -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CH3COCH3_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'CO       -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_CO_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'ISOP     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_ISOP_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'ISOP_VBS -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_ISOP_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'C10H16   -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_MTERP_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'SOAG0     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/emissions-cmip6_e3sm_SOAG0_surf_1850-2014_1.9x2.5_c20230201.nc',
            'NO        -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions-cmip6_e3sm_NO_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc',
            'DMS       -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DMSflux.2010-as-1850.1deg_latlon_conserv.POPmonthlyClimFromACES4BGC_c20190220.nc',
            'SO2       -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so2_surf_1850-2014_c180205.nc',
            'bc_a4     -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_bc_a4_surf_1850-2014_c180205.nc',
            'num_a1    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a1_surf_1850-2014_c180205.nc',
            'num_a2    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a2_surf_1850-2014_c180205.nc',
            'num_a4    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_num_a4_surf_1850-2014_c180205.nc',
            'pom_a4    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_pom_a4_surf_1850-2014_c180205.nc',
            'so4_a1    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a1_surf_1850-2014_c180205.nc',
            'so4_a2    -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/DECK_ne30/cmip6_mam4_so4_a2_surf_1850-2014_c180205.nc'
            'E90       -> /lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/emis/chem_gases/2degrees/emissions_E90_surface_2010-as-1850_clim_1.9x2.5_c20230213.nc'
 srf_emis_type          = 'CYCLICAL'
 !..............................
 ! oxidants
 !..............................
 tracer_cnst_cycle_yr           = 1849
 tracer_cnst_datapath           = '/lcrc/group/e3sm/data/inputdata/atm/cam/chem/trop_mozart_aero/oxid'
 tracer_cnst_file               = 'oxid_1.9x2.5_L26_1850-2015_c20181106.nc'
 tracer_cnst_filelist           = ''
 tracer_cnst_specifier          = 'prsd_O3:O3','prsd_NO3:NO3','prsd_OH:OH'
 tracer_cnst_type               = 'CYCLICAL'
```

