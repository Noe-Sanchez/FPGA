LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY switch_to_led IS
	PORT(
		SW		:	IN		STD_LOGIC_VECTOR( 9 DOWNTO 0);
		LEDR	:	OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0));
END switch_to_led;

ARCHITECTURE behavior OF switch_to_led IS

COMPONENT mux_4to1 IS
	PORT(
		x0, x1, x2, x3 : IN 	STD_LOGIC;
		sel 				: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		y 					: OUT STD_LOGIC);
END COMPONENT;

BEGIN
	
	LEDR(9 DOWNTO 1) <= (OTHERS => '0');
	mux	:	mux_4to1	PORT	MAP(
							SW(0),SW(1),SW(2),SW(3),SW(5 DOWNTO 4),LEDR(0));
END behavior;