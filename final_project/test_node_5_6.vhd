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
		
		
		
		--output signals from the node(they will connected to adjacent routers)
		push_w: out std_logic;
		push_x: out std_logic;
		push_y: out std_logic;
		push_z: out std_logic;
		
		data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		
		--output tst signals coming from node_5
		tst_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_w: out std_logic;
		
		tst_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_y: out std_logic;
		
		tst_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_z: out std_logic;
		
		--input tst signals for node_6
		tst_data_in_1: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_1: in std_logic;
		
		tst_data_in_3: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_3: in std_logic;
		
		tst_data_in_4: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		tst_push_4: in std_logic
		
	);
	end component;

	--

	signal tb_clk: std_logic;
	signal tb_reset: std_logic;
	
	signal tb_data_in_1: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_1: std_logic;
	
	signal tb_data_in_2: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_2: std_logic;
	
	signal tb_data_in_3: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_3: std_logic;
	
	--
	
	signal tb_data_in_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_w: std_logic;
	
	signal tb_data_in_x: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_x: std_logic;
	
	signal tb_data_in_y: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_push_y: std_logic;
	
	-- 
	
	signal tb_tst_in_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_w: std_logic;
	
	signal tb_tst_in_y: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_y: std_logic;
	
	signal tb_tst_in_z: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_z: std_logic;
	
	--
	signal tb_tst_data_in_1: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_1: std_logic;
		
	signal tb_tst_data_in_3: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_3: std_logic;
		
	signal tb_tst_data_in_4: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_tst_push_4: std_logic;
		
	
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
		
		
		
		--output signals from the node(they will connected to adjacent routers)
		data_in_w => tb_data_in_w,
		push_w => tb_push_w,
		
		data_in_x => tb_data_in_x,
		push_x => tb_push_x,
		
		data_in_y => tb_data_in_y,
		push_y => tb_push_y,
		
		tst_in_w => tb_tst_in_w,
		tst_push_w => tb_tst_push_w,
	
		tst_in_y => tb_tst_in_y,
		tst_push_y => tb_tst_push_y,
	
		tst_in_z => tb_tst_in_z,
		tst_push_z => tb_tst_push_z,
		
		tst_data_in_1 => tb_tst_data_in_1,
		tst_push_1 => tb_tst_push_1,
		
		tst_data_in_3 => tb_tst_data_in_3,
		tst_push_3 => tb_tst_push_3,
		
		tst_data_in_4 => tb_tst_data_in_4,
		tst_push_4 => tb_tst_push_4
		
	);


	
	process
	begin
		tb_clk <= '0';
		wait for 200ns;
		tb_clk <= '1';
		wait for 200ns;
	end process;
	
	process
	begin
	
		tb_reset <= '1';
		wait for 300ns; -- 150ns
		tb_reset <= '0';
		wait for 200ns; -- 250ns
		
		-- fifo_1 of node_5 wants to send packet to fifo_x
		-- src=5=00101 dst=6=00110
		tb_data_in_1 <= "110010100110";
		tb_push_1 <= '1';
		
	
		-- fifo_1 of node_6 wants to send packet to fifo_w
		-- src=7=00111 dst=1=00001
		tb_tst_data_in_1 <= "110011100001";
		tb_tst_push_1 <= '1';
		
		
		-- fifo_3 of node_5 wants to send packet to fifo_y
		-- src=4=00100 dst=10=01010
		tb_data_in_3 <= "110010001010";
		tb_push_3 <= '1';
		
		-- fifo_3 of node_6 wants to send packet to fifo_y
		-- src=6=00110 dst=10=01001
		tb_tst_data_in_3 <= "110011001001";
		tb_tst_push_3 <= '1';
		
		-- fifo_4 of node_6 wants to send packet to fifo_y
		-- src=10=01010 dst=1=00001
		tb_tst_data_in_4 <= "110101000001";
		tb_tst_push_4 <= '1';
		
		
		tb_push_2 <= '0';
		--wait for 400ns; -- 450ns
		--clk 1
		
		wait for 400ns; -- 650ns
		--clk 2
		-- data is load into fifos
		tb_push_1 <= '0';
		tb_push_3 <= '0';
		tb_tst_push_1 <= '0';
		tb_tst_push_3 <= '0';
		tb_tst_push_4 <= '0';
		
		wait for 400ns; -- 850ns
		--clk 3
		assert (tb_tst_push_y='1')							report ("test_tst_push_y failed ...") 		severity error;
		assert (tb_tst_in_y="110010001010")				report ("test_tst_data_y failed ...") 		severity error;
		
		wait for 400ns; -- 1050ns
		-- clk 4
		
		wait for 400ns; -- 1250ns
		-- clk 5
		report ("test_packet 5->6 should be dropped...") 		severity note;
		
		wait for 400ns; -- 1450ns
		-- clk 6
		assert (tb_tst_push_w='1')							report ("test_clk6_push_y failed ...") 		severity error;
		assert (tb_tst_in_w="110011100001")				report ("test_clk6_data_y failed ...") 		severity error;
		
		wait for 400ns; -- 1650ns
		-- clk 7
		
		wait for 400ns; -- 1850ns
		-- clk 8
		
		wait for 400ns; -- 2050ns
		-- clk 9
		
		wait for 400ns; -- 2250ns
		-- clk 10
		report("For testing, packet 5->6 has not been dropped... ");
		assert (tb_push_w='1')									report ("test_push_w failed ...") 			severity error;
		assert (tb_data_in_w="110010100110")				report ("test_data_in_w failed ...") 		severity error;
		
		wait for 400ns;
		-- clk 11
		
		wait for 400ns;
		-- clk 12
		
		wait for 400ns;
		-- clk 13
		
		wait for 400ns;
		-- clk 14
		
		wait for 400ns;
		-- clk 15
		
		wait for 400ns;
		-- clk 16
		
		wait;
		
	end process;


end architecture;