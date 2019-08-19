
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity mux_when is
	
	generic(
		constant portsize : integer := 4
		
	);	
	port (
		mux_sel : in bit;
		mux_in_a : in unsigned ((portsize-1) downto 0);
		mux_in_b : in unsigned ((portsize-1) downto 0);
		mux_out : out unsigned ((portsize-1) downto 0)
	);
end entity mux_when;


-- Arquitetura (O que acontece dentro da entidade)
architecture mux1 of mux_when is
begin

	mux_out <= 	mux_in_a when mux_sel = '0' else
				mux_in_b when mux_sel = '1' else
		   		(others=>'0');

end architecture mux1;