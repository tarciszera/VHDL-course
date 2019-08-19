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
component seven_segment_cntrl is
	
	generic(
		constant segType : integer := 0
	);	
	port (
		seg_input : in std_logic_vector (2 downto 0);
		seg_a : out std_logic;
		seg_b : out std_logic;
		seg_c : out std_logic;
		seg_d : out std_logic;
		seg_e : out std_logic;
		seg_f : out std_logic;
		seg_g : out std_logic
	);
end component seven_segment_cntrl;
	
	
-- criando sinais de estimulo

	signal seg_input : std_logic_vector (2 downto 0);
	signal seg_a : std_logic;
	signal seg_b : std_logic;
	signal seg_c : std_logic;
	signal seg_d : std_logic;
	signal seg_e : std_logic;
	signal seg_f : std_logic;
	signal seg_g : std_logic;
	
begin

	instancia_sevseg:component seven_segment_cntrl
		generic map(
			segType => 0
		)
		port map(
			seg_input => seg_input,
			seg_a     => seg_a,
			seg_b     => seg_b,
			seg_c     => seg_c,
			seg_d     => seg_d,
			seg_e     => seg_e,
			seg_f     => seg_f,
			seg_g     => seg_g
		);
				
	process
	begin
		seg_input <= "000";
		wait for 50 ns;
		seg_input <= "000";
		wait for 50 ns;
		seg_input <= "010";
		wait for 50 ns;
		seg_input <= "000";
		wait for 50 ns;
		seg_input <= "100";
		wait for 50 ns;
		seg_input <= "101";
		wait for 50 ns;
		seg_input <= "110";
		wait for 50 ns;
		seg_input <= "111";
		wait for 50 ns;
	end process;
		

end architecture stm;