LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY carry_ripple_4bit_adder IS
	PORT( a, b: 	IN		std_logic_vector(3 downto 0);
			c: 		IN 	std_logic;
			s: 		OUT 	std_logic_vector(3 downto 0);
			co:		OUT	std_logic
	);
END carry_ripple_4bit_adder;

ARCHITECTURE Behavior OF carry_ripple_4bit_adder IS

COMPONENT FullAdder IS
	PORT( a, b, ci: 	IN		std_logic;
			s, co:		OUT	std_logic
	);
END COMPONENT;

SIGNAL CO1 CO2, CO3: std_logic;

BEGIN
	PROCESS(a, b, ci) BEGIN
		
		FA0: FullAdder PORT MAP (a0, b0, ci, s(0), CO1);
		FA1: FullAdder PORT MAP (a1, b1, co1, s(0), CO2);
		FA2: FullAdder PORT MAP (a2, b2, co2, s(0), CO3);
		FA3: FullAdder PORT MAP (a3, b3, co3, s(0), co);
	
	END PROCESS;
END Behavior;