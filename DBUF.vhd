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

entity DBUF is
    Port ( clk: in STD_LOGIC ;
            IN_ra: in std_logic_vector(15 downto 0);
            IN_rb: in std_logic_vector(15 downto 0);
			IN_rx : in  STD_LOGIC_VECTOR (2 downto 0);
            IN_op_code: in std_logic_vector(6 downto 0);

            OUT_ra: out std_logic_vector(15 downto 0);
            OUT_rb: out std_logic_vector(15 downto 0);
			OUT_rx : out  STD_LOGIC_VECTOR (2 downto 0);
            OUT_op_code: out std_logic_vector(6 downto 0);
			-- instr_out : out  STD_LOGIC_VECTOR (15 downto 0));
end DBUF;

architecture Behavioral of DBUF is


begin

	process(clk,instr_in)
	begin
		if rising_edge(clk) and clk'event  then

            OUT_ra <= IN_ra;
            OUT_rb <= IN_rb;
            OUT_rx <= IN_rx;
            OUT_op_code <= IN_op_code;
		end if;
	END PROCESS;

end Behavioral;
