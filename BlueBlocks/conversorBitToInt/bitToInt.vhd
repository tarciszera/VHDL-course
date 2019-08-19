-- adder (generic)

-- Library and which part of the library
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity convertBitToInt is
	generic(
		tam : integer := 4
	);
	port (
		bit : in std_logic_vector ((tam-1) downto 0);
		int : out integer
	);
end entity convertBitToInt;

-- Architecture
architecture conv of convertBitToInt is
	
	function bitConvInt (signal bitIn : std_logic_vector) return integer is
		variable temp : integer;
	begin
		temp := 0;
		for i in bitIn'range loop
			if bitIn(i)='1' then
				temp := temp + 2**i;
			end if;
		end loop;
		
 		return temp;
	end bitConvInt;
	
	
begin
	
	int <= bitConvInt(bit);
	
end architecture conv;