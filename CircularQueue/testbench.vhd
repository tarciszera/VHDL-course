-------------------------------------------------------------------
-- name        : testbench.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Types examples
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb is
end entity tb;

architecture RTL of tb is
	
	signal clk 	: std_logic;
	signal clear	: std_logic;
	signal w_flag	: std_logic;
	signal r_flag	: std_logic;
	signal empty_flag: std_logic;	
	signal full_flag: std_logic;	
	signal data_in	: std_logic_vector (15 downto 0);
	signal data_out: std_logic_vector (15 downto 0);
	 
begin
	
	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
	
	
	clear <= '0', '1' after 5 ns;	
	w_flag <= '0', '1' after 10 ns,'0' after 50 ns, '1' after 110 ns, '0' after 450 ns;
	r_flag <= '0', '1' after 50 ns, '0' after 70 ns, '1' after 480 ns;
	data_in <= (others => '1'), 
				Std_logic_vector(To_unsigned(1, 16)) after 30 ns, 
				Std_logic_vector(To_unsigned(10, 16)) after 60 ns, 
				Std_logic_vector(To_unsigned(15, 16)) after 200 ns,
				Std_logic_vector(To_unsigned(83, 16)) after 500 ns;
	
	
	
	CircularQueue: entity work.CircularQueue
		port map(
			clk        => clk,
			clear_n      => clear,
			w_flag     => w_flag,
			r_flag     => r_flag,
			empty_flag => empty_flag,
			full_flag  => full_flag,
			data_in    => data_in,
			data_out   => data_out
		);
	

end architecture RTL;
