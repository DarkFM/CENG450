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
				reset: in std_logic;
				IN_EX : in  STD_LOGIC_VECTOR (5 downto 0);
				IN_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
				IN_WB : in  STD_LOGIC_VECTOR (1 downto 0);	 
            IN_ra_index: in std_logic_vector(2 downto 0);
            IN_rb: in std_logic_vector(15 downto 0);
            IN_rc: in std_logic_vector(15 downto 0);
				IN_c1 : in  STD_LOGIC_VECTOR (3 downto 0);
            IN_instruction: in std_logic_vector(15 downto 0);
				PC_in : in std_logic_vector(15 downto 0);
				
            OUT_ra_index: out std_logic_vector(2 downto 0);
				OUT_EX : out  STD_LOGIC_VECTOR (5 downto 0);
				OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
				OUT_WB : out  STD_LOGIC_VECTOR (1 downto 0);
            OUT_rb: out std_logic_vector(15 downto 0);
            OUT_rc: out std_logic_vector(15 downto 0);
				OUT_c1 : out  STD_LOGIC_VECTOR (3 downto 0);
            OUT_instruction: out std_logic_vector(15 downto 0);
				PC_out : out std_logic_vector(15 downto 0)
        );
			-- instr_out : out  STD_LOGIC_VECTOR (15 downto 0));
end DBUF;

architecture Behavioral of DBUF is


begin

	process(clk)
	begin
--	IN_EX <= '0';
--	IN_MEM <= '0';
--	IN_WB <= '0';	
		if rising_edge(clk) then
			if reset = '1' then
					OUT_EX <= (others => '0');
					OUT_MEM <= (others => '0');
					OUT_WB <= (others => '0');
					OUT_rb <= (others => '0');
					OUT_rc <= (others => '0');
					OUT_instruction <= (others => '0');
					PC_out <= (others => '0');
					OUT_c1 <= (others => '0');
					OUT_ra_index <= (others => '0');
			else
					OUT_EX <= IN_EX;
					OUT_MEM <= IN_MEM;
					OUT_WB <= IN_WB;
					OUT_rb <= IN_rb;
					OUT_rc <= IN_rc;
					OUT_instruction <= IN_instruction;
					PC_out <= PC_in;
					OUT_c1 <= IN_c1;
					OUT_ra_index <= IN_ra_index;
			end if;
		end if;
	END PROCESS;

end Behavioral;
