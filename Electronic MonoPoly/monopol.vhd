----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:48 11/19/2015 
-- Design Name: 
-- Module Name:    monopol - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use work.avner.all;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity monopol is
    Port ( 
		reset 			: in  STD_LOGIC;
		clk	   		: in std_logic;
   	stop_switch		: in stop_switch_array:=('1','1','1','1');
		sof				: in sof_array:=('1','1','1','1');
      buy	 			: in  buy_array:=('1','1','1','1');
--		cube_1			: out  integer range 1 to 4;
--		cube_2			: out  integer range 1 to 4;
     anod_num_out		: out anod_num_out_array;
       katod_num_out	: out katod_num_out_array;

--		address_led		: out	address_led_array;
		led_color		: out	led_color_array
	 );
end monopol;

architecture Behavioral of monopol is

component clocks 
    Port ( 
				clk_50M 		: in  STD_LOGIC;
           clk_1msec 	: out  STD_LOGIC;
           clk_10msec 	: out  STD_LOGIC;
           clk_1sec 		: out  STD_LOGIC
			  );
end component;




	component cube_3 
		port
	(
		clk	   	: in std_logic;
		reset			: in std_logic;
			state		: in	state_type;
		players		: in players_array;
   	stop_switch	: in stop_switch_array;
   	player_order: in player_order_array;
		sof			: in sof_array;
		player		: out color;
		cube_1		: out  integer range 1 to 4;
		cube_2		: out  integer range 1 to 4
		
	);

end component;


component status 
    Port ( 
			  reset 				: in  STD_LOGIC;
			  sof					: in sof_array;
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
end component;


component pay is
    Port ( 
           clk_1msec		: in  STD_LOGIC;
				state			: in	state_type;
           reset 			: in  STD_LOGIC;
           move 			: in  STD_LOGIC;
           player 		: in  color;
				stop_switch : in stop_switch_array;
           buy	 			: in  buy_array;
           sof 			: in  sof_array;
			  init_address	: in  address_array;
           last_address : in  address_array;
           money 			: out money_array;
           players 		: out players_array;
   		  owner_status : out owner_array  
			  );
end component;


component led_display is
    Port ( 	
				address_led		: in	address_led_array;
				led_color		: in	led_color_array;
           anod_num_out		: out anod_num_out_array;
           katod_num_out	: out katod_num_out_array
				);
end component;


component monopol_sm is
    Port ( 
		reset 			: in  STD_LOGIC;
		clk	   		: in std_logic;
         move 			: in  STD_LOGIC;
   	stop_switch		: in stop_switch_array;
		sof				: in sof_array;
      buy	 			: in  buy_array;
		owner_status 	: in owner_array  ;
      last_address 	: in  address_array;
		player			: in color;
--		cube_1			: out  integer range 1 to 4;
--		cube_2			: out  integer range 1 to 4;
--     anod_num_out		: out anod_num_out_array;
--       katod_num_out	: out katod_num_out_array;
--		address_led		: out	address_led_array;
				state		: out	state_type
--		led_color		: out	led_color_array
	 );
end component;


component write_display_1 is
    Port ( 
--				data 		: in  string(1 to 16);
           reset 		: in  STD_LOGIC;
           clk 		: in  STD_LOGIC;
           r_s 		: out  STD_LOGIC;
           r_w 		: out  STD_LOGIC;
           e 			: out  STD_LOGIC;
           db7_db0 	: out  STD_LOGIC_VECTOR (7 downto 0);
			  to_write 	: in 	 display
			  );
end component;


component data_to_display is
    Port ( 
				state 		: in  state_type;
           cube_1 		: in  integer range 1 to 4;
           cube_2 		: in  integer range 1 to 4;
           player			: in  color;
           to_display 	: out  string(1 to 16)
			  );
end component;






   signal player 		: color := red;
   signal clk_1msec 	: std_logic;
   signal clk_10msec : std_logic := '0';
   signal clk_1sec 	: std_logic := '0';

   signal cube_1_sig : integer range 1 to 4 := 1;
   signal cube_2_sig : integer range 1 to 4 := 1;
   signal move		 	: std_logic := '0';

	signal players		: players_array;
	signal player_order	:  player_order_array:=(red,green,blue,yellow);
	signal owner_status 	:  owner_array  ;
   signal money 			:  money_array;
   signal last_address 	:   address_array;
	signal address_led	:	address_led_array;
	signal init_address	: address_array;

	signal data 	:  string(1 to 16);
   signal r_s 		:   STD_LOGIC;
   signal r_w 		:   STD_LOGIC;
   signal e 		:   STD_LOGIC;
   signal db7_db0 :   STD_LOGIC_VECTOR (7 downto 0);
	signal to_write :  display;

	signal state	: 	state_type;
	signal cube_1	: 	integer range 1 to 4;
	signal cube_2	: 	integer range 1 to 4;
   signal to_display 	:   string(1 to 16);






















begin


   uut_1: clocks PORT MAP 
		(
          clk_50M 	=> clk,
          clk_1msec 	=> clk_1msec,
          clk_10msec => clk_10msec,
          clk_1sec 	=> clk_1sec
        );



   uut_2: cube_3 PORT MAP 
	(     
	clk	   		=>		clk_1msec,	   	
   reset				=>   reset,			
	state				=>		state,
   player			=>   player,		
   players			=>   players,		
   stop_switch		=>   stop_switch,	
   player_order 	=>  player_order,
   sof			 	=>  sof,			
   cube_1		 	=>  cube_1_sig,		
   cube_2		 	=>  cube_2_sig		
	);





   uut_3: status PORT MAP 
			(
			reset			=>	reset, 				 				
			move			=>	move,
         sof			=>	sof,						
         player 		=>	player, 			
         clk_10msec	=>	clk_10msec,		
         clk_1sec		=>	clk_1sec,			
         stop_switch	=>	stop_switch,		
         cube_1 		=>	cube_1_sig, 			
         cube_2 		=>	cube_2_sig, 			
			address_led	=> address_led,		
			init_address => init_address,
			last_address => last_address,
         led_color	=>	led_color				
        );


   uut_4: pay PORT MAP 
			(
			clk_1msec		=>		clk_1msec,
			state				=>		state,
			owner_status	=>	  owner_status,
			player 		   =>   player, 		
			players 		   =>   players, 		
			stop_switch		=>	  stop_switch,
			buy	 			=>   buy,	 			
			sof 			   =>   sof, 			
			money 			=>   money, 			
			reset 			=>   reset, 			
			move				=>		move,
			init_address	=>		init_address,
			last_address   =>   last_address
			);
			


   uut_5: led_display PORT MAP 
			(
			address_led		=>		address_led,		
         led_color	   =>    ('1','1','1','1'),	 
         anod_num_out	=>    anod_num_out,
         katod_num_out  =>    katod_num_out
			);
			
			
	uut_6:	monopol_sm Port map
		( 
		reset 			=>	 	reset, 			
		clk	   		=>		clk,	   		
		move				=>		move,
   	stop_switch		=>	 	stop_switch,		
		sof				=>		sof,				
      buy	 			=>	 	buy,	 			
		owner_status 	=>		owner_status,
		last_address	=>		last_address,
		player			=>		player,
--		cube_1			=>		cube_1,			
--		cube_2			=>	 	cube_2,			
--     anod_num_out		=>		nod_num_out,		
--       katod_num_out	=>	 	katod_num_out,	
--		address_led		=>		address_led,		
				state		=>	 	state		
--		led_color		=>		led_color		
	 );


uut_7: write_display_1 Port map
		( 
--				data 		=>			data, 	
           reset 		=>      reset, 	
           clk 		=>      clk, 	
           r_s 		=>      r_s, 	
           r_w 		=>      r_w, 	
           e 			=>      e, 		
           db7_db0 	=>      db7_db0, 
			  to_write 	=>      to_write
			  );


uut_8: data_to_display Port map
		( 
				state 		=>		state, 	
           cube_1 		=>   cube_1_sig, 	
           cube_2 		=>	  cube_2_sig, 			
           player			=>   player, 		
           to_display 	=>   to_display
			  );


end Behavioral;
