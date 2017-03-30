----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:33:04 03/28/2017 
-- Design Name: 
-- Module Name:    holding_reg - Behavioral 
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

entity holding_reg is
    Port ( n_flag : in  STD_LOGIC;
           z_flag : in  STD_LOGIC;
           z_check : in  STD_LOGIC;
           n_check : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           out_pc_sel : out  STD_LOGIC);
end holding_reg;

architecture Behavioral of holding_reg is

signal z_flag_hold : std_logic := '0';
signal n_flag_hold : std_logic := '0';

begin

process(clk, n_flag, z_flag) begin
	if rising_edge(clk) then
		z_flag_hold <= z_flag;
		n_flag_hold <= n_flag;
	end if;
end process;

out_pc_sel <= (z_flag_hold and z_check) or (n_flag_hold and n_check);

end Behavioral;

