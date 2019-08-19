-- Bloco mux (Tarcis)

-- Bibliotecas e cl�sulas
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity mux_sel is
	
	generic(
		constant portsize : integer := 4
		
	);	
	port (
		mux_sel : in bit;
		mux_in_a : in unsigned ((portsize-1) downto 0);
		mux_in_b : in unsigned ((portsize-1) downto 0);
		mux_out : out unsigned ((portsize-1) downto 0)
	);
end entity mux_sel;


-- Arquitetura (O que acontece dentro da entidade)
architecture mux2 of mux_sel is
begin
	with mux_sel select
	mux_out <= mux_in_a when '0',
			   mux_in_b when '1',
    		   (others=>'0') when others;

end architecture mux2;