#Delete the working directory -> to clean everything
file delete -force "work"
echo *************** Previous work directory deleted ****************

# Create again the work directory
file mkdir "work"
echo *************** New work directory created *********************

source "scripts/mbe/analysis_fgp_mbe.tcl"
echo *************** Analysis completed *********************

source "scripts/mbe/ultra/compile_0_mbe_ultra.tcl"
echo *************** Compile ULTRA with t=0 completed *********************

source "scripts/mbe/ultra/compile_final_mbe_ultra.tcl"
echo *************** Compile ULTRA Final completed *********************

report_timing
