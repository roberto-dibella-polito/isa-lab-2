/**********************************************************************
** TESTBENCH FOR FPmul modified - Fine grain pipelined
** The delayer module is set to 6, since it is the expected latency of
** the fpmul.
**
** Project: Lab 2 - fpmul_mod_fgp
** Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
** Last modified: 8/12/2020 10:15
***********************************************************************/


//timescale 1ns

module tb_fpmul ();
	
	wire CLK_i;
	wire END_SIM_i;
	wire D_READY_i;	// 
	wire WR_EN_i;		// Write enable for the data sink
	reg RST_n_i;

	wire [31:0] FP_IN;
	wire [31:0] FP_Z_i;
	wire ERR_i;
   
	clk_gen CG(
		.END_SIM(END_SIM_i),
  	    .CLK(CLK_i)
	);

	data_maker SM(
		.RST_n(RST_n_i),
		.CLK(CLK_i),
		.END_SIM(END_SIM_i),
		.DATA(FP_IN),
		.D_READY(D_READY_i)
	);

	FPmul DUT(
		.FP_A(FP_IN),
		.FP_B(FP_IN),
		.FP_Z(FP_Z_i),
		.clk(CLK_i)
	);

	delayer #(6) DL(
		.clk(CLK_i),
		.RST_n(RST_n_i),
		.DIN(D_READY_i),
		.DOUT(WR_EN_i)
	);

   	data_sink DS(
		.CLK(CLK_i),
		.RST_n(RST_n_i),
		.FP_Z(FP_Z_i),
		.ERR(ERR_i),
		.EN(WR_EN_i)
	);  

	
	// Initial reset
	initial begin 
		RST_n_i = 0; #2
		RST_n_i = 1;
	end

endmodule

