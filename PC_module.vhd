----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:15 03/16/2017 
-- Design Name: 
-- Module Name:    PC_module - Behavioral 
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

entity PC_module is
    Port ( PC_in : in  STD_LOGIC_VECTOR (6 downto 0);
           reset : in  STD_LOGIC;
           en_global : in  STD_LOGIC;
			  clk: in std_logic;
           PC_out : out  STD_LOGIC_VECTOR (6 downto 0);
			  out_en: out std_logic
		  );
end PC_module;

architecture Behavioral of PC_module is
	signal temp_pc : STD_LOGIC_VECTOR (6 downto 0):= (others => '0'); 

begin

--	PC_out <= "0000000";
	
process(clk) begin

	if falling_edge(clk) then
		if(reset = '1') then
			temp_pc <= (others => '0'); 
			out_en <= '0';
		elsif(en_global = '1') then
			temp_pc <= PC_in;
			out_en <= en_global;
		end if;
	end if;
end process;

	PC_out <= temp_pc;


end Behavioral;

