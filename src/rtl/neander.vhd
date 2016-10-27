library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity neander is
	port (
		clock_in: in std_logic;
		reset_in: in std_logic;
		data_in: in std_logic_vector(15 downto 0);
		data_out: out std_logic_vector(7 downto 0);
		address_out : out std_logic_vector(7 downto 0);
		write_enable_out: out std_logic
	);
end neander;

architecture arch_neander of neander is

	signal pc: std_logic_vector(7 downto 0);
	signal ac: std_logic_vector(7 downto 0);
	signal n: std_logic;
	signal z: std_logic;

	signal address_write_out: std_logic_vector(7 downto 0);

	signal write_enable: std_logic;

begin
	--pipeline
	process(clock_in)
	begin	
		if reset_in = '1' then
			pc <= (others => '0');
		elsif clock_in'event and clock_in = '1' then
			pc <= pc + 2;
		end if;
	end process;

	--instruction fetch
	process(clock_in)
	begin
		if reset_in = '1' then
			write_enable <= '0';
			data_out <= (others => '0');
			ac <= (others => '0');
			n <= '0';
			z <= '1';
			address_write_out <= (others => '0');
		elsif clock_in'event and clock_in = '1' then
	
			case data_in(15 downto 8) is --TODO: use mask & 240
				when "00000000" => --NOP
					write_enable <= '0';
					data_out <= (others => '0');
					address_write_out <= (others => '0');
				when "00010000" => --STA
					write_enable <= '1';
					data_out <= ac;
					address_write_out <= data_in(7 downto 0);
				when "00100000" => --LDA
					write_enable <= '0';
					data_out <= (others => '0');
					address_write_out <= (others => '0');
					ac <= data_in(7 downto 0);
				when "00110000" => --ADD
					write_enable <= '0';
					data_out <= (others => '0');
					address_write_out <= (others => '0');
					ac <= ac + data_in(7 downto 0); 

					if ac = 0 then
						z <= '1';
					else
						z <= '0';
					end if;
					
					if ac > 127 then
						n <= '1';
					else
						n <= '0';
					end if;
				when others => 
			end case;
		end if;
	end process;

	write_enable_out <= write_enable;

	address_out <= pc when write_enable = '0' else address_write_out;

end arch_neander;


