----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:54:20 01/17/2016 
-- Design Name: 
-- Module Name:    monopol_sm - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity monopol_sm is
    Port ( 
		reset 			: in  STD_LOGIC;
		clk	   		: in std_logic;
		move	   		: in std_logic;
   	stop_switch		: in stop_switch_array;
		sof				: in sof_array;
      buy	 			: in  buy_array;
		owner_status 	: in owner_array  ;
      last_address 	: in  address_array;
		player			: in color;
--		cube_1			: out  integer range 1 to 4;
--		cube_2			: out  integer range 1 to 4;
     anod_num_out		: out anod_num_out_array;
       katod_num_out	: out katod_num_out_array;
--		address_led		: out	address_led_array;
				state		: out	state_type;
		led_color		: out	led_color_array
	 );
end monopol_sm;

architecture Behavioral of monopol_sm is
	signal next_state:state_type;
	signal present_state:state_type;
begin

process(reset,next_state,stop_switch, buy, sof, move)
begin

if (reset = '0') then
	next_state <= wait_for_red;
else	
		
	case next_state is
	
		when	init =>
			if (stop_switch(player)='0') then
				next_state <= stop_switch_red;
			else
				next_state <= init;
			end if;
	
	
	
	
	
		
--		when	init =>
--			if (stop_switch(red)='0') then
--				next_state <= stop_switch_red;
--			else
--				next_state <= init;
--			end if;
			
		when	stop_switch_red =>
			if (move = '1') then
				next_state <= moving_red_state;
			else
				next_state <= stop_switch_red;
			end if;	
				
		when	moving_red_state =>
			if (move = '0') then
				next_state <= waiting_for_red_decision;
			else
					next_state <= moving_red_state;
			end if;
				
		when	waiting_for_red_decision =>
			if (owner_status(last_address(player))=basket) then
				if (buy(player)='0') then
					next_state <= buy_red;
				end if;	
			elsif (sof(player)='0') then
					next_state <= wait_for_red;
			else
					next_state <= waiting_for_red_decision;
			end if;
			
		when	buy_red =>
			if (sof(player)='0') then
				next_state <= wait_for_red;
			else
				next_state <= buy_red;
			end if;



		when	wait_for_green =>
			if (stop_switch(green)='0') then
				next_state <= stop_switch_green;
			else
				next_state <= wait_for_green;
			end if;
			
		when	stop_switch_green =>
			if (move = '1') then
				next_state <= moving_green_state;
			else
				next_state <= stop_switch_red;
			end if;	
				
		when	moving_green_state =>
			if (move = '0') then
				if (buy(green)='0') then
					next_state <= buy_green;
				elsif (sof(red)='0') then
					next_state <= wait_for_blue;
				else
					next_state <= moving_green_state;
				end if;
			end if;
			
		when	buy_green =>
			if (sof(green)='0') then
				next_state <= wait_for_blue;
			else
				next_state <= buy_green;
			end if;


		when	wait_for_blue =>
			if (stop_switch(blue)='0') then
				next_state <= stop_switch_blue;
			else
				next_state <= wait_for_blue;
			end if;

		when	stop_switch_blue =>
			if (move = '1') then
				next_state <= moving_blue_state;
			else
				next_state <= stop_switch_blue;
			end if;	
				
		when	moving_blue_state =>
			if (move = '0') then
				if (buy(blue)='0') then
					next_state <= buy_blue;
				elsif (sof(red)='0') then
					next_state <= wait_for_blue;
				else
					next_state <= moving_blue_state;
				end if;
			end if;
			
		when	buy_blue =>
			if (sof(blue)='0') then
				next_state <= wait_for_yellow;
			else
				next_state <= buy_blue;
			end if;


		when	wait_for_yellow =>
			if (stop_switch(yellow)='0') then
				next_state <= stop_switch_yellow;
			else
				next_state <= wait_for_yellow;
			end if;

		when	stop_switch_yellow =>
			if (move = '1') then
				next_state <= moving_yellow_state;
			else
				next_state <= stop_switch_yellow;
			end if;	
				
		when	moving_yellow_state =>
			if (move = '0') then
				if (buy(yellow)='0') then
					next_state <= buy_yellow;
				elsif (sof(yellow)='0') then
					next_state <= wait_for_red;
				else
					next_state <= moving_yellow_state;
				end if;
			end if;
			
		when	buy_yellow =>
			if (sof(yellow)='0') then
				next_state <= wait_for_red;
			else
				next_state <= buy_yellow;
			end if;

		when	wait_for_red =>
			if (stop_switch(player)='0') then
				next_state <= stop_switch_red;
			else
				next_state <= wait_for_red;
			end if;
	
	end case;
end if;	
end process;	

process(clk,next_state)
begin
if (clk'event and clk='0') then
	state <= next_state;
end if;
end process;
end Behavioral;

