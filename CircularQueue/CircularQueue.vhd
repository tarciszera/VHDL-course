-------------------------------------------------------------------
-- name        : registers.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Component instatiation using generate
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CircularQueue is
	port (
		clk 	: in std_logic;
		clear_n	: in std_logic;
		w_flag	: in std_logic;
		r_flag	: in std_logic;
		empty_flag: out std_logic;	
		full_flag: out std_logic;	
		data_in	: in std_logic_vector (15 downto 0);
		data_out: out std_logic_vector (15 downto 0);
		tam_0: out unsigned (4 downto 0)
	);
end entity;


architecture RTL of CircularQueue is
	
	type reg_array is array (0 to 31) of std_logic_vector (15 downto 0);
	signal registers : reg_array;
	
	signal w_flag_encoder : std_logic_vector(31 downto 0) := (others => '0');
	signal head : unsigned (4 downto 0);
	signal tail : unsigned (4 downto 0);
	signal tam : unsigned (4 downto 0);
	signal empty : std_logic := '0';
	signal full : std_logic := '0';
	
begin
	
	empty_flag <= empty;
	full_flag <= full;
	tam_0 <= tam;
	
	-- gera três componentes: observem reg_out
	reg_gen: for i in 0 to 31 generate
		regs: entity work.reg16
			port map (
				clk => clk,
				sclr_n => clear_n,
				clk_ena => w_flag_encoder(i),
				datain => data_in,
				reg_out => registers(i)
			);
	end generate;
	
	process (head, tail, clear_n) is
		variable tam_buf: integer:= 0;
	begin
		if (clear_n = '0') then
			tam <= (others => '0');
			tam_buf := 0;
		else
			if (head >= tail) then
				tam_buf := To_integer(head - tail);
			else
				tam_buf := To_integer(head - tail) + 32;
			end if;
			tam <= To_unsigned(tam_buf, 5);
		end if;
	end process ;
	
	
	
	full_empty_proc: process(tam) is
	begin
		empty <= '0';
		full <= '0';
		if (tam = 0)then
			empty <= '1';
		elsif (tam >= 31) then
			full <= '1';
		end if;
	end process;
	
	enc_proc: process(full, w_flag, head)
	begin
		w_flag_encoder <= (others => '0');
		if (full = '0' and w_flag = '1') then
				w_flag_encoder(To_integer(head)) <= '1';
		end if;
	end process;
	
	
	
	write_proc: process(clk, clear_n) is
		variable head_buf : integer range 0 to 31 := 0;
	begin 
		if (clear_n = '0') then
			head_buf := 0;
		elsif 	(rising_edge(clk)) then
			if (full = '0' and w_flag = '1') then
				if head_buf = 31 then
					head_buf := 0;
				else
					head_buf := head_buf + 1;
				end if;
			end if;
			head <= To_unsigned(head_buf, 5);
		end if;
	end process;	
	
	read_proc: process(clk, clear_n) is
		variable tail_buf : integer range 0 to 31 := 0;
	begin 
		if (clear_n = '0') then
			tail_buf := 0;
			data_out <= (others => '0');
		elsif (rising_edge(clk)) then
			if (empty = '0' and r_flag = '1') then
				data_out <= registers(tail_buf);
				if tail_buf = 31 then
					tail_buf := 0;
				else
					tail_buf := tail_buf + 1;
				end if;
			end if;
			tail <= To_unsigned(tail_buf, 5);
		end if;
	end process;	
			
	
end architecture RTL;