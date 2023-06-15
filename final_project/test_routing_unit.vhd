library ieee;
use ieee.std_logic_1164.all;

entity test_routing_unit is
end entity;

architecture arch_test_routing_unit of test_routing_unit is

	--node numbers
	constant N0:  std_logic_vector(4 downto 0) := "00000";
	constant N1:  std_logic_vector(4 downto 0) := "00001";
	constant N2:  std_logic_vector(4 downto 0) := "00010";
	constant N3:  std_logic_vector(4 downto 0) := "00011";
	constant N4:  std_logic_vector(4 downto 0) := "00100";
	constant N5:  std_logic_vector(4 downto 0) := "00101";
	constant N6:  std_logic_vector(4 downto 0) := "00110";
	constant N7:  std_logic_vector(4 downto 0) := "00111";
	constant N8:  std_logic_vector(4 downto 0) := "01000";
	constant N9:  std_logic_vector(4 downto 0) := "01001";
	constant N10: std_logic_vector(4 downto 0) := "01010";
	constant N11: std_logic_vector(4 downto 0) := "01011";
	constant N12: std_logic_vector(4 downto 0) := "01100";
	constant N13: std_logic_vector(4 downto 0) := "01101";
	constant N14: std_logic_vector(4 downto 0) := "01110";
	constant N15: std_logic_vector(4 downto 0) := "01111";
	
	--directions
	constant W: std_logic_vector(1 downto 0) := "00"; -- UP
	constant X: std_logic_vector(1 downto 0) := "01"; -- RIGHT
	constant Y: std_logic_vector(1 downto 0) := "10"; -- DOWN
	constant Z: std_logic_vector(1 downto 0) := "11"; -- LEFT

component routing_unit is
port(
	route_1: in std_logic_vector(9 downto 0);
	route_2: in std_logic_vector(9 downto 0);
	route_3: in std_logic_vector(9 downto 0);
	route_4: in std_logic_vector(9 downto 0);
	
	next_1:				out std_logic_vector(1 downto 0);
	--is_next_1_valid: 	out std_logic;
	next_2:				out std_logic_vector(1 downto 0);
	--is_next_2_valid: 	out std_logic;
	next_3:				out std_logic_vector(1 downto 0);
	--is_next_3_valid: 	out std_logic;
	next_4:				out std_logic_vector(1 downto 0)
	--is_next_4_valid: 	out std_logic
);
end component;

	signal route_1: 	std_logic_vector(9 downto 0);
	signal route_2: 	std_logic_vector(9 downto 0);
	signal route_3: 	std_logic_vector(9 downto 0);
	signal route_4: 	std_logic_vector(9 downto 0);
		
	signal next_1:		std_logic_vector(1 downto 0);
	signal next_2:		std_logic_vector(1 downto 0);
	signal next_3:		std_logic_vector(1 downto 0);
	signal next_4:		std_logic_vector(1 downto 0);
	
begin

uut: routing_unit
port map(
	route_1 => route_1,
	route_2 => route_2,
	route_3 => route_3,
	route_4 => route_4,
	next_1  => next_1,
	next_2  => next_2,
	next_3  => next_3,
	next_4  => next_4
);

process
begin

	wait for 20ns;
	
	-- 5 -> 0
	route_1 <= N5 & N0;
	wait for 20ns;
	assert (next_1 = W) report "5 -> 0 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 1
	route_1 <= N5 & N1;
	wait for 20ns;
	assert (next_1 = W) report "5 -> 1 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 2
	route_1 <= N5 & N2;
	wait for 20ns;
	assert (next_1 = W) report "5 -> 2 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 3
	route_1 <= N5 & N3;
	wait for 20ns;
	assert (next_1 = W) report "5 -> 3 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 4
	route_1 <= N5 & N4;
	wait for 20ns;
	assert (next_1 = Z) report "5 -> 4 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 5
	route_1 <= N5 & N5;
	wait for 20ns;
	report "5 -> 5; testbench: packet should be dropped" severity note;
	wait for 20ns;
	
	-- 5 -> 6
	route_1 <= N5 & N6;
	wait for 20ns;
	assert (next_1 = X) report "5 -> 6 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 7
	route_1 <= N5 & N7;
	wait for 20ns;
	assert (next_1 = X) report "5 -> 7 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 8
	route_1 <= N5 & N8;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 8 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 9
	route_1 <= N5 & N9;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 9 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 10
	route_1 <= N5 & N10;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 10 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 11
	route_1 <= N5 & N11;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 11 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 12
	route_1 <= N5 & N12;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 12 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 13
	route_1 <= N5 & N13;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 13 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 14
	route_1 <= N5 & N14;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 14 failed" severity error;
	wait for 20ns;
	
	-- 5 -> 15
	route_1 <= N5 & N15;
	wait for 20ns;
	assert (next_1 = Y) report "5 -> 15 failed" severity error;	
	wait for 20ns;
	
	wait;
end process;

end architecture;