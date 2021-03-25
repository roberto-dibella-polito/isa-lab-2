#Delete the working directory -> to clean everything
file delete -force "work"
echo *************** Previous work directory deleted ****************

# Create again the work directory
file mkdir "work"
echo *************** New work directory created *********************

source "scripts/fgp/analysis_fgp.tcl"
echo *************** Analysis completed *********************

source "scripts/fgp/compile_0_ultra.tcl"
echo *************** Compile ULTRA with t=0 completed *********************

source "scripts/fgp/compile_final_ultra.tcl"
echo *************** Compile with t=1.68 completed *********************

report_timing

