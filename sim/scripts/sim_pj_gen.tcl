# PARTIAL PRODUCT GENERATION - Try
# This script is used to try to use the two different architecture and see if their compilations have problem



file delete -force "work" 

vlib work

vcom -93 -work ./work ../src/fpuvhdl_mbe/mbe/pj_generator.vhd

