#Delete the working directory -> to clean everything
file delete -force "work"
echo *************** Previous work directory deleted ****************

# Create again the work directory
file mkdir "work"
echo *************** New work directory created *********************

source "scripts/mbe/analysis_fgp_mbe.tcl"
echo *************** Analysis completed *********************

source "scripts/mbe/opt_reg/compile_0_mbe.tcl"
echo *************** Compile with t=0 completed *********************

source "scripts/mbe/opt_reg/compile_0_95_mbe.tcl"
#echo *************** Compile with t=0.89 completed *********************


