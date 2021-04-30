library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity Register_File is
port (
 clk: in std_logic;
 write_en: in std_logic;
 write_dest: in std_logic_vector(4 downto 0);
 write_data: in std_logic_vector(31 downto 0);
 write_R30: in std_logic_vector(31 downto 0);
 write_R31: in std_logic_vector(31 downto 0);
 read_addr_1: in std_logic_vector(4 downto 0);
 read_addr_2: in std_logic_vector(4 downto 0);
 data_1: out std_logic_vector(31 downto 0);
 data_2: out std_logic_vector(31 downto 0));
end Register_File;

architecture Behavioral of Register_File is
type reg_f is array (0 to 31) of std_logic_vector (31 downto 0);
signal reg_array: reg_f:=(
b"00000000000000000000000000000000",
b"00000000000000000000000000000001",
b"00000000000000000000000000000010",
b"00000000000000000000000000001111",
b"11111111111111111111111111111110",
b"00000000000000000000000000000101",
b"00000000000000000000000000000000",
b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000",
   b"00000000000000000000000000000000"
);

begin
 process(clk) 
 begin

 if(rising_edge(clk)) then
   if(write_en='1') then
    if(to_integer(unsigned(write_dest)) > 0 and to_integer(unsigned(write_dest)) < 30) then
    reg_array(to_integer(unsigned(write_dest))) <= write_data;
    elsif (to_integer(unsigned(write_dest)) = 30) then
    reg_array(to_integer(unsigned(write_dest))) <= write_R30;
    reg_array(to_integer(unsigned(write_dest) + 1)) <= write_R31;
   end if;
   end if;
 end if;
 end process;

 data_1 <= x"00000000" when read_addr_1 = "00000" else reg_array(to_integer(unsigned(read_addr_1)));
 data_2 <= x"00000000" when read_addr_2 = "00000" else reg_array(to_integer(unsigned(read_addr_2)));
end Behavioral;