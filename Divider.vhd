library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider is
	port(
		StartDIVU: in std_logic;
		N, D: in std_logic_vector(31 downto 0);
		R, Q: out std_logic_vector(31 downto 0));
end Divider;

architecture behavioral of Divider is
	begin
	
	main: process(StartDIVU, N, D)
		variable Q_reg: unsigned (31 downto 0);
		variable R_reg: unsigned (31 downto 0);

		begin
		if (StartDIVU = '1') then
			if D = x"00000000" then
				Q <= (others => 'X');
				R <= (others => 'X');
			else 
				Q_reg := (others => '0');
				R_reg := (others => '0');
			
				for i in 31 downto 0 loop
					R_reg := R_reg (30 downto 0) & '0';
					R_reg(0) := N(i);
					if R_reg >= unsigned(D) then
						R_reg := R_reg - unsigned(D);
						Q_reg(i) := '1';
					end if;
				end loop;
			
				Q <= std_logic_vector(Q_reg);
				R <= std_logic_vector(R_reg);
			end if;
		end if;
	end process;

end behavioral;