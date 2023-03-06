LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;
USE	ieee.std_logic_signed.ALL;
USE	ieee.std_logic_textio.ALL;
USE	std.textio.ALL;

--Entity: no port list!
ENTITY  tb_ALU IS
END	tb_ALU;

--Architecture
ARCHITECTURE test_arch OF tb_ALU IS
	COMPONENT ALU IS
		PORT(
		a, b 		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		sel 		: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
		final_s 	: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;
	
SIGNAL	a_tb			:	STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";	--INPUT
SIGNAL	b_tb			:	STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";	--INPUT
SIGNAL	sel_tb			:	STD_LOGIC_VECTOR(2 DOWNTO 0):= "000";	--INPUT
SIGNAL	s_d				:	STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";	--OUTPUT
SIGNAL 	s_tb 			: 	STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";
SIGNAL	s_check 		: 	STD_LOGIC:= '0';						--OUTPUT
SIGNAL	cout_tb 		: 	STD_LOGIC:= '0';						--OUTPUT

BEGIN
	--DUT Instantiation
	DUT			:	ALU PORT MAP(a_tb, b_tb, sel_tb, s_tb);

	--Stimulus by hand drawn waves, poor coverage
	stim_proc	:	PROCESS
	BEGIN
		WAIT FOR 0 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "000"; s_d <= "11";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "001"; s_d <= "01";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "010"; s_d <= "11";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "011"; s_d <= "00";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "100"; s_d <= "00";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "101"; s_d <= "11";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "110"; s_d <= "11";
		WAIT FOR 10 ns;
		a_tb <= "10"; b_tb <= "01"; sel_tb <= "111"; s_d <= "01";
		WAIT FOR 10 ns;
		WAIT;
	END PROCESS;

	process(s_tb, s_d) begin
		if s_tb = s_d then
			s_check <= '1';
		else
			s_check <= '0';
		end if;
	end process;
END ARCHITECTURE;