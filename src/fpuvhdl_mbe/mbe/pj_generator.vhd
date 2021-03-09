-- MBE multiplier
-- Single bit Partial product generation block

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pj_generator is 
	port(
		A_SIG 	: in std_logic_vector(31 downto 0);
		b_in	: in std_logic_vector(2 downto 0);
		pj		: out std_logic_vector(32 downto 0)
	);
end pj_generator;

-- FIRST ARCHITECTURE
-- Using three selection signals

architecture bhv_1 of pj_generator is
	
	signal sel_0, sel_A, sel_2A : std_logic;
	signal qj 					: std_logic_vector(32 downto 0);
	
begin
	
	sel_0 <= not(b_in(1) xor b_in(0)) and not(b_in(2) xor b_in(1));
	sel_A <= b_in(1) xor b_in(0);
	sel_2A <= not(b_in(1) xor b_in(0)) and (b_in(2) xor b_in(1));
	
	-- Behavioural selection of qj
	-- Done in this way to speed-up the modeling process
	qj_sel: process(sel_0, sel_A, sel_2A)
	begin
		if sel_0 then
			qj <= (others=>'0');
		
		elsif sel_A then 
			qj <= A_SIG(31) & A_SIG;
		
		elsif sel_2A then
			qj <= A_SIG & '0';
			
		end if;
	end process;
	
	pj <= ( b_in(2) xor qj ) or b_in(2);
	
end bhv_1;

-- SECOND ARCHITECTURE:
-- The value of qj is chosen comparing directly b_in: 
-- the realization of the boolean values is left to the compiler

architecture bhv_2 of pj_generator is

	signal qj : std_logic_vector(32 downto 0);
	
begin
	
	qj_sel: process(b_in)
	begin
	
		case b_in is
			
			when "000" or "111" => qj <= (others=>'0');
			when "011" or "100" => qj <= A_SIG & '0';
			when others => qj <= A_SIG(31) & A_SIG;
		
		end case;
		
	end process;

end bhv_2;
		


		