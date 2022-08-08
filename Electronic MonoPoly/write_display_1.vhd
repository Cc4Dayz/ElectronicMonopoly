----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:50:25 11/19/2015 
-- Design Name: 
-- Module Name:    write_display - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.avner.all;




-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity write_display_1 is
    Port ( 
--				data 		: in  string(1 to 16);
           reset 		: in  STD_LOGIC;
           clk 		: in  STD_LOGIC;
           r_s 		: out  STD_LOGIC;
           r_w 		: out  STD_LOGIC;
           e 			: out  STD_LOGIC;
           db7_db0 	: out  STD_LOGIC_VECTOR (7 downto 0);
			  to_write 	: in display
			  );
end write_display_1;



architecture Behavioral of write_display_1 is

signal data	:	string(1 to 16) := ("    Monopol     ");	

signal count: integer range 0 to 3;
signal count_word: integer range 0 to 19;
signal data_in: STD_LOGIC_VECTOR (16*8-1 downto 0);	-- 16 characters

begin

data_in <= to_std_logic_vector(data);

process(reset,clk)

variable num_of_char : integer range 1 to 19:=19;

begin



if reset = '0' then
	r_s <= '1';
	r_w <= '1';
	e	<= '0';
	db7_db0	<= x"00";
	count_word <= 0;
	count <= 3;
elsif (clk'event and clk = '0') then

	count <= (count + 1) mod 4;
	if count = 3 then
		if count_word = num_of_char then
			count_word <= count_word;
		else 
			count_word <= (count_word +1);
		end if;
	end if;
end if;

				if (count_word =1 or count_word =2) then
					r_s <= '0';
				else 
					r_s <= '1';
				end if;





		case count is
			when 0  =>
					r_w <= '0';
					e <= '0';
					db7_db0 <= x"00";
			when 1 =>
--				r_s <= '1';
				r_w <= '0';
		CASE count_word IS
		
		
			WHEN 1 =>						-- Clear Display
				db7_db0 <= x"01";
				e <= '1';
			WHEN 2 =>						--Return Home
				db7_db0 <= x"02";
				e <= '1';
			WHEN 3 =>
				db7_db0 <= data_in(1*8-1 downto 0);
				e <= '1';
			WHEN 4 =>
				db7_db0 <= data_in(2*8-1 downto 1*8);
				e <= '1';
			WHEN 5 =>
				db7_db0 <= data_in(3*8-1 downto 2*8);
				e <= '1';
			WHEN 6 =>
				db7_db0 <= data_in(4*8-1 downto 3*8);
				e <= '1';
			WHEN 7 =>
				db7_db0 <= data_in(5*8-1 downto 4*8);
				e <= '1';
			WHEN 8 =>
				db7_db0 <= data_in(6*8-1 downto 5*8);
				e <= '1';
			WHEN 9 =>
				db7_db0 <= data_in(7*8-1 downto 6*8);
				e <= '1';
			WHEN 10 =>
				db7_db0 <= data_in(8*8-1 downto 7*8);
				e <= '1';
			WHEN 11 =>
				db7_db0 <= data_in(9*8-1 downto 8*8);
				e <= '1';
			WHEN 12 =>
				db7_db0 <= data_in(10*8-1 downto 9*8);
				e <= '1';
			WHEN 13 =>
				db7_db0 <= data_in(11*8-1 downto 10*8);
				e <= '1';
			WHEN 14 =>
				db7_db0 <= data_in(12*8-1 downto 11*8);
				e <= '1';
			WHEN 15 =>
				db7_db0 <= data_in(13*8-1 downto 12*8);
				e <= '1';
			WHEN 16 =>
				db7_db0 <= data_in(14*8-1 downto 13*8);
				e <= '1';
			WHEN 17 =>
				db7_db0 <= data_in(15*8-1 downto 14*8);
				e <= '1';
			WHEN 18 =>
				db7_db0 <= data_in(16*8-1 downto 15*8);
				e <= '1';
			WHEN others =>
				db7_db0 <= data_in(16*8-1 downto 15*8);
				e <= '0';
		END CASE;

			when 2 =>
--				r_s <= '0';
				r_w <= '0';
				e <= '0';


		
		
			when others =>
--				r_s <= '0';
				r_w <= '0';
				e <= '0';
				db7_db0 <= x"00";
	
	end case;
	
		
end process;		
		
		
end Behavioral;





-- 1 architecture beh of test is
-- 2 .......
-- 3 constant N : natural := 16;
-- 4 type tstring is array(natural range<>) of character;
-- 5 constant msje1 : tstring(0 to N-1) := "Vuelvo en 5 ... ";
-- 6 .......
-- 7 -- declaracion de la senal para asignar el Hex correspondiente
-- 8 signal byte_to_Tx: std_logic_vector(7 downto 0);
-- 9 
--10 -- declaracion de contador
--11 signal char_cont: natural range 0 to N-1;
--12 .......

