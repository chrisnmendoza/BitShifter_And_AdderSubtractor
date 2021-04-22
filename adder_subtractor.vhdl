library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor is
generic(n: positive:=2);
port(	upperInput: in std_logic_vector (3 downto 0)
        lowerInput: in std_logic_vector (3 downto 0) --this input gets inverted for a subtraction
        lowerModifiedInput: inout std_logic_vector (3 downto 0) --the possibly inverted version of lowerInput
		O:	out std_logic_vector(3 downto 0) -- output
        carry: inout std_logic_vector(3 downto 0) --this is the carry-in and carry-out
        overflow: out std_logic --signifies overflow
        underflow: out std_logic --signifies underflow
        sel: in std_logic -- 0 signifies addition, 1 signifies subtraction. when subtracting lowerinput gets inverted
);
end adder_subtractor;

architecture behav of adder_subtractor is
begin
lowerModifiedInput(0) <= lowerInput(0) xor sel;
lowerModifiedInput(1) <= lowerInput(1) xor sel;
lowerModifiedInput(2) <= lowerInput(2) xor sel;
lowerModifiedInput(3) <= lowerInput(3) xor sel;
carry(0) <= sel; --when sel == 1 this signifies subtraction, and according to 2's complement must add 1 to LSB
carry(1) <= (upperInput(1) and carry(0) or (upperInput(1) and lowerModifiedInput(1))) or (lowerModifiedInput(1) and carry(0));
carry(2) <= (upperInput(2) and carry(1) or (upperInput(2) and lowerModifiedInput(2))) or (lowerModifiedInput(2) and carry(1));
carry(3) <= (upperInput(3) and carry(2) or (upperInput(3) and lowerModifiedInput(3))) or (lowerModifiedInput(3) and carry(2));
O(0) <= upperInput(0) xor lowerModifiedInput xor carry(0); 		
O(1) <= upperInput(1) xor lowerModifiedInput(1) xor carry(1);	
O(2) <= upperInput(2) xor lowerModifiedInput(2) xor carry(2);	
O(3) <= upperInput(3) xor lowerModifiedInput(3) xor carry(3);	



end behav;

