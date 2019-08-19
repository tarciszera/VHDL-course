library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
	port(
		clk : in std_logic;
		stop : in std_logic;
		dout : out std_logic_vector (7 downto 0)
	);
end entity fsm;

architecture RTL of fsm is
	type state_type is (a, ab, b, bc, c, cd, d, de, e, ef, f, fa);
	signal cont : unsigned (9 downto 0);
begin
	
	process(clk, stop) is
		variable state : state_type := a;
		variable n1 : integer range 0 to 1000 := 800;
		variable n2 : integer range 0 to 1000 := 300;
		variable cont_buf : integer := 0;
		variable cont_bits : integer := 10;
	begin
		if stop = '1' then
			cont_buf := 0;
			state := a;
			dout <= (others => '0');
		elsif rising_edge(clk) then
			cont_buf := cont_buf + 1;
			case state is
			when a =>
				state := a;
				dout <= Std_logic_vector(To_unsigned(1,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := ab;
					cont_buf := 0;
				end if;
			when ab =>
				state := ab;
				dout <= Std_logic_vector(To_unsigned(3,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := b;
					cont_buf := 0;
				end if;
			when b =>
				state := b;
				dout <= Std_logic_vector(To_unsigned(2,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := bc;
					cont_buf := 0;
				end if;
			when bc =>
				state := bc;
				dout <= Std_logic_vector(To_unsigned(6,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := c;
					cont_buf := 0;
				end if;
			when c =>
				
				state := c;
				dout <= Std_logic_vector(To_unsigned(4,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := cd;
					cont_buf := 0;
				end if;
			when cd =>
				
				state := cd;
				dout <= Std_logic_vector(To_unsigned(12,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := d;
					cont_buf := 0;
				end if;
			when d =>
				
				state := d;
				dout <= Std_logic_vector(To_unsigned(8,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := de;
					cont_buf := 0;
				end if;
			when de =>
				
				state := de;
				dout <= Std_logic_vector(To_unsigned(24,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := e;
					cont_buf := 0;
				end if;
			when e =>
				
				state := e;
				dout <= Std_logic_vector(To_unsigned(16,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := ef;
					cont_buf := 0;
				end if;
			when ef =>
				state := ef;
				dout <= Std_logic_vector(To_unsigned(48,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := f;
					cont_buf := 0;
				end if;
			when f =>
				
				state := f;
				dout <= Std_logic_vector(To_unsigned(32,8));
				
				if cont = To_unsigned(n1,cont_bits) then
					state := fa;
					cont_buf := 0;
				end if;
			when fa =>
				
				state := fa;
				dout <= Std_logic_vector(To_unsigned(33,8));
				
				if cont = To_unsigned(n2,cont_bits) then
					state := a;
					cont_buf := 0;
				end if;
			end case;
			
			cont <= To_unsigned(cont_buf, cont_bits);
		end if;
	end process;
	

end architecture RTL;