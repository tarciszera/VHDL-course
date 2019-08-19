library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity tb;

architecture stimulus of tb is
	constant portsize : integer := 10;
	signal dataa : unsigned (portsize-1 downto 0);
	signal datab : unsigned (portsize-1 downto 0);
	signal product : unsigned (2*portsize-1 downto 0);

begin
	inst_mult:entity work.mult
		generic map(
			portsize => portsize
		)
		port map(
			dataa   => dataa,
			datab   => datab,
			product => product
		);
	process is
	begin
		dataa <= to_unsigned(2,portsize);
		datab <= to_unsigned(2,portsize);
		wait for 10 ns;
		dataa <= to_unsigned(3,portsize);
		wait for 10 ns;
		dataa <= to_unsigned(31,portsize);
		wait;
	end process;
end architecture stimulus;
