file delete -force "work" 

vlib work

vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_v2.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vcom -93 -work ./work ../tb/delayer.vhd
vcom -93 -work ./work ../src/fpuvhdl/common/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../src/fpuvhdl/common/fpround_fpround.vhd
vcom -93 -work ./work ../src/fpuvhdl/common/packfp_packfp.vhd
vcom -93 -work ./work ../src/fpuvhdl/common/unpackfp_unpackfp.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd
vlog -work ./work ../tb/tb_fpmul_basic.v

# Start simulation
vsim work.tb_fpmul
#add wave -radix hexadecimal * 
add wave sim:/tb_fpmul/CLK_i
add wave sim:/tb_fpmul/END_SIM_i
add wave -radix hexadecimal sim:/tb_fpmul/FP_IN
add wave -radix hexadecimal sim:/tb_fpmul/FP_Z_i
add wave sim:/tb_fpmul/ERR_i

add wave -divider "Internal signals"
add wave -radix hexadecimal sim:/tb_fpmul/DUT/fp_a
add wave -radix hexadecimal sim:/tb_fpmul/DUT/fp_b

add wave -divider "Read from fp_samples.hex"
add wave -radix hexadecimal sim:/tb_fpmul/SM/rd_file/val

add wave -divider "Data producing signals"
add wave sim:/tb_fpmul/SM/d_ready
add wave sim:/tb_fpmul/DL/delay_i
add wave sim:/tb_fpmul/DL/dout

#run 2200 ns
