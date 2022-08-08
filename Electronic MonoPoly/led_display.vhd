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
USE ieee.numeric_std.ALL;

use work.avner.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_display is
    Port ( 	address_led		: in	address_led_array;
				  led_color		: in	led_color_array;
           anod_num_out		: out anod_num_out_array;
           katod_num_out	: out katod_num_out_array
				);
end led_display;

architecture Behavioral of led_display is



begin
process(address_led)


variable number_anode : number_anode_array;
variable number_katode : number_katode_array;


variable col: color;

begin


number_anode(col)  := to_integer(unsigned(address_led(col)(1 downto 0)));
number_katode(col) := to_integer(unsigned(address_led(col)(4 downto 2)));



for col in red to yellow loop
	katod_num_out(col) <= ("11111111");
	katod_num_out(col)(number_katode(col)) <= ('0');
	anod_num_out(col) <= ("0000");
	anod_num_out(col)(number_anode(col)) <= ('1');
end loop;





end process;
end Behavioral;



