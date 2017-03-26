----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:57:07 03/25/2017 
-- Design Name: 
-- Module Name:    decode_test - Behavioral 
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

entity decode_test is
    Port ( instr_out : out  STD_LOGIC_VECTOR (15 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (15 downto 0);
			  P_reset : in  STD_LOGIC;
           P_clock : in  STD_LOGIC;
           P_enable : in std_logic);
end decode_test;

architecture Behavioral of decode_test is


	component Mux2x1 is
		generic(n1_bits: integer := 16;
			n2_bits: integer := 16;
			n3_bits: integer := 16
	);
		 Port ( SEL : IN STD_LOGIC; 
			A : IN std_logic_vector(n1_bits-1 downto 0);
           B : IN std_logic_vector(n2_bits-1 downto 0);
           X : out  STD_LOGIC_VECTOR(n3_bits-1 downto 0));
	end component;

-- fetch stage modules
	component counter  is
	  port(
			reset:	in std_logic;
			PC_IN : IN std_logic_vector(15 downto 0);
			en_global:	in std_logic;
			NEXT_PC:	out std_logic_vector(15 downto 0)

	  );
    end component;
	 
	 component PC_module is
    Port ( PC_in : in  STD_LOGIC_VECTOR (15 downto 0);
           reset : in  STD_LOGIC;
           en_global : in  STD_LOGIC;
			  clk: in std_logic;
           PC_out : out  STD_LOGIC_VECTOR (15 downto 0)
--			  out_en: out std_logic
		  );
	end component;

    component ROM_VHDL IS
    	port (
        	addr: IN std_logic_vector(15 downto 0);
        	clk: IN std_logic;
        	data: OUT std_logic_vector(15 downto 0)
	  );
    END component;

	
	component FBUF is
		Port ( clk: in STD_LOGIC ;
			reset: in std_logic;
			instr_in : in  STD_LOGIC_VECTOR (15 downto 0);
			PC_in : in std_logic_vector(15 downto 0);
			PC_out : out std_logic_vector(15 downto 0);
			instr_out : out  STD_LOGIC_VECTOR (15 downto 0)
			
		);
	end component;


	signal INSTR_TO_FBUF: std_logic_vector(15 downto 0);
	
	signal PC_to_ROM_add : std_logic_vector(15 downto 0);
	
	signal FBUF_OUT_PC: std_logic_vector(15 downto 0);
	signal FBUF_instr_out: std_logic_vector(15 downto 0);

    signal Reg_file_data1 : std_logic_vector(15 downto 0);
    signal Reg_file_data2 : std_logic_vector(15 downto 0);		
	
	
	-- CONNECTIONS FOR PC_MUX
	SIGNAL PC_SEL :  STD_LOGIC;
	SIGNAL PC_FROM_EBUF : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL PC_FROM_ADD :  STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL MUX_TO_PC_MODULE :  STD_LOGIC_VECTOR (15 downto 0);	


begin

PC_SEL <= '0';
PC_FROM_EBUF <= (others => '0');

	MUX_PC: Mux2x1
		generic map(n1_bits => PC_FROM_EBUF'length, n2_bits => PC_FROM_ADD'length, n3_bits => MUX_TO_PC_MODULE'length)
		Port map(
			SEL => PC_SEL, -- comes from FBUF
			A  => PC_FROM_ADD,
			B  =>  PC_FROM_EBUF,
			X  => MUX_TO_PC_MODULE
		);
		
	Adder: counter
    port map (
		reset => P_reset,
		PC_IN => PC_to_ROM_add,
    	en_global => P_enable,
    	NEXT_PC => PC_FROM_ADD
    );

	PC : PC_module
	port map(
		PC_in => MUX_TO_PC_MODULE,
		reset => P_reset,
		en_global => P_enable,
		clk => P_clock,
		PC_out => PC_to_ROM_add
	);


    ROM: ROM_VHDL
    	port map (
			addr => PC_to_ROM_add,
			clk => P_clock,
			data => INSTR_TO_FBUF
		);

	FBUF1: FBUF
		port map (
			clk => P_clock,
			reset => P_reset,
			instr_in => INSTR_TO_FBUF,
			PC_in => PC_FROM_ADD,
			PC_out => pc_out,
			instr_out => instr_out
		);
		


end Behavioral;

