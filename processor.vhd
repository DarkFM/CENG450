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
           reset : in  STD_LOGIC;
           clock : in  STD_LOGIC;
				en	: in std_logic;
           dout: out std_logic_vector(15 downto 0);
			  op_code: out std_logic_vector(6 downto 0);
				OUT_VAL_1 : out std_logic_vector(15 downto 0);
				OUT_VAL_2 : out std_logic_vector(15 downto 0);
				OUT_C1 : out std_logic_vector(3 downto 0)
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
			write_en : in std_logic;
			write_address: in std_logic_vector(2 downto 0);
			data_in : std_logic_vector(15 downto 0);
			clk : in std_logic;
			reset : in std_logic;

			OP_CODE : out std_logic_vector(6 downto 0);

			-- needed for A instruvctions
			OUT_VAL_1 : out std_logic_vector(15 downto 0);
			OUT_VAL_2 : out std_logic_vector(15 downto 0);

			-- needed for the shift offset
			OUT_C1 : out std_logic_vector(3 downto 0)

		);
	end component;
	 
	signal PC_out: std_logic_vector(6 downto 0);
	signal INSTR_TO_FBUF: std_logic_vector(15 downto 0);
	signal FBUF_TO_DECODE: std_logic_vector(15 downto 0);
	
	--signals for FBUF to REG_FILE
--	SIGNAL op_code: std_logic_vector(6 downto 0);
	--alias RA is STD_LOGIC_VECTOR(2 DOWNTO 0);
	--alias RA: STD_LOGIC_VECTOR(2 DOWNTO 0);


begin

	PC: counter
    port map(
		clock => clock,
    	reset => reset,
    	en => en,
    	Q => PC_out
    );

    I_MEM: ROM_VHDL
    	port map(
			addr => PC_out,
			clk => clock,
			data => INSTR_TO_FBUF
		);
			
	fetch_buffer: FBUF
		port map(
			clk => clock,
			instr_in => INSTR_TO_FBUF,
			instr_out => FBUF_TO_DECODE
		); 	

	decode: decode_stage
	Port map
	(
		instr_in => FBUF_TO_DECODE,
		write_en => '0',
		write_address => (others => '0'),
		data_in => (others => '0'),
		clk => clock,
		reset => reset,

		OP_CODE => op_code,

		-- needed for A instruvctions
		OUT_VAL_1 => OUT_VAL_1,
		OUT_VAL_2 =>OUT_VAL_2,
		
		-- needed for the shift offset
		OUT_C1 => OUT_C1

	);

end Behavioral;

