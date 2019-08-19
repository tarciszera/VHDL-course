-- Seven Seg Control Block

-- Library and uses
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity reg is
	generic(
		constant portsize : integer range 0 to 256 := 16
	);
	port (
		clk : in std_logic;
		sclr_n : in std_logic;
		clk_ena : in std_logic;
		datain : in unsigned ((portsize -1) downto 0);
		reg_out : out unsigned ((portsize -1) downto 0)
	);
end entity reg;


-- Architecture
architecture registration of reg is
begin
	reg_process: process (clk, sclr_n, clk_ena)
	begin
		if (sclr_n = '0') then
			reg_out <= (others => '0');
		elsif (rising_edge(clk)) then
			if (clk_ena = '1') then
				reg_out <= datain;
			end if;
		end if;
	end process;
end architecture registration;