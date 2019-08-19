library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_adder is
end entity tb_adder;

architecture RTL of tb_adder is
	constant portsize : integer := 4;
	signal dataa : unsigned (portsize-1 downto 0);
	signal datab : unsigned (portsize-1 downto 0);
	signal sum : unsigned (portsize-1 downto 0);
	
begin
	adder_instance:entity work.adder
		generic map(
			portsize => portsize
		)
		port map(
			dataa => dataa,
			datab => datab,
			sum   => sum
		);
		
	process is
	begin
		dataa <= to_unsigned(1, portsize);
		datab <= to_unsigned(10, portsize);
		wait for 10 ns;
		dataa <= to_unsigned(2, portsize);
		wait for 10 ns;
		dataa <= to_unsigned(3, portsize);
		wait;
	end process;
	
end architecture RTL;
