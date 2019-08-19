library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Declaracao do pacote
package my_package is

---- Tipo ------------------------------------------------------------------

	type sigs is array (0 to 7) of signed (3 downto 0);

---- Funcao ----------------------------------------------------------------
	
	function ASL(n: integer; vector: std_logic_vector) return std_logic_vector;
		
---- Procedimento ----------------------------------------------------------
		
    procedure even_min_max(signal sig: in sigs; signal min, max, eve: out signed (3 downto 0));
    	
----------------------------------------------------------------------------

end package my_package;
----------------------------------------------------------------------------


-- Corpo do pacote
package body my_package is

---- Funcao ----------------------------------------------------------------

	function ASL(n: integer; vector: std_logic_vector) return std_logic_vector is
		
		variable  tam: integer := vector'length;
		variable  buf: std_logic_vector (n-1 downto 0) := (others => '0');
		
	begin
		
		return vector (n to tam-1) & buf;
		
	end function ASL;

---- Procedimento ----------------------------------------------------------

	procedure even_min_max(signal sig: in sigs; 
				  signal min, max, eve: out signed (3 downto 0)) is
		
		variable min_buf : signed (3 downto 0);
		variable max_buf : signed (3 downto 0);
		variable eve_buf : signed (6 downto 0);
		
	begin
		
		min_buf := sig(0);
		max_buf := sig(0);
		eve_buf := "0000000";
	
		for i in sig'range loop
			
			if sig(i) < min_buf then
				min_buf := sig(i);
			end if;
		
			if sig(i) > max_buf then
				max_buf := sig(i);
			end if;
	
			eve_buf := eve_buf + sig(i);
	
		end loop;
		
		min <= min_buf;
		max <= max_buf;
		eve <= eve_buf(6 downto 3);
			
	end procedure even_min_max;

----------------------------------------------------------------------------
	
end package body my_package;
