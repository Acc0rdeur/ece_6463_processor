library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
	port (
		Op, Func: in std_logic_vector(5 downto 0);
		MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jmp, Halt, StartDIVU: out std_logic;
		ALUControl: out std_logic_vector(3 downto 0));
end ControlUnit;

architecture behavioral of ControlUnit is

	signal MemtoReg_inner, MemWrite_inner, Branch_inner, ALUSrc_inner, RegDst_inner, RegWrite_inner, Jmp_inner, Halt_inner, StartDIVU_inner: std_logic := '0';
	signal ALUControl_inner: std_logic_vector(3 downto 0);

	begin
		decode: process(Op, Func)
		begin
			if (Op = "000000") then
				if (Func = "011010") then
					MemtoReg_inner <= '0';
					MemWrite_inner <= '0';
					Branch_inner <= '0';
					ALUSrc_inner <= '0';
					RegWrite_inner <= '1';
					RegDst_inner <= '0';
					Jmp_inner <= '0';
					Halt_inner <= '0';
					StartDIVU_inner <= '1';
					ALUControl_inner <= (others => 'X');
				else
					MemtoReg_inner <= '0';
					MemWrite_inner <= '0';
					Branch_inner <= '0';
					ALUSrc_inner <= '0';
					RegWrite_inner <= '1';
					RegDst_inner <= '0';
					Jmp_inner <= '0';
					Halt_inner <= '0'; -- 00
				end if;
				
				if (Func = "010010") then
					ALUControl_inner <= "0000"; -- 12 = AND
				elsif (Func = "010011") then 
					ALUControl_inner <= "0001"; -- 13 = OR
				elsif (Func = "010100") then
					ALUControl_inner <= "0010"; -- 14 = NOR
				elsif (Func = "010000") then
					ALUControl_inner <= "0011"; -- 10 = XRLR
				elsif (Func = "010001") then
					ALUControl_inner <= "0100"; -- 11 = RRXR
				elsif (Func = "010101") then
					ALUControl_inner <= "0101"; -- 15 = LRAD
				elsif (Func = "010110") then
					ALUControl_inner <= "0110"; -- 16 = SBRR
				elsif (Func = "100000") then
					ALUControl_inner <= "0111"; -- 20 = ADD
				elsif (Func = "100001") then
					ALUControl_inner <= "1000"; -- 21 = ADDU
				end if;

			elsif (Op = "000011") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '1';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "0000"; -- 03 = ANDI

			elsif (Op = "000100") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '1';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "0001"; -- 04 = ORI

			elsif (Op = "000111") then
				MemtoReg_inner <= '1';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '1';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "0111"; -- 07 = LW
				
			elsif (Op = "001000") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '1';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1000"; -- 08 = ADDI

			elsif (Op = "101011") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '1';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '0';
				RegDst_inner <= '0';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "0111"; -- 2b = SW

			elsif (Op = "001001") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '1';
				ALUSrc_inner <= '0';
				RegWrite_inner <= '0';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1010"; -- 09 = BLT

			elsif (Op = "001010") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '1';
				ALUSrc_inner <= '0';
				RegWrite_inner <= '0';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1011"; -- 0A = BEQ

			elsif (Op = "001011") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '1';
				ALUSrc_inner <= '0';
				RegWrite_inner <= '0';
				RegDst_inner <= '1';
				Jmp_inner <= '0';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1100"; -- 0B = BNE

			elsif (Op = "001100") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '1';
				RegWrite_inner <= '0';
				RegDst_inner <= '0';
				Jmp_inner <= '1';
				Halt_inner <= '0';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1110"; -- 0C = JMP

			elsif (Op = "111111") then
				MemtoReg_inner <= '0';
				MemWrite_inner <= '0';
				Branch_inner <= '0';
				ALUSrc_inner <= '0';
				RegWrite_inner <= '0';
				RegDst_inner <= '0';
				Jmp_inner <= '0';
				Halt_inner <= '1';
				StartDIVU_inner <= '0';
				ALUControl_inner <= "1111"; -- 3F = HAL
			
			end if;
		end process;

		MemtoReg <= MemtoReg_inner;
		MemWrite <= MemWrite_inner;
		Branch <= Branch_inner;
		ALUSrc <= ALUSrc_inner;
		RegWrite <= RegWrite_inner;
		RegDst <= RegDst_inner;
		Jmp <= Jmp_inner;
		Halt <= Halt_inner;
		StartDIVU <= StartDIVU_inner;
		ALUControl <= ALUControl_inner;

end behavioral;