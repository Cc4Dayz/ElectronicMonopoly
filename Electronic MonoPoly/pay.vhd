----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:01 12/30/2015 
-- Design Name: 
-- Module Name:    pay - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
use work.avner.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pay is
    Port ( 
           clk_1msec		: in  STD_LOGIC;
				state			: in	state_type;
			  owner_status : out owner_array  ;
           player 		: in  color;
           players 		: out players_array;
           buy	 			: in  buy_array;
				stop_switch : in stop_switch_array;
           sof 			: in  sof_array;
           money 			: out money_array;
           reset 			: in  STD_LOGIC;
           move 			: in  STD_LOGIC;
			  init_address	: in address_array;
           last_address : in  address_array);
end pay;

architecture Behavioral of pay is

signal money_sig:money_array;
signal money_sig_1:money_array;



signal owner_status_sig:owner_array;
signal money_gl: integer range 0 to 4000:=0;
signal train	: train_array;
begin



--process(reset,player,last_address,buy,sof)
--process(reset,stop_switch,buy,sof,move)
process(reset,state)
begin
	if (reset = '0') then 
		players <= ('1','1','1','1');
--		money_gl <= 0;
		money_sig_1 <= (1500,1500,1500,1500);
		owner_status_sig <= (basket,others => basket);
		train <= (0, others => 0);
-------------------------------------------------------------------------

		elsif (state = waiting_for_red_decision and 
			  (last_address(player) = 0  or 
				last_address(player) = 2  or 
				last_address(player) = 3  or 
				last_address(player) = 7  or 
				last_address(player) = 8  or 
				last_address(player) = 17 or 
				last_address(player) = 22 or 
				last_address(player) = 26 or 
				last_address(player) = 27  )) then						--tax  not for sale
				money_sig_1(player) <= money_sig_1(player) - penalty(last_address(player)) + money_gl;

		elsif (owner_status_sig(last_address(player))= basket) then
			
			if ( state = buy_red and price(last_address(player)) /= 0) then		-- Buy Street
													
				if (money_sig_1(player)+ money_gl >= price(last_address(player))) then									-- The player has enough money to buy
					money_sig_1(player) <= money_sig_1(player) - price(last_address(player)) + money_gl;
					owner_status_sig(last_address(player)) <= player;
					
				if (last_address(player) = 4 	or 							--	Buy train station
					 last_address(player) = 12 or
					 last_address(player) = 18 or
					 last_address(player) = 25 ) then 
							
					train(player) <= train(player) + 1;
					
				end if;
				end if;
			end if;
---------------------------------------------------------------------------

		elsif (owner_status_sig(last_address(player)) /= player and owner_status_sig(last_address(player)) /= basket )  then	--Penalty

			if ( state = waiting_for_red_decision ) then			-- waiting for stop moving

				if (money_sig_1(player)+ money_gl >= penalty(last_address(player))) then		-- The player has enough money to pay the penalty

					if (last_address(player) = 4 or 	--	 train station panelty
						 last_address(player) = 12 or
						 last_address(player) = 18 or
						 last_address(player) = 25 ) then
						money_sig_1(player) <= money_sig_1(player) - (penalty(last_address(player)))*train(player) + money_gl;
						money_sig_1(owner_status_sig(last_address(player))) <= money_sig_1(owner_status_sig(last_address(player)))+ (penalty(init_address(player)))*train(player);

					else
						money_sig_1(player) <= money_sig_1(player) - penalty(last_address(player)) + money_gl;
						money_sig_1(owner_status_sig(last_address(player))) <= money_sig_1(owner_status_sig(last_address(player)))+ penalty(last_address(player));
					end if;

				else
					players(player) <= '0';			-- The player has not enough money to pay the penalty
					money_sig_1(player) <= 0;		-- The player lose
				

-- move the streets to basket

			end if;
		end if;		

		elsif (state = waiting_for_red_decision  )  then	
				money_sig_1(player) <= money_sig_1(player) + money_gl;



				
end if;


--		 else 

--			money_sig(player) <= money_sig(player) + money_gl;
--	end if;
--end if;
-----------------------------------------------------------------------------------		
--	elsif ( sof'event and sof(player) = '1' ) then
	
--end if;
end process;



process(reset,move)
begin

if (reset = '0') then
	money_sig <=	(1500, 1500, 1500, 1500);

	elsif ( clk_1msec = '0') then

--			money_sig_1(player) <= money_sig_1(player) + money_gl;
			money_sig(player) <= money_sig_1(player) + money_gl;



end if;

end process;




		
		
process(state)
begin
	if (reset = '0' ) then
		money_gl <= 0;
		
--	elsif (move'event and move = '0' ) then
		elsif  (last_address(player) = 0 and init_address(player) /= 0) then	-- Very good luck
			money_gl <= 400;		--Very Good Luck
		elsif  (init_address(player) > last_address(player)) then			-- Good Luck
			money_gl <= 200;		--Good Luck
		else
			money_gl <= 0;		
--		end if;	
--	else 
--		money_gl <= 0;			
	end if;
	
end process;



money 			<= money_sig_1;
owner_status 	<= owner_status_sig;

end Behavioral;

