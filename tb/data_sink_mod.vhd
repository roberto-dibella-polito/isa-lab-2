----------------------------------------------------------------
-- OUTPUT SAVER
-- Modified version of the "data_sink.vhd" example code provided
-- fot Lab 1.
-- Data coming from the output FP_Z are saved in the file
-- "fpmul_mod_vhd.txt" whenever the EN signal is sampled as high.
-- Each time a new value is saved, it is compared with the 
-- corresponding value coming from the file "fp_prod.hex",
-- containing the correct value: if the two values mismatch, ERR
-- is set to 1.
-- 
--
-- Project: Lab 2 - fpmul_mod
-- Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
-- Last modified: 8/12/2020 16:38
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    FP_Z  : in std_logic_vector(31 downto 0);
	EN	  : in std_logic;
	ERR	  : out std_logic);
end data_sink;

architecture bhv of data_sink is

begin  -- bhv
  	
	wrt_file: process (CLK, RST_n)
  
		file res_fp : text open WRITE_MODE is "results/fpmul_mod_vhd.txt"; --Output file to be written
		variable line_out : line;
		
		file fp_in : text open READ_MODE is "../tb/fp_prod.hex"; --Input file with results
		variable line_in : line;
		variable x : std_logic_vector(31 downto 0);
    
	begin  -- process wrt_file
		if RST_n = '0' then                 -- asynchronous reset (active low)
			ERR <= '0';
		elsif CLK'event and CLK = '1' then  -- rising clock edge
			if EN = '1' then
				hwrite(line_out, FP_Z);
				writeline(res_fp, line_out);

				-- Read line from fp_prod.hex
				if not endfile(fp_in) then
					readline(fp_in, line_in);
					hread(line_in, x);
				
					-- Comparing
					if (x /= FP_Z) then
						ERR <= '1';
					end if;			
				
				end if;
			end if;
		end if;
	end process wrt_file;

end bhv;
