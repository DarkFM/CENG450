----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:01:13 01/24/2011 
-- Design Name: 
-- Module Name:    ROM_128_8 - Behavioral 
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
library ieee ;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;

----------------------------------------------------

entity counter is


port(	
--	clock:	in std_logic;
	reset:	in std_logic;
	PC_IN : IN std_logic_vector(15 downto 0);
	en_global:	in std_logic;
	NEXT_PC:	out std_logic_vector(15 downto 0)
--	current_pc: out std_logic_vector(6 downto 0)
);
end counter;

----------------------------------------------------

architecture behv of counter is		 	  
	
    signal Pre_Q: integer range 0 to 127:= 0 ;

begin

    -- behavior describe the counter

 process(PC_IN, en_global)
    begin
--	 if rising_edge(clock) then
		if reset = '1' then
 	    		Pre_Q <= 0;
--		elsif en_global = '1' then	
		else
			Pre_Q <= Pre_Q + 1;
--		else
--			Pre_Q <= 0;

	   end if;
--	 end if;
 end process;	
 
	 NEXT_PC <= conv_std_logic_vector(Pre_Q,7);
--		current_pc <= PC_IN;
    -- concurrent assignment statement

end behv;


