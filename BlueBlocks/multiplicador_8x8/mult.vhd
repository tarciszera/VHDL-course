library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
	generic(
		constant portsize : integer := 4
	);
	port(
		dataa : in unsigned (portsize-1 downto 0);
		datab : in unsigned (portsize-1 downto 0);
		product : out unsigned (2*portsize-1 downto 0)
	);
end entity mult;

architecture RTL of mult is
begin
	product <= dataa*datab;
end architecture RTL;
