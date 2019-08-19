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
-- criando sinais de estimulo
	constant portsize : integer := 16;
	signal clk :  std_logic;
	signal sclr_n :  std_logic;
	signal clk_ena :  std_logic;
	signal datain :  unsigned ((portsize -1)  downto 0);
	signal reg_out :  unsigned ((portsize -1)  downto 0);
	
begin

	regist:entity work.reg
		generic map(
			portsize => portsize
		)
		port map(
			clk => clk,
			sclr_n => sclr_n,
			clk_ena => clk_ena,
			datain => datain,
			reg_out => reg_out
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
		sclr_n <= '0';
		wait for 25 ns;
		sclr_n <= '0';
		wait for 50 ns;
		sclr_n <= '1';
		wait;
	end process;
	
	process
	begin
		datain <= (others => '0');
		wait for 25 ns;
		datain(0) <= '1';
		wait for 25 ns;
		datain(1) <= '1';
		wait for 25 ns;
	end process;
	
	process
	begin
		clk_ena <= '1';
		wait for 100 ns;
		clk_ena <= '0';
		wait for 25 ns;
		clk_ena <= '1';
		wait;
		
	end process;
		
		

end architecture stm;