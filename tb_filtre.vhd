----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 10:43:06
-- Design Name: 
-- Module Name: tb_filtre - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_filtre is
--  Port ( );
end tb_filtre;

architecture Behavioral of tb_filtre is

    component filtre is
    Port ( S0 : in STD_LOGIC_VECTOR (7 downto 0);
           S1 : in STD_LOGIC_VECTOR (7 downto 0);
           S2 : in STD_LOGIC_VECTOR (7 downto 0);
           S3 : in STD_LOGIC_VECTOR (7 downto 0);
           S4 : in STD_LOGIC_VECTOR (7 downto 0);
           S5 : in STD_LOGIC_VECTOR (7 downto 0);
           S6 : in STD_LOGIC_VECTOR (7 downto 0);
           S7 : in STD_LOGIC_VECTOR (7 downto 0);
           S8 : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTp : out STD_LOGIC_VECTOR (7 downto 0);
           inEN_W : in STD_LOGIC;
           outEN_W : out STD_LOGIC;
           RESET_Filtre : in STD_LOGIC);
    end component;
    
    signal S0: STD_LOGIC_VECTOR (7 downto 0);
    signal S1: STD_LOGIC_VECTOR (7 downto 0);
    signal S2: STD_LOGIC_VECTOR (7 downto 0);
    signal S3: STD_LOGIC_VECTOR (7 downto 0);
    signal S4: STD_LOGIC_VECTOR (7 downto 0);
    signal S5: STD_LOGIC_VECTOR (7 downto 0);
    signal S6: STD_LOGIC_VECTOR (7 downto 0);
    signal S7: STD_LOGIC_VECTOR (7 downto 0);
    signal S8: STD_LOGIC_VECTOR (7 downto 0);
    signal CLK: STD_LOGIC;
    signal OUTp : STD_LOGIC_VECTOR (7 downto 0);
    signal inEN_W : STD_LOGIC;
    signal outEN_W : STD_LOGIC;
    signal RESET_Filtre: STD_LOGIC;

    constant clock_period: time := 10 ns;

begin
   uut: filtre port map (  S0       => S0,
                           S1       => S1,
                           S2       => S2,
                           S3       => S3,
                           S4       => S4,
                           S5       => S5,
                           S6       => S6,
                           S7       => S7,
                           S8       => S8,
                           CLK      => CLK,
                           OUTp     => OUTp,
                           inEN_W   => inEN_W,
                           outEN_W  => outEN_W,
                           RESET_Filtre    => RESET_Filtre );
                           
  clocking: process
  begin
      CLK <= '0';
      wait for clock_period/2;
      CLK <= '1';
      wait for clock_period/2;
  end process;
  
  stimulus: process
  begin
    RESET_Filtre <= '1';
    S0 <= (others=>'0');
    S1 <= (others=>'0');
    S2 <= (others=>'0');
    S3 <= (others=>'0');
    S4 <= (others=>'0');
    S5 <= (others=>'0');
    S6 <= (others=>'0');
    S7 <= (others=>'0');
    S8 <= (others=>'0');
    inEN_W <= '0';
    wait for clock_period;
    RESET_Filtre <= '0';
    wait for clock_period;
    S0 <= "00000001";
    S1 <= "00000010";
    S2 <= "00000011";
    S3 <= "00000100";
    S4 <= "00000101";
    S5 <= "00000110";
    S6 <= "00000111";
    S7 <= "00001000";
    S8 <= "00001001";
    wait;
  end process;


end Behavioral;
