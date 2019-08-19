
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity tb is
end entity tb;


-- Arquitetura (O que acontece dentro da entidade)
architecture stm of tb is
-- criando sinais de estimulo

	constant portsize : integer := 8;
	signal vec_in : unsigned (portsize-1 downto 0);
	signal par_out :  std_logic;
	signal enable : std_logic;
	
begin

	paridade_instance:entity work.paridade
		generic map(
			portsize => portsize
		)
		port map(
			par_vec_in => vec_in,
			par_enable => enable,
			par_out => par_out
		);
		
	
	
	process
	begin
		vec_in <= (others => '0');
		wait for 25 ns;
		vec_in(0) <= '1';
		wait for 25 ns;
		vec_in(1) <= '1';
		wait for 25 ns;
		vec_in(2) <= '1';
		wait for 25 ns;
		vec_in(3) <= '1';
		wait for 25 ns;
		vec_in(4) <= '1';
		wait;
	end process;
	
	process
	begin
		enable <= '1';
		wait for 105 ns;
		enable <= '0';
		wait for 50 ns;
		enable <= '1';
		wait;
		
	end process;
		
		

end architecture stm;