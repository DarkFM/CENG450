--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:50:02 03/25/2017
-- Design Name:   
-- Module Name:   /home/cbest/CENG450/Processor/processor_test.vhd
-- Project Name:  processor_proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processor
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
 
ENTITY processor_test IS
END processor_test;
 
ARCHITECTURE behavior OF processor_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processor
    PORT(
         IN_port : IN  std_logic_vector(15 downto 0);
         OUT_port : OUT  std_logic_vector(15 downto 0);
         P_reset : IN  std_logic;
         P_clock : IN  std_logic;
         P_enable : IN  std_logic;
         P_OUT_C1 : OUT  std_logic_vector(3 downto 0);
         dout : OUT  std_logic_vector(15 downto 0);
         P_OUT_z_flag : OUT  std_logic;
         P_OUT_n_flag : OUT  std_logic;
         OUT_MEM : OUT  std_logic_vector(3 downto 0);
         OUT_WB : OUT  std_logic_vector(1 downto 0);
         OUT_INSTRUC : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal IN_port : std_logic_vector(15 downto 0) := (others => '0');
   signal P_reset : std_logic := '0';
   signal P_clock : std_logic := '0';
   signal P_enable : std_logic := '0';

 	--Outputs
   signal OUT_port : std_logic_vector(15 downto 0);
   signal P_OUT_C1 : std_logic_vector(3 downto 0);
   signal dout : std_logic_vector(15 downto 0);
   signal P_OUT_z_flag : std_logic;
   signal P_OUT_n_flag : std_logic;
   signal OUT_MEM : std_logic_vector(3 downto 0);
   signal OUT_WB : std_logic_vector(1 downto 0);
   signal OUT_INSTRUC : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant P_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          IN_port => IN_port,
          OUT_port => OUT_port,
          P_reset => P_reset,
          P_clock => P_clock,
          P_enable => P_enable,
          P_OUT_C1 => P_OUT_C1,
          dout => dout,
          P_OUT_z_flag => P_OUT_z_flag,
          P_OUT_n_flag => P_OUT_n_flag,
          OUT_MEM => OUT_MEM,
          OUT_WB => OUT_WB,
          OUT_INSTRUC => OUT_INSTRUC
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
      wait for P_clock_period*20;	
		P_enable <= '0';
      wait for P_clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
