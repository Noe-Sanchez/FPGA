/*library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_vga_square is
end entity;
    
architecture behaviour of tb_vga_square is
COMPONENT vga_square IS
	GENERIC (
		Ha: INTEGER := 96; --Hpulse
		Hb: INTEGER := 144; --Hpulse+HBP
		Hc: INTEGER := 784; --Hpulse+HBP+Hactive
		Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
		Va: INTEGER := 2; --Vpulse
		Vb: INTEGER := 35; --Vpulse+VBP
		Vc: INTEGER := 515; --Vpulse+VBP+Vactive
		Vd: INTEGER := 525; --Vpulse+VBP+Vactive+VFP
		P_time: INTEGER := 1; --Vpulse+VBP+Vactive+VFP

		rest_time: INTEGER := 750000000;
		--rest_time: INTEGER := 10;

		Hc_div2: INTEGER := 320; 
		Vc_div2: INTEGER := 240; 

		dx: INTEGER := 50;
		dy: INTEGER := 50; 

		x: INTEGER := 320; 
		y: INTEGER := 240; 

		w_div2: INTEGER := 30; 
		h_div2: INTEGER := 30; 

		w_div4: INTEGER := 10; 
		h_div4: INTEGER := 10); 
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		red_switch, green_switch, blue_switch, s_en, up_sw, down_sw, right_sw, left_sw: IN STD_LOGIC;
		x_origin : out integer range 0 to 640:= x;
		y_origin : out integer range 0 to 480:= y;
		pixel_clk: BUFFER STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		nblanck, nsync : OUT STD_LOGIC);
END COMPONENT;
    



    signal tb_s_en  :   std_logic_vector(1 downto 0);
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


  
*/