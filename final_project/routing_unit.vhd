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
	
	variable row_src_1, row_src_2, row_src_3, row_src_4: std_logic_vector(2 downto 0);
	variable col_src_1, col_src_2, col_src_3, col_src_4: std_logic_vector(1 downto 0);
	variable row_dst_1, row_dst_2, row_dst_3, row_dst_4: std_logic_vector(2 downto 0);
	variable col_dst_1, col_dst_2, col_dst_3, col_dst_4: std_logic_vector(1 downto 0);
begin
	-- next_1
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
	

	--next_2
	src_2 := route_2(9 downto 5);
	dst_2 := route_2(4 downto 0);
	
	row_src_2 := src_2(4 downto 2);
	col_src_2 := src_2(1 downto 0);
	
	row_dst_2 := dst_2(4 downto 2);
	col_dst_2 := dst_2(1 downto 0);
	
	if(src_2 = dst_2) then
		-- TODO: drop the packet
		report "packet should be dropped" severity note;
		next_2 <= "00";
	elsif(row_src_2 = row_dst_2) then
		-- move only horizontally
		if(unsigned(col_dst_2) > unsigned(col_src_2)) then
			--move forward
			next_2 <= X;
		else
			--move backward
			next_2 <= Z;
		end if;
	elsif(col_src_2 = col_dst_2) then
		-- move only vertically
		if(unsigned(row_dst_2) > unsigned(row_src_2)) then
			--move down
			next_2 <= Y;
		else
			--move up
			next_2 <= W;
		end if;
	else
		-- src and des are located in completely different domains
		-- so, walk one step vetically (or horizontally)
		if(unsigned(row_dst_2) > unsigned(row_src_2)) then
			--move down
			next_2 <= Y;
		else
			--move up
			next_2 <= W;
		end if;
	end if;
	
	
	-- next_3
	src_3 := route_3(9 downto 5);
	dst_3 := route_3(4 downto 0);
	
	row_src_3 := src_3(4 downto 2);
	col_src_3 := src_3(1 downto 0);
	
	row_dst_3 := dst_3(4 downto 2);
	col_dst_3 := dst_3(1 downto 0);
	
	if(src_3 = dst_3) then
		-- TODO: drop the packet
		report "packet should be dropped" severity note;
		next_3 <= "00";
	elsif(row_src_3 = row_dst_3) then
		-- move only horizontally
		if(unsigned(col_dst_3) > unsigned(col_src_3)) then
			--move forward
			next_3 <= X;
		else
			--move backward
			next_3 <= Z;
		end if;
	elsif(col_src_3 = col_dst_3) then
		-- move only vertically
		if(unsigned(row_dst_3) > unsigned(row_src_3)) then
			--move down
			next_3 <= Y;
		else
			--move up
			next_3 <= W;
		end if;
	else
		-- src and des are located in completely different domains
		-- so, walk one step vetically (or horizontally)
		if(unsigned(row_dst_3) > unsigned(row_src_3)) then
			--move down
			next_3 <= Y;
		else
			--move up
			next_3 <= W;
		end if;
	end if;
	
	
	-- next_4
	src_4 := route_4(9 downto 5);
	dst_4 := route_4(4 downto 0);
	
	row_src_4 := src_4(4 downto 2);
	col_src_4 := src_4(1 downto 0);
	
	row_dst_4 := dst_4(4 downto 2);
	col_dst_4 := dst_4(1 downto 0);
	
	if(src_4 = dst_4) then
		-- TODO: drop the packet
		report "packet should be dropped" severity note;
		next_4 <= "00";
	elsif(row_src_4 = row_dst_4) then
		-- move only horizontally
		if(unsigned(col_dst_4) > unsigned(col_src_4)) then
			--move forward
			next_4 <= X;
		else
			--move backward
			next_4 <= Z;
		end if;
	elsif(col_src_4 = col_dst_4) then
		-- move only vertically
		if(unsigned(row_dst_4) > unsigned(row_src_4)) then
			--move down
			next_4 <= Y;
		else
			--move up
			next_4 <= W;
		end if;
	else
		-- src and des are located in completely different domains
		-- so, walk one step vetically (or horizontally)
		if(unsigned(row_dst_4) > unsigned(row_src_4)) then
			--move down
			next_4 <= Y;
		else
			--move up
			next_4 <= W;
		end if;
	end if;
	 
end process;


end architecture;