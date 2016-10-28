library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

use ieee.std_logic_textio.all;
use std.textio.all;

entity memory is
	port (
		clock_in: in std_logic;
		reset_in: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(15 downto 0);
		address_in : in std_logic_vector(7 downto 0);
		write_enable: in std_logic
	);
end memory;
architecture arch_memory of memory is
	type ram_type is array(65535 downto 0) of std_logic_vector(7 downto 0);
	type char_file_type is file of character;
	signal ram : ram_type := (others => (others => '0'));

begin

	process(clock_in)
		variable data :  std_logic_vector(7 downto 0);
		variable char_buffer: character;
		variable file_line: line;
		variable index : natural := 0;
		file load_file : char_file_type open read_mode is "code.mem";
	begin
		--mem load from file
		if index = 0 then
			while not endfile(load_file) loop
				read(load_file, char_buffer);
				if index > 3 then --skip header
					ram(conv_integer(index-4)) <= std_logic_vector(to_unsigned(character'POS(char_buffer), 8));
					read(load_file, char_buffer); --skip a byte
				end if;
				index := index + 1;
			end loop;
		end if;

		--mem access
		if reset_in = '1' then
			data_out <= (others => '0');
		elsif clock_in'event and clock_in = '1' then
			if write_enable = '1' then
				ram(conv_integer(address_in)) <= data_in;
			else
				data_out <= ram(conv_integer(address_in)) & ram(conv_integer(address_in) + 1);
			end if;
		end if;
	end process;
end arch_memory;
