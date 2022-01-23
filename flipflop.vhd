----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2021 15:50:54
-- Design Name: 
-- Module Name: flipflop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flipflop is
generic (Bus_Width: integer := 8);
    Port ( D : in STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
           Q : out STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC);
end flipflop;

architecture Behavioral of flipflop is
begin
    process(CLK,RESET)
    begin
        if RESET='1' then
            Q <= (others=>'0');
        elsif (CLK'event and CLK ='1') then 
            Q <= D;
        end if;
    end process;
end architecture Behavioral;
