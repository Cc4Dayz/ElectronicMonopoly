--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


package avner is






type state_type is (init,stop_switch_red, buy_red, --sof_red, 
										stop_switch_green, buy_green, --sof_green ,
										stop_switch_blue, buy_blue, --sof_blue, 
										stop_switch_yellow, buy_yellow, --sof_yellow,
										wait_for_red, wait_for_green, wait_for_blue, wait_for_yellow,
										moving_red_state, moving_green_state, moving_blue_state, moving_yellow_state,
										waiting_for_red_decision
										);

  type owner	is (red,green,blue,yellow,basket,nfs);	-- nfs - not for sale
  subtype color is owner range red to yellow ;

--type <type_name> is array integer range <lower_limit> to <upper_limit>;
--TYPE std_logic_vector IS ARRAY ( NATURAL RANGE <>) OF std_logic;

type	address_array		is array (red to yellow) of integer range 0 to 28;
type  address_led_array	is array (red to yellow) of std_logic_vector(4 downto 0);
type 	katod_num_out_array 	is array (red to yellow) of std_logic_vector(7 downto 0);
type	buy_array			is array (red to yellow) of std_logic;
type	color_order 		is array (0 to 3) of color;
type	cube_result_array	is array (red to yellow) of integer range 0 to 8;
type	display 				is (init);
type	anod_num_out_array	is array (red to yellow) of std_logic_vector(3 downto 0);
type	led_color_array	is array (color) of std_logic;
type	money_array			is array (red to yellow) of integer range 0 to 20000;
type  number_anode_array is array (red to yellow) of integer range 0 to 7;
type	number_character is array (1 to 4) of character ;
type  number_katode_array is array (red to yellow) of integer range 0 to 3;
type	owner_array			is array (0 to 28) of owner;
type	penalty_array		is array (0 to 28) of integer range 0 to 200;
type	player_order_array	is array (0 to 3) of color;
type	players_array		is array (red to yellow) of std_logic;
type	price_array			is array (0 to 28) of integer range 0 to 400;
type	prison_array		is array	(red to yellow) of integer range 0 to 2;
type	result		  		is array (0 to 3) of integer range 0 to 8;
type	sof_array			is array (red to yellow) of std_logic;
type	stop_switch_array	is array (red to yellow) of std_logic;
type	train_array			is array (red to yellow) of integer range 0 to 4;







constant price 	: price_array 		:= (0,60,0,0,200,100,120,0,0,140,240,160,200,180,200,0,220,0,200,260,260,280,0,300,320,200,0,0,400);
constant penalty 	: penalty_array 	:= (0,40,0,200,25,60,80,0,100,10,200,12,25,14,16,0,18,0,25,22,22,24,0,26,28,25,0,100,50);






--    record
--        <type_name>        : std_logic_vector( 7 downto 0);
--        color        : std_logic;
--    end record;

function to_std_logic_vector( s : string ) return std_logic_vector; 


end avner;


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


package body avner is


function to_std_logic_vector( s : string )
	return std_logic_vector 
	is
		variable r : std_logic_vector( s'length * 8 - 1 downto 0) ;
	begin
		for i in 1 to s'high loop
			r(i * 8 - 1 downto (i - 1) * 8) := std_logic_vector( conv_unsigned( character'pos(s(i)) , 8 ) ) ;
		end loop ;
		return r ;
	end;	




----------------------------------------------------------------
-- random generator

--procedure rand_int( variable seed1, seed2 : inout positive; 
--                           min, max : in integer; 
--                           result : out integer) is
--    variable rand      : real;
--    variable val_range : real;
--  begin
--    assert (max >= min) report "Rand_int: Range Error" severity Failure;
--    
--    uniform(seed1, seed2, rand);
--    val_range := real(Max - Min + 1);
--    result := integer( trunc(rand * val_range )) + min;
--  end procedure;
  
 ---------------------------------------------------------------------
-- How to use it ?

--process
--  variable seed1, seed2 : positive := 1587437; --any number will do. Different seed value changes the sequence.
--  variable input_int    : integer;
--begin  
--  wait until rising_edge(clk);
--  
--  rand_int(seed1, seed2,  0, 255, input_int);
--  
--  input_slv <= std_logic_vector( to_unsigned( input_int, 8));
--end process; 
  



	end avner;
	









