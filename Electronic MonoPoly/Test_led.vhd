library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Test_Led is

    Port 
		(	clk_50M 		: in  STD_LOGIC;
			clk_1msec 		: out  STD_LOGIC;
			clk_10msec 		: out  STD_LOGIC;
			clk_1sec 		: out  STD_LOGIC;	
			anode1 	 :	out std_logic_vector (7 downto 0);
			katode1	 :	out std_logic_vector (3 downto 0)
		);
end;

architecture Test_Led_rtl of Test_Led is

signal clk_1msec_sig 	: std_logic := '0';
signal clk_10msec_sig : std_logic := '0';
signal clk_1sec_sig 	: std_logic := '0';

begin


process(clk_50M)

variable counter: integer range 0 to 50000000 := 0;
begin
	if (clk_50M'event and clk_50M='0') then
		

		if counter = 49999999 then
--		if counter = 49999 then		--for test
			clk_1sec_sig <= not clk_1sec_sig;
			counter := 0;
		else
			counter := counter + 1;
		end if;


		if counter mod 500000 = 0 then
--		if counter mod 500 = 0 then		--for test
			clk_10msec_sig <= not clk_10msec_sig;
		end if;


		if counter mod (50000) = 0 then
--		if counter mod (50) = 0 then		--for test
			clk_1msec_sig <= not clk_1msec_sig;
		end if;
		
	end if;


end process;

clk_1sec <= clk_1sec_sig;
clk_10msec <= clk_10msec_sig;
clk_1msec <= clk_1msec_sig;


	process (clk_1msec_sig)
	variable anoda 	: std_logic_vector (7 downto 0);
	variable katoda	: std_logic_vector (3 downto 0);
	variable i 		: integer range 0 to 29 := 0;
	begin
	
		if (clk_1msec_sig'event and clk_1msec_sig = '0' ) then
			for I in 0 to 29 loop


				case i is
					when  0 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11111110";
					when  1 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11111110";
					when  2 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11111110";
					when  3 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11111110";
					when  4 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11111101";
					when  5 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11111101";
					when  6 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11111101";
					when  7 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11111101";
					when  8 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11111011";
					when  9 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11111011";
					when  10 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11111011";
					when  11 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11111011";
					when  12 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11110111";
					when  13 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11110111";
					when  14 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11110111";
					when  15 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11110111";
					when  16 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11101111";
					when  17 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11101111";
					when  18 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11101111";
					when  19 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11101111";
					when  20 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "11011111";
					when  21 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "11011111";
					when  22 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "11011111";
					when  23 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "11011111";
					when  24 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "10111111";
					when  25 =>
								 anoda	:=	 "0010";
								 katoda	:=	 "10111111";
					when  26 =>
								 anoda	:=	 "0100";
								 katoda	:=	 "10111111";
					when  27 =>
								 anoda	:=	 "1000";
								 katoda	:=	 "10111111";
					when  28 =>
								 anoda	:=	 "0001";
								 katoda	:=	 "01111111";
								 
				end case;
			end loop;
		end if;
				anode1	<=	anoda;
				katode1	<=	katode;
					
	
end





