/*library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity UpCounter is
   port (clk, rst: in std_logic;
         cnt: in std_logic;
         C: out std_logic_vector(3 downto 0);
         tc: out std_logic);
end UpCounter;

architecture Structure of UpCounter is
   component Reg4
      port (clk, rst: in std_logic;
            ld: in std_logic;            
            I: in std_logic_vector(3 downto 0);
            Q: out std_logic_vector(3 downto 0));
   end component;

   component Inc4
      port (a: in std_logic_vector(3 downto 0);
            s: out signed(3 downto 0));
   end component;

   component AND4
      port (x, y, z : in std_logic;
            F: out std_logic);
   end component;

   signal tempC: std_logic_vector(3 downto 0);
   signal incC: std_logic_vector(3 downto 0);
   constant CLK_PERIOD : time := 5 ns;

begin

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

Reg4_1: Reg4 port map(tb_clk, tb_rst, tb_cnt, incC, tempC);
Inc4_1: Inc4 port map(tempC, incC);
AND4_1: AND4 port map(tempC(2), tempC(1), tempC(0), tb_tc);

   process(tempC)
   begin
      C <= tempC;
   end process;
end Structure;*/