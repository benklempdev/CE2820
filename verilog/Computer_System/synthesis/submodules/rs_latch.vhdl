library ieee;
use ieee.std_logic_1164.all;

entity rs_latch is
	port(
		set, reset: in std_logic;
		q, q_n: inout std_logic
	);
end entity;

architecture arch of rs_latch is
	begin
		q <= reset nor q_n;
		q_n <= set nor q;

		--  set   --- _
		--           |_>o---- q_n
		--       |---       |
		--       |--------\ /
		--                 X
		--       |--------/ \
		--       |--- _     |
		--           |_>o---- q
		-- reset  ---
end architecture;
