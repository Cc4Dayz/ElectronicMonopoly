----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:52:45 11/07/2015 
-- Design Name: 
-- Module Name:    status - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use work.avner.all;




-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity status is
    Port ( 
			reset 				: in  STD_LOGIC;
					sof			: in sof_array;
           player 			: in  color;
			  clk_10msec		: in 	STD_LOGIC;
			  clk_1sec			: in 	STD_LOGIC;
			  stop_switch		: in stop_switch_array;
           cube_1 			: in  integer range 1 to 4;
           cube_2 			: in  integer range 1 to 4;
			  move				: out 	STD_LOGIC;
			  address_led		: out	address_led_array;
			  init_address		: out address_array;
           last_address 	: out  address_array;
			  led_color			: out	led_color_array
			  );
end status;

architecture Behavioral of status is

signal 			address_led_sig 	: address_array;
signal 			init_address_sig 		: address_array;
signal 			last_address_sig 		: address_array;
signal           address	 		:  address_array;
signal			  move_sig			:	STD_LOGIC:='0';

begin

--init_address(player) <= address(player);
--last_address(player) <= (address(player) + cube_1 + cube_2)  mod 29;
					


--process(reset,clk_1sec, player, stop_switch, clk_10msec)
process(reset,clk_1sec)

begin

if reset = '0' then
	
	address	 <= (0, 0, 0, 0);
--	address	 <= (25, 25, 25, 25);
	move_sig <= '0';
	

	
	
		
--					if	(stop_switch'event and stop_switch(player) = '0') then

--					if	(clk_10msec'event and clk_10msec = '0') then


		elsif (clk_1sec'event and clk_1sec = '0') then


					if (stop_switch(player) = '0') then
							move_sig <= '1';
							last_address_sig(player) <= (init_address_sig(player) + cube_1 + cube_2)  mod 28;
					end if;
					

					if (address_led_sig(player)) = (init_address_sig(player) + cube_1 + cube_2)  mod 28 then
							move_sig <= '0';
							init_address_sig(player) <= last_address_sig(player);
					end if;
--						end if;
					
					if move_sig = '1' then
								
							if (address_led_sig(player) = (address(player) + cube_1 + cube_2)  mod 28) then
									address_led_sig(player) <= address_led_sig(player) ;
									address(player) <= address_led_sig(player);
							else 
								address_led_sig(player) <= (address_led_sig(player) + 1) mod 28;
							end if;
								
					end if;

--						end if;




	end if;

end process;


with player select
		led_color <= 	(clk_10msec,'1','1','1') when red,
							('1',clk_10msec,'1','1') when green,
							('1','1',clk_10msec,'1') when blue,
							('1','1','1',clk_10msec) when yellow;



--		led_color 	<= (clk_10msec, others => '1');


--process(reset,led_color)
--begin
--
--case	player is
--
--	when	red =>
--		led_color(red) 	<= clk_10msec;
--		led_color(green) 	<= '1';
--		led_color(blue) 	<= '1';
--		led_color(yellow) <= '1';
--
--	when others =>
--		led_color(red) 	<= '1';
--		led_color(green) 	<= '1';
--		led_color(blue) 	<= '1';
--		led_color(yellow) <= '1';
--
--end case;






	
--		if move_sig = '0' then

--	if (reset = '0') then
--			led_color			 <= ('1', '1', '1', '1');					
--			led_color(red) 	<= (clk_10msec);		
	

--			elsif (clk_10msec'event and clk_10msec='0') then

--				if (sof(player)='0') then
--						led_color(player) <= '0';
--				else
--	else
--			led_color			 <= ('1', '1', '1', '1');					
--			led_color(player) <= (clk_10msec);		
--	end if;
--			end if;
--		else
--			led_color			 <= ('1', '1', '1', '1');					
--			led_color(player) <= (clk_10msec);		
--			
--	end if;




	
--end process;	
	
address_led(red) <= std_logic_vector(to_unsigned(address_led_sig(red),5));
address_led(green) <= std_logic_vector(to_unsigned(address_led_sig(green),5));
address_led(blue) <= std_logic_vector(to_unsigned(address_led_sig(blue),5));
address_led(yellow) <= std_logic_vector(to_unsigned(address_led_sig(yellow),5));

move <= move_sig;
init_address <= init_address_sig;
last_address <= last_address_sig;


end Behavioral;

