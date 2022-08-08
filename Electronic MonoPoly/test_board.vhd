library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_board is
	port (
		a1  :in std_logic;
		b1 :out std_logic
		);
end;

architecture rtl of test_board is
begin
 b1 <= a1;
 
 end;