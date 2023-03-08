library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg4 is
   port(clk, rst: in std_logic;
        ld: in std_logic;
        I: in signed(3 downto 0);
        Q: out signed(3 downto 0));
end Reg4;

architecture Behavior of Reg4 is
begin
   process(clk) begin
      if (rising_edge(clk)) then
         if ld = '1' then
            Q <= I;
         end if;
      end if;
   end process;
end Behavior;
