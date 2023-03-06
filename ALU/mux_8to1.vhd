LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_8to1 IS
	PORT(
		x7, x6, x5, x4, x3, x2, x1, x0	: IN 	STD_LOGIC;
		sel 							: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
		y 								: OUT	STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF mux_8to1 IS
BEGIN
	with sel select
		y <= 	x0 WHEN "111",
				x1 WHEN "110",
				x2 WHEN "101",
				x3 WHEN "100",
				x4 WHEN "011",
				x5 WHEN "010",
				x6 WHEN "001",
				x7 WHEN others;
END ARCHITECTURE;