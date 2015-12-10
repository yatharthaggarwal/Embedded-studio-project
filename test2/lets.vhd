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
			button : in std_logic; 
			led : out std_logic;
			lcd_rw : out std_logic; ---read&write control
			lcd_e : out std_logic; ----enable control
			lcd_rs : out std_logic; ----data or command contro
			data : out std_logic_vector(7 downto 0)); ---data line
end lcd_disp;

architecture Behavioral of lcd_disp is
	constant N: integer :=17;
	type arr is array (1 to N) of std_logic_vector(7 downto 0);
	constant datas : arr := (X"38",X"0c",X"06",X"01",X"C0",X"59",X"41",X"54",X"48",X"41",X"52",X"54",X"48",X"20",X"20",X"20",X"20"); --command and data to display
	constant datap : arr := (X"38",X"0c",X"06",X"01",X"C0",X"4D",X"41",X"59",X"41",X"4E",X"4B",X"20",X"52",X"41",X"4A",X"41",X"4E"); --command and data to display
	begin
		lcd_rw <= '0'; ----lcd write
		process(clk)
			variable i : integer := 0;
			variable j : integer := 1;
			begin
			if button = '1' then led <= '1';
			
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
					
					if j = 18 then ---repeated display of data
						j := 5;
					end if;
				
				end if;
			
			else 
			led<='0';
			if clk'event and clk = '1' then
					
					if i <= 1000000 then
						i := i + 1;
						lcd_e <= '1';
						data <= datap(j)(7 downto 0);
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
					
					if j = 18 then ---repeated display of data
						j := 5;
					end if;
				
				end if;
			
			end if;
	end process;
end Behavioral;