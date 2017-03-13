library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


------------------------------------------------------------------------------------------------------------
entity alu is
	Port
	(
		P_IN_rst : in std_logic;
		P_IN_en : in std_logic;
		P_IN_clk : in std_logic;

		P_IN_alu_mode : in std_logic_vector(6 downto 0);
		P_IN_arg1 : in std_logic_vector(15 downto 0);
		P_IN_arg2 : in std_logic_vector(15 downto 0);
		P_OUT_result : out std_logic_vector(15 downto 0);
		P_OUT_z_flag : out std_logic;
		P_OUT_n_flag : out std_logic;
		P_OUT_p_flag : out std_logic
		-- could add:
			-- unsigned overflow flag
			-- signed overflow flag
			-- parity flag
	);
end alu;

------------------------------------------------------------------------------------------------------------
architecture alu of alu is
begin
	process(P_IN_clk)
		-- this will create a 3 bit signal
		variable int_ALU_MODE : integer range 0 to 127;
	begin
		if rising_edge(P_IN_clk) then
			if (P_IN_rst = '1') then
				P_OUT_result <= (others => '0');
				P_OUT_z_flag <= '0';
				P_OUT_n_flag <= '0';
				P_OUT_p_flag <= '0';
			elsif (P_IN_en = '1') then
				int_ALU_MODE := to_integer(unsigned(P_IN_alu_mode));

				case int_ALU_MODE is
					when 0 =>
						-- !!! should never happen; would like to throw an exception here !!!
						null;
					when 1 => P_OUT_result <= std_logic_vector(unsigned(P_IN_arg1) + unsigned(P_IN_arg2));
					when 2 => P_OUT_result <= std_logic_vector(unsigned(P_IN_arg1) - unsigned(P_IN_arg2));
					when 3 => P_OUT_result <= std_logic_vector(resize(unsigned(P_IN_arg1) * unsigned(P_IN_arg2), 16));
					when 4 => P_OUT_result <= P_IN_arg1 nand P_IN_arg2;
					when 5 => P_OUT_result <= std_logic_vector(shift_left(unsigned(P_IN_arg1), to_integer(unsigned(P_IN_arg2))));
					when 6 => P_OUT_result <= std_logic_vector(shift_right(unsigned(P_IN_arg1), to_integer(unsigned(P_IN_arg2))));
					when 7 =>
						-- zero flag
						if (P_IN_arg1 = X"0000") then
							P_OUT_z_flag <= '1';
						else
							P_OUT_z_flag <= '0';
						end if;
						-- negative flag
						if (P_IN_arg1(15) = '1') then
							P_OUT_n_flag <= '1';
						else
							P_OUT_n_flag <= '0';
						end if;
						-- positive flag
						if ((P_IN_arg1(15) = '0') and (P_IN_arg1 /= X"0000")) then
							P_OUT_p_flag <= '1';
						else
							P_OUT_p_flag <= '0';
						end if;
					when others => null;
				end case;
			end if;
		end if;
	end process;
end alu;
