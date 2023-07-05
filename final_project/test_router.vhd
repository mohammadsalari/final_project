-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity test_router is

end entity;


architecture arch_test_router of test_router is
	constant DATA_WIDTH: positive := 12;
	component router is
	generic(
		DATA_WIDTH: positive := 12
	);
	port(
		clk: in std_logic;
		reset: in std_logic;
		-- input ports
		route_1: in std_logic_vector(9 downto 0);
		route_2: in std_logic_vector(9 downto 0);
		route_3: in std_logic_vector(9 downto 0);
		route_4: in std_logic_vector(9 downto 0);
		
		req_1: in std_logic;
		req_2: in std_logic;
		req_3: in std_logic;
		req_4: in std_logic;
		
		data_1: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_2: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_3: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_4: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		
		w_is_ready: in std_logic;
		x_is_ready: in std_logic;
		y_is_ready: in std_logic;
		z_is_ready: in std_logic;
		
		-- output ports
		req_to_w: out std_logic;
		req_to_x: out std_logic;
		req_to_y: out std_logic;
		req_to_z: out std_logic;
		
		
		pop_1: out std_logic;
		pop_2: out std_logic;
		pop_3: out std_logic;
		pop_4: out std_logic;
		
		data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
	end component;

	signal tb_clk: std_logic;
	signal tb_reset: std_logic;
	
	-- input ports
	signal tb_route_1: std_logic_vector(9 downto 0);
	signal tb_route_2: std_logic_vector(9 downto 0);
	signal tb_route_3: std_logic_vector(9 downto 0);
	signal tb_route_4: std_logic_vector(9 downto 0);
	
	signal tb_req_1: std_logic;
	signal tb_req_2: std_logic;
	signal tb_req_3: std_logic;
	signal tb_req_4: std_logic;
		
	signal tb_data_1: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_2: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_3: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_4: std_logic_vector(DATA_WIDTH - 1 downto 0);
		
	signal tb_w_is_ready: std_logic;
	signal tb_x_is_ready: std_logic;
	signal tb_y_is_ready: std_logic;
	signal tb_z_is_ready: std_logic;
		
	-- output ports
	signal tb_req_to_w: std_logic;
	signal tb_req_to_x: std_logic;
	signal tb_req_to_y: std_logic;
	signal tb_req_to_z: std_logic;
		
		
	signal tb_pop_1: std_logic;
	signal tb_pop_2: std_logic;
	signal tb_pop_3: std_logic;
	signal tb_pop_4: std_logic;
		
	signal tb_data_in_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_in_x: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_in_y: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_data_in_z: std_logic_vector(DATA_WIDTH - 1 downto 0);

begin

uut: router
generic map(DATA_WIDTH => DATA_WIDTH)
port map (

	clk => tb_clk,
	reset => tb_reset,
	
	-- input ports
	route_1 => tb_route_1,
	route_2 => tb_route_2,
	route_3 => tb_route_3,
	route_4 => tb_route_4,
	
	req_1 => tb_req_1,
	req_2 => tb_req_2,
	req_3 => tb_req_3,
	req_4 => tb_req_4,
		
	data_1 => tb_data_1,
	data_2 => tb_data_2,
	data_3 => tb_data_3,
	data_4 => tb_data_4,
		
	w_is_ready => tb_w_is_ready,
	x_is_ready => tb_x_is_ready,
	y_is_ready => tb_y_is_ready,
	z_is_ready => tb_z_is_ready,
		
	-- output ports
	req_to_w => tb_req_to_w,
	req_to_x => tb_req_to_x,
	req_to_y => tb_req_to_y,
	req_to_z => tb_req_to_z,
		
		
	pop_1 => tb_pop_1,
	pop_2 => tb_pop_2,
	pop_3 => tb_pop_3,
	pop_4 => tb_pop_4,
		
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
		tb_req_1 <= '0';
		tb_req_2 <= '0';
		tb_req_3 <= '0';
		tb_req_4 <= '0';
		wait for 150ns;
		tb_reset <= '0';
		wait for 100ns;
		
		-- fifo_1 : data="110010100110" [type=11 src=5=00101 dst=6=00110]
		tb_data_1 <= "110010100110";
		tb_route_1 <= "0010100110";
		tb_req_1 <= '1';
		tb_w_is_ready <= '1'; -- the packet will be trasfered to fifo_w
		
		-- fifo_2 : data="110011100001" [type=11 src=7=00111 dst=1=00001]
		tb_data_2 <= "110011100001";
		tb_route_2 <= "0011100001";
		tb_req_2 <= '1';
		tb_z_is_ready <= '1'; -- the packet will be trasfered to fifo_z
		
		
		-- fifo_3 : data="110010001010" [type=11 src=4=00100 dst=10=01010]
		tb_data_3 <= "110010001010";
		tb_route_3 <= "0010001010";
		tb_req_3 <= '1';
		tb_y_is_ready <= '1'; -- the packet will be trasfered to fifo_y
		
		wait for 200ns; -- pop_1=>1 and req_to_w=>1
		assert (tb_pop_1='1')							report ("test_clk1_pop_1 failed ...") 			severity error;
		assert (tb_req_to_w='1')						report ("test_clk1_req_to_w failed ...") 		severity error;
		assert (tb_data_in_w="110010100110")		report ("test_clk1_data_in_w failed ...") 	severity note;
		
		wait for 200ns; -- pop_1=>0 and pop_2=>1, req_to_w=>0 and req_to_z=>1
		assert (tb_pop_1='0')							report ("test_clk2_pop_1 failed ...") 			severity error;
		assert (tb_req_to_w='0')						report ("test_clk2_req_to_w failed ...") 		severity error;
		--
		assert (tb_pop_2='1')							report ("test_clk2_pop_2 failed ...") 			severity error;
		assert (tb_req_to_z='1')						report ("test_clk2_req_to_z failed ...") 		severity error;
		assert (tb_data_in_z="110011100001")		report ("test_clk2_data_in_z failed ...") 	severity note;
		
		wait for 200ns; -- pop_3=>1 and pop_2=>0, req_to_z 0 and req_to_y 1 --> bug: z doesnt change to zero, pop_2 doesnt change to zero
		assert (tb_pop_2='0')							report ("test_clk3_pop_2 failed ...") 			severity error;
		assert (tb_req_to_z='0')						report ("test_clk3_req_to_z failed ...") 		severity error;
		--
		assert (tb_pop_3='1')							report ("test_clk3_pop_3 failed ...") 			severity error;
		assert (tb_data_in_y="110010001010")		report ("test_clk3_data_y failed ...") 		severity error;
		assert (tb_req_to_y='1')						report ("test_clk3_req_to_y failed ...") 		severity error;
		
		wait for 200ns; -- pop_3=>0, req_to_y 0
		assert (tb_pop_1='0')							report ("test_clk4_pop_1 failed ...") 			severity error;
		assert (tb_pop_2='0')							report ("test_clk4_pop_2 failed ...") 			severity error;
		assert (tb_pop_3='0')							report ("test_clk4_pop_3 failed ...") 			severity error;
		assert (tb_pop_4='0')							report ("test_clk4_pop_4 failed ...") 			severity error;
		assert (tb_req_to_w='0')						report ("test_clk4_req_to_z failed ...") 		severity error;
		assert (tb_req_to_x='0')						report ("test_clk4_req_to_z failed ...") 		severity error;
		assert (tb_req_to_y='0')						report ("test_clk4_req_to_z failed ...") 		severity error;
		assert (tb_req_to_z='0')						report ("test_clk4_req_to_z failed ...") 		severity error;
		
		
		
		tb_req_1 <= '0';
		tb_req_2 <= '0';
		tb_req_3 <= '0';
		tb_req_4 <= '0';
		
		wait;
		
	end process;


end architecture;