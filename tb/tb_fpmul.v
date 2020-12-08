/**********************************************************************
** TESTBENCH FOR FPmul
**
** Project: Lab 2
** Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
** Last modified: 8/12/2020 10:15
***********************************************************************/


//timescale 1ns

module FPmul ();
	
	wire CLK_i;
	wire END_SIM_i;
	reg RST_n_i;

	wire [31:0] FP_IN;
	wire [31:0] FP_Z_i;
	wire ERR_i;
   
	clk_gen CG(
		.END_SIM(END_SIM_i),
  	    .CLK(CLK_i)
	);

	data_maker SM(
		.CLK(CLK_i),
		.END_SIM(END_SIM_i),
		.DATA(FP_IN)
	);

	FPmul DUT(
		.FP_A(FP_IN),
		.FP_B(FP_IN),
		.FP_Z(FP_Z_i),
		.clk(CLK_i)
	);

   data_sink DS(
		.CLK(CLK_i),
		.RST_n(RST_n_i),
		.FP_Z(FP_Z_i),
		.ERR(ERR_i)
	);  

	
	// Initial reset
	initial begin 
		RST_n_i = 0; #2
		RST_n_i = 1;
	end

endmodule

