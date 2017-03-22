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
			  P_PC_OUT:  out  STD_LOGIC_VECTOR (6 downto 0);
--			  FBUF_OUT:  out  STD_LOGIC_VECTOR (15 downto 0);

--			   P_op_code: out std_logic_vector(6 downto 0);
			 	P_OUT_VAL_1 : out std_logic_vector(15 downto 0);
			 	P_OUT_VAL_2 : out std_logic_vector(15 downto 0);
			
--				 P_OUT_C1 : out std_logic_vector(3 downto 0);
                -- to write back
                --P_out_ra : out std_logic_vector(2 downto 0);
					 
                -- results
--                dout: out std_logic_vector(15 downto 0);
--                P_OUT_z_flag : out std_logic;
--                P_OUT_n_flag : out std_logic;
--                P_OUT_p_flag : out std_logic;
					OUT_EX : out  STD_LOGIC_VECTOR (7 downto 0);
					OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
					OUT_WB : out  STD_LOGIC_VECTOR (3 downto 0);
					OUT_INSTRUC: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)

			  );
end processor;

architecture Behavioral of processor is

-- fetch stage modules
	component counter  is
	  port(
			PC_IN : IN std_logic_vector(6 downto 0);
			en_global:	in std_logic;
			NEXT_PC:	out std_logic_vector(6 downto 0);
			current_pc: out std_logic_vector(6 downto 0)
	  );
    end component;
	 
	 component PC_module is
    Port ( PC_in : in  STD_LOGIC_VECTOR (6 downto 0);
           reset : in  STD_LOGIC;
           en_global : in  STD_LOGIC;
			  clk: in std_logic;
           PC_out : out  STD_LOGIC_VECTOR (6 downto 0);
			  out_en: out std_logic
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
			reset: in std_logic;
			instr_in : in  STD_LOGIC_VECTOR (15 downto 0);
			PC_in : in std_logic_vector(6 downto 0);
			PC_out : out std_logic_vector(6 downto 0);
			instr_out : out  STD_LOGIC_VECTOR (15 downto 0)
			
		);
	end component;

	-- decode stage modules
	
component control_unit is
    Port ( 
			RST : IN STD_LOGIC;
			clk : in std_logic;
			IN_CTRL_instr_in : in  STD_LOGIC_VECTOR (15 downto 0);

			OUT_CTRL_EX : out  STD_LOGIC_VECTOR (7 downto 0);
			OUT_CTRL_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
			OUT_CTRL_WB : out  STD_LOGIC_VECTOR (3 downto 0);
			OUT_CTRL_R_INDEX1: out  STD_LOGIC_VECTOR (2 downto 0);
			OUT_CTRL_R_INDEX2: out  STD_LOGIC_VECTOR (2 downto 0)
--			OUT_CTRL_instr_in : OUT  STD_LOGIC_VECTOR (15 downto 0)
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
				reset: in std_logic;
				IN_EX : in  STD_LOGIC_VECTOR (7 downto 0);
				IN_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
				IN_WB : in  STD_LOGIC_VECTOR (3 downto 0);	 

            IN_rb: in std_logic_vector(15 downto 0);
            IN_rc: in std_logic_vector(15 downto 0);

            IN_instruction: in std_logic_vector(15 downto 0);
				PC_in : in std_logic_vector(6 downto 0);
				
				OUT_EX : out  STD_LOGIC_VECTOR (7 downto 0);
				OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
				OUT_WB : out  STD_LOGIC_VECTOR (3 downto 0);
            OUT_rb: out std_logic_vector(15 downto 0);
            OUT_rc: out std_logic_vector(15 downto 0);

            OUT_instruction: out std_logic_vector(15 downto 0);
				PC_out : out std_logic_vector(6 downto 0)
				);
    end component;

--    component alu is
--    	Port
--    	(
--    		P_IN_rst : in std_logic;
--    		P_IN_en : in std_logic;
--    		P_IN_clk : in std_logic;
--
--    		P_IN_alu_mode : in std_logic_vector(6 downto 0);
--    		P_IN_arg1 : in std_logic_vector(15 downto 0);
--    		P_IN_arg2 : in std_logic_vector(15 downto 0);
--    		P_OUT_result : out std_logic_vector(15 downto 0);
--    		P_OUT_z_flag : out std_logic;
--    		P_OUT_n_flag : out std_logic;
--    		P_OUT_p_flag : out std_logic
--
--    	);
--    end component;


--	signal PC_out: std_logic_vector(6 downto 0);
	signal INSTR_TO_FBUF: std_logic_vector(15 downto 0);
	signal adder_to_FBUF: std_logic_vector(6 downto 0);
	
	signal enable_PC_Adder: std_logic;
	
	signal PC_to_ROM_add : std_logic_vector(6 downto 0);
	signal adder_to_PC :std_logic_vector(6 downto 0);
	signal add_to_FBUF: std_logic_vector(6 downto 0);
	
	signal FBUF_PC_out: std_logic_vector(6 downto 0);
	signal FBUF_instr_out: std_logic_vector(15 downto 0);
	
	signal CTRL_TO_REG1 : std_logic_vector(2 downto 0);
	signal CTRL_TO_REG2 : std_logic_vector(2 downto 0);
	

--	--signals for FBUF to REG_FILE
--    signal S_RB: std_logic_vector(2 downto 0);
--    signal S_RC: std_logic_vector(2 downto 0);
--	--alias RA is STD_LOGIC_VECTOR(2 DOWNTO 0);
--	--alias RA: STD_LOGIC_VECTOR(2 DOWNTO 0);
--
--    -- signals for decode to reg file
--    signal index1 : std_logic_vector(2 downto 0);
--    signal index2 : std_logic_vector(2 downto 0);
--
--    -- signals for REG_FILE and DECODE to DBUF
--    SIGNAL S_op_code: std_logic_vector(6 downto 0);
--    signal RA_index_carry : std_logic_vector(2 downto 0);
--   -- signal C1_carry : std_logic_vector(3 downto 0);
    signal Reg_file_data1 : std_logic_vector(15 downto 0);
    signal Reg_file_data2 : std_logic_vector(15 downto 0);
--
--    -- signals for DBUF to ALU
--    signal S_DBUF_op_code : std_logic_vector(6 downto 0);
--    signal S_DBUF_VAL_1 : std_logic_vector(15 downto 0);
--    signal S_DBUF_VAL_2 : std_logic_vector(15 downto 0);
--	 
--	 -- signals from ALU to processor output
--	 signal S_ALU_OUT_1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
--	 signal S_ALU_OUT_2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
--	 
	-- signals from ctrl unit to DBUF 
	SIGNAL S_OUT_CTRL_EX :  STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL S_OUT_CTRL_MEM : STD_LOGIC_VECTOR (3 downto 0);
	SIGNAL S_OUT_CTRL_WB :  STD_LOGIC_VECTOR (3 downto 0);


begin


	-- fetch modules

	PC_adder: counter
    port map (
		PC_IN => PC_to_ROM_add,
    	en_global => enable_PC_Adder,
    	NEXT_PC => adder_to_PC,
		current_pc =>adder_to_FBUF
    );

	PC : PC_module
	port map(
		PC_in => adder_to_PC,
		reset => P_reset,
		en_global => P_enable,
		clk => P_clock,
		PC_out => PC_to_ROM_add,
		out_en => enable_PC_Adder
	);


    I_MEM: ROM_VHDL
    	port map (
			addr => PC_to_ROM_add,
			clk => P_clock,
			data => INSTR_TO_FBUF
		);

	fetch_buffer: FBUF
		port map (
			clk => P_clock,
			reset => P_reset,
			instr_in => INSTR_TO_FBUF,
			PC_in => adder_to_FBUF,
			PC_out => FBUF_PC_out,
			instr_out => FBUF_instr_out
		);


Ctrl_unit: control_unit
    Port map ( 
			clk => P_clock,
			RST   => P_reset,
			IN_CTRL_instr_in => FBUF_instr_out,

			OUT_CTRL_EX => S_OUT_CTRL_EX,
			OUT_CTRL_MEM => S_OUT_CTRL_MEM,
			OUT_CTRL_WB => S_OUT_CTRL_WB,
			OUT_CTRL_R_INDEX1 => CTRL_TO_REG1,
			OUT_CTRL_R_INDEX2 => CTRL_TO_REG2

		);
			


    reg_file: register_file
    	port map (
    		rst  => P_reset,
    		clk => P_clock,

    		rd_address_1 => CTRL_TO_REG1,
    		data_out_1 => Reg_file_data1,

    		rd_address_2 => CTRL_TO_REG2,
    		data_out_2 => Reg_file_data2,

    		wr_address => (others => '0'),
    		data_in => (others => '0'),
    		reg_wr_en => '0'
    	);

    decode_buffer: DBUF
        port map (
                clk => P_clock,
					 reset => P_reset,
				IN_EX => S_OUT_CTRL_EX,
				IN_MEM => S_OUT_CTRL_MEM,
				IN_WB => S_OUT_CTRL_WB,	 
            IN_rb => Reg_file_data1,
            IN_rc => Reg_file_data2,
            IN_instruction => FBUF_instr_out,
				PC_in => FBUF_PC_out,
				
				OUT_EX => OUT_EX,
				OUT_MEM => OUT_MEM,
				OUT_WB => OUT_WB,		
            OUT_rb => P_OUT_VAL_1,
            OUT_rc => P_OUT_VAL_2, 
            OUT_instruction => OUT_INSTRUC,
				PC_out => P_PC_OUT			 
            );
--
--    ALU1: alu
--        Port map
--        (
--            P_IN_rst => P_reset,
--            P_IN_en => P_enable,
--            P_IN_clk => P_clock,
--
--            P_IN_alu_mode => S_DBUF_op_code,
--            P_IN_arg1 => S_DBUF_VAL_1,
--            P_IN_arg2 => S_DBUF_VAL_2,
--            P_OUT_result => dout,   -- result to processor
--            P_OUT_z_flag => P_OUT_z_flag,-- result to processor
--            P_OUT_n_flag => P_OUT_n_flag, -- result to processor
--            P_OUT_p_flag => P_OUT_p_flag -- result to processor
--
--        );

end Behavioral;
