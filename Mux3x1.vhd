----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:28 03/24/2017 
-- Design Name: 
-- Module Name:    Mux3x1 - Behavioral 
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

entity Mux3x1 is
	generic(n1_bits: integer := 16;
			n2_bits: integer := 16;
			n3_bits: integer := 16;
			n4_bits: integer := 16
	);
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);
           a : in  STD_LOGIC_VECTOR (n1_bits-1 downto 0);
           b : in  STD_LOGIC_VECTOR (n2_bits-1 downto 0);
           c : in  STD_LOGIC_VECTOR (n3_bits-1 downto 0);
           x : out  STD_LOGIC_VECTOR (n4_bits-1 downto 0));
end Mux3x1;

architecture Behavioral of Mux3x1 is

begin

	x <= b when (sel = "01") else
		  c when (sel = "10") else
		  a;

end Behavioral;

