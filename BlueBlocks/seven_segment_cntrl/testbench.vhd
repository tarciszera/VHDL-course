LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e sa�da)
entity tb is
end entity tb;


-- Arquitetura (O que acontece dentro da entidade)
architecture stm of tb is

-- criando sinais de estimulo

	signal seg_input : unsigned (3 downto 0);
	signal seg_a : std_logic;
	signal seg_b : std_logic;
	signal seg_c : std_logic;
	signal seg_d : std_logic;
	signal seg_e : std_logic;
	signal seg_f : std_logic;
	signal seg_g : std_logic;
	signal seg_h : std_logic;
	
begin

	instancia_sevseg:entity work.seven_segment_cntrl
		generic map(
			segType => 0,
			dot => 1
		)
		port map(
			seg_input => seg_input,
			seg_a     => seg_a,
			seg_b     => seg_b,
			seg_c     => seg_c,
			seg_d     => seg_d,
			seg_e     => seg_e,
			seg_f     => seg_f,
			seg_g     => seg_g,
			seg_h     => seg_h
		);
				
	process
	begin
		seg_input <= "0000";
		wait for 30 ns;
		seg_input <= "0001";
		wait for 30 ns;
		seg_input <= "0010";
		wait for 30 ns;
		seg_input <= "0011";
		wait for 30 ns;
		seg_input <= "0100";
		wait for 30 ns;
		seg_input <= "0101";
		wait for 30 ns;
		seg_input <= "0110";
		wait for 30 ns;
		seg_input <= "1000";
		wait for 30 ns;
		seg_input <= "1001";
		wait for 30 ns;
	end process;
		

end architecture stm;