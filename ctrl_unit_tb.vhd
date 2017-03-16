--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:34:13 03/11/2017
-- Design Name:   
-- Module Name:   M:/CENG450/testing/processor/ctrl_unit_tb.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control_unit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ctrl_unit_tb IS
END ctrl_unit_tb;
 
ARCHITECTURE behavior OF ctrl_unit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_unit
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         IN_CTRL_instr_in : IN  std_logic_vector(15 downto 0);
         OUT_OP_CODE : OUT  std_logic_vector(6 downto 0);
         OUT_CTRL_EX : OUT  std_logic_vector(4 downto 0);
         OUT_CTRL_MEM : OUT  std_logic_vector(3 downto 0);
         OUT_CTRL_WB : OUT  std_logic_vector(3 downto 0);
         rd_index1 : OUT  std_logic_vector(2 downto 0);
         rd_index2 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal IN_CTRL_instr_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OUT_OP_CODE : std_logic_vector(6 downto 0);
   signal OUT_CTRL_EX : std_logic_vector(4 downto 0);
   signal OUT_CTRL_MEM : std_logic_vector(3 downto 0);
   signal OUT_CTRL_WB : std_logic_vector(3 downto 0);
   signal rd_index1 : std_logic_vector(2 downto 0);
   signal rd_index2 : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control_unit PORT MAP (
          CLK => CLK,
          RST => RST,
          IN_CTRL_instr_in => IN_CTRL_instr_in,
          OUT_OP_CODE => OUT_OP_CODE,
          OUT_CTRL_EX => OUT_CTRL_EX,
          OUT_CTRL_MEM => OUT_CTRL_MEM,
          OUT_CTRL_WB => OUT_CTRL_WB,
          rd_index1 => rd_index1,
          rd_index2 => rd_index2
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;
		RST <= '0';		
      wait for CLK_period*10;
		IN_CTRL_instr_in <= "0000001011010001";
		wait for CLK_period*1;
		IN_CTRL_instr_in <= "0000001101011010";
		wait for CLK_period*1;
		IN_CTRL_instr_in <= "0000001101011010";
		wait for CLK_period*1;
		IN_CTRL_instr_in <= "0000001101011010";				
      -- insert stimulus here 

      wait;
   end process;

END;
