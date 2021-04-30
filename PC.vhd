----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2020 10:16:25 PM
-- Design Name: 
-- Module Name: PC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
  Port ( 
  clk,reset: in std_logic;
  pc_in : in std_logic_vector(31 downto 0);
  ishalt : in std_logic;
  pc_out : out std_logic_vector(31 downto 0)
 
  );
end PC;

architecture Behavioral of PC is
signal pctemp:std_logic_vector(31 downto 0);
signal jumpbranch_temp:std_logic;
begin

process(clk,reset)
begin 
 if(reset='1') then
  pc_out <= x"00000000";
 elsif(rising_edge(clk)) then
  if (ishalt='0') then
    pc_out <= pc_in;
  elsif (ishalt='1') then
    pc_out <= std_logic_vector(unsigned(pc_in) - to_unsigned(4,32));
 end if;
 end if;
end process;

end Behavioral;