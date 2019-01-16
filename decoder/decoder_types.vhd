LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

package decoder_types is

	--! Record for instruction decoding
	type opcodes_t is record
		opcode : std_logic_vector(6 downto 0);	--! Instruction opcode
		funct3 : std_logic_vector(2 downto 0);	--! Instruction function: 7 bits
		funct7 : std_logic_vector(6 downto 0);	--! Instruction function: 3 bits
	end record opcodes_t;

	--! Arithmetic type R opcode
	constant TYPE_R	: std_logic_vector(6 downto 0) := "0110011";
		--! Func3 opcodes
		constant TYPE_ADD_SUB	: std_logic_vector(2 downto 0) := "000";
			--! Func7 opcodes
			constant TYPE_ADD	: std_logic_vector(6 downto 0) := "0000000";
			constant TYPE_SUB	: std_logic_vector(6 downto 0) := "0100000";
			
	--! Arithmetic type I opcode
	constant TYPE_I	: std_logic_vector(6 downto 0) := "0010011";
		--! Func3 opcodes
		constant TYPE_ADDI	: std_logic_vector(2 downto 0) := "000";
		constant TYPE_SLTI	: std_logic_vector(2 downto 0) := "010";
		constant TYPE_SLTIU	: std_logic_vector(2 downto 0) := "011";
		constant TYPE_XORI	: std_logic_vector(2 downto 0) := "100";
		constant TYPE_ORI	: std_logic_vector(2 downto 0) := "110";
		constant TYPE_ANDI	: std_logic_vector(2 downto 0) := "111";
	
	--! Memory type S opcode
	constant TYPE_S	: std_logic_vector(6 downto 0) := "0100011";
		--! Func3 opcodes
		constant TYPE_SB	: std_logic_vector(2 downto 0) := "000";
		constant TYPE_SH	: std_logic_vector(2 downto 0) := "001";
		constant TYPE_SW	: std_logic_vector(2 downto 0) := "010";
	
	
	--! Special type U opcode
	constant TYPE_LUI	: std_logic_vector(6 downto 0) := "0110111";
	constant TYPE_AUIPC	: std_logic_vector(6 downto 0) := "0010111";
	
	
--	constant PLUS_ULA	: std_logic_vector(2 downto 0) := "000";
--	constant MUL_ULA 	: std_logic_vector(2 downto 0) := "001";
--	constant AND_ULA 	: std_logic_vector(2 downto 0) := "010";
--	constant OR_ULA 	: std_logic_vector(2 downto 0) := "011";
--	constant XOR_ULA 	: std_logic_vector(2 downto 0) := "100";
--	constant NOT_ULA 	: std_logic_vector(2 downto 0) := "101";
--	constant SLL_ULA 	: std_logic_vector(2 downto 0) := "110";
--	constant SRL_ULA 	: std_logic_vector(2 downto 0) := "111";
--	
--	constant MUX_ULA_R		: std_logic_vector(1 downto 0) := "00";
--	constant MUX_ULA_I  	: std_logic_vector(1 downto 0) := "01";
--	constant MUX_ULA_Shift 	: std_logic_vector(1 downto 0) := "10";
--	constant MUX_ULA_BRANCH : std_logic_vector(1 downto 0) := "11";
--	
--	constant MUX_BR_ULA		: std_logic := '0';
--	constant MUX_BR_RAM		: std_logic := '1';
--	
--	constant MUX_COMP_0		: std_logic := '0';
--	constant MUX_COMP_EQUAL	: std_logic := '1';
--	
--	constant PC_DT_PSEUDO 	: std_logic := '0';
--	constant PC_DT_BRANCH	: std_logic := '1';	
--	
--	constant LED_IO_REG : std_logic_vector(7 downto 0) := "10000000";
--	constant SW_IO_REG  : std_logic_vector(7 downto 0) := "10000001";
--	constant SEG7_IO_REG: std_logic_vector(7 downto 0) := "10000010";	
		
end package decoder_types;

package body decoder_types is
	
end package body decoder_types;