# Import files into Design Compiler: ANALYZE
# analyze -f vhdl -lib WORK ../src/<file name>.vhd

#####################################################
#	PJ_GENERATOR SYNTHESIS SCRIPT					#
#	Design: 		fpuvhdl_mbe						#
#	Last modified:									#	
#####################################################


analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/pj_generator.vhd
set power_preserve_rtl_hier_names true

elaborate pj_generator -arch bhv_2 -lib WORK > results/mbe/pj_gen_bhv2_elaborate.txt
uniquify
link

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

report_timing > results/mbe/pj_gen_bhv2_timing_clk_0.txt
report_area > results/mbe/pj_gen_bhv2_area_clk_0.txt
report_resources > results/mbe/pj_gen_bhv2_res_clk_0.txt

