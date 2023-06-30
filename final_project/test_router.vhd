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
		wait for 10ns;
		tb_clk <= '1';
		wait for 10ns;
	end process;
	
	process
	begin
	
		tb_reset <= '1';
		tb_req_1 <= '0';
		tb_req_2 <= '0';
		tb_req_3 <= '0';
		tb_req_4 <= '0';
		wait for 15ns;
		tb_reset <= '0';
		wait for 10ns;
		
		-- fifo_2 wants to send packet to fifo_x
		-- src=5=00101 dst=6=00110
		tb_data_1 <= "110010100110";
		tb_route_1 <= "0010100110";
		tb_req_1 <= '1';
		tb_x_is_ready <= '1';
		
		-- only route 1 is implemented
		
		wait for 10ns;
		
		assert (tb_pop_1='0')						report ("test_1_pop_2 failed ...") 		severity error;
		
		wait for 20ns;
		wait for 20ns;
		wait for 20ns;
		wait for 20ns;
		
		assert (tb_pop_1='1')						report ("test_2_pop_1 failed ...") 		severity error;
		
		assert (tb_req_to_x='1')					report ("test_2_req_to_x failed ...") 		severity error;
		
		assert (tb_data_in_x="110010100110")		report ("test_2_data_x failed ...") 		severity error;
		
		tb_req_1 <= '0';
		
		wait for 20ns;
		
		assert (tb_pop_1='0')						report ("test_3_pop_1 failed ...") 		severity error;
		assert (tb_pop_2='0')						report ("test_3_pop_2 failed ...") 		severity error;
		assert (tb_pop_3='0')						report ("test_3_pop_3 failed ...") 		severity error;
		assert (tb_pop_4='0')						report ("test_3_pop_4 failed ...") 		severity error;
		
		assert (tb_req_to_w='0')					report ("test_3_req_to_w failed ...") 		severity error;
		assert (tb_req_to_x='0')					report ("test_3_req_to_x failed ...") 		severity error;
		assert (tb_req_to_y='0')					report ("test_3_req_to_y failed ...") 		severity error;
		assert (tb_req_to_z='0')					report ("test_3_req_to_z failed ...") 		severity error;
		
		wait;
		
	end process;


end architecture;