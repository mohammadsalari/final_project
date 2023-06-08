library IEEE;
use IEEE.std_logic_1164.all;

entity test_mux_4_to_1 is
end entity;

architecture arch_test_mux_4_to_1 of test_mux_4_to_1 is
  component mux_4_to_1
    port (
      sel  : in  std_logic_vector(1 downto 0);
      in0  : in  std_logic;
      in1  : in  std_logic;
      in2  : in  std_logic;
      in3  : in  std_logic;
      out1 : out std_logic
    );
  end component;

  signal sel_tb  : std_logic_vector(1 downto 0);
  signal in0_tb  : std_logic;
  signal in1_tb  : std_logic;
  signal in2_tb  : std_logic;
  signal in3_tb  : std_logic;
  signal out1_tb : std_logic;

begin
  uut: mux_4_to_1
    port map (
      sel  => sel_tb,
      in0  => in0_tb,
      in1  => in1_tb,
      in2  => in2_tb,
      in3  => in3_tb,
      out1 => out1_tb
    );

  process
  begin
    
	 in0_tb <= '0';
    in1_tb <= '1';
    in2_tb <= '0';
    in3_tb <= '1';
	 wait for 10ns; 
	 -- wait until the input is stabled
	 
	 
	 -- Test case 1: sel = "00"
    sel_tb <= "00";
    wait for 10 ns;
	 
	 -- Test case 2: sel = "00"
    sel_tb <= "01";
    wait for 10 ns;
	 
	 -- Test case 3: sel = "00"
    sel_tb <= "10";
    wait for 10 ns;
	 
	 -- Test case 4: sel = "00"
    sel_tb <= "11";
    wait for 10 ns;
	 
	 -- Add more test cases here if needed

    wait;
  end process;
end architecture;