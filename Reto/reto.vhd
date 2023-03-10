library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reto is
        generic (
                baud_rate : integer := 50000000/115200; -- uart rfid's baud rate
                wait_time : integer :=        4999  -- a second with a 50 mhz clock
        );
        port(
                d_in                 : in  std_logic_vector(7 downto 0);
                clk, reset, tx_start : in                     std_logic;
                start_flag 	     : out                    std_logic;
                tx_done_tick, tx     : buffer                 std_logic);
end entity;

architecture behavior of reto is
	signal s_tick	    :                 std_logic := '0';
	signal edit_enabled :  		      std_logic := '1';
	type   state_type   is (s_idle, s_busy, s_stop);
	signal state 	    :      state_type := s_idle;
	begin

   	process(clk, reset) is
      		variable counter : integer := 0;
      		variable edit_enabled_counter : integer := 0;
   	begin
      		if reset = '1' then
         		if rising_edge(clk) then
        			counter := counter + 1;
            			if counter = baud_rate - 1 then
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
            			when s_idle =>
               				tx_done_tick <= '0';
					start_flag <= '0';
               				if tx_start= '0' and edit_enabled = '1' then
                  				tx <= '0';
                  				state <= s_busy;
                  				d_in_tmp := d_in;
                  				counter := 0;
						start_flag <= '1';
               				else
                  				tx <= '1';
               				end if;
            			when s_busy =>
					start_flag <= '0';
               				tx <= d_in_tmp(0);
               				d_in_tmp := '0' & d_in_tmp(7 downto 1);
               				counter := counter + 1;
               				if counter = 8 then
                  				state <= s_stop;
                  				counter := 0;
               				end if;
            			when s_stop =>
               				tx <= '1';
                  			tx_done_tick <= '1';
               				state <= s_idle;
            			when others =>
               				state <= s_idle;
            		end case;
         	end if;
   	end process;
end architecture;
