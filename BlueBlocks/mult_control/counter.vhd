-- Seven Seg Control Block

-- Library and uses
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity counter is
	
	port (
		clk : in std_logic;
		aclr_n : in std_logic;
		count_out : out unsigned (1 downto 0)
	);
end entity counter;


-- Architecture
architecture count of counter is
begin
	process (clk, aclr_n)
		variable buf: unsigned (1 downto 0);
	begin
		if aclr_n = '0' then
			buf := "00";
		elsif (rising_edge(clk)) then
			buf := buf + 1;
		end if;
		count_out <= buf;
	end process;
end architecture count;