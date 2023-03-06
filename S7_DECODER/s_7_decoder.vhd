LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY s_7_decoder IS
	PORT(
		x0, x1, x2, x3	: IN 	STD_LOGIC;
		y 				: OUT 	STD_LOGIC_VECTOR(0 TO 7));
END ENTITY;

-- 
ARCHITECTURE behavior OF s_7_decoder IS
	signal sel : STD_LOGIC_VECTOR(0 TO 3);

BEGIN
	sel(3) <= x3; sel(2) <= x2; sel(1) <= x1; sel(0) <= x0;
	process(sel) begin
		case sel is
			when "0000" => y <= "00000011"; 
			when "0001" => y <= "10011111";
			when "0010" => y <= "00100101";
			when "0011" => y <= "00001101";
			when "0100" => y <= "10011001";
			when "0101" => y <= "01001001";
			when "0110" => y <= "01000001";
			when "0111" => y <= "00011111";			
			when "1000" => y <= "00000001";
			when "1001" => y <= "00011001";
			when "1010" => y <= "00010001";
			when "1011" => y <= "11000001";
			when "1100" => y <= "01100011";
			when "1101" => y <= "10000101";
			when "1110" => y <= "01100001";
			when "1111" => y <= "01110001";
			when others => y <= "00000000";
		end case;
	end process;
END ARCHITECTURE;