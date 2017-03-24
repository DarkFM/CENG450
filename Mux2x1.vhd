----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:29 03/22/2017 
-- Design Name: 
-- Module Name:    Mux2x1 - Behavioral 
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

entity Mux2x1 is
	generic(n1_bits: integer := 16;
			n2_bits: integer := 16;
			n3_bits: integer := 16
	);
    Port ( SEL : IN STD_LOGIC; 
			A : IN std_logic_vector(n1_bits-1 downto 0);
           B : IN std_logic_vector(n2_bits-1 downto 0);
           X : out  STD_LOGIC_VECTOR(n3_bits-1 downto 0));
end Mux2x1;

architecture Behavioral of Mux2x1 is

begin
	X <= A when (SEL = '0') else B;

end Behavioral;

