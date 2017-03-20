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

			OUT_CTRL_EX : out  STD_LOGIC_VECTOR (4 downto 0);
			OUT_CTRL_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
			OUT_CTRL_WB : out  STD_LOGIC_VECTOR (3 downto 0);
			OUT_CTRL_R_INDEX1: out  STD_LOGIC_VECTOR (2 downto 0);
			OUT_CTRL_R_INDEX2: out  STD_LOGIC_VECTOR (2 downto 0)
--			OUT_CTRL_instr_in : OUT  STD_LOGIC_VECTOR (15 downto 0);

			);
			
end control_unit;

architecture Behavioral of control_unit is

	-- might not be synthesisable
	alias A_OP_CODE is IN_CTRL_instr_in(15 DOWNTO 9);
	alias A_RA is IN_CTRL_instr_in(8 DOWNTO 6);
	alias A_RB is IN_CTRL_instr_in(5 DOWNTO 3);
	alias A_RC is IN_CTRL_instr_in(2 DOWNTO 0);
	alias A_C1 is IN_CTRL_instr_in(3 DOWNTO 0);
	
	-- Execute stage	
		--signal ctrl_C1 : std_logic_vector(3 downto 0);-- OUT_CTRL_EX(3 downto 0);
		--signal ctrl_ALU_ENABLE : std_logic; -- is OUT_CTRL_EX(4);
	
	
	-- Memory stage
	
	-- Write Back stage
----	signal S_EX: std_logic_vector(4 downto 0);
--	signal S_MEM: STD_LOGIC_VECTOR (3 downto 0);
----	signal S_WB: std_logic_vector(3 downto 0);
--	
--	SIGNAL ctrl_C1: std_logic_vector(3 downto 0);
--	SIGNAL ctrl_ALU_ENABLE: std_logic;
--	-- variables for WB stage
--	SIGNAL ctrl_RA_index: std_logic_vector(2 downto 0);
--	SIGNAL ctrl_REG_W_ENABLE: std_logic;

	signal int_op_code : integer;

begin
--	var_assign: process(IN_CTRL_instr_in)
--		-- variables for EX stage
--		variable ctrl_C1: std_logic_vector(3 downto 0);
--		variable ctrl_ALU_ENABLE: std_logic;
--		-- variables for WB stage
--		variable ctrl_RA_index: std_logic_vector(2 downto 0);
--		variable ctrl_REG_W_ENABLE: std_logic;
		

--		variable int_op_code: integer := to_integer(unsigned(A_OP_CODE));

		
--		begin

		int_op_code <= to_integer(unsigned(A_OP_CODE));
		
----		if rising_edge(CLK) then
--			if RST = '1' then
--				ctrl_C1 <= "0000";
--				ctrl_ALU_ENABLE <='0';
--				ctrl_REG_W_ENABLE <= '0';
--				ctrl_RA_index <= (others => '0');
--				S_MEM <= (others => '0');
--
----				rd_index1 <= (others => '0');
----				rd_index1 <= (others => '0');
--		else
--		-- signal assignments from CU
--		case int_op_code is
--			when 0 => 
--				ctrl_C1 <= "0000";
--				ctrl_ALU_ENABLE <='0';
--				ctrl_REG_W_ENABLE <= '0';
--				ctrl_RA_index <= (others => '0');
--				S_MEM <= (others => '0');
--			-- A1 format
--			when 1 |2 |3| 4 =>
--				-- enable ALU
--				ctrl_C1 <= "0000";
--				ctrl_ALU_ENABLE <= '1';
--				-- enable write into reg
--				ctrl_RA_index <= A_RA;
--				ctrl_REG_W_ENABLE <= '1';
--				S_MEM <= (others => '0');
--				
--				
--				-- sending to reg file
----				rd_index1 <= A_RB;
----				rd_index2 <= A_RC;
--		
--				
--			-- A2 format
--			when 5 | 6 =>
--				-- enable alu and c1 output
--				ctrl_C1 <= A_C1;
--				ctrl_ALU_ENABLE <= '1';
--				-- enable write into reg
--				ctrl_RA_index <= A_RA;
--				ctrl_REG_W_ENABLE <= '1';
--				S_MEM <= (others => '0');				
--
--				-- sending to reg file
----				rd_index1 <= A_RA;
----				rd_index2 <= (others => '0');
--
--
--				
--			-- A3 format
--			when 7 | 33 =>
--				-- enable alu 
--				ctrl_C1 <= "0000";
--				ctrl_ALU_ENABLE <= '1';
--				-- enable write into reg
--				ctrl_RA_index <= A_RA;
--				ctrl_REG_W_ENABLE <= '1';
--				S_MEM <= (others => '0');				
--	
--
--				-- sending data to reg file
----					rd_index1 <= A_RA;
----					rd_index2 <= (others => '0');
--
--
--			when others => null;
--		end case;
--		end if;
--	end process;

	with int_op_code select
		OUT_CTRL_EX <=
		-- A instructions
			'1' & "0000" when 1 to 4,
			'1' & A_C1 when 5 to 6,
			'1' & "0000" when 7 to 33,
			"00000" when others;
			
	with int_op_code select		
		OUT_CTRL_MEM <= 
				-- A instructions
				"0000" when 1 to 4,
				"0000" when 5 to 6,
				"0000" when 7 to 33,
				"0000" when others;
				
	with int_op_code select			
		OUT_CTRL_WB <= 
				-- A instructions
				'1' & A_RA when 1 to 4,
				'1' & A_RA when 5 to 6,
				'1' & A_RA when 7 to 33,
				"0000" when others;	
			
	OUT_CTRL_R_INDEX1 <= A_RB;
	OUT_CTRL_R_INDEX2 <= A_RC;
--	OUT_CTRL_instr_in	<= IN_CTRL_instr_in;	

end Behavioral;

