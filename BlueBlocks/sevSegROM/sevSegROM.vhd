-- Seven Seg Control Block

-- Library and uses
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity seven_segment_cntrl is
	
	generic(
		constant segType : integer := 0
	);	
	port (
		seg_input : in std_logic_vector (2 downto 0);
		seg_a : out std_logic;
		seg_b : out std_logic;
		seg_c : out std_logic;
		seg_d : out std_logic;
		seg_e : out std_logic;
		seg_f : out std_logic;
		seg_g : out std_logic
	);
end entity seven_segment_cntrl;


-- Architecture
architecture control of seven_segment_cntrl is
begin
	sev_seg_process: process (seg_input)
		variable bufferOut : unsigned (6 downto 0);
	begin
		bufferOut := (others=>'0');

		case seg_input is
			
			when "000" =>
				bufferOut(0):= '1';
				bufferOut(1):= '1';
				bufferOut(2):= '1';
				bufferOut(3):= '1';
				bufferOut(4):= '1';
				bufferOut(5):= '1';
			
			when "001" =>
				bufferOut(1):= '1';
				bufferOut(2):= '1';
			
			when "010" =>
				bufferOut(0):= '1';
				bufferOut(1):= '1';
				bufferOut(3):= '1';
				bufferOut(4):= '1';
				bufferOut(6):= '1';

			when "011" =>		
				bufferOut(0):= '1';
				bufferOut(1):= '1';
				bufferOut(2):= '1';
				bufferOut(3):= '1';
				bufferOut(6):= '1';
				
			when "100" =>
				bufferOut(1):= '1';
				bufferOut(2):= '1';
				bufferOut(5):= '1';
				bufferOut(6):= '1';
			
			when "101" =>
				bufferOut(0):= '1';
				bufferOut(2):= '1';
				bufferOut(3):= '1';
				bufferOut(5):= '1';
				bufferOut(6):= '1';

			when "110" =>
				bufferOut(0):= '1';
				bufferOut(1):= '1';
				bufferOut(2):= '1';
				bufferOut(3):= '1';
				bufferOut(4):= '1';
				bufferOut(6):= '1';
				
			when "111" =>
				bufferOut(0):= '1';
				bufferOut(1):= '1';
				bufferOut(2):= '1';

		end case;
		
		if segType = 0 then
			
			seg_a <= std_logic(bufferOut(0));
			seg_b <= std_logic(bufferOut(1));
			seg_c <= std_logic(bufferOut(2));
			seg_d <= std_logic(bufferOut(3));
			seg_e <= std_logic(bufferOut(4));
			seg_f <= std_logic(bufferOut(5));
			seg_g <= std_logic(bufferOut(6));
		else			
			seg_a <= not std_logic(bufferOut(0));
			seg_b <= not std_logic(bufferOut(1));
			seg_c <= not std_logic(bufferOut(2));
			seg_d <= not std_logic(bufferOut(3));
			seg_e <= not std_logic(bufferOut(4));
			seg_f <= not std_logic(bufferOut(5));
			seg_g <= not std_logic(bufferOut(6));
			
		end if;
		
	end process;
end architecture control;