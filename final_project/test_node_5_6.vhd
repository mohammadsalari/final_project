-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity test_node_5_6 is
end entity;

architecture arch_test_node_5_6 of test_node_5_6 is

	constant DATA_WIDTH: positive := 12;
	constant ADDR_WIDTH: positive := 2;

	component node_5_6 is
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
	
	-- signals for testing route 5 to 6 through fifo_1
	signal tb_data_in_1: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_1: std_logic;
	signal tb_push_x: std_logic;
	signal tb_data_in_x: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	-- signals for testing route 7 to 1 through fifo_2
	signal tb_data_in_2: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_2: std_logic;
	signal tb_push_z: std_logic;
	signal tb_data_in_z: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	-- signals for testing router 4 to 10 through fifo_3
	signal tb_data_in_3: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_3: std_logic;
	signal tb_push_y: std_logic;
	signal tb_data_in_y: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	
	-- 
	signal tb_data_in_4: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_4: std_logic;
	signal tb_push_w: std_logic;
	signal tb_data_in_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	
	signal tb_full_w: std_logic;
	signal tb_full_x: std_logic;
	signal tb_full_y: std_logic;
	signal tb_full_z: std_logic;
	
begin

uut:node_5_6
	generic map (DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
	port map(
		clk 	=> tb_clk,
		reset => tb_reset,
		
		-- input signals to the node
		data_in_1	=> tb_data_in_1,
		push_1 		=> tb_push_1,
		
		data_in_2 => tb_data_in_2,
		push_2 => tb_push_2,
		
		data_in_3 => tb_data_in_3,
		push_3 => tb_push_3,
		
		data_in_4 => (others=>'0'),
		push_4 => '0',
		
		--full signals specify the state of adjacent router(they come from adjacent routers)
		full_w => tb_full_w,
		full_x => tb_full_x,
		full_y => tb_full_y,
		full_z => tb_full_z,
		
		--output signals from the node(they will connected to adjacent routers)
		push_w => tb_push_w,
		push_x => tb_push_x,
		push_y => tb_push_y,
		push_z => tb_push_z,
		
		data_in_w => tb_data_in_w,
		data_in_x => tb_data_in_x,
		data_in_y => tb_data_in_y,
		data_in_z => tb_data_in_z
	);


	
	process
	begin
		tb_clk <= '0';
		wait for 100ns;
		tb_clk <= '1';
		wait for 100ns;
	end process;
	
	process
	begin
	
		tb_reset <= '1';
		tb_push_1 <= '0';
		wait for 150ns;
		tb_reset <= '0';
		wait for 100ns;
		
		-- fifo_1 wants to send packet to fifo_x
		-- src=5=00101 dst=6=00110
		tb_data_in_1 <= "110010100110";
		tb_push_1 <= '1';
		tb_full_x <= '0';
		
	
		-- fifo_2 wants to send packet to fifo_w
		-- src=7=00111 dst=1=00001
		tb_data_in_2 <= "110011100001";
		tb_push_2 <= '1';
		tb_full_w <= '0';
		
		
		-- fifo_3 wants to send packet to fifo_y
		-- src=4=00100 dst=10=01010
		tb_data_in_3 <= "110010001010";
		tb_push_3 <= '1';
		tb_full_y <= '0';
		
		wait for 200ns;
		--clk 1
		-- data is load into fifos
		tb_push_1 <= '0';
		tb_push_2 <= '0';
		tb_push_3 <= '0';
		
		wait for 200ns;
		-- clk 2
		
		wait for 200ns;
		-- clk 3
		
		wait for 200ns; 
		-- clk 4
		
		wait for 200ns;
		-- clk 5
		
		wait for 200ns;
		-- clk 6
		
		wait for 200ns;
		-- clk 7
		assert (tb_push_y='1')							report ("test_clk6_push_y failed ...") 		severity error;
		assert (tb_data_in_y="110010001010")		report ("test_clk6_data_y failed ...") 		severity error;
		
		wait for 200ns;
		-- clk 8
		
		wait for 200ns;
		-- clk 9
		
		wait for 200ns;
		-- clk 10
		report ("test_clk10: packet 5->6 should be dropped ...") 		severity note;

		wait for 200ns;
		-- clk 11
		
		wait for 200ns;
		-- clk 12
		
		wait for 200ns;
		-- clk 13
		
		wait for 200ns;
		-- clk 14
		
		wait for 200ns;
		-- clk 15
		
		wait;
		
	end process;


end architecture;