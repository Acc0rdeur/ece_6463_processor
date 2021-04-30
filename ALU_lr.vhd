library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_lr is
	port (
		source: in std_logic_vector(31 downto 0);
		amount: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0));
end ALU_lr;

architecture behavioral of ALU_lr is
	begin
		with amount(3 downto 0) select result <=
			source(30 downto 0) & source(31) when "0001",
			source(29 downto 0) & source(31 downto 30) when "0010",
			source(28 downto 0) & source(31 downto 29) when "0011",
			source(27 downto 0) & source(31 downto 28) when "0100",
			source(26 downto 0) & source(31 downto 27) when "0101",
			source(25 downto 0) & source(31 downto 26) when "0110",
			source(24 downto 0) & source(31 downto 25) when "0111",
			source(23 downto 0) & source(31 downto 24) when "1000",
			source(22 downto 0) & source(31 downto 23) when "1001",
			source(21 downto 0) & source(31 downto 22) when "1010",
			source(20 downto 0) & source(31 downto 21) when "1011",
			source(19 downto 0) & source(31 downto 20) when "1100",
			source(18 downto 0) & source(31 downto 19) when "1101",
			source(17 downto 0) & source(31 downto 18) when "1110",
			source(16 downto 0) & source(31 downto 17) when "1111",
			source when others;
end behavioral;