library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY AND_4 is
      port (a, b, c, d: in std_logic;
            F: out std_logic);
end ENTITY;

architecture Behavior of AND_4 is
      begin
         process(a,b,c,d) begin
            F <= (a and b) and (c and d);
         end process;
end Behavior;
            