library ieee;
use ieee.std_logic_1164.all;

entity arbiter is
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
end entity;

architecture arch_arbiter of arbiter is
	
	type states_w is (w1, w2, w3, w4);
	type states_x is (x1, x2, x3, x4);
	type states_y is (y1, y2, y3, y4);
	type states_z is (z1, z2, z3, z4);
	
	signal reg_state_w, next_state_w: states_w;
	signal reg_state_x, next_state_x: states_x;
	signal reg_state_y, next_state_y: states_y;
	signal reg_state_z, next_state_z: states_z;
	
	signal next_data_w, reg_data_w: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal next_data_x, reg_data_x: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal next_data_y, reg_data_y: std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal next_data_z, reg_data_z: std_logic_vector(DATA_WIDTH - 1 downto 0);
	
	signal next_req_to_w, reg_req_to_w: std_logic;
	signal next_req_to_x, reg_req_to_x: std_logic;
	signal next_req_to_y, reg_req_to_y: std_logic;
	signal next_req_to_z, reg_req_to_z: std_logic;
	
	signal next_grant_1, reg_grant_1: std_logic;
	signal next_grant_2, reg_grant_2: std_logic;
	signal next_grant_3, reg_grant_3: std_logic;
	signal next_grant_4, reg_grant_4: std_logic;
	
	constant W: std_logic_vector(1 downto 0) := "00"; -- UP
	constant X: std_logic_vector(1 downto 0) := "01"; -- RIGHT
	constant Y: std_logic_vector(1 downto 0) := "10"; -- DOWN
	constant Z: std_logic_vector(1 downto 0) := "11"; -- LEFT

	
begin

--state register
	process(clk, reset)
	begin
	
		if(reset='1') then
			reg_state_w <= w1;
			reg_state_x <= x1;
			reg_state_y <= y1;
			reg_state_z <= z1;
			
			-- no need to initialized reg_data_X
			
			reg_req_to_w <= '0';
			reg_req_to_x <= '0';
			reg_req_to_y <= '0';
			reg_req_to_z <= '0';
			
			reg_grant_1 <= '0';
			reg_grant_2 <= '0';
			reg_grant_3 <= '0';
			reg_grant_4 <= '0';
		elsif(rising_edge(clk)) then
			reg_state_w <= next_state_w;
			reg_state_x <= next_state_x;
			reg_state_y <= next_state_y;
			reg_state_z <= next_state_z;
			
			reg_data_w <= next_data_w;
			reg_data_x <= next_data_x;
			reg_data_y <= next_data_y;
			reg_data_z <= next_data_z;
			
			reg_req_to_w <= next_req_to_w;
			reg_req_to_x <= next_req_to_x;
			reg_req_to_y <= next_req_to_y;
			reg_req_to_z <= next_req_to_z;
			
			reg_grant_1 <= next_grant_1;
			reg_grant_2 <= next_grant_2;
			reg_grant_3 <= next_grant_3;
			reg_grant_4 <= next_grant_4;
		end if;
		
	end process;

	
	--next state register
	process(reg_state_w, reg_state_x, reg_state_y, reg_state_z)
	
	begin
		-- default value of controlling signals of input_buffers
		next_grant_1 <= '0';
		next_grant_2 <= '0';
		next_grant_3 <= '0';
		next_grant_4 <= '0';
		
		-- default value of controlling signals of output_buffers
		next_req_to_w <= '0';
		next_req_to_x <= '0';
		next_req_to_y <= '0';
		next_req_to_z <= '0';
		
		next_data_w <= (others=>'0');
		next_data_x <= (others=>'0');
		next_data_y <= (others=>'0');
		next_data_z <= (others=>'0');
		
		-- next state of fifo_w
		if(w_is_ready = '1') then							-- fifo_out_w is not full, it can not accept a new packet 
			case reg_state_w is
				when w1 => 										-- it is the turn of fifo_in_1 to send its packet through fifo_out_w
					if(req_1 = '1' and dst_1 = W) then 	-- there is a valid packet in fifo_in_1 to the destination of fifo_out_w
						next_data_w <= data_1;
						next_req_to_w <= '1';
						next_grant_1 <= '1';
					end if;
					next_state_w <= w2; 						-- give the turn to fifo_in_2, for next cycle
				
				when w2 =>
					if(req_2 = '1' and dst_2 = W) then 
						next_data_w <= data_2;
						next_req_to_w <= '1';
						next_grant_2 <= '1';
					end if;
					next_state_w <= w3;
				
				when w3 =>
					if(req_3 = '1' and dst_3 = W) then 	
						next_data_w <= data_3;
						next_req_to_w <= '1';
						next_grant_3 <= '1';
					end if;
					next_state_w <= w4;
				
				when w4 =>
					if(req_4 = '1' and dst_4 = W) then 	
						next_data_w <= data_4;
						next_req_to_w <= '1';
						next_grant_4 <= '1';
					end if;
					next_state_w <= w1; 
				
				when others =>
					report "something wrong is happend in: arbiter -> next_state logic -> reg_state_w";
					next_state_w <= w2; -- back to the 'w1' state
			end case;
		end if;
		
		-- next state of fifo_x
		if(x_is_ready = '1') then							-- fifo_out_x is not full, it can not accept a new packet 
			case reg_state_x is
				when x1 => 										-- it is the turn of fifo_in_1 to send its packet through fifo_out_x
					if(req_1 = '1' and dst_1 = X) then 	-- there is a valid packet in fifo_in_1 to the destination of fifo_out_x
						next_data_x <= data_1;
						next_req_to_x <= '1';
						next_grant_1 <= '1';
					end if;
					next_state_x <= x2; 						-- give the turn to fifo_in_2, for next cycle
				
				when x2 =>
					if(req_2 = '1' and dst_2 = X) then 
						next_data_x <= data_2;
						next_req_to_x <= '1';
						next_grant_2 <= '1';
					end if;
					next_state_x <= x3;
				
				when x3 =>
					if(req_3 = '1' and dst_3 = X) then 	
						next_data_x <= data_3;
						next_req_to_x <= '1';
						next_grant_3 <= '1';
					end if;
					next_state_x <= x4;
				
				when x4 =>
					if(req_4 = '1' and dst_4 = X) then 	
						next_data_x <= data_4;
						next_req_to_x <= '1';
						next_grant_4 <= '1';
					end if;
					next_state_x <= x1; 
				
				when others =>
					report "something wrong is happend in: arbiter -> next_state logic -> reg_state_x";
					next_state_x <= x1; -- back to the 'x1' state
			end case;
		end if;
		
		-- next state of fifo_y
		if(y_is_ready = '1') then							-- fifo_out_y is not full, it can not accept a new packet 
			case reg_state_y is
				when y1 => 										-- it is the turn of fifo_in_1 to send its packet through fifo_out_y
					if(req_1 = '1' and dst_1 = Y) then 	-- there is a valid packet in fifo_in_1 to the destination of fifo_out_y
						next_data_y <= data_1;
						next_req_to_y <= '1';
						next_grant_1 <= '1';
					end if;
					next_state_y <= y2; 						-- give the turn to fifo_in_2, for next cycle
				
				when y2 =>
					if(req_2 = '1' and dst_2 = Y) then 
						next_data_y <= data_2;
						next_req_to_y <= '1';
						next_grant_2 <= '1';
					end if;
					next_state_y <= y3;
				
				when y3 =>
					if(req_3 = '1' and dst_3 = Y) then 	
						next_data_y <= data_3;
						next_req_to_y <= '1';
						next_grant_3 <= '1';
					end if;
					next_state_y <= y4;
				
				when y4 =>
					if(req_4 = '1' and dst_4 = Y) then 	
						next_data_y <= data_4;
						next_req_to_y <= '1';
						next_grant_4 <= '1';
					end if;
					next_state_y <= y1; 
				
				when others =>
					report "something wrong is happend in: arbiter -> next_state logic -> reg_state_y";
					next_state_y <= y1; -- back to the 'y1' state
			end case;
		end if;
		
		
		-- next state of fifo_z
		if(z_is_ready = '1') then							-- fifo_out_z is not full, it can not accept a new packet 
			case reg_state_z is
				when z1 => 										-- it is the turn of fifo_in_1 to send its packet through fifo_out_z
					if(req_1 = '1' and dst_1 = Z) then 	-- there is a valid packet in fifo_in_1 to the destination of fifo_out_z
						next_data_z <= data_1;
						next_req_to_z <= '1';
						next_grant_1 <= '1';
					end if;
					next_state_z <= z2; 						-- give the turn to fifo_in_2, for next cycle
				
				when z2 =>
					if(req_2 = '1' and dst_2 = Z) then 
						next_data_z <= data_2;
						next_req_to_z <= '1';
						next_grant_2 <= '1';
					end if;
					next_state_z <= z3;
				
				when z3 =>
					if(req_3 = '1' and dst_3 = Z) then 	
						next_data_z <= data_3;
						next_req_to_z <= '1';
						next_grant_3 <= '1';
					end if;
					next_state_z <= z4;
				
				when z4 =>
					if(req_4 = '1' and dst_4 = Z) then 	
						next_data_z <= data_4;
						next_req_to_z <= '1';
						next_grant_4 <= '1';
					end if;
					next_state_z <= z1; 
				
				when others =>
				report "something wrong is happend in: arbiter -> next_state logic -> reg_state_z";
				next_state_z <= z1; -- back to the 'z1' state
			end case;
		end if;
	end process;
-- END state register


-- output logic
	data_w <= reg_data_w;
	data_x <= reg_data_x;
	data_y <= reg_data_y;
	data_z <= reg_data_z;
	
	req_to_w <= reg_req_to_w;
	req_to_x <= reg_req_to_x;
	req_to_y <= reg_req_to_y;
	req_to_z <= reg_req_to_z;
	
	grant_1 <= reg_grant_1;
	grant_2 <= reg_grant_2;
	grant_3 <= reg_grant_3;
	grant_4 <= reg_grant_4;
	
	
-- END output logic

end architecture;