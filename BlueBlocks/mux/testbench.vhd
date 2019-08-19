-- Bloco somador (Tarcis)

-- Bibliotecas e cl�sulas
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity tb is
end entity tb;


-- Arquitetura (O que acontece dentro da entidade)
architecture stm of tb is
	constant portsize : integer := 4;
	signal mux_sel : bit;
	signal mux_in_a : unsigned ((portsize-1) downto 0);
	signal mux_in_b : unsigned ((portsize-1) downto 0);
	signal mux_outWS : unsigned ((portsize-1) downto 0);
	signal mux_outWE : unsigned ((portsize-1) downto 0);

	
begin

	mux_we:entity work.muxWE
		generic map(
			portsize => portsize
		)
		port map(
			mux_sel  => mux_sel,
			mux_in_a => mux_in_a,
			mux_in_b => mux_in_b,
			mux_out  => mux_outWE
		);
		
	mux_ws:entity work.muxWS
		generic map(
			portsize => portsize
		)
		port map(
			mux_sel  => mux_sel,
			mux_in_a => mux_in_a,
			mux_in_b => mux_in_b,
			mux_out  => mux_outWS
		);
				
	process
	begin
		mux_in_a <= to_unsigned(10, portsize);
		mux_in_b <= to_unsigned(20, portsize);
		wait for 50 ns;
		mux_sel <= '0';
		wait for 50 ns;
		mux_sel <= '1';
	end process;
		

end architecture stm;