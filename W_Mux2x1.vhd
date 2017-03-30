----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:42 03/27/2017 
-- Design Name: 
-- Module Name:    Wr_En_Mux2x1 - Behavioral 
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

entity Wr_En_Mux2x1 is
    Port ( SEL : in  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           X : out  STD_LOGIC);
end Wr_En_Mux2x1;

architecture Behavioral of Wr_En_Mux2x1 is

begin
	X <= A when (SEL = '0') else B;

end Behavioral;

