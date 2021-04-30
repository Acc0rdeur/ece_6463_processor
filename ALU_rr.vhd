library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_rr is
	port (
		source: in std_logic_vector(31 downto 0);
		amount: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0));
end ALU_rr;

architecture behavioral of ALU_rr is
	begin
		with amount(3 downto 0) select result <=
			source(0) & source(31 downto 1) when "0001",
			source(1 downto 0) & source(31 downto 2) when "0010",
			source(2 downto 0) & source(31 downto 3) when "0011",
			source(3 downto 0) & source(31 downto 4) when "0100",
			source(4 downto 0) & source(31 downto 5) when "0101",
			source(5 downto 0) & source(31 downto 6) when "0110",
			source(6 downto 0) & source(31 downto 7) when "0111",
			source(7 downto 0) & source(31 downto 8) when "1000",
			source(8 downto 0) & source(31 downto 9) when "1001",
			source(9 downto 0) & source(31 downto 10) when "1010",
			source(10 downto 0) & source(31 downto 11) when "1011",
			source(11 downto 0) & source(31 downto 12) when "1100",
			source(12 downto 0) & source(31 downto 13) when "1101",
			source(13 downto 0) & source(31 downto 14) when "1110",
			source(14 downto 0) & source(31 downto 15) when "1111",
			source when others;
end behavioral;