library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity UART is
GENERIC (
   bd_r : integer := 50000000/115200; -- UART RFID's Baud Rate
   wait_time : integer := 49999999 -- A second with a 50 MHz clock
);
PORT(
    clk, reset: 	in 	std_logic;
    tx_start: 	in 	std_logic;
    d_in: 		in 	std_logic_vector(7 downto 0);
    tx_done_tick:	out	std_logic;
    tx: 		out 	std_logic);
END entity;

architecture Behavior of UART is
   signal s_tick:	std_logic;
   signal edit_enabled : std_logic:='1';
   type state_type is (S_IDLE, S_BUSY, S_STOP);
   signal state : state_type := S_IDLE;	
begin
   
   process(clk, reset) is
      variable counter : integer:= 0;
      variable edit_enabled_counter : integer:= 0;
   begin
      if reset = '1' then
         if rising_edge(clk) then
            counter := counter + 1;
            if counter = bd_r - 1 then
               s_tick <= '1';
               counter := 0;
            else
               s_tick <= '0';
            end if;

            if tx_done_tick = '1' then
               edit_enabled <= '0';
            end if;

            edit_enabled_counter := edit_enabled_counter + 1;
            if edit_enabled_counter = wait_time - 1 then
               edit_enabled <= '1';
               edit_enabled_counter := 0;
            end if;
         end if;
      else
         counter := 0;
         edit_enabled_counter := 0;
      end if;
   end process;
   
   dut : process(s_tick)
      variable counter : integer := 0;
      variable d_in_tmp : std_logic_vector(7 downto 0);
   begin
      if rising_edge(s_tick) then
         case(state) is
            --IDLE
            when S_IDLE =>
               tx_done_tick <= '0';
               if tx_start= '0' and edit_enabled = '1' then
                  tx <= '0';
                  state <= S_BUSY;
                  d_in_tmp := d_in;
                  counter := 0;
               else
                  tx <= '1';
               end if;

            --BUSY
            when S_BUSY =>
               tx <= d_in_tmp(0);
               d_in_tmp := '0' & d_in_tmp(7 downto 1);
               
               counter := counter + 1;
               if counter = 8 then
                  state <= S_STOP;
                  counter := 0;
                  tx_done_tick <= '1';
               end if;

            --STOP
            when S_STOP =>
               tx <= '1';
               state <= S_IDLE;

            -- OTHERS
            when others =>
               state <= S_IDLE; 
            end case;
         end if;
   end process;


end Behavior;