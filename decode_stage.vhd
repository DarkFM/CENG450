library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.STD_LOGIC_ARITH.all;

------------------------------------------------------------------------------------------------------------
entity decode_stage is
	Port
	(
		instr_in : in std_logic_vector(15 downto 0);
		write_en : in std_logic;
		write_address: in std_logic_vector(2 downto 0);
		data_in : std_logic_vector(15 downto 0);
		clk : in std_logic;
		reset : in std_logic;

		OP_CODE : out std_logic_vector(6 downto 0);
		-- OUT_RA : out std_logic_vector(15 downto 0);
		-- OUT_RB : out std_logic_vector(15 downto 0);
		-- needed for A instruvctions
		OUT_VAL_1 : out std_logic_vector(15 downto 0);
		OUT_VAL_2 : out std_logic_vector(15 downto 0);
		-- OUT_RC : out std_logic_vector(15 downto 0);

		-- needed for the shift offset
		OUT_C1 : out std_logic_vector(3 downto 0)

	);
end decode_stage;

architecture decode_stage of decode_stage is

	alias A_OP_CODE is instr_in(15 DOWNTO 9);
	alias A_RA is instr_in(8 DOWNTO 6);
	alias A_RB is instr_in(5 DOWNTO 3);
	alias A_RC is instr_in(2 DOWNTO 0);
	alias A_C1 is instr_in(3 DOWNTO 0);

	signal S_op_code: std_logic_vector(6 downto 0);
	-- signal index_RA: std_logic_vector(2 downto 0);
	-- signal index_RB: std_logic_vector(2 downto 0);
	-- signal index_RC: std_logic_vector(2 downto 0);
	-- signal index_C1: std_logic_vector(3 downto 0);

	signal rd_index1: std_logic_vector(2 downto 0);
	signal rd_index2: std_logic_vector(2 downto 0);

	component register_file is
		port (
			rst : in std_logic;
			clk : in std_logic;

			rd_address_1: in std_logic_vector(2 downto 0);
			data_out_1: out std_logic_vector(15 downto 0);

			rd_address_2: in std_logic_vector(2 downto 0);
			data_out_2: out std_logic_vector(15 downto 0);

			wr_address: in std_logic_vector(2 downto 0);
			data_in: in std_logic_vector(15 downto 0);
			reg_wr_en: in std_logic
		);
	end component;


begin

	reg_file: register_file
		port map(
			rst  => reset,
			clk => clk,

			rd_address_1 => rd_index1,
			data_out_1 => OUT_VAL_1,

			rd_address_2 => rd_index2,
			data_out_2 => OUT_VAL_2,

			wr_address => write_address,
			data_in => data_in,
			reg_wr_en => write_en
		);

	decode : process(instr_in)
		variable int_op_code: integer := to_integer(unsigned(A_OP_CODE));
		begin
			-- S_op_code <= A_OP_CODE;

			-- send op code to output
			OP_CODE <= A_OP_CODE;

			case int_op_code is

				when 0 => null;
				when 1 to 4 =>
					rd_index1 <= A_RB;
					rd_index2 <= A_RC;
				when 5 to 6 =>
					rd_index1 <= A_RA;
					OUT_C1 <= A_C1;
					rd_index2 <= (others => '0');

				when 7 to 33 =>
					rd_index1 <= A_RA;
				when others => null;
			end case;

		end process;

end decode_stage;
