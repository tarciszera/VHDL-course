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
	
-- criando sinais de estimulo
	signal clk :  std_logic;
	signal reset_a :  std_logic;
	signal start :  std_logic;
	signal dataa:  std_logic_vector (7 downto 0);
	signal datab:  std_logic_vector (7 downto 0);
	signal seg_a :  std_logic;
	signal seg_b :  std_logic;
	signal seg_c :  std_logic;
	signal seg_d :  std_logic;
	signal seg_e :  std_logic;
	signal seg_f :  std_logic;
	signal seg_g :  std_logic;
	signal seg_h :  std_logic;
	signal done_flag :  std_logic;
	signal product8x8_out:  std_logic_vector (15 downto 0);
	
begin

	mul88:entity work.mult88
		port map(
			clk            => clk,
			reset_a        => reset_a,
			start          => start,
			dataa          => dataa,
			datab          => datab,
			seg_a          => seg_a,
			seg_b          => seg_b,
			seg_c          => seg_c,
			seg_d          => seg_d,
			seg_e          => seg_e,
			seg_f          => seg_f,
			seg_g          => seg_g,
			done_flag      => done_flag,
			product8x8_out => product8x8_out
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
	
		datab <= "01100101";
		dataa <= "00101011";
		start <= '1';
		reset_a <= '0';
		wait for 5 ns;
		reset_a <= '1';
		wait for 10 ns;
		start <= '0';
		
		wait;
	end process;
		

end architecture stm;