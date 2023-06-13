library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_buffer is
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
end entity;


architecture arch_fifo_buffer of fifo_buffer is
	component register_file is
	  generic(
		DATA_WIDTH: 	positive := 12;  											-- Width of each register word
		ADDR_WIDTH: 	positive := 2   											-- Width of the address
	  );
	  port(
		clk: 				in std_logic;                 						-- Clock input
		read_addr: 		in std_logic_vector(ADDR_WIDTH - 1 downto 0);  	-- read address input
		write_addr:		in std_logic_vector(ADDR_WIDTH - 1 downto 0);  	-- write address input
		data_in: 		in std_logic_vector(DATA_WIDTH - 1 downto 0); 	-- Data input
		write_enable: 	in std_logic;        									-- Write enable signal
		data_out: 		out std_logic_vector(DATA_WIDTH - 1 downto 0) 	-- Data output
	  );
	end component;

	
	signal next_read_ptr: 			std_logic_vector(ADDR_WIDTH downto 0);	-- MSB in ptrs are used to finding out if buffer is full/empty or not.
																								-- len(ADDR_WIDTH) = ACTUAL_ADDR_WIDTH + 1
	signal next_write_ptr: 			std_logic_vector(ADDR_WIDTH downto 0);
	signal next_full: 				std_logic;
	signal next_empty: 				std_logic;
	
	
	signal reg_data_out: 			std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal reg_read_ptr: 			std_logic_vector(ADDR_WIDTH downto 0);
	signal reg_write_ptr: 			std_logic_vector(ADDR_WIDTH downto 0);
	signal reg_full:					std_logic;
	signal reg_empty:					std_logic;
	
	signal internal_read_addr: 	std_logic_vector(ADDR_WIDTH - 1 downto 0);
	signal internal_write_addr: 	std_logic_vector(ADDR_WIDTH - 1 downto 0);
	signal internal_write_enable:	std_logic;
	
	
begin

-- SECTION state register
	
	process(clk, reset)
	begin

		if(reset = '1') then
			reg_read_ptr	<= (others => '0');
			reg_write_ptr	<= (others => '0');
			reg_full			<= '0';
			reg_empty		<= '1';
		elsif (clk'event and clk='1') then
			--reg_data_out assignment is done by the register_file component
			
			reg_read_ptr	<= next_read_ptr;
			reg_write_ptr	<= next_write_ptr;
			reg_full 		<= next_full;
			reg_empty		<= next_empty;
		end if;
		
	end process;
	
	lbl_mapping_register_file: register_file
	generic map(
	  DATA_WIDTH=>DATA_WIDTH,
	  ADDR_WIDTH=>ADDR_WIDTH
	)
	port map(
		clk 				=> clk,
		data_in 			=> data_in,
		data_out 		=> reg_data_out,
		read_addr 		=> internal_read_addr,
		write_addr 		=> internal_write_addr,
		write_enable 	=> internal_write_enable
	);
	
-- END state register

-- SECTION next state logic
	
	-- assignments:
	-- -- internal_read_addr
	-- -- internal_write_addr
	-- -- internal_write_enable
	-- -- var_full
	-- -- var_empty
	-- -- next_read_ptr
	-- -- var_next_read_ptr
	-- -- next_write_ptr
	-- -- var_next_write_ptr
	-- -- next_full
	-- -- next_empty
	process(data_in, reg_read_ptr, reg_write_ptr, push, pop)
		variable var_full:				std_logic;
		variable var_empty:				std_logic;
		variable var_next_read_ptr: 	std_logic_vector(ADDR_WIDTH downto 0);
		variable var_next_write_ptr: 	std_logic_vector(ADDR_WIDTH downto 0);
	begin
		-- read_addr calculator
		internal_read_addr <= 	reg_read_ptr(ADDR_WIDTH - 1 downto 0);
		
		-- write_addr calculator
		internal_write_addr <= 	reg_write_ptr(ADDR_WIDTH - 1 downto 0);
		
		-- var_empty calculator
		var_empty := '0';
		if(reg_read_ptr = reg_write_ptr) then -- buffer is empty
			var_empty := '1';
		end if;

		-- var_full calculator
		var_full := '0';
		if(reg_read_ptr(ADDR_WIDTH - 1 downto 0)=reg_write_ptr(ADDR_WIDTH - 1 downto 0) and reg_read_ptr(ADDR_WIDTH)/=reg_write_ptr(ADDR_WIDTH)) then -- buffer is full
			var_full := '1';
		end if;

		-- internal_write_enable calculator
		internal_write_enable <= push and (not var_full);
		
		-- next_read_ptr and var_next_read_ptr calculator
		next_read_ptr 		<= reg_read_ptr;
		var_next_read_ptr := reg_read_ptr;
		if(pop='1' and var_empty='0') then
			 next_read_ptr 		<= std_logic_vector(unsigned(reg_read_ptr) + 1);
			 var_next_read_ptr 	:= std_logic_vector(unsigned(reg_read_ptr) + 1);
		end if;
		
		-- next_write_ptr and var_next_write_ptr calculator
		next_write_ptr 		<= reg_write_ptr;
		var_next_write_ptr 	:= reg_write_ptr;
		if(push='1' and var_full='0') then
			 next_write_ptr 		<= std_logic_vector(unsigned(reg_write_ptr) + 1);
			 var_next_write_ptr 	:= std_logic_vector(unsigned(reg_write_ptr) + 1);
		end if;
		
		-- next_empty calculator
		next_empty <= '0';
		if(var_next_read_ptr = var_next_write_ptr) then -- buffer is empty
			next_empty <= '1';
		end if;

		-- var_full calculator
		next_full <= '0';
		if(var_next_read_ptr(ADDR_WIDTH - 1 downto 0)=var_next_write_ptr(ADDR_WIDTH - 1 downto 0) and var_next_read_ptr(ADDR_WIDTH)/=var_next_write_ptr(ADDR_WIDTH)) then -- buffer is full
			next_full <= '1';
		end if;
		
	end process;
-- END next state logic


-- SECTION output logic
	data_out <= reg_data_out;
	full 		<= reg_full;
	empty 	<=	reg_empty;
-- END output logic

end architecture;

	