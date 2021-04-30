----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2020 10:29:10 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX5 is
 Port (
 Control_sgnl: in std_logic;
 Input_0: in std_logic_vector(4 downto 0);
 Input_1: in std_logic_vector(4 downto 0);
 Output: out  std_logic_vector(4 downto 0)
  );
end MUX5;

architecture Behavioral of MUX5 is

begin
Output <= Input_1 when Control_sgnl='1' else Input_0;

end Behavioral;
