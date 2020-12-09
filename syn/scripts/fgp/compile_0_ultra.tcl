#################################################################################
#	INITIAL ULTRA COMPILATION SCRIPT											#
#	Design: 		fpuvhdl_mod_fgp												#
#	Goal:			Find the maximum frequency forcing the clock period to zero #
#	Last modified:	December 9, 2020 10:02										#	
#################################################################################

# Constraints

# Timing constraints
create_clock -name MY_CLK -period 0.0 clk	
set_dont_touch_network MY_CLK				
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

# Load constraints
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

# Timing & Area report

report_timing > results/fgp/timing_clk_0_bu.txt
report_area > results/fgp/area_clk_0_bu.txt


