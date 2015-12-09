library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	--Uncomment the following library declaration if instantiating
	--any Xilinx primitives in this code.
	--library UNISIM;
	--use UNISIM.VComponents.all;
entity lcd_disp is
port (   clk : in std_logic; ----clock i/p
			lcd_rw : out std_logic; ---read&write control
			lcd_e : out std_logic; ----enable control
			lcd_rs : out std_logic; ----data or command control
			data : out std_logic_vector(7 downto 0)); ---data line
end lcd_disp;

architecture Behavioral of lcd_disp is
	constant N: integer :=13;
	type arr is array (1 to N) of std_logic_vector(7 downto 0);
	constant datas : arr := (X"38",X"0c",X"06",X"01",X"C0",x"30",x"31",x"54",x"4e",x"43",x"53",x"49",x"4f"); --command and data to display
	begin
		lcd_rw <= '0'; ----lcd write
		process(clk)
			variable i : integer := 0;
			variable j : integer := 1;
			begin
			if clk'event and clk = '1' then
				if i <= 1000000 then
					i := i + 1;
					lcd_e <= '1';
					data <= datas(j)(7 downto 0);
				elsif i > 1000000 and i < 2000000 then
					i := i + 1;
					lcd_e <= '0';
				elsif i = 2000000 then
					j := j + 1;
					i := 0;
				end if;
			if j <= 5 then
				lcd_rs <= '0'; ---command signal
			elsif j > 5 then
				lcd_rs <= '1'; ----data signal
			end if;
			if j = 14 then ---repeated display of data
				j := 5;
			end if;
		end if;
	end process;
end Behavioral;