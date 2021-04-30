----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2020 11:44:21 PM
-- Design Name: 
-- Module Name: SIGN_EXT - Behavioral
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

entity SIGN_EXT is
 Port (
  Sign_In        : in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
  Jump_sgnl     : in STD_LOGIC;
  Sign_Imm       : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
  Sign_Addr  : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
   );
end SIGN_EXT;

architecture Behavioral of SIGN_EXT is

signal Sign_Ext : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin
process (Sign_In,Jump_sgnl)
begin
if(Jump_sgnl='1') then
   Sign_Ext <= "000000" & Sign_In(25 downto 0); 
elsif (Jump_sgnl = '0') then 
        if (Sign_In(15) = '1') then
            Sign_Ext <= x"FFFF" & Sign_In(15 downto 0);
            end if;
        if (Sign_In(15) = '0') then
            Sign_Ext <= x"0000" & Sign_In(15 downto 0);           
            end if;    
end if;    
end process;

Sign_Imm <= Sign_Ext;
Sign_Addr <= Sign_Ext(29 downto 0) & "00";

end Behavioral;
