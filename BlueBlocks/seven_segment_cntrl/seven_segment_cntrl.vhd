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
		seg_a : out std_logic;
		seg_b : out std_logic;
		seg_c : out std_logic;
		seg_d : out std_logic;
		seg_e : out std_logic;
		seg_f : out std_logic;
		seg_g : out std_logic;
		seg_h : out std_logic
	);
end entity seven_segment_cntrl;


-- Architecture
architecture control of seven_segment_cntrl is
begin
	sev_seg_process: process (seg_input)
		variable bufferOut0 : unsigned (6 downto 0);
		variable bufferOut1 : unsigned (6 downto 0);
	begin
	
		bufferOut0 := (others => '0');
		bufferOut1 := (others => '1');
		if seg_input = "0000" then
			
			bufferOut0(0):= '1';
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			bufferOut0(3):= '1';
			bufferOut0(4):= '1';
			bufferOut0(5):= '1';
			
			
			bufferOut1(0):= '0';
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			bufferOut1(3):= '0';
			bufferOut1(4):= '0';
			bufferOut1(5):= '0';
			
		elsif seg_input = "0001" then
			
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			
		elsif seg_input = "0010" then
		
			bufferOut0(0):= '1';
			bufferOut0(1):= '1';
			bufferOut0(3):= '1';
			bufferOut0(4):= '1';
			bufferOut0(6):= '1';
			
			bufferOut1(0):= '0';
			bufferOut1(1):= '0';
			bufferOut1(3):= '0';
			bufferOut1(4):= '0';
			bufferOut1(6):= '0';
			
			
		elsif seg_input = "0011" then
		
			bufferOut0(0):= '1';
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			bufferOut0(3):= '1';
			bufferOut0(6):= '1';
			
			bufferOut1(0):= '0';
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			bufferOut1(3):= '0';
			bufferOut1(6):= '0';
		
		elsif seg_input = "0100" then
			
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			bufferOut0(5):= '1';
			bufferOut0(6):= '1';
			
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			bufferOut1(5):= '0';
			bufferOut1(6):= '0';

		elsif seg_input = "0101" then
			
			bufferOut0(0):= '1';
			bufferOut0(2):= '1';
			bufferOut0(3):= '1';
			bufferOut0(5):= '1';
			bufferOut0(6):= '1';
			
			bufferOut1(0):= '0';
			bufferOut1(2):= '0';
			bufferOut1(3):= '0';
			bufferOut1(5):= '0';
			bufferOut1(6):= '0';

		elsif seg_input = "0110" then
			
			bufferOut0(0):= '1';
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			bufferOut0(3):= '1';
			bufferOut0(4):= '1';
			bufferOut0(6):= '1';
			
			bufferOut1(0):= '0';
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			bufferOut1(3):= '0';
			bufferOut1(4):= '0';
			bufferOut1(6):= '0';

		elsif seg_input = "0111" then
			
			bufferOut0(0):= '1';
			bufferOut0(1):= '1';
			bufferOut0(2):= '1';
			
			bufferOut1(1):= '0';
			bufferOut1(2):= '0';
			bufferOut1(0):= '0';

		elsif seg_input = "1000" then
			
			bufferOut0 := (others => '1');
			bufferOut1 := (others => '0');
			
		elsif seg_input = "1001" then
			
			bufferOut0 := (others => '1');
			bufferOut0(4) := '0';
			
			bufferOut1 := (others => '0');
			bufferOut1(4) := '1';
		end if;
		
		if segType = 0 then
		
			seg_a <= std_logic(bufferOut0(0));
			seg_b <= std_logic(bufferOut0(1));
			seg_c <= std_logic(bufferOut0(2));
			seg_d <= std_logic(bufferOut0(3));
			seg_e <= std_logic(bufferOut0(4));
			seg_f <= std_logic(bufferOut0(5));
			seg_g <= std_logic(bufferOut0(6));
		
		else
		
			seg_a <= std_logic(bufferOut1(0));
			seg_b <= std_logic(bufferOut1(1));
			seg_c <= std_logic(bufferOut1(2));
			seg_d <= std_logic(bufferOut1(3));
			seg_e <= std_logic(bufferOut1(4));
			seg_f <= std_logic(bufferOut1(5));
			seg_g <= std_logic(bufferOut1(6));
		
		end if;
		
		if dot = 0 then
			seg_h <= '0';
		else
			seg_h <= '1';
		end if;
			
	end process;
end architecture control;