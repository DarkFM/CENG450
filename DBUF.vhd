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
				IN_EX : in  STD_LOGIC_VECTOR (7 downto 0);
				IN_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
				IN_WB : in  STD_LOGIC_VECTOR (1 downto 0);	 
            IN_ra_index: in std_logic_vector(2 downto 0);
            IN_rb: in std_logic_vector(15 downto 0);
            IN_rc: in std_logic_vector(15 downto 0);
				IN_c1 : in  STD_LOGIC_VECTOR (3 downto 0);
            IN_instruction: in std_logic_vector(15 downto 0);
				PC_in : in std_logic_vector(15 downto 0);
			IN_DISP : in std_logic_vector(15 downto 0);
				
            OUT_ra_index: out std_logic_vector(2 downto 0);
				
				OUT_ALU_EN : OUT STD_LOGIC;
				OUT_ALU2_EN : OUT STD_LOGIC;
				OUT_BRN_SEL : OUT STD_LOGIC;
				OUT_ALU_DISP_SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
				OUT_ALU_MODE : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--				OUT_EX : out  STD_LOGIC_VECTOR (7 downto 0);
				OUT_MEM : out  STD_LOGIC_VECTOR (3 downto 0);
				OUT_WB : out  STD_LOGIC_VECTOR (1 downto 0);
            OUT_rb: out std_logic_vector(15 downto 0);
            OUT_rc: out std_logic_vector(15 downto 0);
				OUT_c1 : out  STD_LOGIC_VECTOR (3 downto 0);
            OUT_instruction: out std_logic_vector(15 downto 0);
				PC_out : out std_logic_vector(15 downto 0);
				OUT_DISP : out std_logic_vector(15 downto 0)
        );
			-- instr_out : out  STD_LOGIC_VECTOR (15 downto 0));
end DBUF;

architecture Behavioral of DBUF is
	alias EX_ALU_EN is IN_EX(7);
	alias EX_ALU2_EN is IN_EX(6);	
	alias EX_ALU_BRN_SEL IS IN_EX(5);
	alias EX_ALU_DISP_SEL IS IN_EX(4 downto 3);	
	alias EX_ALU_MODE IS IN_EX(2 downto 0);
	
begin

	process(clk)
	begin
--	IN_EX <= '0';
--	IN_MEM <= '0';
--	IN_WB <= '0';	
		if rising_edge(clk) then
			if reset = '1' then
--					OUT_EX <= (others => '0');
					OUT_ALU_EN <= '0';
					OUT_ALU2_EN <= '0';
					OUT_BRN_SEL <= '0';
					OUT_ALU_DISP_SEL <= (others => '0');
					OUT_ALU_MODE <= (others => '0');
					OUT_MEM <= (others => '0');
					OUT_WB <= (others => '0');
					OUT_rb <= (others => '0');
					OUT_rc <= (others => '0');
					OUT_instruction <= (others => '0');
					PC_out <= (others => '0');
					OUT_c1 <= (others => '0');
					OUT_ra_index <= (others => '0');
					OUT_DISP <= (OTHERS => '0');
			else
--					OUT_EX <= IN_EX;
					OUT_ALU_EN <= EX_ALU_EN;
					OUT_ALU2_EN <= EX_ALU2_EN;
					OUT_BRN_SEL <= EX_ALU_BRN_SEL;
					OUT_ALU_DISP_SEL <= EX_ALU_DISP_SEL;
					OUT_ALU_MODE <= EX_ALU_MODE;
					OUT_MEM <= IN_MEM;
					OUT_WB <= IN_WB;
					OUT_rb <= IN_rb;
					OUT_rc <= IN_rc;
					OUT_instruction <= IN_instruction;
					PC_out <= PC_in;
					OUT_c1 <= IN_c1;
					OUT_ra_index <= IN_ra_index;
					OUT_DISP <= IN_DISP ;
			end if;
		end if;
	END PROCESS;

end Behavioral;
