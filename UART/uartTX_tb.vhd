library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity uartTX_tb is
end uartTX_tb;
 
architecture Behave of uartTX_tb is
   
	-- Test Bench uses a 50 MHz Clock
	constant c_CLK_PERIOD : time := 20 ns;
  
	-- Want to interface to 115200 baud UART
	-- 50000000 / 115200 = 434 Clocks Per Bit.
	constant c_CLKS_PER_BIT : integer := 434;
 
	constant c_BIT_PERIOD : time := 8680 ns;
   
	signal clk_tb     	: std_logic                 	:= '0';
	signal tx_start_tb     	: std_logic                   	:= '0';
	signal s_tick_tb	: std_logic			:= '0';
	signal d_in_tb   	: std_logic_vector(7 downto 0)	:= (others => '0');
	signal tx_done_tick_tb	: std_logic			:= '0';
	signal tx_tb 		: std_logic			:= '1';

	COMPONENT uart IS
	PORT(
		clk, reset: 	in 	std_logic;
		tx_start: 	in 	std_logic;
		s_tick: 	in	std_logic;
		d_in: 		in 	std_logic_vector(7 downto 0);
		tx_done_tick:	out	std_logic;
		tx: 		out 	std_logic
		);
	END COMPONENT;
   
begin
 
	clk_tb <= not clk_tb after c_CLK_PERIOD/2;

   	-- Instantiate UART transmitter
	DUT:	uart port map(clk_tb, '0', tx_start_tb, s_tick_tb, d_in_tb, tx_done_tick_tb, tx_tb);
   
	process is
	begin
  
		-- Tell the UART to send a command.  Exercise TX    
		wait until rising_edge(clk_tb);
		wait until rising_edge(clk_tb);
		tx_start_tb   <= '1';
		d_in_tb <= X"55"; 
	 	 
		wait until rising_edge(clk_tb);	
		tx_start_tb   <= '0';
	 
		data1:	for i in 0 to 9 loop
				wait for 8680 ns;
				s_tick_tb <= '1'; 
				wait until rising_edge(clk_tb);	
				s_tick_tb <= '0';
			end loop data1; 
	
		wait;
	 
	end process;
end Behave;