library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mbe is
	port(
		A_SIG	: in unsigned(31 downto 0);
		B_SIG	: in unsigned(31 downto 0);
		PROD	: out unsigned(63 downto 0)
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
	
	component dadda is
		port(
			P0 : in std_logic_vector(35 downto 0);
			P1 : in std_logic_vector(36 downto 0);
			P2 : in std_logic_vector(36 downto 0);
			P3 : in std_logic_vector(36 downto 0);
			P4 : in std_logic_vector(36 downto 0);
			P5 : in std_logic_vector(36 downto 0);
			P6 : in std_logic_vector(36 downto 0);
			P7 : in std_logic_vector(36 downto 0);
			P8 : in std_logic_vector(36 downto 0);
			P9 : in std_logic_vector(36 downto 0);
			P10 : in std_logic_vector(36 downto 0);
			P11 : in std_logic_vector(36 downto 0);
			P12 : in std_logic_vector(36 downto 0);
			P13 : in std_logic_vector(36 downto 0);
			P14 : in std_logic_vector(36 downto 0);
			P15 : in std_logic_vector(35 downto 0);
			P16 : in std_logic_vector(33 downto 0);
			PARTIAL_1 : out std_logic_vector(63 downto 0);
			PARTIAL_2 : out std_logic_vector(63 downto 0);
			OV	: out std_logic
		);
	end component;
	
	signal multiplier 	: std_logic_vector(32 downto 0);
	--signal bin			: std_logic_vector(2 downto 0);
	
	type radix is array (17 downto 0) of std_logic_vector(2 downto 0);
	signal bin : radix;
	
	type partial_product is array (16 downto 0) of std_logic_vector(32 downto 0);
	signal pj : partial_product;
	
	-- DIRECT REPRESENTATION TYPES of partial product, sign extended
	type partial_product_ext37 is array (14 downto 1) of std_logic_vector(36 downto 0);
	
	signal p0_extended : std_logic_vector(35 downto 0);
	signal pj_extended : partial_product_ext37;
	signal p15_extended : std_logic_vector(35 downto 0);
	signal p16_extended : std_logic_vector(33 downto 0);
	
	signal op1, op2 : std_logic_vector(63 downto 0);
	signal dadda_overflow: std_logic;
	
	
begin
	
	multiplier <= std_logic_vector(B_SIG) & '0';
	
	-- Given each triplet b(2j+1),b(2j),b(2j-1) i have to place on Pj generator
	partial_products: for i in 0 to 31 generate
	
		pj_right: if (i rem 2) /= 0 generate
		
			bin(i/2) <= multiplier(i+1) & multiplier(i) & multiplier(i-1);
			
			partial: entity work.pj_generator(bhv_2) port map
			( 
				A_SIG 	=> std_logic_vector(A_SIG),
				b_in	=> bin(i/2),
				pj		=> pj(i/2)
			);
			
		end generate;
	end generate;

	
	---------------------------------------------------------------------------
	-- PARTIAL PRODUCT EXTENSION
	---------------------------------------------------------------------------
	
	-- pj is DIRECT or COMPLEMENTED depending on the value of b(2j+1), 
	-- to have the 2's complement the addition of b(2j+1) to the LSB is needed
	
	p0_extended <= not(pj(0)(32)) & pj(0)(32) & pj(0)(32) & pj(0);

	pj_ext_gen: for i in 1 to 14 generate
		
		pj_extended(i) <= '1' & not(pj(i)(32)) & pj(i) & '0' & pj(i-1)(32);
		
	end generate;
	
	p15_extended <= not(pj(15)(32)) & pj(15) & '0' & pj(14)(32);
	p16_extended <= pj(16)(31 downto 0) & '0' & pj(15)(32);	
	
	-- Dadda Tree
	tree: dadda port map
	(
		P0 => p0_extended,
		P1 => pj_extended(1),
		P2 => pj_extended(2),
		P3 => pj_extended(3),
		P4 => pj_extended(4),
		P5 => pj_extended(5),
		P6 => pj_extended(6),
		P7 => pj_extended(7),
		P8 => pj_extended(8),
		P9 => pj_extended(9),
		P10 => pj_extended(10),
		P11 => pj_extended(11),
		P12 => pj_extended(12),
		P13 => pj_extended(13),
		P14 => pj_extended(14),
		P15 => p15_extended,
		P16 => p16_extended,
		PARTIAL_1 => op1,
		PARTIAL_2 => op2,
		OV	=> dadda_overflow
	);
	
	-- Final adder
	
	PROD <= unsigned(op1) + unsigned(op2);
	
end structure;
	