-- In the name of God

library ieee;
use ieee.std_logic_1164.all;

entity node_5_6 is
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
	data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
	push_w: out std_logic;
	
	data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
	push_x: out std_logic;
	
	data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
	push_y: out std_logic;
	
	data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0);
	push_z: out std_logic;
	
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
end entity;


architecture arch_node_5_6 of node_5_6 is
	
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
		data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_w: out std_logic;
		
		data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_x: out std_logic;
		
		data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_y: out std_logic;
		
		data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_z: out std_logic
		
	);
	end component;

	component node_6 is
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
		data_in_w: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_w: out std_logic;
		
		data_in_x: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_x: out std_logic;
		
		data_in_y: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_y: out std_logic;
		
		data_in_z: out std_logic_vector(DATA_WIDTH - 1 downto 0);
		push_z: out std_logic
		
	);
	end component;

	
	--signal internal_data_1:	std_logic_vector(DATA_WIDTH - 1 downto 0);
	--signal internal_push_1:		std_logic;
	
	signal internal_data_2:	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_push_2:		std_logic;
	
	signal internal_data_z:	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal internal_push_z:		std_logic;
	
	--signal internal_data_4:	std_logic_vector(DATA_WIDTH - 1 downto 0);
	--signal internal_push_4:		std_logic;
	
begin



lbl_node_5: node_5
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	-- input signals to the node
	data_in_1 => data_in_1,
	push_1 => push_1,
		
	data_in_2 => data_in_2,
	push_2 => push_2,
		
	data_in_3 => data_in_3,
	push_3 => push_3,
		
	data_in_4 => internal_data_z,
	push_4 => internal_push_z,
		
	--full signals specify the state of adjacent router(they come from adjacent routers)
	full_w => '0',
	full_x => '0',
	full_y => '0',
	full_z => '0',
	
	--output signals from the node(they will connected to adjacent routers)
	data_in_w => tst_in_w,
	push_w => tst_push_w,
	
	data_in_x => internal_data_2,
	push_x => internal_push_2,
	
	data_in_y => tst_in_y,
	push_y => tst_push_y,
	
	data_in_z => tst_in_z,
	push_z => tst_push_z
		
);

lbl_node_6: node_6
generic map(
	DATA_WIDTH => DATA_WIDTH,
	ADDR_WIDTH => ADDR_WIDTH
)
port map(
	clk => clk,
	reset => reset,
		
	-- input signals to the node
	data_in_1 => tst_data_in_1,
	push_1 => tst_push_1,
		
	data_in_2 => internal_data_2,
	push_2 => internal_push_2,
		
	data_in_3 => tst_data_in_3,
	push_3 => tst_push_3,
		
	data_in_4 => tst_data_in_4,
	push_4 => tst_push_4,
		
	--full signals specify the state of adjacent router(they come from adjacent routers)
	full_w => '0',
	full_x => '0',
	full_y => '0',
	full_z => '0',
	
	--output signals from the node(they will connected to adjacent routers)
	data_in_w => data_in_w,
	push_w => push_w,
	
	data_in_x => data_in_x,
	push_x => push_x,
	
	data_in_y => data_in_y,
	push_y => push_y,
	
	data_in_z => internal_data_z,
	push_z => internal_push_z
		
);



end architecture;