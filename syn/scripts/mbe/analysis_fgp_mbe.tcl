# Import files into Design Compiler: ANALYZE
# analyze -f vhdl -lib WORK ../src/<file name>.vhd

#####################################################
#	ANALYSIS SCRIPT									#
#	Design: 		fpuvhdl_mod_fgp_mbe				#
#####################################################


analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/common/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/common/unpackfp_unpackfp.vhd

analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/ha.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/fa.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/pj_generator.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/dadda.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/mbe/mbe.vhd

analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/multiplier/fpmul_stage2_struct_fgp_mbe.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/multiplier/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl_mbe/multiplier/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true

elaborate FPmul -arch pipeline -lib WORK > ./elaborate_mbe.txt
uniquify
link


