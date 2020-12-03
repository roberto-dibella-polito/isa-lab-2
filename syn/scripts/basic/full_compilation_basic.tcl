#Delete the working directory -> to clean everything
file delete -force "work"
echo *************** Previous work directory deleted ****************

# Create again the work directory
file mkdir "work"
echo *************** New work directory created *********************

source "scripts/analysis.tcl"
echo *************** Analysis completed *********************

source "scripts/basic/compile_0.tcl"
echo *************** Compile with t=0 completed *********************


source "scripts/basic/compile_1_73.tcl"
