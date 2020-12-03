# Import files into Design Compiler: ANALYZE
# analyze -f vhdl -lib WORK ../src/<file name>.vhd

#####################################################
#	ANALYSIS SCRIPT									#
#	Design: 		fpuvhdl_mod						#
#	Last modified:	December 3, 2020 15:30			#	
#####################################################


analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/common/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/multiplier/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/multiplier/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mod/multiplier/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true

elaborate FPmul -arch pipeline -lib WORK > ./elaborate.txt
uniquify
link


