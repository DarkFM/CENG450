----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:54 03/27/2017 
-- Design Name: 
-- Module Name:    OUT_BOX - Behavioral 
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

entity OUT_BOX is
    Port ( OUT_REG_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           OUT_REG_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
			  ENABLE: IN STD_LOGIC);
end OUT_BOX;

architecture Behavioral of OUT_BOX is

signal data : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
begin

	process(ENABLE,OUT_REG_IN) begin

		if(ENABLE = '1') then
			data <= OUT_REG_IN;
		else
			data <= (others => '0');
		end if;
		
	end process;
	
	OUT_REG_OUT <= data ;
	
end Behavioral;

