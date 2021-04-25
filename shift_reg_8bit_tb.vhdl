library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_8bit_tb is
end shift_reg_8bit_tb;

architecture behav of shift_reg_8bit_tb is
--  Declaration of the component that will be instantiated.
component shift_reg_8bit
port (	I_8bit:	in std_logic_vector (7 downto 0);
		I_SHIFT_IN_8bit: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O_8bit:	out std_logic_vector(7 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
shift_reg_8bit_0: shift_reg_8bit port map (I_8bit => i, I_SHIFT_IN_8bit => i_shift_in, sel => sel, clock => clk, enable => enable, O_8bit => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
i: std_logic_vector (7 downto 0);
i_shift_in, clock, enable: std_logic;
sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := --WRONG test vectors. replace with your own.

(("11000000", '0', '1', '1', "11", "11000000"),
("11000001", '0', '1', '1', "11", "11000001"),
("11000001", '0', '1', '1', "10", "01100000"),
("11000001", '0', '1', '1', "00", "01100000")); -- Need two vectors to simulate an edge.
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
i <= patterns(n).i;
i_shift_in <= patterns(n).i_shift_in;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
