library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Declaracao do pacote
package everage_package is

---- Tipo ------------------------------------------------------------------

	type vec_32_16b is array (0 to 31) of unsigned (15 downto 0);
		
---- Procedimento ----------------------------------------------------------
		
    procedure everage(signal sig: in vec_32_16b; signal eve: out unsigned (15 downto 0));
    	
----------------------------------------------------------------------------

end package everage_package;
----------------------------------------------------------------------------


-- Corpo do pacote
package body everage_package is

---- Procedimento ----------------------------------------------------------

	procedure everage(signal sig: in vec_32_16b; 
				  	  signal eve: out unsigned (15 downto 0)) is
		
		variable eve_buf : unsigned ((15+3) downto 0);
		
	begin
		
		eve_buf := (others => '0');
	
		for i in sig'range loop
			
			eve_buf := eve_buf + sig(i);
	
		end loop;
		
		eve <= eve_buf((15+3) downto 3);
			
	end procedure everage;

----------------------------------------------------------------------------
	
end package body everage_package;
