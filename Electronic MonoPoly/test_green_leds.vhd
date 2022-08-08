library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_green_leds is
	port (

	katode_led_green_leds 	:out std_logic_vector(7 downto 0);
	anod_led_green_leds		:out std_logic_vector(3 downto 0)
	);
	
end;

architecture rtl of test_green_leds is
begin
 
	katode_led_green_leds	<=	"11111101";
	anod_led_green_leds		<=	"0010";
 
 
 end;