----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:24:55 11/07/2015 
-- Design Name: 
-- Module Name:    clocks - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clocks is
    Port ( clk_50M 		: in  STD_LOGIC;
           clk_1msec 	: out  STD_LOGIC;
           clk_10msec 	: out  STD_LOGIC;
           clk_1sec 		: out  STD_LOGIC);
end clocks;

architecture Behavioral of clocks is

signal clk_1msec_sig 	: std_logic := '0';
signal clk_10msec_sig : std_logic := '0';
signal clk_1sec_sig 	: std_logic := '0';

begin

process(clk_50M)

variable counter: integer range 0 to 50000000 := 0;
begin
	if (clk_50M'event and clk_50M='0') then
		

--		if counter = 49999999 then
		if counter = 49999 then		--for test
			clk_1sec_sig <= not clk_1sec_sig;
			counter := 0;
		else
			counter := counter + 1;
		end if;


--		if counter mod 500000 = 0 then
		if counter mod 500 = 0 then		--for test
			clk_10msec_sig <= not clk_10msec_sig;
		end if;


--		if counter mod (50000) = 0 then
		if counter mod (50) = 0 then		--for test
			clk_1msec_sig <= not clk_1msec_sig;
		end if;
		
	end if;


end process;

clk_1sec <= clk_1sec_sig;
clk_10msec <= clk_10msec_sig;
clk_1msec <= clk_1msec_sig;




end Behavioral;

