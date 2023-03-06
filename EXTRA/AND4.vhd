library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY AND4 is
      port (a, b, c: in std_logic;
            F: out std_logic);
end ENTITY;

architecture Behavior of AND4 is
      begin
         process(a,b,c) begin
            F <= c='1' and (a='1' or b='1');
         end process;
end Behavior;
            