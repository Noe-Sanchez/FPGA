library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity UpCounter is
   port (clk, rst: in std_logic;
         cnt: in std_logic;
         C: out signed(3 downto 0);
         tc: out std_logic);
end UpCounter;

architecture Structure of UpCounter is
   component Reg4
      port (clk, rst: in std_logic;
            ld: in std_logic;            
            I: in signed(3 downto 0);
            Q: out signed(3 downto 0));
   end component;

   component Inc4
      port (a: in signed(3 downto 0);
            s: out signed(3 downto 0));
   end component;

   component AND_4
      port (a, b, c, d: in std_logic;
            F: out std_logic);
   end component;

   component baudrate_gen
	   port(clk, reset:	in 	std_logic;
		     tick: 		out 	std_logic);
   end component;

   signal tempC: signed(3 downto 0);
   signal incC: signed(3 downto 0);
   constant CLK_PERIOD : time := 5 ns;
   signal tb_clk, tb_rst, tb_cnt, tb_tc : std_logic := '0';

begin
/*
p_clk : process begin
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
*/
Reg4_1: Reg4 port map(clk, rst, cnt, incC, tempC);
Inc4_1: Inc4 port map(tempC, incC);
AND4_1: AND_4 port map(tempC(3), tempC(2), tempC(1), tempC(0), tc);

   process(tempC)
   begin
      C <= tempC;
   end process;
end Structure;