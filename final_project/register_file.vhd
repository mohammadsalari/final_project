library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  generic(
    DATA_WIDTH: positive := 12;  -- Width of each register word
    ADDR_WIDTH: positive := 2   -- Width of the address
  );
  port(
    clk: in std_logic;                 -- Clock input
    addr: in std_logic_vector(ADDR_WIDTH - 1 downto 0);  -- Address input
    data_in: in std_logic_vector(DATA_WIDTH - 1 downto 0); -- Data input
    write_enable: in std_logic;        -- Write enable signal
    data_out: out std_logic_vector(DATA_WIDTH - 1 downto 0) -- Data output
  );
end entity;

architecture arch_register_file of register_file is
  type RegisterArray is array(0 to 2**ADDR_WIDTH - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal registers: RegisterArray;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if write_enable = '1' then
        registers(to_integer(unsigned(addr))) <= data_in;
      end if;
      data_out <= registers(to_integer(unsigned(addr)));
    end if;
  end process;
end architecture;
