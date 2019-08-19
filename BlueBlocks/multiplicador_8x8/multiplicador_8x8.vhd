
-- Library and uses
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity mult88 is
	port(
		dataa: in std_logic_vector (7 downto 0);
		datab: in std_logic_vector (7 downto 0);
		start : in std_logic;
		reset_a : in std_logic;
		clk : in std_logic;
		done_flag : out std_logic;
		product8x8_out: out std_logic_vector (15 downto 0);
		seg_a : out std_logic;
		seg_b : out std_logic;
		seg_c : out std_logic;
		seg_d : out std_logic;
		seg_e : out std_logic;
		seg_f : out std_logic;
		seg_g : out std_logic;
		seg_h : out std_logic
	);
end entity mult88;

-- Architecture
architecture mu of mult88 is

	-- signals declaration
	
	--mux
	signal sela : std_logic;
	signal selb : std_logic;
	signal aout : unsigned(3 downto 0);
	signal bout : unsigned(3 downto 0);
	--mult
	signal product : unsigned(7 downto 0);
	--shifter
	signal shift : unsigned(1 downto 0);
	signal shift_out : unsigned(15 downto 0);
	--adder
	signal sum : unsigned(15 downto 0);
	--reg16
	signal sclr_n : std_logic;
	signal clk_ena : std_logic;
	--counter
	signal count : unsigned(1 downto 0);
	--mult_control
	signal input_sel : unsigned(1 downto 0);
	signal shift_sel : unsigned(1 downto 0);
	signal state_out : unsigned(2 downto 0);
	
	signal n_start : std_logic;
	signal product8x8_out1: unsigned (15 downto 0);
		
begin
	
	
	muxa:entity work.mux_sel
		generic map(
			portsize => 4
		)
		port map(
			mux_sel  => Std_logic(input_sel(1)),
			mux_in_a => Unsigned(dataa (3 downto 0)),
			mux_in_b => Unsigned(dataa (7 downto 4)),
			mux_out  => aout
		);
	muxb:entity work.mux_sel
		generic map(
			portsize => 4
		)
		port map(
			mux_sel  => Std_logic(input_sel(0)),
			mux_in_a => Unsigned(datab (3 downto 0)),
			mux_in_b => Unsigned(datab (7 downto 4)),
			mux_out  => bout
		);
		
	mult4x4:entity work.mult
		generic map(
			portsize => 4
		)
		port map(
			dataa => aout,
			datab => bout,
			product  => product
		);
	
	shfter:entity work.shifter
		port map(
			input       => product,
			shift_cntrl => shift,
			shift_out   => shift_out
		);
		
	adders:entity work.adder
		generic map(
			portsize => 16
		)
		port map(
			dataa => shift_out,
			datab => product8x8_out1,
			sum   => sum
		);
		
	reg16a:entity work.reg
		port map(
			clk     => clk,
			sclr_n  => sclr_n,
			clk_ena => clk_ena,
			datain  => sum,
			reg_out => product8x8_out1
		);
		
	countera:entity work.counter
		port map(
			clk       => clk,
			aclr_n    => n_start,
			count_out => count
		);	
		
	mult_control:entity work.mult_control
		port map(
			clk       => clk,
			reset_a   => reset_a,
			start     => start,
			count     => count,
			input_sel => input_sel,
			shift_sel => shift,
			state_out => state_out,
			done      => done_flag,
			clk_ena   => clk_ena,
			sclr_n    => sclr_n
		);
		
	sev_seg:entity work.seven_segment_cntrl
		generic map(
			segType => 1,
			dot => 0
		)
		port map(
			seg_input => state_out,
			seg_a     => seg_a,
			seg_b     => seg_b,
			seg_c     => seg_c,
			seg_d     => seg_d,
			seg_e     => seg_e,
			seg_f     => seg_f,
			seg_g     => seg_g,
			seg_h     => seg_h
		);
		
		
	
		n_start <= not start;
		product8x8_out <= Std_logic_vector(product8x8_out1);
		
end architecture mu;
