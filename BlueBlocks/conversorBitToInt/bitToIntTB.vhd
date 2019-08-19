-- adder test bench (generic)

-- Library and which part of the library
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity tb is
end entity tb;

-- Architecture
architecture stm of tb is

-- creating stimulus signals
	signal bit : std_logic_vector (3 downto 0);
	signal int : integer;
	
begin

	instancia_converte:entity work.convertBitToInt
		generic map(
			tam => 4
		)
		port map(
			bit => bit,
			int => int
		);
	
	process
	begin
		bit <= "1100";
		wait for 10 ns;
		bit <= "0101";
		wait;
	end process;
	
	
end architecture stm;