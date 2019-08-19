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


architecture rtl of de10_lite is

	signal clk: std_logic;
	signal clk_10k: std_logic;
	signal rst_n: std_logic;
	signal rst: std_logic;
	signal lock: std_logic;
	signal data_input: std_logic_vector (15 downto 0);
	signal filt_out: std_logic_vector (15 downto 0);
	
begin
	
	rst_n <= sw(9);
	LEDR(0) <= clk;
	
	rst <= not rst_n;
	lock <= '0';
	
	data_input(0) <= sw(0);
	data_input(1) <= sw(1);
	data_input(2) <= sw(2);
	data_input(3) <= sw(3);
	data_input(15 downto 4) <= (others => '0');
	
	
------------------ Processo de gerar 1 segundo de clock ---------------------/
	clock: process (clk_10k) is
		variable counter: integer range 0 to 60000 := 0;
		variable n: integer := 5000;
		variable n2: integer := 2500;
	begin
		if (rst = '1') then
			counter := 0;
		elsif rising_edge(clk_10k) then
			if (counter >= n) then
				counter := 0;
			else
				counter := counter + 1;
			end if;
			
			if (counter >= 0 and counter <= n2) then
				clk <= '1';
			elsif (counter > n2 and counter < n) then
				clk <= '0'; 
			end if;
			
		end if;
	end process;
------------------------------------------------------------------------------/
	
----------------------- Declaracao do pll e filtro ---------------------------/
	pll: entity work.pll
		port map (
			areset	 => rst,
			inclk0	 => ADC_CLK_10,
			c0	 => clk_10k,
			locked	 => lock
		);
	
	digital_filter: entity work.digital_filter
		port map (
			clk 		=> clk,
			rst_n	  	=> rst_n,
			data_input  => data_input,
			filt_out 	=> filt_out
		);
------------------------------------------------------------------------------/
	
----------------------- Declaracao dos decodificadores 7 seg -----------------/
	disp7seg: entity work.seven_segment_cntrl
		generic map(
			segType => 1,
			dot     => 0
		)
		port map(
			seg_input => Unsigned(data_input(3 downto 0)),
			dataout   => HEX1 (7 downto 0)
		);
	
	disp7seg2: entity work.seven_segment_cntrl
		generic map(
			segType => 1,
			dot     => 0
		)
		port map(
			seg_input => Unsigned(filt_out(3 downto 0)),
			dataout   => HEX0 (7 downto 0)
		);
------------------------------------------------------------------------------/

end;

