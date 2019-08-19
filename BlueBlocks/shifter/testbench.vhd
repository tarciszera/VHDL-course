-- Bibliotecas e clásulas
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e saída)
entity tb is
end entity tb;


-- Arquitetura (O que acontece dentro da entidade)
architecture stm of tb_shifter is

-- declarando um componente que terah o comportamento do somador
	component shifter is
	
	port (
	input : in unsigned ((7) downto 0);
	shift_cntrl : in unsigned ((1) downto 0);
	shift_out : out unsigned ((15) downto 0)
	);
	
	end component shifter;
	
-- criando sinais de estimulo
	signal shft_input : unsigned((7) downto 0) := "11001100";
	signal shft_cont : unsigned((1) downto 0) := "00";
	signal shft_output : unsigned((15) downto 0) := "0000000000000000";
	
begin

	instanciaSomador: component shifter
	port map(
		input       => shft_input,
		shift_cntrl => shft_cont,
		shift_out   => shft_output
	);
		
	process
	begin
		wait for 200 ns;
			shft_cont <= "00";
		wait for 200 ns;
			shft_cont <= "01";
		wait for 200 ns;
			shft_cont <= "10";
		wait for 200 ns;
			shft_cont <= "11";
	end process;
		

end architecture stm;