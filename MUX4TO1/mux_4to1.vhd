LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_4to1 IS
	PORT(
		x0, x1, x2, x3 : IN 	STD_LOGIC;
		sel 				: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		y 					: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF mux_4to1 IS
BEGIN
	with sel select
		y <= 	x3 WHEN "11",
				x2 WHEN "10",
				x1 WHEN "01",
				x0 WHEN others;
END ARCHITECTURE;