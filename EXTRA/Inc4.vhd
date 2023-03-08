library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Inc4 is
   port (a: in signed(3 downto 0);
         s: out signed(3 downto 0));
end Inc4;

architecture Behavior of Inc4 is
begin
   process(a) begin
      s <= a + 1;
   end process;
end Behavior;



