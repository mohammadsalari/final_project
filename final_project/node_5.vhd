-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity node_5 is
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
end entity;


architecture arch_node_5 of node_5 is
	
	component fifo_buffer is
	generic(
		DATA_WIDTH: positive := 12;
		ADDR_WIDTH: positive := 2
	);
	port(
		clk: 			in std_logic;
		reset: 		in std_logic;
		
		data_in:		in std_logic_vector(DATA_WIDTH - 1 downto 0);
		push: 		in std_logic;
		pop: 			in std_logic;

		data_out: 	out std_logic_vector(DATA_WIDTH - 1 downto 0);
		full:			out std_logic;
		empty: 		out std_logic
	);
	end component;

	component router is
	generic(
		DATA_WIDTH: positive := 12
	);
	port(
		clk: 		in std_logic;
		reset: 	in std_logic;
		-- input ports
		route_1: in std_logic_vector(9 downto 0);
		route_2: in std_logic_vector(9 downto 0);
		route_3: in std_logic_vector(9 downto 0);
		route_4: in std_logic_vector(9 downto 0);
		
		req_1: 	in std_logic;
		req_2: 	in std_logic;
		req_3: 	in std_logic;
		req_4: 	in std_logic;
		
		data_1: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_2: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_3: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		data_4: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		
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

	signal internal_data_out_1: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_empty_1: 		std_logic;
	
	signal internal_route_1: std_logic_vector(9 downto 0);
	signal internal_req_1: std_logic;
	signal internal_pop_1: std_logic;
	
	signal internal_full_w: std_logic;
begin

lbl_fifo_1: fifo_buffer
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	data_in => data_in_1,
	push => push_1,
	pop => internal_pop_1,

	data_out => internal_data_out_1,
	full => open,
	empty => internal_empty_1

);

internal_route_1 <= "00101"&internal_data_out_1(4 downto 0);

internal_req_1 <= not internal_empty_1;
internal_full_w <= not full_w;


lbl_router: router
generic map(DATA_WIDTH => DATA_WIDTH)
port map(
		clk 	=> clk,
		reset => reset,
		-- input ports
		route_1 => internal_route_1,
		route_2 => (others=>'0'),
		route_3 => (others=>'0'),
		route_4 => (others=>'0'),
		
		req_1 => internal_req_1,
		req_2 => '0',
		req_3 => '0',
		req_4 => '0',
		
		data_1 => internal_data_out_1,
		data_2 => (others=>'0'),
		data_3 => (others=>'0'),
		data_4 => (others=>'0'),
		
		w_is_ready => internal_full_w,
		x_is_ready => '0',
		y_is_ready => '0',
		z_is_ready => '0',
		
		-- output ports
		req_to_w => push_w,
		req_to_x => open,
		req_to_y => open,
		req_to_z => open,
		
		
		pop_1 => internal_pop_1,
		pop_2 => open,
		pop_3 => open,
		pop_4 => open,
		
		data_in_w => data_in_w,
		data_in_x => open,
		data_in_y => open,
		data_in_z => open

);

end architecture;