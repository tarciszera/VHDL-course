-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de10_lite is 
	port (
		---------- CLOCK ----------
		ADC_CLK_10:	in std_logic;
		MAX10_CLK1_50: in std_logic;
		MAX10_CLK2_50: in std_logic;
		
		----------- SDRAM ------------
		DRAM_ADDR: out std_logic_vector (12 downto 0);
		DRAM_BA: out std_logic_vector (1 downto 0);
		DRAM_CAS_N: out std_logic;
		DRAM_CKE: out std_logic;
		DRAM_CLK: out std_logic;
		DRAM_CS_N: out std_logic;		
		DRAM_DQ: inout std_logic_vector(15 downto 0);
		DRAM_LDQM: out std_logic;
		DRAM_RAS_N: out std_logic;
		DRAM_UDQM: out std_logic;
		DRAM_WE_N: out std_logic;
		
		----------- SEG7 ------------
		HEX0: out std_logic_vector(7 downto 0); 
		HEX1: out std_logic_vector(7 downto 0);
		HEX2: out std_logic_vector(7 downto 0);
		HEX3: out std_logic_vector(7 downto 0);
		HEX4: out std_logic_vector(7 downto 0);
		HEX5: out std_logic_vector(7 downto 0);

		----------- KEY ------------
		KEY: in std_logic_vector(1 downto 0);

		----------- LED ------------
		LEDR: out std_logic_vector(9 downto 0);

		----------- SW ------------
		SW: in std_logic_vector(9 downto 0);

		----------- VGA ------------
		VGA_B: out std_logic_vector(3 downto 0);
		VGA_G: out std_logic_vector(3 downto 0);
		VGA_HS: out std_logic;
		VGA_R: out std_logic_vector(3 downto 0);
		VGA_VS: out std_logic;
	
		----------- Accelerometer ------------
		GSENSOR_CS_N: out std_logic;
		GSENSOR_INT: in std_logic_vector(2 downto 1);
		GSENSOR_SCLK: out std_logic;
		GSENSOR_SDI: inout std_logic;
		GSENSOR_SDO: inout std_logic;
	
		----------- Arduino ------------
		ARDUINO_IO: inout std_logic_vector(15 downto 0);
		ARDUINO_RESET_N: inout std_logic
	);
end entity;


architecture RTL of de10_lite is
	
	signal lock 	: std_logic;
	signal rst 	: std_logic;
	signal clk 	: std_logic;
	
	
	signal clk_10k 	: std_logic;
	signal clear_n	: std_logic;
	signal w_flag	: std_logic;
	signal r_flag	: std_logic;
	signal empty_flag: std_logic;	
	signal full_flag: std_logic;	
	signal data_in	: std_logic_vector (15 downto 0);
	signal data_out: std_logic_vector (15 downto 0);
	
	signal cont : unsigned (15 downto 0);
	signal tam : unsigned (4 downto 0);
	 
begin
	lock <= '0';
	rst <= '0';
	
	clear_n <= SW(0);
	w_flag <= SW(1);
	r_flag <= SW(2);
	data_in(0) <= SW(3);
	data_in(1) <= SW(4);
	data_in(2) <= SW(5);
	data_in(3) <= SW(6);
	data_in(15 downto 4) <= (others => '0');
	
	LEDR(0) <= clear_n;
	LEDR(1) <= tam(0);
	LEDR(2) <= tam(1);
	LEDR(3) <= tam(2);
	LEDR(4) <= tam(3);
	LEDR(5) <= tam(4);
	LEDR(6) <= clk;
	LEDR(7) <= empty_flag;
	LEDR(8) <= full_flag;
	
	
	
	process (clk_10k, clk) is
		variable cont_buf: integer range 0 to 63000 := 0;
		variable n : integer := 10000;
	begin
		if rising_edge(clk_10k) then
			cont_buf := cont_buf +1;
			if (cont_buf = n) then
				cont_buf := 0;
			end if;
			
		end if;
		cont <= To_unsigned(cont_buf, 16);
	end process;
	
	
	process (cont) is
		variable n : integer:= 10000;
		variable n2 : integer:= 5000;
	begin
		if cont >= To_unsigned(0,16) and cont < To_unsigned(n2,16) then
			clk <= '1';
		elsif cont <= To_unsigned(n,16) and cont >= To_unsigned(n2,16) then
			clk <= '0';
		end if;
	end process;
	
	
	CircularQueue: entity work.CircularQueue
		port map(
			clk        => clk,
			clear_n    => clear_n,
			w_flag     => w_flag,
			r_flag     => r_flag,
			empty_flag => empty_flag,
			full_flag  => full_flag,
			data_in    => data_in,
			data_out   => data_out,
			tam_0 	   => tam
		);
	
	pll: entity work.pll
		port map (
			areset	 => rst,
			inclk0	 => ADC_CLK_10,
			c0	 => clk_10k,
			locked	 => lock
		);
	
	Disp7seg: entity work.seven_segment_cntrl
		generic map(
			segType => 1,
			dot     => 0
		)
		port map(
			seg_input => Unsigned(data_out(3 downto 0)),
			dataout   => HEX0 (7 downto 0)
		);

end architecture RTL;

