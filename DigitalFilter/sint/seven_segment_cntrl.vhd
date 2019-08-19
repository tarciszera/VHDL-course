-- Seven Seg Control Block

-- Library and uses
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity seven_segment_cntrl is
	
	generic(
		constant segType : integer := 0;
		constant dot : integer := 0
	);	
	port (
		seg_input : in unsigned (3 downto 0);
		dataout:out std_logic_vector (7 downto 0)
	);
end entity seven_segment_cntrl;


-- Architecture
architecture control of seven_segment_cntrl is
	 

begin
	sev_seg_process: process (seg_input)
		variable bufferOut0 : unsigned (7 downto 0);
		variable bufferOut1 : unsigned (6 downto 0);
		
	begin
		bufferOut0 := (others => '0');
		if (seg_input = To_unsigned(0,4)) then
			bufferOut0 := To_unsigned(63, 8);
			
		elsif (seg_input = To_unsigned(1,4)) then
			bufferOut0 := To_unsigned(6, 8);
			
		elsif (seg_input = To_unsigned(2,4)) then
			bufferOut0 := To_unsigned(91, 8);
			
		elsif (seg_input = To_unsigned(3,4)) then
			bufferOut0 := To_unsigned(79, 8);
			
		elsif (seg_input = To_unsigned(4,4)) then
			bufferOut0 := To_unsigned(102, 8);
			
		elsif (seg_input = To_unsigned(5,4)) then
			bufferOut0 := To_unsigned(109, 8);
			
		elsif (seg_input = To_unsigned(6,4)) then
			bufferOut0 := To_unsigned(125, 8);
			
		elsif (seg_input = To_unsigned(7,4)) then
			bufferOut0 := To_unsigned(7, 8);
			
		elsif (seg_input = To_unsigned(8,4)) then
			bufferOut0 := To_unsigned(127, 8);
			
		elsif (seg_input = To_unsigned(9,4)) then
			bufferOut0 := To_unsigned(111, 8);
			
		elsif (seg_input = To_unsigned(10,4)) then
			bufferOut0 := To_unsigned(119, 8);
			
		elsif (seg_input = To_unsigned(11,4)) then
			bufferOut0 := To_unsigned(124, 8);
			
		elsif (seg_input = To_unsigned(12,4)) then
			bufferOut0 := To_unsigned(15, 8);
			
		elsif (seg_input = To_unsigned(13,4)) then
			bufferOut0 := To_unsigned(94, 8);
			
		elsif (seg_input = To_unsigned(14,4)) then
			bufferOut0 := To_unsigned(121, 8);
			
		elsif (seg_input = To_unsigned(15,4)) then
			bufferOut0 := To_unsigned(113, 8);
			
		end if;
		
		dataout <= not Std_logic_vector(bufferOut0);
		
			
	end process;
end architecture control;