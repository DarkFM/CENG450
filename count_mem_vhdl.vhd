library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count_mem is
    Port ( clk : in std_logic;
		 reset:	in std_logic;
		 en:	in std_logic;
           dout: out std_logic_vector(7 downto 0));
end count_mem;

architecture Behavioral of count_mem is

    component counter  is
        port(	clock:	in std_logic;
        	reset:	in std_logic;
        	en:	in std_logic;
        	Q:	out std_logic_vector(6 downto 0)
        );
    end component;

    component ROM_VHDL IS
    	port (
        	addr: IN std_logic_vector(6 downto 0);
        	clk: IN std_logic;
        	data: OUT std_logic_vector(7 downto 0)
        );
    END component;

    signal count_out: std_logic_vector(6 downto 0);
    signal alu_mode_signal: std_logic_vector(2 downto 0);
    signal alu_arg_1:std_logic_vector(2 downto 0); 
    signal alu_arg_2:std_logic_vector(2 downto 0); 
	
    begin

    u0: counter
    port map(
        clock => clk,
    	reset => reset,
    	en => en,
    	Q => count_out
    );

    rom1: ROM_VHDL
    	port map(
    	addr => count_out,
    	clk => clk,
    	data => dout);

    
end Behavioral;
