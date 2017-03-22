----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    20:35:15 03/08/2017
-- Design Name:
-- Module Name:    FBUF - Behavioral
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

entity FBUF is
    Port ( clk: in STD_LOGIC ;
			reset: in std_logic;
			instr_in : in  STD_LOGIC_VECTOR (15 downto 0);
			PC_in : in std_logic_vector(6 downto 0);
			PC_out : out std_logic_vector(6 downto 0);
			instr_out : out  STD_LOGIC_VECTOR (15 downto 0));
end FBUF;

architecture Behavioral of FBUF is


begin

	process(clk,instr_in,PC_in)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				instr_out <= (others => '0');
				PC_out <= (others => '0');			
			else 
				instr_out <= instr_in;
				PC_out <= PC_in;
			end if;
		end if;
	END PROCESS;

end Behavioral;
