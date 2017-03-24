library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.STD_LOGIC_ARITH.all;

------------------------------------------------------------------------------------------------------------
entity decode_stage is
	Port
	(
		instr_in : in std_logic_vector(15 downto 0);

		OUT_rd_index1 : out std_logic_vector(2 downto 0);
		OUT_rd_index2 : out std_logic_vector(2 downto 0);
		OUT_RA_index : out std_logic_vector(2 downto 0);
		OUT_DISP_L : out std_logic_vector(8 downto 0);		
		OUT_DISP_S : out std_logic_vector(5 downto 0);
		OUT_C1 : out std_logic_vector(3 downto 0)

	);
end decode_stage;

architecture decode_stage of decode_stage is

	alias A_OP_CODE is instr_in(15 DOWNTO 9);
	alias A_RA is instr_in(8 DOWNTO 6);
	alias A_RB is instr_in(5 DOWNTO 3);
	alias A_RC is instr_in(2 DOWNTO 0);
	alias A_C1 is instr_in(3 DOWNTO 0);
	alias disp_l is instr_in(8 DOWNTO 0);	
	alias disp_s is instr_in(5 DOWNTO 0);	
--	variable int_op_code : integer;

begin
--		variable int_op_code : integer := to_integer(unsigned(A_OP_CODE));

	OUT_rd_index1 <= 
--		A_RA when (to_integer(unsigned(A_OP_CODE))= 5) else
--		A_RA when (to_integer(unsigned(A_OP_CODE))= 6) else
		A_RB;
	OUT_rd_index2 <= A_RC;
	OUT_RA_index  <= A_RA;
	OUT_DISP_L <= disp_l;		
	OUT_DISP_S <= disp_S;	
	OUT_C1 <= A_C1;

end decode_stage;
