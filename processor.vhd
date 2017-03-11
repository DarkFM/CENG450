----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    17:10:15 03/08/2017
-- Design Name:
-- Module Name:    processor - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
    Port ( --IN_port : in  STD_LOGIC_VECTOR (15 downto 0);
           --OUT_port : out  STD_LOGIC_VECTOR (15 downto 0);
           P_reset : in  STD_LOGIC;
           P_clock : in  STD_LOGIC;
           P_enable : in std_logic;

			--   P_op_code: out std_logic_vector(6 downto 0);
			-- 	P_OUT_VAL_1 : out std_logic_vector(15 downto 0);
			-- 	P_OUT_VAL_2 : out std_logic_vector(15 downto 0);
				-- P_OUT_C1 : out std_logic_vector(3 downto 0);
                -- to write back
                P_out_ra : out std_logic_vector(2 downto 0);
                -- results
                dout: out std_logic_vector(15 downto 0);
                P_OUT_z_flag : out std_logic;
                P_OUT_n_flag : out std_logic;
                P_OUT_p_flag : out std_logic

			  );
end processor;

architecture Behavioral of processor is

	component counter  is
	  port(	clock:	in std_logic;
        	reset:	in std_logic;
        	en:	in std_logic;
        	Q:	out std_logic_vector(6 downto 0)
	  );
    end component;

    component ROM_VHDL IS
    	port (
        	addr: IN std_logic_vector(6 downto 0);
        	clk: IN std_logic;
        	data: OUT std_logic_vector(15 downto 0)
	  );
    END component;

	component FBUF is
		Port ( clk: in STD_LOGIC ;
			instr_in : in  STD_LOGIC_VECTOR (15 downto 0);
			instr_out : out  STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;

	component decode_stage is
		Port(
			instr_in : in std_logic_vector(15 downto 0);
			OUT_OP_CODE : out std_logic_vector(6 downto 0);

            rd_index1 : out std_logic_vector(2 downto 0);
            rd_index2 : out std_logic_vector(2 downto 0);


            -- needed for the shift offset
            OUT_C1 : out std_logic_vector(3 downto 0);

    		OUT_RA_index : out std_logic_vector(2 downto 0)
		);
	end component;

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

    component DBUF is
        Port ( clk: in STD_LOGIC ;
                IN_ra_index: in std_logic_vector(3 downto 0);
                IN_rb: in std_logic_vector(15 downto 0);
                IN_rc: in std_logic_vector(15 downto 0);
                IN_c1 : in  STD_LOGIC_VECTOR (2 downto 0);
                IN_op_code: in std_logic_vector(6 downto 0);

                OUT_ra_index: out std_logic_vector(15 downto 0);
                OUT_rb: out std_logic_vector(15 downto 0);
                OUT_rc: out std_logic_vector(15 downto 0);
                OUT_c1 : out  STD_LOGIC_VECTOR (2 downto 0);
                OUT_op_code: out std_logic_vector(6 downto 0)
            );
    end component;

    component alu is
    	Port
    	(
    		P_IN_rst : in std_logic;
    		P_IN_en : in std_logic;
    		P_IN_clk : in std_logic;

    		P_IN_alu_mode : in std_logic_vector(2 downto 0);
    		P_IN_arg1 : in std_logic_vector(15 downto 0);
    		P_IN_arg2 : in std_logic_vector(15 downto 0);
    		P_OUT_result : out std_logic_vector(15 downto 0);
    		P_OUT_z_flag : out std_logic;
    		P_OUT_n_flag : out std_logic;
    		P_OUT_p_flag : out std_logic

    	);
    end component;


	signal PC_out: std_logic_vector(6 downto 0);
	signal INSTR_TO_FBUF: std_logic_vector(15 downto 0);
	signal FBUF_TO_DECODE: std_logic_vector(15 downto 0);

	--signals for FBUF to REG_FILE
    signal S_RB: std_logic_vector(2 downto 0);
    signal S_RC: std_logic_vector(2 downto 0);
	--alias RA is STD_LOGIC_VECTOR(2 DOWNTO 0);
	--alias RA: STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- signals for decode to reg file
    signal index1 : std_logic_vector(2 downto 0);
    signal index2 : std_logic_vector(2 downto 0);

    -- signals for REG_FILE and DECODE to DBUF
    SIGNAL S_op_code: std_logic_vector(6 downto 0);
    signal RA_index_carry : std_logic_vector(2 downto 0);
    signal C1_carry : std_logic_vector(2 downto 0);
    signal Reg_file_data1 : std_logic_vector(15 downto 0);
    signal Reg_file_data2 : std_logic_vector(15 downto 0);

    -- signals for DBUF to ALU
    signal S_DBUF_op_code : std_logic_vector(6 downto 0);
    signal S_DBUF_VAL_1 : std_logic_vector(15 downto 0);
    signal S_DBUF_VAL_2 : std_logic_vector(15 downto 0);


begin

	PC: counter
    port map (
		clock => P_clock,
    	reset => P_reset,
    	en => P_enable,
    	Q => PC_out
    );

    I_MEM: ROM_VHDL
    	port map (
			addr => PC_out,
			clk => P_clock,
			data => INSTR_TO_FBUF
		);

	fetch_buffer: FBUF
		port map (
			clk => P_clock,
			instr_in => INSTR_TO_FBUF,
			instr_out => FBUF_TO_DECODE
		);

	decode: decode_stage
    	Port map
    	(
    		instr_in => FBUF_TO_DECODE,
    		OUT_OP_CODE => S_op_code,

    		-- needed for A instruvctions
    		rd_index1 => index1,
    		rd_index2 => index2,

    		-- needed for the shift offset
    		OUT_C1 => C1_carry,
    		OUT_RA_index => RA_index_carry

    	);


    reg_file: register_file
    	port map (
    		rst  => P_reset,
    		clk => P_clock,

    		rd_address_1 => index1,
    		data_out_1 => Reg_file_data1,

    		rd_address_2 => index2,
    		data_out_2 => Reg_file_data2,

    		wr_address => (others => '0'),
    		data_in => (others => '0'),
    		reg_wr_en => '0'
    	);

    decode_buffer: DBUF
        port map (
                clk => P_clock,
                IN_ra_index => RA_index_carry,
                IN_rb => Reg_file_data1,
    			IN_rc => Reg_file_data2,
    			IN_c1 => C1_carry,
                IN_op_code => S_op_code,

                OUT_ra_index => P_out_ra,
                OUT_rb => P_IN_arg1,
                OUT_rc => P_IN_arg2,  -- 
    			OUT_c1 => P_OUT_C1,  -- c1 to processor output
                OUT_op_code => S_op_code_DBUF --connect to alu
            );

    ALU1: alu
        Port map
        (
            P_IN_rst => P_reset,
            P_IN_en => P_enable,
            P_IN_clk => P_clock,

            P_IN_alu_mode => S_DBUF_op_code,
            P_IN_arg1 => S_DBUF_VAL_1,
            P_IN_arg2 => S_DBUF_VAL_2,
            P_OUT_result => dout,   -- result to processor
            P_OUT_z_flag => P_OUT_z_flag,
            P_OUT_n_flag => P_OUT_n_flag,
            P_OUT_p_flag => P_OUT_p_flag

        );

end Behavioral;
