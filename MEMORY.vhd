----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:54 03/27/2017 
-- Design Name: 
-- Module Name:    MEMORY - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMORY is
    Port ( rst : in std_logic;
			  mem_write_en : in  STD_LOGIC;
           mem_read_en : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (15 downto 0);
--				address : in  unsigned(15 downto 0);
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end MEMORY;

architecture Behavioral of MEMORY is
type memory_array is array (integer range 0 to 255) of std_logic_vector(7 downto 0); -- try without "integer range"
	signal S_mem_file : memory_array;
	
	 constant mem_content : memory_array := (
					others => "00000000");

begin
	write_process: process(mem_write_en,rst,address,data_in,mem_read_en)
			variable msb,lsb : std_logic_vector(7 downto 0) := (others=> '0');
	begin
				if(rst = '1') then
					-- this zeores out the array
					for i in 0 to 255 loop
						S_mem_file(i) <= (others => '0');
					end loop;
					msb := x"00";
					lsb := x"00";
				elsif(mem_write_en = '1') then
					msb := data_in(15 downto 8);
					lsb := data_in(7 downto 0);
					S_mem_file(to_integer(unsigned(address))) <= lsb;
					S_mem_file(to_integer(unsigned(address)) + 1) <= msb;
				elsif(mem_read_en = '1') then
					lsb := S_mem_file(to_integer(unsigned(address)));
					msb := S_mem_file(to_integer(unsigned(address)) + 1);
				end if;
					data_out <= msb & lsb;


	end process;
	
--	read_process: process(mem_read_en,rst,address,data_in) 
--		
--		variable msb,lsb : std_logic_vector(7 downto 0) := (others=> '0');
--	
--		begin
--		if(rst = '1') then
----			data_out <= (others => '0');
--			msb := x"00";
--			lsb := x"00";
--		elsif(mem_read_en = '1') then
----			data_out <= S_mem_file(conv_integer(unsigned(address)));
--			lsb := S_mem_file(to_integer(unsigned(address)));
--			msb := S_mem_file(to_integer(unsigned(address)) + 1);
--		end if;
--		data_out <= msb & lsb;
--	end process;

end Behavioral;

