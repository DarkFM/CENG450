library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------------------------------------------
entity register_file is
	port
	(
		rst : in std_logic;
		clk : in std_logic;

		rd_address_1: in std_logic_vector(2 downto 0);
		data_out_1: out std_logic_vector(15 downto 0);

		rd_address_2: in std_logic_vector(2 downto 0);
		data_out_2: out std_logic_vector(15 downto 0);

		wr_address: in std_logic_vector(2 downto 0);
		data_in: in std_logic_vector(15 downto 0);
		reg_wr_en: in std_logic
	);
end register_file;

------------------------------------------------------------------------------------------------------------
architecture register_file of register_file is

	type T_reg_array is array (integer range 0 to 7) of std_logic_vector(15 downto 0); -- try without "integer range"
	signal S_reg_file : T_reg_array := (X"000F", X"0011",X"0022", X"0033", X"0044", X"0055", X"0066", X"0077") ;
	
begin
	--write operation
	process(clk) begin
		if rising_edge(clk) then
			if(rst = '1') then
				-- this zeores out the array
				--for i in 0 to 7 loop
					--S_reg_file(i) <= (others => '0');
				--end loop;
				S_reg_file<= (X"000F", X"0011",X"0022", X"0033", X"0044", X"0055", X"0066", X"0077") ;
			elsif(reg_wr_en = '1') then
				case wr_address(2 downto 0) is
					-- can probably just change this to use an array index like RAM
					when "000" => S_reg_file(0) <= data_in;
					when "001" => S_reg_file(1) <= data_in;
					when "010" => S_reg_file(2) <= data_in;
					when "011" => S_reg_file(3) <= data_in;
					when "100" => S_reg_file(4) <= data_in;
					when "101" => S_reg_file(5) <= data_in;
					when "110" => S_reg_file(6) <= data_in;
					when "111" => S_reg_file(7) <= data_in;
					when others => NULL;
				end case;
			end if;
		end if;
	end process;

	--read operation
	data_out_1 <=
		S_reg_file(0) when(rd_address_1="000") else
		S_reg_file(1) when(rd_address_1="001") else
		S_reg_file(2) when(rd_address_1="010") else
		S_reg_file(3) when(rd_address_1="011") else
		S_reg_file(4) when(rd_address_1="100") else
		S_reg_file(5) when(rd_address_1="101") else
		S_reg_file(6) when(rd_address_1="110") else
		S_reg_file(7);

	data_out_2 <=
		S_reg_file(0) when(rd_address_2="000") else
		S_reg_file(1) when(rd_address_2="001") else
		S_reg_file(2) when(rd_address_2="010") else
		S_reg_file(3) when(rd_address_2="011") else
		S_reg_file(4) when(rd_address_2="100") else
		S_reg_file(5) when(rd_address_2="101") else
		S_reg_file(6) when(rd_address_2="110") else
		S_reg_file(7);

end register_file;
