library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reto is
end entity;

architecture behavior of tb_reto is
	component reto is
        	port(
                	d_in                 : in     std_logic_vector(7 downto 0);
                	clk, reset, tx_start : in                        std_logic;
                	start_flag 	     : out                       std_logic;
               		tx_done_tick, tx     : buffer                    std_logic);
	end component;

	signal tb_reset              : 			   std_logic := '1';
	signal tb_start, tb_clk, tb_tx, tb_done_tick, tb_start_flag : 			   std_logic := '0';
	signal data                                    : std_logic_vector(7 downto 0) := "10010100";

	constant CLK_PERIOD : time := 20 ns;

	begin
		p_clk : process
    		begin
        		for i in 0 to 100000 loop
            			if tb_clk = '0' then
                			tb_clk <= '1';
            			else
                			tb_clk <= '0';
            			end if;
            			wait for 10 ns;
        		end loop;
        		wait;
    		end process;

		stimuli : process
		begin
			--wait for 0 ns;
			--	tb_reset <= '1';
			--wait for 20 ns;
			--	tb_reset <= '0';
			--wait for 8640 ns;
			wait for 17290 ns;
				tb_start <= '0';
			wait for 8630 ns;
				tb_start <= '1';
			wait for 300 us;
				tb_start <= '0';
			wait for 8640 ns;
				tb_start <= '1';
			wait;
		end process;

		dut : reto port map(data, tb_clk, tb_reset, tb_start, tb_start_flag, tb_done_tick, tb_tx);

end architecture;
