LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY switch_to_led_7_s IS
	PORT(
		SW		:	IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0	:	OUT	  STD_LOGIC_VECTOR(0 TO 7));
END switch_to_led_7_s;

ARCHITECTURE behavior OF switch_to_led_7_s IS

COMPONENT s_7_decoder IS
	PORT(
		x0, x1, x2, x3	: IN 	STD_LOGIC;
		y 				: OUT 	STD_LOGIC_VECTOR(0 TO 7));
END COMPONENT;

BEGIN
	S_7	:	s_7_decoder	PORT	MAP(
							SW(3),SW(2),SW(1),SW(0),HEX0(0 TO 7));
END behavior;