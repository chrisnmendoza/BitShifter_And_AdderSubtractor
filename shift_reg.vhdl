library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
port(	D, clk: in std_logic;
		Q: out std_logic);
end flip_flop;

architecture behavior of flip_flop is
	begin
	process(clk) is
		begin
			if (rising_edge(clk)) then 
				Q <= D;
			end if;
		end process;
end behavior;



entity shift_reg is
port(	I:	in std_logic_vector (3 downto 0); -- for loading
		I_SHIFT_IN: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) -- output the current register content. HINT: should be combinational.
		-- SHIFT_OUT : out std_logic;
);
end shift_reg;

architecture behav of shift_reg is
begin

process(I, I_SHIFT_IN, sel, clock, enable) is
begin
	if (enable='1') then
		O <= I;
	end if;
end process;

end behav;

