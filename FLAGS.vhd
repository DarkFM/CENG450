----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:35:42 03/26/2017 
-- Design Name: 
-- Module Name:    FLAGS - Behavioral 
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

entity FLAGS is
    Port ( DATA_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           Z_FLAG : out  STD_LOGIC;
           N_FLAG : out  STD_LOGIC;
           ENABLE : in  STD_LOGIC
		  );
end FLAGS;

architecture Behavioral of FLAGS is

	signal data :  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal z :  STD_LOGIC := '0';
	signal n :  STD_LOGIC := '0';
begin
	
		data <= DATA_IN;
		
		
		process(ENABLE,DATA_IN) begin
		
			if(ENABLE = '1') then
			
				if (data = X"0000") then
					z <= '1';
				else
					z <= '0';
				end if;
				
				-- negative flag
				if (data(15) = '1') then
					n <= '1';
				else
					n <= '0';
				end if;
				
			else
				z <= '0';
				n <= '0';
			end if;
		
		end process;
		
		Z_FLAG <= z;
		N_FLAG <= n;
--		with data select
--			Z_FLAG <= 
--			'1' when X"0000",
--			'0' when others;			
--			
--		with data(15) select
--			N_FLAG <= 
--			'1' when  '1',
--			'0' when others;
--			
		
--		if (data = X"0000") then
--			Z_FLAG <= '1';
--		else
--			Z_FLAG <= '0';
--		end if;
--		-- negative flag
--		if (data(15) = '1') then
--			N_FLAG <= '1';
--		else
--			N_FLAG <= '0';
--		end if;


end Behavioral;

