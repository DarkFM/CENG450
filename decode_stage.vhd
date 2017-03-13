library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.STD_LOGIC_ARITH.all;

------------------------------------------------------------------------------------------------------------
entity decode_stage is
	Port
	(
		instr_in : in std_logic_vector(15 downto 0);
		OUT_OP_CODE : out std_logic_vector(6 downto 0);

		-- needed for A instruvctions
		-- signals for register file, also RA might need to go to memory
		rd_index1 : out std_logic_vector(2 downto 0);
		rd_index2 : out std_logic_vector(2 downto 0);

		-- needed for the shift offset
		OUT_C1 : out std_logic_vector(3 downto 0);

		-- needed by write back or memory stage
		OUT_RA_index : out std_logic_vector(2 downto 0)

	);
end decode_stage;

architecture decode_stage of decode_stage is

	alias A_OP_CODE is instr_in(15 DOWNTO 9);
	alias A_RA is instr_in(8 DOWNTO 6);
	alias A_RB is instr_in(5 DOWNTO 3);
	alias A_RC is instr_in(2 DOWNTO 0);
	alias A_C1 is instr_in(3 DOWNTO 0);


begin


	decode : process(instr_in)
		variable int_op_code: integer := to_integer(unsigned(A_OP_CODE));
		begin
			-- S_op_code <= A_OP_CODE;

			-- send op code to output
			OUT_OP_CODE <= A_OP_CODE;

			case int_op_code is

				when 0 => null;
				when 1 to 4 =>
					rd_index1 <= A_RB;
					rd_index2 <= A_RC;
					OUT_C1 <= (others => '0');
					OUT_RA_index <= (others => '0');
				when 5 to 6 =>
					rd_index1 <= A_RA;
					rd_index2 <= (others => '0');
					OUT_C1 <= A_C1;
					OUT_RA_index <= A_RA;

				when 7 to 33 =>
					rd_index1 <= A_RA;
					rd_index2 <= (others => '0');
					OUT_C1 <= (others => '0');
					OUT_RA_index <=  A_RA;
				when others => null;
			end case;

		end process;

end decode_stage;
