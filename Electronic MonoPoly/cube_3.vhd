----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:34 12/31/2015 
-- Design Name: 
-- Module Name:    cube_1 - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.avner.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cube_3 is
	port 
	(
		clk	   	: in std_logic;
		reset			: in std_logic;
		state			: in	state_type;
		player		: out color;
		players		: in players_array;
   	stop_switch	: in stop_switch_array;
   	player_order: in player_order_array;
		sof			: in sof_array;
		cube_1		: out  integer range 1 to 4;
		cube_2		: out  integer range 1 to 4
		);

end entity;



architecture rtl of cube_3 is
signal result_1_sig: integer range 11 to 44;
signal player_sig: color := red;
signal cube_1_sig: integer range 1 to 4;
signal cube_2_sig: integer range 1 to 4;
signal done : std_logic := '0'; 
signal i: integer range 0 to 3 :=0;
--signal n: integer range 0 to 3 :=0;
signal cube_result:cube_result_array;

signal stp_switch : std_logic;
signal sf_switch : std_logic;


begin

process(clk)
begin
	
	if (clk'event and clk='0') then
		if reset = '0' then
				result_1_sig <= 11;
			elsif	(result_1_sig mod 5 = 4) then
					if result_1_sig = 44 then		
						result_1_sig <= 11;
					else result_1_sig <= result_1_sig + 7;
					end if;
					
			else
					result_1_sig <= result_1_sig + 1;		
		end if;
	end if;
end process;

stp_switch <= stop_switch(red) or stop_switch(green) or stop_switch(blue) or stop_switch(yellow);
sf_switch <= sof(red) or sof(green) or sof(blue) or sof(yellow);


------------------------------------------------------------------------------------
process(stop_switch)
begin

--if (reset = '0') then
--		player_sig <= player_order(0);
--		i <= 0;
--		done <='0';

--	elsif ( clk'event and clk='0') then
-----------------------------------------------------------------------

		if (stop_switch(player_sig) = '0' and state=wait_for_red ) then		--stop the cubes
			cube_1_sig <= result_1_sig mod 5;
			cube_2_sig <= result_1_sig / 10;
--			done <= '1';
end if;
end process;
------------------------------------------------------------------------	
process(clk,reset,player_sig, stop_switch, sof)
begin

if (reset = '0') then
		player_sig <= player_order(0);
		i <= 0;
		done <='0';

		elsif (sof(player_sig) = '0' and (state = waiting_for_red_decision or state = buy_red)) then		--הקוביות זהות
--				done <= '0';														--השחקן משחק פעם נוספת
			if cube_1_sig = cube_2_sig then
				player_sig <= player_order(i);
--
---------------------------------------------------------------------------				
--				
			else
				i <= (i+1)mod 4;
				player_sig <= player_order((i+1)mod 4);					-- התור עובר לשחקן הבא
				if (players(player_order((i+1)mod 4)) = '0') then		-- השחקן הבא אינו משתתף
					i <= (i+2)mod 4;
					player_sig <= player_order((i+2)mod 4);
				end if;
----------------------------------------------------------------------------				
			end if;
	
	
--end if;	
end if;
end process;

--player <= player_order(i);

player <= player_sig;
cube_1 <= cube_1_sig ;
cube_2 <= cube_2_sig ;


end rtl;


