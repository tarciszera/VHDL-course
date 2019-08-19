
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity paridade is
	generic(
		constant portsize : integer := 8
	);
	port (
		par_vec_in : in unsigned (portsize-1 downto 0);
		par_enable : in std_logic;
		par_out : out std_logic
	);
end entity paridade;


-- Architecture
architecture count of paridade is
begin
	process (par_vec_in, par_enable)
		variable cont: std_logic;
	begin
	    cont := '1';
		if par_enable = '1' then
			for i in par_vec_in'range loop
				if (par_vec_in(i) = '1') then
					cont := not cont;
				end if;
			end loop;
		end if;
		par_out <= cont;
	end process;
end architecture count;