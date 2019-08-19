library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digital_filter is
	
	port(	
		clk: in std_logic;
		rst_n: in std_logic;
		data_input: in std_logic_vector (15 downto 0);
		filt_out: out std_logic_vector (15 downto 0)
	);
	
end entity digital_filter;

architecture RTL of digital_filter is
			signal mem_raddress		: std_logic_vector (4 downto 0);
			signal mem_waddress		: std_logic_vector (4 downto 0);
			signal mem_clock		: std_logic;
			signal mem_data_in		: std_logic_vector (15 downto 0);
			signal mem_wren			: std_logic;
			signal mem_data_out		: std_logic_vector (15 downto 0);	
			
			signal clock		: std_logic;
			signal acumulator	: std_logic_vector ((15+5) downto 0);	
begin

---------------------- Atribuição de sinais ---------------------------------------------\
	-- Vetor de saída é o acumulador deslocado 5 bits (div por 32)
	filt_out <= acumulator(20 downto 5);
	
	clock <= clk;
		
	mem_clock <= clock;
	mem_data_in <= data_input;
	mem_wren <= '1';

---------------------- Att endereços de leitura e escrita -------------------------------\
	write_to_ram : process (clock) is
		variable waddress_buf: integer range 0 to 31 := 0;
		variable raddress_buf: integer range 0 to 32 := 0;
	begin
		if (rst_n = '0') then
			waddress_buf := 0;
			raddress_buf := 1;

			mem_waddress <= Std_logic_vector(To_unsigned(waddress_buf, 5));
			mem_raddress <= Std_logic_vector(To_unsigned(raddress_buf, 5));

		elsif rising_edge(clock) then 
			
			if (waddress_buf >= 31) then
				waddress_buf := 0;
			else 
				waddress_buf := waddress_buf +1;
			end if;

			raddress_buf := waddress_buf + 1;
			if raddress_buf >= 32 then
				raddress_buf := 0;
			end if;

			mem_waddress <= Std_logic_vector(To_unsigned(waddress_buf, 5));
			mem_raddress <= Std_logic_vector(To_unsigned(waddress_buf, 5));
			
		end if;		
	end process write_to_ram;
----------------------------------------------------------------------------------------\

	
enc_proc: process(w_flag, head)
begin
	w_flag_encoder <= (others => '0');
	if (w_flag = '1') then
			w_flag_encoder(To_integer(head)) <= '1';
	end if;
end process;
	
---------------- Acumula o valor de entrada atual e retira a saida atual ---------------\
	process (clock, rst_n) is
		variable acumulator_buf: integer := 0;
	begin
		if (rst_n = '0') then
			acumulator_buf := 0;
		elsif (rising_edge(clock)) then
			acumulator_buf := acumulator_buf + To_integer(Unsigned(mem_data_in)) - To_integer(Unsigned(mem_data_out));
		end if;

		acumulator <= Std_logic_vector(To_unsigned(acumulator_buf, 21));
	end process;
----------------------------------------------------------------------------------------\

--------------------------------- SRAM ---------------------------------------------------\
	sram: entity work.sram2p
		port map (
			clock		=> mem_clock,
			data		=> mem_data_in,
			rdaddress		=> mem_raddress,
			wraddress		=> mem_waddress,
			wren		=> mem_wren,
			q	=> mem_data_out
		);
----------------------------------------------------------------------------------------\

end architecture RTL;
