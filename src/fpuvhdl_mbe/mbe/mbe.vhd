library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mbe_mult is
	port(
		A_SIG	: in std_logic_vector(31 downto 0);
		B_SIG	: in std_logic_vector(31 downto 0);
		PROD	: out std_logic_vector(63 downto 0)
	);
end mbe_mult;

architecture structure of mbe_mult is
	
	signal 
	
begin
	