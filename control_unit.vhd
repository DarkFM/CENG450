----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:00:55 03/11/2017 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port ( 
			RST : IN STD_LOGIC;
			clk : in std_logic;
			IN_CTRL_instr_in : in  STD_LOGIC_VECTOR (15 downto 0);

			OUT_CTRL_EX : out  STD_LOGIC_VECTOR (7 downto 0);
			OUT_CTRL_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
			OUT_CTRL_WB : out  STD_LOGIC_VECTOR (1 downto 0);
			OUT_CTRL_RA_MUX_SEL: out  STD_LOGIC;
			OUT_CTRL_IN_MUX_SEL: out  STD_LOGIC;
			OUT_CTRL_SIGN_EXTEND_MUX_SEL: out  STD_LOGIC;
			OUT_CTRL_WRITE_EN: out  STD_LOGIC;
			OUT_CTRL_WRITE_INDEX: out  STD_LOGIC_VECTOR (2 downto 0);	
			OUT_PORT_EN : OUT STD_LOGIC
			


			);
			
end control_unit;

architecture Behavioral of control_unit is

	-- might not be synthesisable
	alias A_OP_CODE is IN_CTRL_instr_in(15 DOWNTO 9);
	alias A_RA is IN_CTRL_instr_in(8 DOWNTO 6);
	alias A_RB is IN_CTRL_instr_in(5 DOWNTO 3);
	alias A_RC is IN_CTRL_instr_in(2 DOWNTO 0);
	alias A_C1 is IN_CTRL_instr_in(3 DOWNTO 0);
	


	signal int_op_code : integer := 0;

begin
	

		int_op_code <= to_integer(unsigned(A_OP_CODE));
		

	with int_op_code select
		OUT_CTRL_EX <=
		-- A instructions
-- alu_en & alu2_en & alu_bran_sel & alu_disp_sel & alu_mode
			'1' & '0' & '0' & "00" & "001" when 1,
			'1' & '0' & '0' & "00" & "010" when 2,
			'1' & '0' & '0' & "00" & "011" when 3,			
			'1' & '0' & '0' & "00" & "100" when 4,							
			'1' & '0' & '0' & "10" & "101" when 5,
			'1' & '0' & '0' & "10" & "110" when 6, 	-- Right SHIFT by c1 times
			'1' & '0' & '0' & "00" & "111" when 7, -- TEST instruction for flags
			'0' & '0' & '0' & "00" & "000" when 32,	-- OUT, send instruction to out port
			'0' & '0' & '0' & "00" & "000" when 33, 	-- IN, send instruction to IN port and into reg_file
			'0' & '0' & '0' & "00" & "000" when others;
			-- NEED TO CHANGE alu_disp_sel FOR WHEN IT IS A BRANCH
			
	with int_op_code select		
		OUT_CTRL_MEM <= 
				-- A instructions
				"1000" when 1 to 4,
				"1000" when 5 to 7,
				"0000" when 32,
				"1000" when 33,
				"0000" when others;
				
	with int_op_code select			
		OUT_CTRL_WB <= 
				-- A instructions
				'1' & '0' when 1 to 4,
				'1' & '0' when 5 to 6,
				'1' & '0' when 7 to 32,
				'1' & '0' when 33, 	-- IN, send instruction to IN port and into reg_file
				"00" when others;	
				
	
	-----------------------------------------------------------------------------------------------
	--				Signals for fetch stage mux's
	-----------------------------------------------------------------------------------------------
	with int_op_code select		
			OUT_CTRL_RA_MUX_SEL <=	
				'1' when 5 to 6,	-- if shift instruction
				'0' when others;
			
	with int_op_code select	
			OUT_CTRL_IN_MUX_SEL <= 
				'1' when 33,	-- if IN instruction
				'0' WHEN others;
			
	with int_op_code select	
			OUT_CTRL_SIGN_EXTEND_MUX_SEL <= 
				'1' when 67 to 70,	-- for B2 type instruction
				'0' when others;
				
	with int_op_code select	
			OUT_CTRL_WRITE_EN <= 
				'1' when 33,	-- for IN insrutuction
				'0' when others;
			
	with int_op_code select	
			OUT_CTRL_WRITE_INDEX <=
				A_RA when 33, -- for IN insrutuction
				(others => '0') when others;
							
	with int_op_code select	
			OUT_PORT_EN <=
				'1' when 5 TO 6, -- for OUT insrutuction
				'0' when others;				
		
--	OUT_CTRL_R_INDEX1 <= A_RB;
--	OUT_CTRL_R_INDEX2 <= A_RC;


end Behavioral;

