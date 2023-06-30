-- In the Name of God

library ieee;
use ieee.std_logic_1164.all;

entity router is
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
end entity;


architecture arch_router of router is

	component routing_unit is
	-- PACKET_LENGTH is 12
	-- 2-bit: PACKET_TYPE
	-- 5-bit: SRC_WIDTH
	-- 5-bit: DST_WIDTH
	port(
		route_1: in std_logic_vector(9 downto 0);
		route_2: in std_logic_vector(9 downto 0);
		route_3: in std_logic_vector(9 downto 0);
		route_4: in std_logic_vector(9 downto 0);
		
		next_1:				out std_logic_vector(1 downto 0);
		next_2:				out std_logic_vector(1 downto 0);
		next_3:				out std_logic_vector(1 downto 0);
		next_4:				out std_logic_vector(1 downto 0)
	);
	end component;
	
	component arbiter is
	generic(
		DATA_WIDTH: positive := 12
	);
	port (
		clk: 		in std_logic;
		reset: 	in std_logic;
		
		data_1: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_1: 	in std_logic;
		dst_1: 	in std_logic_vector(1 downto 0);
		grant_1:	out std_logic;
		
		data_2: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_2: 	in std_logic;
		dst_2: 	in std_logic_vector(1 downto 0);
		grant_2:	out std_logic;
		
		data_3: 	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_3: 	in std_logic;
		dst_3: 	in std_logic_vector(1 downto 0);
		grant_3:	out std_logic;
		
		data_4:	in std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_4: 	in std_logic;
		dst_4: 	in std_logic_vector(1 downto 0);
		grant_4:	out std_logic;
		
		
		w_is_ready:	in std_logic;
		data_w: 		out std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_to_w: 	out std_logic;
		
		x_is_ready:	in std_logic;
		data_x: 		out std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_to_x: 	out std_logic;
		
		y_is_ready:	in std_logic;
		data_y: 		out std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_to_y: 	out std_logic;
		
		z_is_ready:	in std_logic;
		data_z: 		out std_logic_vector(DATA_WIDTH - 1 downto 0);
		req_to_z: 	out std_logic	
	);
	end component;
	
	signal internal_dst_1: std_logic_vector(1 downto 0);
	signal internal_dst_2: std_logic_vector(1 downto 0);
	signal internal_dst_3: std_logic_vector(1 downto 0);
	signal internal_dst_4: std_logic_vector(1 downto 0);
	
begin

lbl_routing_unit: routing_unit
port map(
	route_1 => route_1,
	route_2 => route_2,
	route_3 => route_3,
	route_4 => route_4,
	next_1 => internal_dst_1,
	next_2 => internal_dst_2,
	next_3 => internal_dst_3,
	next_4 => internal_dst_4
);

lbl_arbiter: arbiter
generic map (DATA_WIDTH => DATA_WIDTH)
port map(
	clk => clk,
	reset => reset,
	
	w_is_ready => w_is_ready,
	x_is_ready => x_is_ready,
	y_is_ready => y_is_ready,
	z_is_ready => z_is_ready,
	
	dst_1 => internal_dst_1,
	dst_2 => internal_dst_2,
	dst_3 => internal_dst_3,
	dst_4 => internal_dst_4,
	
	data_1 => data_1,
	data_2 => data_2,
	data_3 => data_3,
	data_4 => data_4,
	
	req_1 => req_1,
	req_2 => req_2,
	req_3 => req_3,
	req_4 => req_4,
	
	grant_1 => pop_1,
	grant_2 => pop_2,
	grant_3 => pop_3,
	grant_4 => pop_4,
	
	req_to_w => req_to_w,
	req_to_x => req_to_x,
	req_to_y => req_to_y,
	req_to_z => req_to_z,
	
	data_w => data_in_w,
	data_x => data_in_x,
	data_y => data_in_y,
	data_z => data_in_z
);
end architecture;