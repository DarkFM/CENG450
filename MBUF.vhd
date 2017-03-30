----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:20 03/29/2017 
-- Design Name: 
-- Module Name:    MBUF - Behavioral 
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

entity MBUF is
    Port ( IN_WB : in  STD_LOGIC_VECTOR (1 downto 0);
           IN_DATA_RD : in  STD_LOGIC_VECTOR (15 downto 0);
           IN_ADDR : in  STD_LOGIC_VECTOR (15 downto 0);
           RA_INDEX : in  STD_LOGIC_VECTOR (2 downto 0);
           OUT_ADDR : out  STD_LOGIC_VECTOR (15 downto 0);
           OUT_DATA_RD : out  STD_LOGIC_VECTOR (15 downto 0);
           OUT_RA_INDEX : out  STD_LOGIC_VECTOR (2 downto 0);
           OUT_WR_EN : out  STD_LOGIC;
           OUT_WB_MUX_SEL : out  STD_LOGIC;
			  clk: in STD_LOGIC;
			  reset: IN STD_LOGIC);
end MBUF;

architecture Behavioral of MBUF is

	alias WB_WRITE_EN IS IN_WB(1);
	alias WB_MUX_SEL IS IN_WB(0);

begin

	process(clk) begin
		if rising_edge(clk) then
			if reset = '1' then
			  OUT_ADDR <= (others => '0');
           OUT_DATA_RD <= (others => '0');
           OUT_RA_INDEX <= (others => '0');
           OUT_WR_EN <= '0';
           OUT_WB_MUX_SEL <= '0';
		  else
			  OUT_ADDR <= IN_ADDR;
           OUT_DATA_RD <= IN_DATA_RD;
           OUT_RA_INDEX <= RA_INDEX;
           OUT_WR_EN <= WB_WRITE_EN;
           OUT_WB_MUX_SEL <= WB_MUX_SEL;
		  end if;
	  end if;
	END PROCESS;

end Behavioral;

