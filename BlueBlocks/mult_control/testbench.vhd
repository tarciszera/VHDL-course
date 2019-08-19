
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
	signal start :  std_logic;
	signal reset_a :  std_logic;
	signal count :  unsigned(1 downto 0);
	signal done :  std_logic;
	signal clk_ena :  std_logic;
	signal cont_ena :  std_logic;
	signal sclr_n :  std_logic;
	signal input_sel :  unsigned(1 downto 0);
	signal shift_sel :  unsigned(1 downto 0);
	signal state_out :  unsigned(2 downto 0);
	
begin

	cont_inst:entity work.counter
	port map(
		clk => clk,
		aclr_n => cont_ena,
		count_out => count
	);

	fsm_inst:entity work.mult_control
	port map(
		clk => clk,
		reset_a => reset_a,
		start => start,
		count => count,
		input_sel => input_sel,
		shift_sel => shift_sel,
		state_out => state_out,
		done => done,
		clk_ena => clk_ena,
		sclr_n => sclr_n
	);
		
			
	process
	begin
		clk <= '0';
		wait for 40 ns;
		clk <= '1';
		wait for 40 ns;
		
			
	end process;
	
	process
	begin
		start <= '1';
		reset_a <= '0';
		cont_ena <= '0';
		wait for 20 ns;
		reset_a <= '1';
		wait for 40 ns;
		start <= '0';
		wait for 40 ns;
		cont_ena <= '1';
		
		wait;
	end process;	
	

end architecture stm;