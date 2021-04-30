library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCPlus4 is
	port (
		PCPlus4_in: in std_logic_vector(31 downto 0);
		PCPlus4_out: out std_logic_vector(31 downto 0));
end PCPlus4;

architecture behavioral of PCPlus4 is
	begin
		PCPlus4_out <= PCPlus4_in + x"00000004";
end behavioral;