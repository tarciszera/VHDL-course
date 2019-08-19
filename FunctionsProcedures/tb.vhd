library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.my_package.all;

entity tb is
	
	port(
		
		outputFunc : out std_logic_vector (4 downto 0);
		outputProcMax : out signed (3 downto 0);
		outputProcMin : out signed (3 downto 0);
		outputProcEve : out signed (3 downto 0)
		
	);
	
end entity tb;

architecture RTL of tb is
	
	signal sig 	:sigs;
		
begin
	
	sig <= ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111");
	
	outputFunc <= ASL(2, "10011");
	
	even_min_max(sig, outputProcMin, outputProcMax, outputProcEve);
	
end architecture RTL;
