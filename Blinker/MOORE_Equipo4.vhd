LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MOORE_Equipo4 IS
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		left_sw, right_sw, int_sw: IN STD_LOGIC;
		leds : out std_logic_vector(5 downto 0);
		other_leds : out std_logic_vector(3 downto 0));
	END MOORE_Equipo4;

ARCHITECTURE MOORE_Equipo4 OF MOORE_Equipo4 IS
signal state  :   std_logic_vector(2 downto 0) := "000";
signal led_clk : std_logic:= '0';
signal counter : integer range 0 to 50000000 := 0;

BEGIN

-- set the clk of the led to toggle every second

process(clk)
begin
	if rising_edge(clk) then
		counter <= counter + 2;
		if counter = 49999998 then
			led_clk <= not led_clk;
			counter <= 0;
		end if;
	end if;
end process;

PROCESS (led_clk)
BEGIN
	other_leds <= "0000";
	if rising_edge(led_clk) then
		if state = "000" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "001";
				leds <= "001000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "100";
				leds <= "000100";
			else
				state <= "000";
				leds <= "000000";
			end if;

		elsif state = "001" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "010";
				leds <= "011000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "100";
				leds <= "000100";
			else
				state <= "000";
				leds <= "000000";
			end if;
			
		elsif state = "010" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "011";
				leds <= "111000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "100";
				leds <= "000100";
			else
				state <= "000";
				leds <= "000000";
			end if;
			
		elsif state = "011" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "000";
				leds <= "000000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "100";
				leds <= "000100";
			else
				state <= "000";
				leds <= "000000";
			end if;

		elsif state = "100" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "001";
				leds <= "001000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "101";
				leds <= "000110";
			else
				state <= "000";
				leds <= "000000";
			end if;

		elsif state = "101" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "001";
				leds <= "001000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "110";
				leds <= "000111";
			else
				state <= "000";
				leds <= "000000";
			end if;

		elsif state = "110" then
			if int_sw='1' then 
				state <= "111";
				leds <= "111111";
			elsif left_sw='1' and right_sw='0' then
				state <= "001";
				leds <= "001000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "000";
				leds <= "000000";
			else
				state <= "000";
				leds <= "000000";
			end if;

		else
			if int_sw='1' then 
				state <= "000";
				leds <= "000000";
			elsif left_sw='1' and right_sw='0' then
				state <= "001";
				leds <= "001000";	
			elsif left_sw='0' and right_sw='1' then
				state <= "100";
				leds <= "000100";
			else
				state <= "000";
				leds <= "000000";
			end if;
		end if;
	end if;
END PROCESS;

END MOORE_Equipo4;