--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:03:36 03/25/2017
-- Design Name:   
-- Module Name:   /home/cbest/CENG450/Processor/tb_decode.vhd
-- Project Name:  processor_proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decode_test
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
 
ENTITY tb_decode IS
END tb_decode;
 
ARCHITECTURE behavior OF tb_decode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decode_test
    PORT(
         instr_out : OUT  std_logic_vector(15 downto 0);
         pc_out : OUT  std_logic_vector(15 downto 0);
         P_reset : IN  std_logic;
         P_clock : IN  std_logic;
         P_enable : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal P_reset : std_logic := '0';
   signal P_clock : std_logic := '0';
   signal P_enable : std_logic := '0';

 	--Outputs
   signal instr_out : std_logic_vector(15 downto 0);
   signal pc_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant P_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decode_test PORT MAP (
          instr_out => instr_out,
          pc_out => pc_out,
          P_reset => P_reset,
          P_clock => P_clock,
          P_enable => P_enable
        );

   -- Clock process definitions
   P_clock_process :process
   begin
		P_clock <= '0';
		wait for P_clock_period/2;
		P_clock <= '1';
		wait for P_clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--		P_reset <= '1';
--      wait for 105 ns;
--		P_reset <= '0';		
		P_enable <= '1';		
      wait for P_clock_period*20;	
		P_enable <= '0';
      wait for P_clock_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
