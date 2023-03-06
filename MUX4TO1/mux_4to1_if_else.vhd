LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_4to1_if_else IS
	PORT(
		x0, x1, x2, x3 : IN 	STD_LOGIC;
		sel 				: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		y 					: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF mux_4to1_if_else IS
BEGIN
	if (sel = "11") then
		y <= x3;
	elsif (sel = "10") then
		y <= x2;
	elsif (sel = "01") then
		y <= x1;
	else
		y <= x0;
	end if;
END ARCHITECTURE;