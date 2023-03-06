LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY s_7_decoder_when_else IS
	PORT(
		x0, x1, x2, x3	: IN 	STD_LOGIC;
		y 				: OUT 	STD_LOGIC_VECTOR(0 TO 7));
END ENTITY;

-- 
ARCHITECTURE behavior OF s_7_decoder IS
	signal sel : STD_LOGIC_VECTOR(0 TO 3);

BEGIN
	sel(3) <= x3; sel(2) <= x2; sel(1) <= x1; sel(0) <= x0;
	
	y <=	"00000011" when sel = "0000" else 
			"10011111" when sel = "0001" else
			"00100101" when sel = "0010" else
			"00001101" when sel = "0011" else
			"10011001" when sel = "0100" else
			"01001001" when sel = "0101" else
			"01000001" when sel = "0110" else
			"00011111" when sel = "0111" else
			"00000001" when sel = "1000" else
			"00011001" when sel = "1001" else
			"00010001" when sel = "1010" else
			"11000001" when sel = "1011" else
			"01100011" when sel = "1100" else
			"10000101" when sel = "1101" else
			"01100001" when sel = "1110" else
			"01110001" when sel = "1111";
END ARCHITECTURE;