library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4_to_1 is
  port (
    sel  : in  std_logic_vector(1 downto 0);
    in0  : in  std_logic;
    in1  : in  std_logic;
    in2  : in  std_logic;
    in3  : in  std_logic;
    out1 : out std_logic
  );
end entity;

architecture arch_mux_4_to_1 of mux_4_to_1 is
begin
  process(sel, in0, in1, in2, in3)
  begin
    case sel is
      when "00" =>
        out1 <= in0;
      when "01" =>
        out1 <= in1;
      when "10" =>
        out1 <= in2;
      when others =>
        out1 <= in3;
    end case;
  end process;
end architecture;
