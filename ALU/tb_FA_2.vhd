LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;
USE	ieee.std_logic_signed.ALL;
USE	ieee.std_logic_textio.ALL;
USE	std.textio.ALL;

--Entity: no port list!
ENTITY  tb_FA_2 IS
END	tb_FA_2;

--Architecture
ARCHITECTURE test_arch OF tb_FA_2 IS
	COMPONENT FA_2 IS
	PORT(
		a, b 		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		cin 		: IN 	STD_LOGIC;
		s 			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		cout		: OUT	STD_LOGIC);
	END COMPONENT;
	
SIGNAL	a_tb, b_tb								:	STD_LOGIC_VECTOR(1 DOWNTO 0);			--INPUT
SIGNAL	cin_tb									:	STD_LOGIC;								--INPUT
SIGNAL	s_tb, s_d								:	STD_LOGIC_VECTOR(1 DOWNTO 0);			--OUTPUT
SIGNAL	cout_tb, cout_d, cout_check, s_check	:	STD_LOGIC;								--OUTPUT

BEGIN
	--DUT Instantiation
	DUT		:	FA_2 PORT MAP(a_tb, b_tb, cin_tb, s_tb, cout_tb);
	
	--Stimulus by hand drawn waves, poor coverage
	stim_proc	:	PROCESS
			  		BEGIN
					  WAIT FOR 0 ns;
					  a_tb <= "00"; b_tb <= "00"; cin_tb <= '0'; s_d <= "00"; cout_d <= '0';
					  WAIT FOR 10 ns;
					  a_tb <= "00"; b_tb <= "01"; cin_tb <= '0'; s_d <= "01"; cout_d <= '0';
					  WAIT FOR 10 ns;
					  a_tb <= "00"; b_tb <= "10"; cin_tb <= '0'; s_d <= "10"; cout_d <= '0';
					  WAIT FOR 10 ns;
					  a_tb <= "10"; b_tb <= "11"; cin_tb <= '1'; s_d <= "10"; cout_d <= '1';
					  WAIT FOR 10 ns;
					  a_tb <= "11"; b_tb <= "11"; cin_tb <= '1'; s_d <= "11"; cout_d <= '1';
					  WAIT FOR 10 ns;
					  a_tb <= "11"; b_tb <= "01"; cin_tb <= '1'; s_d <= "01"; cout_d <= '1';
					WAIT;
				END PROCESS;
	
	process(s_tb, cout_tb) begin
		if s_tb = s_d then
			s_check <= '1';
		else
			s_check <= '0';
		end if;

		if cout_tb = cout_d then
			cout_check <= '1';
		else
			cout_check <= '0';
		end if;
	end process;
END ARCHITECTURE;