library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port (
		SrcA, SrcB: in std_logic_vector(31 downto 0);
		ALUControl, Rot_amt: in std_logic_vector(3 downto 0);
		ALUResult: out std_logic_vector(31 downto 0);
		Zero: out std_logic);
end ALU;

architecture behavioral of ALU is

	component ALU_lr is
		port (
			source: in std_logic_vector(31 downto 0);
			amount: in std_logic_vector(3 downto 0);
			result: out std_logic_vector(31 downto 0));
	end component;

	component ALU_rr is
		port (
			source: in std_logic_vector(31 downto 0);
			amount: in std_logic_vector(3 downto 0);
			result: out std_logic_vector(31 downto 0));
	end component;
	
	signal XR, LR, RR, SB, XRLR, SBRR, ALUResult_inner: std_logic_vector(31 downto 0);
	signal Zero_inner: std_logic;

	begin
		lr_module: ALU_lr port map (
			source => SrcA,
			amount => Rot_amt,
			result => LR);
		rr_module: ALU_rr port map (
			source => SrcA,
			amount => Rot_amt,
			result => RR);
		xrlr_module: ALU_lr port map (
			source => XR,
			amount => Rot_amt,
			result => XRLR);
		sbrr_module: ALU_rr port map (
			source => SB,
			amount => Rot_amt,
			result => SBRR);

		XR <= SrcA xor SrcB;
		SB <= SrcA - SrcB;

		main: process(SrcA, SrcB, ALUControl, LR, RR, XRLR, SBRR, SB)
		begin
			case ALUControl is
				when "0000" => ALUResult_inner <= SrcA and SrcB;
				when "0001" => ALUResult_inner <= SrcA or SrcB;
				when "0010" => ALUResult_inner <= SrcA nor SrcB;
				when "0111" => ALUResult_inner <= SrcA + SrcB;
				when "1000" => ALUResult_inner <= std_logic_vector(signed(SrcA) + signed(SrcB));
				when "0011" => ALUResult_inner <= XRLR;
				when "0100" => ALUResult_inner <= RR XOR SrcB;
				when "0101" => ALUResult_inner <= LR + SrcB;
				when "0110" => ALUResult_inner <= SBRR;
				when "1010" => if(SrcB < SrcA) then Zero_inner <= '1'; else Zero_inner <= '0'; end if;
				when "1011" => if(SrcA = SrcB) then Zero_inner <= '1'; else Zero_inner <= '0'; end if;
				when "1100" => if(conv_integer(SrcA) /= conv_integer(SrcB)) then Zero_inner <= '1'; else Zero_inner <= '0'; end if;
				when others => ALUResult_inner <= (others => 'X');
			end case;
		end process;

		ALUResult <= ALUResult_inner;
		Zero <= Zero_inner;

end behavioral;