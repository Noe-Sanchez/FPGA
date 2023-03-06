LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY square_con IS
	PORT(
		clk				: 	IN 	STD_LOGIC;
		s3, s2, s1, s0 	:	IN 	STD_LOGIC;
		x	 			:	OUT integer RANGE 30 TO 610:= 320;
		y	 			:	OUT integer RANGE 30 TO 450:= 240
		);
END ENTITY;

ARCHITECTURE behavior OF square_con IS
	SIGNAL s : std_logic_vector(3 downto 0);
	SIGNAL count : integer RANGE 0 TO 10;
BEGIN
	s(3) <= s3; s(2) <= s2; s(1) <= s1; s(0) <= s0;
	process(clk) begin
			case s is
				when "1000" => x<=x-1;
				when "0001" => x<=x+1;
				when others => x<=x;
			end case;

			case s is
				when "0100" => y<=y-1;
				when "0010" => y<=y+1;
				when others => y<=y;
			end case;
		
	end process;
END ARCHITECTURE;