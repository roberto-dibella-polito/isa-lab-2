/**********************************************************************
** TESTBENCH FOR FPmul
** Modified version of the "tb_fir.v" example code
**
** Project: Lab 2.1
** Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
***********************************************************************/


//timescale 1ns

module FPmul ();
	
   wire CLK_i;
   wire END_SIM_i;
   reg RST_n_i;
   reg EN_i;

   wire VIN_i;
   wire [7:0] DIN_i;
   wire [7:0] FP_A;
   wire [7:0] FP_B;
   wire [7:0] clk;
  // wire [7:0] H2_i;
   
   wire VOUT_i;
   wire [7:0] FP_Z;
   wire ERR_i;
   
   clk_gen CG(
		 .END_SIM(END_SIM_i),
  	     .CLK(CLK_i));

   data_maker SM(
		 .CLK(CLK_i),
	     .RST_n(RST_n_i),
		 .VOUT(VIN_i),
		 .DOUT(DIN_i),
		 .A(FP_A),
		 .B(FP_B),
		 .CLK(clk),
		 .END_SIM(END_SIM_i),
		 .EN(EN_i));

   FPmul DUT(
		 .DIN(DIN_i),
		 .b0(FP_A),
	         .b1(FP_B),
	         .a1(clk),
		 .CLK(CLK_i),
		 .VIN(VIN_i),
	         .RST_n(RST_n_i),
                 .DOUT(FP_Z),
 		 .VOUT(VOUT_i));

   data_sink DS(
		 .CLK(CLK_i),
		 .RST_n(RST_n_i),
		 .VIN(VOUT_i),
		 .DIN(FP_Z),
		 .ERR(ERR_i));  

	
	// Initial reset
	initial begin 
		EN_i = 1;
		RST_n_i = 0; #2
		RST_n_i = 1; #28
		EN_i = 0; 	 #20
		EN_i = 1;	 
	end

endmodule

