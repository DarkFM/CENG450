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
				IN_EX : in  STD_LOGIC_VECTOR (4 downto 0);
				IN_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
				IN_WB : in  STD_LOGIC_VECTOR (3 downto 0);	 
            --IN_ra_index: in std_logic_vector(2 downto 0);
            IN_rb: in std_logic_vector(15 downto 0);
            IN_rc: in std_logic_vector(15 downto 0);
				--IN_c1 : in  STD_LOGIC_VECTOR (3 downto 0);
            IN_op_code: in std_logic_vector(6 downto 0);
				--PC_in : in std_logic_vector(15 downto 0)
				--PC_out : out std_logic_vector(15 downto 0)
            --OUT_ra_index: out std_logic_vector(2 downto 0);
				OUT_EX : out  STD_LOGIC_VECTOR (4 downto 0);
				OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
				OUT_WB : out  STD_LOGIC_VECTOR (3 downto 0);
            OUT_rb: out std_logic_vector(15 downto 0);
            OUT_rc: out std_logic_vector(15 downto 0);
				--OUT_c1 : out  STD_LOGIC_VECTOR (3 downto 0);
            OUT_op_code: out std_logic_vector(6 downto 0)
        );
			-- instr_out : out  STD_LOGIC_VECTOR (15 downto 0));
end DBUF;

architecture Behavioral of DBUF is


begin

	process(clk)
	begin
		if rising_edge(clk) then
				OUT_EX <= IN_EX;
				OUT_MEM <= IN_MEM;
				OUT_WB <= IN_WB;
            OUT_rb <= IN_rb;
            OUT_rc <= IN_rc;
            OUT_op_code <= IN_op_code;
		end if;
	END PROCESS;

end Behavioral;
