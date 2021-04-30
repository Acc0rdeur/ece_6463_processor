library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCBranch is
	port (
		SignImm_shifted, PCPlus4_out: in std_logic_vector(31 downto 0);
		PCBranch_out: out std_logic_vector(31 downto 0));
end PCBranch;

architecture behavioral of PCBranch is
	begin
		main: process(SignImm_shifted, PCPlus4_out)
		begin
			PCBranch_out <= SignImm_shifted + PCPlus4_out;
		end process;
end behavioral;