library ieee;
use ieee.std_logic_1164.all;

entity test_register_file is
end entity;

architecture arch_test_register_file of test_register_file is
  constant DATA_WIDTH: positive := 12;  -- Width of each register word
  constant ADDR_WIDTH: positive := 2;   -- Width of the address
  
  signal clk: std_logic;                 -- Clock signal
  signal addr: std_logic_vector(ADDR_WIDTH - 1 downto 0);  -- Address input
  signal data_in: std_logic_vector(DATA_WIDTH - 1 downto 0); -- Data input
  signal write_enable: std_logic;        -- Write enable signal
  signal data_out: std_logic_vector(DATA_WIDTH - 1 downto 0); -- Data output
  
  component register_file is
    generic(
      DATA_WIDTH: positive := 12;  -- Width of each register word
      ADDR_WIDTH: positive := 2  -- Width of the address
    );
    port(
      clk: in std_logic;                 -- Clock input
      addr: in std_logic_vector(ADDR_WIDTH - 1 downto 0);  -- Address input
      data_in: in std_logic_vector(DATA_WIDTH - 1 downto 0); -- Data input
      write_enable: in std_logic;        -- Write enable signal
      data_out: out std_logic_vector(DATA_WIDTH - 1 downto 0) -- Data output
    );
  end component;
  
begin
  dut: register_file
    generic map(
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => ADDR_WIDTH
    )
    port map(
      clk => clk,
      addr => addr,
      data_in => data_in,
      write_enable => write_enable,
      data_out => data_out
    );


  -- clock generator
  process 
  begin
  
    clk <= '0';
	 wait for 10ns;
	 clk <= '1';
	 wait for 10ns;
  
  end process;
    
  -- data simulator
  process
  begin
    -- Initialize testbench inputs
    addr <= "00";
    data_in <= (others => '0');
    write_enable <= '0';
    
    -- Wait for a few clock cycles before starting the test
    wait for 5 ns;
    
    -- Test Case 1: Write to register 0
    addr <= "00";
    data_in <= "101010101010";
    write_enable <= '1';
    wait for 20ns;
    
    -- Test Case 2: Write to register 2
    addr <= "10";
    data_in <= "111100001111";
    write_enable <= '1';
    wait for 20 ns;
    
    -- Test Case 3: Read from register 0
    addr <= "00";
    write_enable <= '0';
	 wait for 10ns;
	 assert (data_out="101010101010") report "test_1 failed..." severity error;
    wait for 10 ns;
    
    -- Test Case 4: Read from register 2
    addr <= "10";
    write_enable <= '0';
    wait for 10ns;
	 assert (data_out="111100001111") report "test_2 failed..." severity error;
	 wait for 10ns;
    
	 -- Test Case 5: Read from register 1
    addr <= "01";
    write_enable <= '0';
    wait for 10ns;
	 report "data_out is unknown...";
	 wait for 10ns;
	 
	 
    -- Add more test cases if needed
    
    wait;
  end process;
  
end architecture;
