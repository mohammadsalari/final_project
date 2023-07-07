library ieee;
use ieee.std_logic_1164.all;


entity test_arbiter is
end entity;

architecture arch_test_arbiter of test_arbiter is
	constant DATA_WIDTH: positive := 12;
	
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

	signal clk: 		std_logic;
	signal reset: 		std_logic;
	
	signal data_1: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_1: 		std_logic;
	signal dst_1: 		std_logic_vector(1 downto 0);
	signal grant_1:	std_logic;
	
	signal data_2: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_2: 		std_logic;
	signal dst_2: 		std_logic_vector(1 downto 0);
	signal grant_2:	std_logic;
	
	signal data_3: 	std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_3: 		std_logic;
	signal dst_3: 		std_logic_vector(1 downto 0);
	signal grant_3:	std_logic;
	
	signal data_4:		std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_4: 		std_logic;
	signal dst_4: 		std_logic_vector(1 downto 0);
	signal grant_4:	std_logic;
	
	
	signal w_is_ready:	std_logic;
	signal data_w: 		std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_to_w: 		std_logic;
	
	signal x_is_ready:	std_logic;
	signal data_x: 		std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_to_x: 		std_logic;
	
	signal y_is_ready:	std_logic;
	signal data_y: 		std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_to_y: 		std_logic;
	
	signal z_is_ready:	std_logic;
	signal data_z: 		std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal req_to_z: 		std_logic;

begin

uut: arbiter
	generic map(DATA_WIDTH => DATA_WIDTH)
	port map(clk => clk, reset => reset,
		data_1 => data_1, data_2 => data_2, data_3 => data_3, data_4 => data_4,
		dst_1 => dst_1, dst_2 => dst_2, dst_3 => dst_3, dst_4 => dst_4,
		req_1 => req_1, req_2 => req_2, req_3 => req_3, req_4 => req_4,
		w_is_ready => w_is_ready, x_is_ready => x_is_ready, y_is_ready => y_is_ready, z_is_ready => z_is_ready,
		grant_1 => grant_1, grant_2 => grant_2, grant_3 => grant_3, grant_4 => grant_4,
		req_to_w => req_to_w, req_to_x => req_to_x, req_to_y => req_to_y, req_to_z => req_to_z,
		data_w => data_w, data_x => data_x, data_y => data_y, data_z => data_z
	);
	
	process
	begin
		clk <= '0';
		wait for 100ns;
		clk <= '1';
		wait for 100ns;
	end process;
	
	process
	begin
	
		reset <= '1';
		req_1 <= '0';
		req_2 <= '0';
		req_3 <= '0';
		req_4 <= '0';
		wait for 150ns;
		reset <= '0';
		wait for 100ns;
		
		 -- fifo_1 : data="110010100110" [type=11 src=5=00101 dst=6=00110]
       data_1 <= "110010100110";
       dst_1 <= "01";
		 req_1 <= '1';
       x_is_ready <= '1'; -- the packet will be trasfered to fifo_x

       -- fifo_2 : data="110011100001" [type=11 src=7=00111 dst=1=00001]
       data_4 <= "110011100100";
       dst_4 <= "11";
		 req_4 <= '1';
       z_is_ready <= '1'; -- the packet will be trasfered to fifo_w


       -- fifo_3 : data="110010001010" [type=11 src=4=00100 dst=10=01010]
       data_3 <= "110010001010";
       dst_3 <= "10";
		 req_3 <= '1';
       y_is_ready <= '1'; -- the packet will be trasfered to fifo_y

		
		wait for 200ns;
		
		assert (grant_1='1')						report ("test_clk1_grant_1 failed ...") 		severity error;
		
		assert (req_to_x='1')					report ("test_2_req_to_x failed ...") 		severity error;
		
		assert (data_x="110010100110")		report ("test_2_data_x failed ...") 		severity error;
		
		req_1 <= '0';
		
		wait for 200ns;
		
		assert (grant_1='0')						report ("test_3_grant_2 failed ...") 		severity error;
		assert (grant_2='1')						report ("test_3_grant_3 failed ...") 		severity error;
		
		assert (req_to_w='1')					report ("test_3_req_to_w failed ...") 		severity error;
		assert (data_w="110011100001")		report ("test_3_data_w failed ...") 		severity error;
		
		req_2 <= '0';
		
		wait for 200ns;
		
		assert (grant_2='0')						report ("test_3_grant_2 failed ...") 		severity error;
		assert (grant_3='1')						report ("test_3_grant_3 failed ...") 		severity error;
		
		assert (req_to_y='1')					report ("test_3_req_to_x failed ...") 		severity error;
		assert (data_y="110010001010")		report ("test_3_data_w failed ...") 		severity error;
		
		req_3 <= '0';
		
		wait for 200ns;
		
		
		assert (grant_1='0')						report ("test_4_grant_1 failed ...") 		severity error;
		assert (grant_2='0')						report ("test_4_grant_2 failed ...") 		severity error;
		assert (grant_3='0')						report ("test_4_grant_3 failed ...") 		severity error;
		assert (grant_4='0')						report ("test_4_grant_4 failed ...") 		severity error;
		
		assert (req_to_w='0')					report ("test_4_req_to_w failed ...") 		severity error;
		assert (req_to_x='0')					report ("test_4_req_to_x failed ...") 		severity error;
		assert (req_to_y='0')					report ("test_4_req_to_y failed ...") 		severity error;
		assert (req_to_z='0')					report ("test_4_req_to_z failed ...") 		severity error;
		
		wait;
		
	end process;
end architecture;