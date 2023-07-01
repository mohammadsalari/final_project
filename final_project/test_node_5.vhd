-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity test_node_5 is
end entity;

architecture arch_test_node_5 of test_node_5 is

	constant DATA_WIDTH: positive := 12;
	constant ADDR_WIDTH: positive := 2;

	component node_5 is
	generic(DATA_WIDTH: positive := 12; ADDR_WIDTH: positive := 2);
	port(
		clk: 			in std_logic;
		reset: 		in std_logic;
		
		-- input signals to the node
		data_in_1: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_1: 		in std_logic;
		
		data_in_2: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_2: 		in std_logic;
		
		data_in_3: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_3: 		in std_logic;
		
		data_in_4: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_4: 		in std_logic;
		
		--full signals specify the state of adjacent router(they come from adjacent routers)
		full_w: in std_logic;
		full_x: in std_logic;
		full_y: in std_logic;
		full_z: in std_logic;
		
		--output signals from the node(they will connected to adjacent routers)
		push_w: out std_logic;
		push_x: out std_logic;
		push_y: out std_logic;
		push_z: out std_logic;
		
		data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0)
		
	);
	end component;


	signal tb_clk: std_logic;
	signal tb_reset: std_logic;
	
	-- input signals to the node
	signal tb_data_in_1: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_1: std_logic;
	
	--full signals specify the state of adjacent router(they come from adjacent routers)
	signal tb_full_w: std_logic;
	
	--output signals from the node(they will connected to adjacent routers)
	signal tb_push_w: std_logic;
	
	signal tb_data_in_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
begin

uut:node_5
	generic map (DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
	port map(
		clk 	=> tb_clk,
		reset => tb_reset,
		
		-- input signals to the node
		data_in_1	=> tb_data_in_1,
		push_1 		=> tb_push_1,
		
		data_in_2 => (others=>'0'),
		push_2 => '0',
		
		data_in_3 => (others=>'0'),
		push_3 => '0',
		
		data_in_4 => (others=>'0'),
		push_4 => '0',
		
		--full signals specify the state of adjacent router(they come from adjacent routers)
		full_w => tb_full_w,
		full_x => '0',
		full_y => '0',
		full_z => '0',
		
		--output signals from the node(they will connected to adjacent routers)
		push_w => tb_push_w,
		push_x => open,
		push_y => open,
		push_z => open,
		
		data_in_w => tb_data_in_w,
		data_in_x => open,
		data_in_y => open,
		data_in_z => open
	);


	
	process
	begin
		tb_clk <= '0';
		wait for 10ns;
		tb_clk <= '1';
		wait for 10ns;
	end process;
	
	process
	begin
	
		tb_reset <= '1';
		tb_push_1 <= '0';
		wait for 15ns;
		tb_reset <= '0';
		wait for 10ns;
		
		-- fifo_2 wants to send packet to fifo_x
		-- src=5=00101 dst=6=00110
		tb_data_in_1 <= "110010100001";
		tb_push_1 <= '1';
		tb_full_w <= '0';
		
		-- only route 1 is implemented
		
		--wait;
		wait for 20ns;
		--tb_push_1 <= '0';
		
		wait for 20ns;
		tb_push_1 <= '0';
		wait for 20ns;
		wait for 20ns;
		wait for 20ns;
		wait for 20ns;
		
		assert (tb_push_w='1')							report ("test_2_push_w failed ...") 		severity error;
		
		assert (tb_data_in_w="110010100001")		report ("test_2_data_w failed ...") 		severity error;
		
		
		wait for 20ns;
		
		
		assert (tb_push_w='0')					report ("test_3_push_w failed ...") 		severity error;
		
		wait;
		
	end process;


end architecture;