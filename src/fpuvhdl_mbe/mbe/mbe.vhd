library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mbe is
	port(
		A_SIG	: in std_logic_vector(31 downto 0);
		B_SIG	: in std_logic_vector(31 downto 0);
		PROD	: out std_logic_vector(63 downto 0)
	);
end mbe;

architecture structure of mbe is
	
	component pj_generator
		port(
			A_SIG 	: in std_logic_vector(31 downto 0);
			b_in	: in std_logic_vector(2 downto 0);
			pj		: out std_logic_vector(32 downto 0)
		);
	end component;
	
	signal multiplier 	: std_logic_vector(32 downto 0);
	--signal bin			: std_logic_vector(2 downto 0);
	
	type radix is array (17 downto 0) of std_logic_vector(2 downto 0);
	signal bin : radix;
	
	type partial_product is array (17 downto 0) of std_logic_vector(32 downto 0);
	signal pj : partial_product;
	
begin
	
	multiplier <= B_SIG & '0';
	
	-- Given each triplet b(2j+1),b(2j),b(2j-1) i have to place on Pj generator
	partial_products: for i in 0 to 31 generate
	
		pj_right: if (i rem 2) /= 0 generate
		
			bin(i/2) <= multiplier(i+1) & multiplier(i) & multiplier(i-1);
			
			partial: entity work.pj_generator(bhv_2) port map
			( 
				A_SIG 	=> A_SIG,
				b_in	=> bin(i/2),
				pj		=> pj(i/2)
			);
			
		end generate;
	end generate;
	
end structure;
	