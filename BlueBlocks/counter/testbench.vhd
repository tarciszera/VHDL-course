-- Bloco Demux (Tarcis)

-- Bibliotecas e cl�sulas
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity tb is
end entity tb;


-- Arquitetura (O que acontece dentro da entidade)
architecture stm of tb is

-- declarando um componente que terah o comportamento do somador
component counter is
	
	port (
		clk : in std_logic;
		aclr_n : in std_logic;
		count_out : out unsigned (1 downto 0)
	);
end component counter;
	
	
-- criando sinais de estimulo

	signal clk :  std_logic;
	signal aclr_n :  std_logic;
	signal count_out :  unsigned (1 downto 0);
	
begin

	instancia_counter:component counter
		port map(
			clk       => clk,
			aclr_n    => aclr_n,
			count_out => count_out
		);
		
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
	
	process
	begin
		aclr_n <= '1';
		wait for 12 ns;
		aclr_n <= '0';
		wait for 12 ns;
		aclr_n <= '1';
		wait for 180 ns;
		aclr_n <= '0';
		wait for 60 ns;
		aclr_n <= '1';
		wait;
		
	end process;
		
		

end architecture stm;