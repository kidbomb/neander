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

	signal write_enable: std_logic;

	signal stall: std_logic_vector(1 downto 0);

	signal opcode: std_logic_vector(7 downto 0);

begin

	--instruction fetch
	process(clock_in)
	begin
		if reset_in = '1' then

			write_enable <= '0';
			data_out <= (others => '0');
			address_out <= (others => '0');

			pc <= (others => '0');
			ac <= (others => '0');
			n <= '0';
			z <= '1';


			stall <= "11";
			opcode <= (others => '0');
		elsif clock_in'event and clock_in = '1' then
			if stall = "00" then 
				opcode <= data_in(15 downto 8);
				address_out <= pc;

				case data_in(15 downto 8) is --TODO: use mask & 240
					when x"00" => --NOP
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";
					when x"10" => --STA
						write_enable <= '1';
						data_out <= ac;
						address_out <= data_in(7 downto 0);
						stall <= "01";

					when x"20" => --LDA
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= data_in(7 downto 0);
						stall <= "01";
	
					when x"30" => --ADD
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= data_in(7 downto 0);

						stall <= "01";

					when x"40" => --OR
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= data_in(7 downto 0);

						stall <= "01";

					when x"50" => --AND
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= data_in(7 downto 0);

						stall <= "01";

					when x"60" => --NOT
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";

					when x"80" => --JMP
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";

					when x"90" => --JN
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";

					when x"A0" => --JZ
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";

					when x"F0" => --HLT
						--TODO
						write_enable <= '0';
						data_out <= (others => '0');
						address_out <= (others => '0');

						stall <= "01";

					when others => 
						stall <= "01";
				end case;
			elsif stall = "01" then
				stall <= "10";
			elsif stall = "10" then
				case opcode is
					when x"00" => --NOP
						pc <= pc + 1;
					when x"10" => --STA
						pc <= pc + 2;

					when x"20" => --LDA
						ac <= data_in(15 downto 8);
						pc <= pc + 2;

					when x"30" => --ADD
						ac <= ac + data_in(15 downto 8); 
						pc <= pc + 2;
	
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

					when x"40" => --OR
						ac <= ac or data_in(15 downto 8);
						pc <= pc + 2;
	
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

					when x"50" => --AND
						ac <= ac and data_in(15 downto 8);
						pc <= pc + 2;
	
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

					when x"60" => --NOT
						ac <= not ac;
						pc <= pc + 1;

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

					when x"80" => --JMP
						pc <= data_in(15 downto 8);
						stall <= "00";
					when x"90" => --JN
						if n = '1' then
							pc <= data_in(15 downto 8);
						end if;
					when x"A0" => --JZ
						if z = '1' then
							pc <= data_in(15 downto 8);
						end if;
					when others => 
				end case;

				stall <= "11";
			elsif stall = "11" then --fetch
				write_enable <= '0';
				address_out <= pc;

				stall <= "00";
			end if;
		end if;
	end process;

	write_enable_out <= write_enable;

end arch_neander;


