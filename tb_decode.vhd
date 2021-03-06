--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:00 03/29/2017
-- Design Name:   
-- Module Name:   M:/CENG450/Processor/tb_decode.vhd
-- Project Name:  PROCESSOR2
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
         P_reset : IN  std_logic;
         P_clock : IN  std_logic;
         P_enable : IN  std_logic;
         IN_port : IN  std_logic_vector(15 downto 0);
         OUT_port : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal P_reset : std_logic := '0';
   signal P_clock : std_logic := '0';
   signal P_enable : std_logic := '0';
   signal IN_port : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal OUT_port : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant P_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decode_test PORT MAP (
          P_reset => P_reset,
          P_clock => P_clock,
          P_enable => P_enable,
          IN_port => IN_port,
          OUT_port => OUT_port
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
      wait for 100 ns;	
		P_reset <= '1';
      wait for 105 ns;
		P_reset <= '0';		
		P_enable <= '1';
		IN_port	<= X"0101";	-- r1
      wait for P_clock_period*5;
		IN_port	<= X"0001"; -- r2
      wait for P_clock_period*1;
		IN_port	<= X"0AAA"; -- r3
      wait for P_clock_period*30;		
--		P_enable <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
