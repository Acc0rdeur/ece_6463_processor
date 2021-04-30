library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity Data_Memory is
port (
 clk: in std_logic;
 access_addr: in std_logic_Vector(31 downto 0);
 write_data: in std_logic_Vector(31 downto 0);
 write_en: in std_logic;
 read_data: out std_logic_Vector(31 downto 0)
);
end Data_Memory;

architecture Behavioral of Data_Memory is
signal ram_addr: std_logic_vector(15 downto 0):= x"0010";
type data_mem is array (0 to 255 ) of std_logic_vector (15 downto 0);
signal RAM: data_mem :=((others=> (others=>'0'))); --Assign 0 to all components
begin

 process(clk,write_en)
 begin
 if (write_en = '1' and falling_edge(clk) ) then
  ram_addr <= access_addr(15 downto 0); --16 bits width, 32 bits data to store
  end if;
  end process; 

 process(clk,write_en)
 begin
  if(rising_edge(clk)) then
  if (write_en='1') then
  --ram_addr <= access_addr(15 downto 0); --16 bits width, 32 bits data to store
  ram(to_integer(unsigned(ram_addr)*2)) <= write_data(15 downto 0);
  ram(to_integer(unsigned(ram_addr))*2+1) <= write_data(31 downto 16);
  end if;
  end if;
 end process;
   read_data(15 downto 0) <= ram(to_integer(unsigned(ram_addr)*2));
   read_data(31 downto 16) <= ram(to_integer(unsigned(ram_addr)*2+1));
   
end Behavioral;