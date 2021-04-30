library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top is
	port (
		CLK, Rst: in std_logic);
end Top;

architecture behavioral of Top is
    attribute dont_touch : string;
    
	component ALU port (
		SrcA, SrcB: in std_logic_vector(31 downto 0);
		ALUControl, Rot_amt: in std_logic_vector(3 downto 0);
		ALUResult: out std_logic_vector(31 downto 0);
		Zero: out std_logic := '0');
	end component;

	component ControlUnit port (
		Op, Func: in std_logic_vector(5 downto 0);
		MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jmp, Halt, StartDIVU: out std_logic;
		ALUControl: out std_logic_vector(3 downto 0));
	end component;

	component Data_Memory port (
		clk: in std_logic;
		access_addr: in std_logic_Vector(31 downto 0);
		write_data: in std_logic_Vector(31 downto 0);
		write_en: in std_logic;
		read_data: out std_logic_Vector(31 downto 0));
	end component;

	component Divider port (
		StartDIVU: in std_logic;
		N, D: in std_logic_vector(31 downto 0);
		R, Q: out std_logic_vector(31 downto 0));
	end component;

	component Instruction_Memory port (
		pc: in std_logic_vector(31 downto 0);
		instruction: out std_logic_vector(31 downto 0));
	end component;

	component MUX5 port (
		Control_sgnl: in std_logic;
		Input_0: in std_logic_vector(4 downto 0);
		Input_1: in std_logic_vector(4 downto 0);
		Output: out std_logic_vector(4 downto 0));
	end component;

	component MUX32 port (
		Control_sgnl: in std_logic;
		Input_0: in std_logic_vector(31 downto 0);
		Input_1: in std_logic_vector(31 downto 0);
		Output: out std_logic_vector(31 downto 0));
	end component;

	component PC port ( 
		clk,reset: in std_logic;
		pc_in : in std_logic_vector(31 downto 0) := x"00000000";
		ishalt : in std_logic;
		pc_out : out std_logic_vector(31 downto 0));
	end component;

	component PCBranch port (
		SignImm_shifted, PCPlus4_out: in std_logic_vector(31 downto 0);
		PCBranch_out: out std_logic_vector(31 downto 0));
	end component;

	component PCPlus4 port (
		PCPlus4_in: in std_logic_vector(31 downto 0);
		PCPlus4_out: out std_logic_vector(31 downto 0));
	end component;

	component Register_File port (
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
	end component;

	component SIGN_EXT port (
		Sign_In: in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
		Jump_sgnl: in STD_LOGIC;
		Sign_Imm: out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
		Sign_Addr: out STD_LOGIC_VECTOR(31 downto 0) := (others => '0'));
	end component;
    
    attribute dont_touch of ALU : component is "yes";
    attribute dont_touch of ControlUnit : component is "yes";
    attribute dont_touch of Data_Memory : component is "yes";
    attribute dont_touch of Divider : component is "yes";
    attribute dont_touch of Instruction_Memory : component is "yes";
    attribute dont_touch of MUX5 : component is "yes";
    attribute dont_touch of MUX32 : component is "yes";
    attribute dont_touch of PC : component is "yes";
    attribute dont_touch of PCBranch : component is "yes";
    attribute dont_touch of PCPlus4 : component is "yes";
    attribute dont_touch of Register_File : component is "yes";
    attribute dont_touch of SIGN_EXT : component is "yes";
    
	signal alu_zero_out_line, halt_out_line, jmp_out_line, memtoreg_out_line, memwrite_out_line, branch_out_line, alusrc_out_line, regdst_out_line, startdivu_line, regwrite_out_line: std_logic;
	signal reg_rd1_out_line, mux_alu_out_line, instrmem_out_line, aluresult_out_line, reg_rd2_out_line, datamem_out_line, div_q_out_line, div_r_out_line, pc_out_line, immext_out_line, mux_datamem_out_line, pcplus4_out_line, pcbranch_out_line, addrext_out_line: std_logic_vector(31 downto 0);
	signal alucontrol_out_line: std_logic_vector(3 downto 0);
	signal mux_reg_out_line: std_logic_vector(4 downto 0);
    signal and_out, or_out: std_logic;
    signal pc_in_line: std_logic_vector(31 downto 0);

begin
    and_out <= branch_out_line and alu_zero_out_line;
    or_out <= jmp_out_line or and_out;
    
	alu_module: ALU port map (
		SrcA => mux_alu_out_line,
		SrcB => reg_rd2_out_line,
		Rot_amt => instrmem_out_line(9 downto 6),
		ALUControl => alucontrol_out_line,
		Zero => alu_zero_out_line,
		ALUResult => aluresult_out_line);

	controlunit_module: ControlUnit port map (
		Op => instrmem_out_line(31 downto 26),
		Func => instrmem_out_line(5 downto 0),
		Halt => halt_out_line,
		Jmp => jmp_out_line,
		MemtoReg => memtoreg_out_line,
		MemWrite => memwrite_out_line,
		Branch => branch_out_line,
		ALUControl => alucontrol_out_line,
		ALUSrc => alusrc_out_line,
		RegDst => regdst_out_line,
		StartDIVU => startdivu_line,
		RegWrite => regwrite_out_line);

	datamem_module: Data_Memory port map (
		clk => CLK,
		access_addr => aluresult_out_line,
		write_data => reg_rd2_out_line,
		write_en => memwrite_out_line,
		read_data => datamem_out_line);

	divider_module: Divider port map (
		StartDIVU => startdivu_line,
		N => reg_rd1_out_line,
		D => reg_rd2_out_line,
		Q => div_q_out_line,
		R => div_r_out_line);

	instrmem_module: Instruction_Memory port map (
		pc => pc_out_line,
		instruction => instrmem_out_line);

	mux_alu_module: MUX32 port map (
		Control_sgnl => alusrc_out_line,
		Input_0 => reg_rd1_out_line,
		Input_1 => immext_out_line,
		Output => mux_alu_out_line);

	mux_datamem_module: MUX32 port map (
		Control_sgnl => memtoreg_out_line,
		Input_0 => aluresult_out_line,
		Input_1 => datamem_out_line,
		Output => mux_datamem_out_line);

	mux_pc_module: MUX32 port map (
		Control_sgnl => or_out,
		Input_0 => pcplus4_out_line,
		Input_1 => pcbranch_out_line,
		Output => pc_in_line);

	mux_reg_module: MUX5 port map (
		Control_sgnl => regdst_out_line,
		Input_0 => instrmem_out_line(15 downto 11),
		Input_1 => instrmem_out_line(25 downto 21),
		Output => mux_reg_out_line);

	pc_module: PC port map (
		clk => CLK,
		reset => Rst,
		pc_in => pc_in_line,
		ishalt => halt_out_line,
		pc_out => pc_out_line);

	pcbranch_module: PCBranch port map (
		SignImm_shifted => addrext_out_line,
		PCPlus4_out => pcplus4_out_line,
		PCBranch_out => pcbranch_out_line);

	pcplus4_module: PCPlus4 port map (
		PCPlus4_in => pc_out_line,
		PCPlus4_out => pcplus4_out_line);

	regfile_module: Register_File port map (
		clk => CLK,
		write_en => regwrite_out_line,
		write_dest => mux_reg_out_line,
		write_data => mux_datamem_out_line,
		write_R30 => div_q_out_line,
		write_R31 => div_r_out_line,
		read_addr_1 => instrmem_out_line(25 downto 21),
		read_addr_2 => instrmem_out_line(20 downto 16),
		data_1 => reg_rd1_out_line,
		data_2 => reg_rd2_out_line);

	signext_module: SIGN_EXT port map (
		Sign_In => instrmem_out_line(31 downto 0),
		Jump_sgnl => jmp_out_line,
		Sign_Imm => immext_out_line,
		Sign_Addr => addrext_out_line);

end behavioral;