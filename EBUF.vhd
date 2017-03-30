----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:32 03/24/2017 
-- Design Name: 
-- Module Name:    EBUF - Behavioral 
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

entity EBUF is
    Port ( 
				clk: in STD_LOGIC;
				reset: IN STD_LOGIC;
				
				IN_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
           IN_WB : in  STD_LOGIC_VECTOR (1 downto 0);
           IN_ALU_RESULT : in  STD_LOGIC_VECTOR (15 downto 0);
           IN_Z_FLAG : in  STD_LOGIC;
           IN_N_FLAG : in  STD_LOGIC;
           IN_BRN_Z_FLAG : in  STD_LOGIC;
           IN_BRN_N_FLAG : in  STD_LOGIC;			  
           IN_DATA2 : in  STD_LOGIC_VECTOR (15 downto 0);
           IN_RA_INDEX : in  STD_LOGIC_VECTOR (2 downto 0);
			  
--           OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
			  OUT_MEM_WR_EN : OUT STD_LOGIC;
			  OUT_MEM_READ_EN: OUT STD_LOGIC;
			  OUT_MEM_Z_CHECK: OUT STD_LOGIC;
			  OUT_MEM_N_CHECK: OUT STD_LOGIC;
           OUT_WB : out  STD_LOGIC_VECTOR (1 downto 0);
           OUT_ALU_RESULT : out  STD_LOGIC_VECTOR (15 downto 0);
           OUT_Z_FLAG : out  STD_LOGIC;
           OUT_N_FLAG : out  STD_LOGIC;
           OUT_BRN_Z_FLAG : out  STD_LOGIC;
           OUT_BRN_N_FLAG : out  STD_LOGIC;					  
           OUT_DATA2 : out  STD_LOGIC_VECTOR (15 downto 0);			  
           OUT_RA_INDEX : out  STD_LOGIC_VECTOR (2 downto 0));
end EBUF;

architecture Behavioral of EBUF is
	alias MEM_WR_EN is IN_MEM(3);
	alias MEM_READ_EN IS IN_MEM(2);
	alias MEM_Z_CHECK is IN_MEM(1);
	alias MEM_N_CHECK is IN_MEM(0);


begin

	process(clk) begin
	
		if rising_edge(clk) then
			if reset = '1' then
--			  OUT_MEM <= (others => '0');
           OUT_WB <= (others => '0');
           OUT_ALU_RESULT <= (others => '0') ;
           OUT_Z_FLAG <= '0';
           OUT_N_FLAG <= '0';
			  OUT_DATA2 <= (others => '0');
           OUT_RA_INDEX <= (others => '0');
           OUT_BRN_Z_FLAG <= '0';
           OUT_BRN_N_FLAG <= '0';
			  OUT_MEM_WR_EN <= '0';
			  OUT_MEM_READ_EN <= '0';	
			  OUT_MEM_Z_CHECK <= '0';
			  OUT_MEM_N_CHECK <= '0';
		  else
--			  OUT_MEM <= IN_MEM;
			  OUT_MEM_WR_EN <= MEM_WR_EN;
			  OUT_MEM_READ_EN <= MEM_READ_EN;
			  OUT_MEM_Z_CHECK	<= MEM_Z_CHECK;
			  OUT_MEM_N_CHECK <= MEM_N_CHECK;
           OUT_WB <= IN_WB;
           OUT_ALU_RESULT <= IN_ALU_RESULT;
           OUT_Z_FLAG <= IN_Z_FLAG;
           OUT_N_FLAG <= IN_N_FLAG;
			  OUT_BRN_Z_FLAG <= IN_BRN_Z_FLAG;
           OUT_BRN_N_FLAG <= IN_BRN_N_FLAG;
			  OUT_DATA2 <= IN_DATA2;
           OUT_RA_INDEX <= IN_RA_INDEX;
		  end if;
	  end if;
  end process;


end Behavioral;

