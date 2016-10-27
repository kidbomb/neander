library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity tb is
	generic(
		address_width: integer := 16
	);
end tb;
architecture tb of tb is
	signal clock, reset, write_enable: std_logic;
	signal data_neander_to_memory, address_neander_to_memory: std_logic_vector(7 downto 0);
	signal data_memory_to_neander: std_logic_vector(15 downto 0);
begin

	--clock
	process
	begin
		clock <= '0';
		wait for 20 ns;
		clock <= '1';
		wait for 20 ns;
	end process;

	reset <= '0', '1' after 20 ns, '0' after 40 ns;
	
	neander_ent: entity work.neander
	port map (
		clock_in	=>	clock,
		reset_in   	=>	reset,
		data_in		=>	data_memory_to_neander,
		data_out	=>	data_neander_to_memory,
		address_out	=>	address_neander_to_memory,
		write_enable_out=>	write_enable
	);

	memory_ent: entity work.memory
	port map (
		clock_in	=>	clock,
		reset_in   	=>	reset,
		data_in		=>	data_neander_to_memory,
		data_out	=>	data_memory_to_neander,
		address_in	=>	address_neander_to_memory,
		write_enable	=>	write_enable
	);
	
end tb;

