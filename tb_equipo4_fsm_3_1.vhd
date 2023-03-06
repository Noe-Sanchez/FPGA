library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_equipo4_fsm_3_1 is
end entity;
    
architecture behaviour of tb_equipo4_fsm_3_1 is
    component equipo4_fsm_3_1 
        port(
            clk, rst :   in      std_logic;
            ab       :   in      std_logic_vector(1 downto 0);
            z        :   out     std_logic
        );
    end component;
    signal tb_ab  :   std_logic_vector(1 downto 0);
    signal tb_clk, tb_z, tb_rst : std_logic;
    constant CLK_PERIOD : time := 20 ns;

begin

    dut : equipo4_fsm_3_1 port map(tb_clk, tb_rst, tb_ab, tb_z);

    p_clk : process
    begin
        tb_clk <= '0';
        for i in 0 to 18 loop
            if tb_clk = '0' then
                tb_clk <= '1';
            else
                tb_clk <= '0';
            end if;
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;
    
    stimuli : process
        begin
            tb_z <= '0';
            tb_rst <= '0';
            tb_ab <= "00";
            wait for CLK_PERIOD;
            --tb_rst <= '1';
            tb_ab <= "11"; 
            wait for CLK_PERIOD;
            --tb_rst <= '0';
            tb_ab <= "10";
            wait for CLK_PERIOD;
            tb_ab <= "11"; 
            wait for CLK_PERIOD;
            tb_ab <= "01";
            wait for CLK_PERIOD;
            tb_ab <= "01"; 
            wait for CLK_PERIOD;
            tb_ab <= "00";
            wait for CLK_PERIOD;
            tb_ab <= "01";
            wait for CLK_PERIOD;
            tb_ab <= "00";
            wait for CLK_PERIOD;
            tb_ab <= "11";
            assert true report "End of stimuli." severity note;
            wait;   
        end process;
end architecture;


  
