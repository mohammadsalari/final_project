-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity node_6 is
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


architecture arch_node_6 of node_6 is
	
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

	-- signals for fifo_1
	signal internal_data_out_1: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_empty_1: 		std_logic;
	
	signal internal_route_1: std_logic_vector(9 downto 0);
	signal internal_req_1: std_logic;
	signal internal_pop_1: std_logic;
	
	signal internal_full_x: std_logic;
	
	-- signals for fifo_2
	signal internal_data_out_2: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_empty_2: 		std_logic;
	
	signal internal_route_2: std_logic_vector(9 downto 0);
	signal internal_req_2: std_logic;
	signal internal_pop_2: std_logic;
	
	signal internal_full_z: std_logic;
	
	-- signals for fifo_3
	signal internal_data_out_3: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_empty_3: 		std_logic;
	
	signal internal_route_3: std_logic_vector(9 downto 0);
	signal internal_req_3: std_logic;
	signal internal_pop_3: std_logic;
	
	signal internal_full_y: std_logic;
	
	-- signals for fifo_3
	signal internal_data_out_4: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_empty_4: 		std_logic;
	
	signal internal_route_4: std_logic_vector(9 downto 0);
	signal internal_req_4: std_logic;
	signal internal_pop_4: std_logic;
	
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


lbl_fifo_2: fifo_buffer
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	data_in => data_in_2,
	push => push_2,
	pop => internal_pop_2,

	data_out => internal_data_out_2,
	full => open,
	empty => internal_empty_2

);


lbl_fifo_3: fifo_buffer
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	data_in => data_in_3,
	push => push_3,
	pop => internal_pop_3,

	data_out => internal_data_out_3,
	full => open,
	empty => internal_empty_3

);



lbl_fifo_4: fifo_buffer
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	data_in => data_in_4,
	push => push_4,
	pop => internal_pop_4,

	data_out => internal_data_out_4,
	full => open,
	empty => internal_empty_4

);

internal_route_1 <= "00110"&internal_data_out_1(4 downto 0);
internal_req_1 <= not internal_empty_1;
internal_full_x <= not full_x;


internal_route_2 <= "00110"&internal_data_out_2(4 downto 0);
internal_req_2 <= not internal_empty_2;
internal_full_z <= not full_z;


internal_route_3 <= "00110"&internal_data_out_3(4 downto 0);
internal_req_3 <= not internal_empty_3;
internal_full_y <= not full_y;


internal_route_4 <= "00110"&internal_data_out_4(4 downto 0);
internal_req_4 <= not internal_empty_4;
internal_full_w <= not full_w;


lbl_router: router
generic map(DATA_WIDTH => DATA_WIDTH)
port map(
		clk 	=> clk,
		reset => reset,
		-- input ports
		route_1 => internal_route_1,
		route_2 => internal_route_2,
		route_3 => internal_route_3,
		route_4 => internal_route_4,
		
		req_1 => internal_req_1,
		req_2 => internal_req_2,
		req_3 => internal_req_3,
		req_4 => internal_req_4,
		
		data_1 => internal_data_out_1,
		data_2 => internal_data_out_2,
		data_3 => internal_data_out_3,
		data_4 => internal_data_out_4,
		
		w_is_ready => internal_full_w,
		x_is_ready => internal_full_x,
		y_is_ready => internal_full_y,
		z_is_ready => internal_full_z,
		
		-- output ports
		req_to_w => push_w,
		req_to_x => push_x,
		req_to_y => push_y,
		req_to_z => push_z,
		
		
		pop_1 => internal_pop_1,
		pop_2 => internal_pop_2,
		pop_3 => internal_pop_3,
		pop_4 => internal_pop_4,
		
		data_in_w => data_in_w,
		data_in_x => data_in_x,
		data_in_y => data_in_y,
		data_in_z => data_in_z

);

end architecture;