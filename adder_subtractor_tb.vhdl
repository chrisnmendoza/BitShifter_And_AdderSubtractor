library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity adder_subtractor_tb is
end adder_subtractor_tb;

architecture behav of adder_subtractor_tb is
--  Declaration of the component that will be instantiated.
component adder_subtractor
port(	upperInput: in std_logic_vector (3 downto 0);
        lowerInput: in std_logic_vector (3 downto 0); --this input gets inverted for a subtraction
		O:	out std_logic_vector(3 downto 0); -- output
        overflow: out std_logic; --1 signifies overflow
        underflow: out std_logic; --1 signifies underflow
        sel: in std_logic -- 0 signifies addition, 1 signifies subtraction. when subtracting, lowerInput gets inverted
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal u, l, o : std_logic_vector(3 downto 0);
signal oFlow, uFlow, s : std_logic;
begin
--  Component instantiation.
adder_subtractor_0: adder_subtractor port map (upperInput => u, lowerInput => l, O => o, overflow => oFlow, underflow => uFlow, sel => s);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
u, l, o: std_logic_vector (3 downto 0);
oFlow, uFlow, s: std_logic;
--  The expected outputs of the shift_reg.
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := --WRONG test vectors. replace with your own.
(("0001", "0001", "0010", '0', '0', '0'),
("0111", "0111", "1110", '1', '0', '0'),
("1000", "1010", "0010", '0', '1', '0'),
("0110", "1001", "1101", '1', '0', '1'),
("0010", "0110", "1100", '0', '0', '1'),
("0100", "0001", "0101", '0', '0', '0'),
("1000", "0111", "0001", '0', '1', '1'),
("0001", "0001", "0000", '0', '0', '1')); -- Order goes: Upper, Lower, Output, Overflow, Underflow, Select
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
u <= patterns(n).u;
l <= patterns(n).l;
o <= patterns(n).o;
oFlow <= patterns(n).oFlow;
uFlow <= patterns(n).uFlow;
s <= patterns(n).s;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;
assert oFlow = patterns(n).oFlow
report "bad overflow value" severity error;
assert uFlow = patterns(n).uFlow
report "bad underflow value" severity error;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
