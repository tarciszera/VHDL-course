library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digital_filter is
	
	port(	
		clk: in std_logic;
		rst_n: in std_logic;
		data_input: in std_logic_vector (15 downto 0);
		filt_out: out std_logic_vector (15 downto 0)
	);
	
end entity digital_filter;

architecture RTL of digital_filter is
begin


end architecture RTL;
