library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_8bit is
port(	I_8bit:	in std_logic_vector (7 downto 0); -- for loading
		I_SHIFT_IN_8bit: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O_8bit:	out std_logic_vector(7 downto 0) -- output the current register content. HINT: should be combinational.
		-- SHIFT_OUT : out std_logic;
);
end shift_reg_8bit;


architecture behav of shift_reg_8bit is

component shift_reg
port (	I:	in std_logic_vector (3 downto 0);
        I_SHIFT_IN: in std_logic;
        sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
        clock:		in std_logic; 
        enable:		in std_logic;
        O:	out std_logic_vector(3 downto 0)
);
end component;

signal values : std_logic_vector (7 downto 0);	--saved values before it gets loaded into O
signal inshift0: std_logic;
signal inshift1: std_logic;
begin

--  Component instantiation.
shift_reg_0: shift_reg port map (I => I_8bit(7 downto 4), I_SHIFT_IN => inshift0, sel => sel, clock => clock, enable => enable, O => O_8bit(7 downto 4)); --left 4 bits
shift_reg_1: shift_reg port map (I => I_8bit(3 downto 0), I_SHIFT_IN => inshift1, sel => sel, clock => clock, enable => enable, O => O_8bit(3 downto 0)); --right 4 bits

process(I_8bit, I_SHIFT_IN_8bit, sel, enable, clock) is
begin
	if (clock='1' and enable='1') then
		if (sel="00") then
			-- do nothing
            --O_8bit <= values;

		elsif (sel ="01") then --left shift
            --write to a mux values(3) and send it in I_SHIFT_IN
            inshift1 <= I_SHIFT_IN_8bit;
            inshift0 <= values(3);
            --O_8bit <= values;
            
		elsif (sel="10") then --right shift
            inshift0 <= I_SHIFT_IN_8bit;
            inshift1 <= values(4);
            --O_8bit <= values;
		elsif (sel="11") then
			--O_8bit <= I_8bit;
            values <= I_8bit;
		end if;
		
		
	end if;
end process;

end behav;

