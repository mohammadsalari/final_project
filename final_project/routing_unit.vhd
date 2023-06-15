library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity routing_unit is
-- PACKET_LENGTH is 12
-- 2-bit: PACKET_TYPE
-- 5-bit: SRC_WIDTH
-- 5-bit: DST_WIDTH
port(
	route_1: in std_logic_vector(9 downto 0);
	route_2: in std_logic_vector(9 downto 0);
	route_3: in std_logic_vector(9 downto 0);
	route_4: in std_logic_vector(9 downto 0);
	
	-- valid bits are used to specify that if generated next signals can be calculated correctly or not.
	next_1:				out std_logic_vector(1 downto 0);
	--is_next_1_valid: 	out std_logic;
	next_2:				out std_logic_vector(1 downto 0);
	--is_next_2_valid: 	out std_logic;
	next_3:				out std_logic_vector(1 downto 0);
	--is_next_3_valid: 	out std_logic;
	next_4:				out std_logic_vector(1 downto 0)
	--is_next_4_valid: 	out std_logic
);
end entity;


architecture arch_routing_unit of routing_unit is
	constant W: std_logic_vector(1 downto 0) := "00"; -- UP
	constant X: std_logic_vector(1 downto 0) := "01"; -- RIGHT
	constant Y: std_logic_vector(1 downto 0) := "10"; -- DOWN
	constant Z: std_logic_vector(1 downto 0) := "11"; -- LEFT
begin

process(route_1, route_2, route_3, route_4)
	variable src_1: std_logic_vector(4 downto 0);
	variable src_2: std_logic_vector(4 downto 0);
	variable src_3: std_logic_vector(4 downto 0);
	variable src_4: std_logic_vector(4 downto 0);
	
	variable dst_1: std_logic_vector(4 downto 0);
	variable dst_2: std_logic_vector(4 downto 0);
	variable dst_3: std_logic_vector(4 downto 0);
	variable dst_4: std_logic_vector(4 downto 0);
	
	variable row_src_1: std_logic_vector(2 downto 0);
	variable col_src_1: std_logic_vector(1 downto 0);
	variable row_dst_1: std_logic_vector(2 downto 0);
	variable col_dst_1: std_logic_vector(1 downto 0);
begin

	src_1 := route_1(9 downto 5);
	dst_1 := route_1(4 downto 0);
	
	row_src_1 := src_1(4 downto 2);
	col_src_1 := src_1(1 downto 0);
	
	row_dst_1 := dst_1(4 downto 2);
	col_dst_1 := dst_1(1 downto 0);
	
	if(src_1 = dst_1) then
		-- TODO: drop the packet
		report "packet should be dropped" severity note;
		next_1 <= "00";
	elsif(row_src_1 = row_dst_1) then
		-- move only horizontally
		if(unsigned(col_dst_1) > unsigned(col_src_1)) then
			--move forward
			next_1 <= X;
		else
			--move backward
			next_1 <= Z;
		end if;
	elsif(col_src_1 = col_dst_1) then
		-- move only vertically
		if(unsigned(row_dst_1) > unsigned(row_src_1)) then
			--move down
			next_1 <= Y;
		else
			--move up
			next_1 <= W;
		end if;
	else
		-- src and des are located in completely different domains
		-- so, walk one step vetically (or horizontally)
		if(unsigned(row_dst_1) > unsigned(row_src_1)) then
			--move down
			next_1 <= Y;
		else
			--move up
			next_1 <= W;
		end if;
	end if;
	
	-- TODO: next_2, next_3, next_4
	next_2 <= (others => '0');
	next_3 <= (others => '0');
	next_4 <= (others => '0'); 
end process;


end architecture;