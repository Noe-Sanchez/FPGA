LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FA_2 IS
	PORT(
		a, b 		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		cin 		: IN 	STD_LOGIC;
		s 			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		cout		: OUT	STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF FA_2 IS

	COMPONENT FA_1 IS
	PORT(
		a, b, cin : IN 	STD_LOGIC;
		s, cout 	: OUT STD_LOGIC);
	END COMPONENT;

	signal s0 	: std_logic:='0';
	signal s1 	: std_logic:='0';
	signal cout0 	: std_logic:='0';
BEGIN
	sum_0	:	FA_1	PORT	MAP (a(0), b(0), cin, s(0), cout0);
	sum_1	:	FA_1	PORT	MAP (a(1), b(1), cout0, s(1), cout);
END ARCHITECTURE;