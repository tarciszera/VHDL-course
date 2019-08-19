-- ShiftRegisterLeft (Tarcis)

-- Bibliotecas e clásulas
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Entidade (Bloco entrada e saída)
entity shifter is
	
	port (
	input : in unsigned ((7) downto 0);
	shift_cntrl : in unsigned ((1) downto 0);
	shift_out : out unsigned ((15) downto 0)
	);
	
end entity shifter;


-- Arquitetura (O que acontece dentro da entidade)
architecture shift of shifter is
begin
	
	process (input, shift_cntrl) 
	begin
		shift_out <= (others => '0');
			
		if shift_cntrl = "01" then
			shift_out(11 downto 4) <= input;			
		elsif shift_cntrl = "10" then
			shift_out(15 downto 8) <= input;
		else
			shift_out(7 downto 0) <= input;
		end if;
					
	end process;

end architecture shift;

