----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2020 09:06:45 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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
use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

component Top is
port(
CLK, Rst: in std_logic);
end component;
signal t_clk, t_Rst: std_logic;
signal cycle_count : integer := 0;

begin 
dut: Top  
port map (t_clk, t_Rst);

clk_gen : process
begin
t_clk <= '0';
wait for 5 ns;
t_clk <= '1';
wait for 5 ns;
cycle_count <= cycle_count + 1;
end process;

stimuli : process
begin
t_Rst <= '1';
wait for 10 ns;
t_Rst <= '0';

wait for 400 ns;
finish;
end process;
end Behavioral;
