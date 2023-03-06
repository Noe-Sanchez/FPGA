LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;
USE	ieee.std_logic_signed.ALL;
USE	ieee.std_logic_textio.ALL;
USE	std.textio.ALL;

--Entity: no port list!
ENTITY  tb_s_7_decoder IS
END	tb_s_7_decoder;

--Architecture
ARCHITECTURE test_arch OF tb_s_7_decoder IS
	COMPONENT s_7_decoder
		PORT(
			x0, x1, x2, x3	: IN 	STD_LOGIC;
			y 				: OUT 	STD_LOGIC_VECTOR(0 TO 7));
	END COMPONENT;
	
SIGNAL	x0_tb, x1_tb, x2_tb, x3_tb, check_tb	:	STD_LOGIC;					--INPUT
SIGNAL	y_tb, y_d								:	STD_LOGIC_VECTOR(0 TO 7);	--OUTPUT

BEGIN
	--DUT Instantiation
	DUT		:	s_7_decoder PORT MAP( x0_tb, x1_tb, x2_tb, x3_tb, y_tb);
	
	--Stimulus by hand drawn waves, poor coverage
	stim_proc	:	PROCESS
			  		BEGIN
					WAIT FOR 0 ns;
						x0_tb <= '0'; x1_tb <= '0'; x2_tb <= '0'; x3_tb <= '0'; y_d <= "00000011";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '0'; x2_tb <= '0'; x3_tb <= '1'; y_d <= "10011111";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '0'; x2_tb <= '1'; x3_tb <= '0'; y_d <= "00100101";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '0'; x2_tb <= '1'; x3_tb <= '1'; y_d <= "00001101";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '0'; y_d <= "10011001";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; y_d <= "01001001";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '1'; x3_tb <= '0'; y_d <= "01000001";
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '1'; x3_tb <= '1'; y_d <= "00011111";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '0'; x2_tb <= '0'; x3_tb <= '0'; y_d <= "00000001";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '0'; x2_tb <= '0'; x3_tb <= '1'; y_d <= "00011001";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '0'; x2_tb <= '1'; x3_tb <= '0'; y_d <= "00010001";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '0'; x2_tb <= '1'; x3_tb <= '1'; y_d <= "11000001";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '0'; y_d <= "01100011";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; y_d <= "10000101";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '1'; x2_tb <= '1'; x3_tb <= '0'; y_d <= "01100001";
					WAIT FOR 10 ns;
						x0_tb <= '1'; x1_tb <= '1'; x2_tb <= '1'; x3_tb <= '1'; y_d <= "01110001";
					WAIT;
				END PROCESS;
				
				PROCESS(y_d, y_tb)
				BEGIN
					if y_d = y_tb then
						check_tb <= '1';
					else
						check_tb <= '0';
					end if;
				END PROCESS;
END ARCHITECTURE;