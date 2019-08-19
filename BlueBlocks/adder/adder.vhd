library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic(
		constant portsize : integer range 0 to 64 := 4
	);
	port(
		dataa : in unsigned (portsize-1 downto 0);
		datab : in unsigned (portsize-1 downto 0);
		sum : out unsigned (portsize-1 downto 0)
		
		);
end entity adder;

architecture RTL of adder is
	
begin
	sum <= dataa + datab;
end architecture RTL;
