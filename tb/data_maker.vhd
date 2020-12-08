----------------------------------------------------------------
-- CLOCK GENERATOR
-- Modified version of the "clk_gen.vhd" example code provided 
-- for the Lab 1.
-- Generates a clock signal of period Ts.
--
-- Project: Lab 2
-- Authors: Group 32 (Chatrasi, Di Bella, Zangeneh)
-- Last modified: 8/12/2020 09:50
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  port (
    CLK  	: in  std_logic;
    DATA 	: out std_logic_vector(31 downto 0)
	END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

	signal sEndSim : std_logic;
	signal END_SIM_i : std_logic_vector(0 to 10);

begin  -- beh

    rd_file: process (CLK)
	
		file fp : text open read_mode is "tb/fp_samples.hex";
		variable ptr : line;
		variable val : std_logic_vector(31 downto 0);
	
	begin  -- process
		if CLK'event and CLK = '1' then  -- rising clock edge
			if (not(endfile(fp))) then
				readline(fp, ptr);
				read(ptr, val);     
				DATA <= val;
				sEndSim <= '0';
			else 
				sEndSim <= '1';
			end if;
		end if;
	end process rd_file;
	
	shift_count: process (CLK, RST_n)
	
	begin  -- process
		if RST_n = '0' then                 -- asynchronous reset (active low)
			END_SIM_i <= (others => '0');
		elsif CLK'event and CLK = '1' then  -- rising clock edge
			END_SIM_i(0) <= sEndSim;
			END_SIM_i(1 to 10) <= END_SIM_i(0 to 9);
		end if;
	end process shift_count;

  END_SIM <= END_SIM_i(10);

end beh;
