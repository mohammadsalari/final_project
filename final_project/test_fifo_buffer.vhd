library ieee;
use ieee.std_logic_1164.all;

entity test_fifo_buffer is
end entity;


architecture arch_test_fifo_buffer of test_fifo_buffer is

constant DATA_WIDTH: positive := 12;
constant ADDR_WIDTH: positive := 2;

component fifo_buffer is
	generic(
		DATA_WIDTH: positive := 12;
		ADDR_WIDTH: positive := 2
	);
	port(
		clk: 		in std_logic;
		reset: 	in std_logic;
		
		data_in: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push: 	in std_logic;
		pop: 		in std_logic;

		data_out: 	out std_logic_vector(DATA_WIDTH - 1 downto 0);
		full: 		out std_logic;
		empty: 		out std_logic
	);
end component;

	signal clk: 		std_logic;
	signal reset: 		std_logic;
	signal data_in: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal push: 		std_logic;
	signal pop: 		std_logic;
	signal data_out: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal full: 		std_logic;
	signal empty: 		std_logic;
	
begin

uut: fifo_buffer
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => 		clk,
	reset => 	reset,
	data_in => 	data_in,
	push => 		push,
	pop => 		pop,
	data_out =>	data_out,
	full => 		full,
	empty => 	empty
);


-- clk generator
process
begin
	clk <= '0';
	wait for 10ns;
	clk <= '1';
	wait for 10ns;
end process;


-- testcases
process
begin

	-- initialization
	data_in 	<= "000000000000";
	push 		<= '0';
	pop 		<= '0';
	reset		<= '1';
	wait for 25ns;
	reset 	<= '0';
	
	-- test 1
	data_in 	<= "000000000001";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 	report "test_1-full failed..." severity error;
	assert (empty='0') 	report "test_1-empty failed..." severity error;
	--dataout unknown
	wait for 10ns;
	
	-- test 2
	data_in 	<= "000000000000";
	push 		<= '0';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_2-full failed..." severity error;
	assert (empty='0') 					report "test_2-empty failed..." severity error;
	assert (data_out="000000000001") report "test_2-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 3
	data_in 	<= "000000000010";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_3-full failed..." severity error;
	assert (empty='0') 					report "test_3-empty failed..." severity error;
	assert (data_out="000000000001") report "test_3-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 4
	data_in 	<= "000000000001";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_4-full failed..." severity error;
	assert (empty='0') 					report "test_4-empty failed..." severity error;
	assert (data_out="000000000001") report "test_4-data_out failed..." severity error;
	--dataout "000000000001"
	--full 0
	--empty 0
	wait for 10ns;
	
	-- test 5
	data_in 	<= "000000000001";
	push 		<= '0';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_5-full failed..." severity error;
	assert (empty='0') 					report "test_5-empty failed..." severity error;
	assert (data_out="000000000010") report "test_5-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 5
	data_in 	<= "000000000001";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_5-full failed..." severity error;
	assert (empty='1') 					report "test_5-empty failed..." severity error;
	assert (data_out="000000000010") report "test_5-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 6
	data_in 	<= "000000000001";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_6-full failed..." severity error;
	assert (empty='0') 					report "test_6-empty failed..." severity error;
	-- data_out is unknown
	wait for 10ns;
	
	-- test 7
	data_in 	<= "000000000011";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_7-full failed..." severity error;
	assert (empty='0') 					report "test_7-empty failed..." severity error;
	assert (data_out="000000000001") report "test_7-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 8
	data_in 	<= "000000000111";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_8-full failed..." severity error;
	assert (empty='0') 					report "test_8-empty failed..." severity error;
	assert (data_out="000000000001") report "test_8-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 9
	data_in 	<= "000000001111";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='1') 					report "test_9-full failed..." severity error;
	assert (empty='0') 					report "test_9-empty failed..." severity error;
	assert (data_out="000000000001") report "test_9-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 10
	data_in 	<= "000000001111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_10-full failed..." severity error;
	assert (empty='0') 					report "test_10-empty failed..." severity error;
	assert (data_out="000000000001") report "test_10-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 11
	data_in 	<= "000000001111";
	push 		<= '1';
	pop 		<= '0';
	wait for 10ns;
	assert (full='1') 					report "test_11-full failed..." severity error;
	assert (empty='0') 					report "test_11-empty failed..." severity error;
	assert (data_out="000000000011") report "test_11-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 12
	data_in 	<= "000000011111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_12-full failed..." severity error;
	assert (empty='0') 					report "test_12-empty failed..." severity error;
	assert (data_out="000000000011") report "test_12-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 13
	data_in 	<= "000000111111";
	push 		<= '1';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_13-full failed..." severity error;
	assert (empty='0') 					report "test_13-empty failed..." severity error;
	assert (data_out="000000000111") report "test_13-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 14
	data_in 	<= "000001111111";
	push 		<= '1';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_14-full failed..." severity error;
	assert (empty='0') 					report "test_14-empty failed..." severity error;
	assert (data_out="000000001111") report "test_14-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 15
	data_in 	<= "000011111111";
	push 		<= '1';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_15-full failed..." severity error;
	assert (empty='0') 					report "test_15-empty failed..." severity error;
	assert (data_out="000000001111") report "test_15-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 16
	data_in 	<= "000011111111";
	push 		<= '0';
	pop 		<= '0';
	wait for 10ns;
	assert (full='0') 					report "test_16-full failed..." severity error;
	assert (empty='0') 					report "test_16-empty failed..." severity error;
	assert (data_out="000000111111") report "test_16-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 17
	data_in 	<= "000011111111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_17-full failed..." severity error;
	assert (empty='0') 					report "test_17-empty failed..." severity error;
	assert (data_out="000000111111") report "test_17-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 18
	data_in 	<= "000011111111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_18-full failed..." severity error;
	assert (empty='0') 					report "test_18-empty failed..." severity error;
	assert (data_out="000001111111") report "test_18-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 19
	data_in 	<= "000011111111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_19-full failed..." severity error;
	assert (empty='1') 					report "test_19-empty failed..." severity error;
	assert (data_out="000011111111") report "test_19-data_out failed..." severity error;
	wait for 10ns;
	
	-- test 20
	data_in 	<= "000011111111";
	push 		<= '0';
	pop 		<= '1';
	wait for 10ns;
	assert (full='0') 					report "test_20-full failed..." severity error;
	assert (empty='1') 					report "test_20-empty failed..." severity error;
	-- data_out is uknown
	wait for 10ns;
	wait;
end process;


end architecture;