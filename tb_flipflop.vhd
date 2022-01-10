-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity flipflop_tb is
end;

architecture bench of flipflop_tb is

  component flipflop
  generic (Bus_Width: integer := 8);
      Port ( D : in STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
             Q : out STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
             CLK : in STD_LOGIC;
             RESET : in STD_LOGIC);
  end component;

  signal D: STD_LOGIC_VECTOR (7 downto 0);
  signal Q: STD_LOGIC_VECTOR (7 downto 0);
  signal CLK: STD_LOGIC;
  signal RESET: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: flipflop port map ( D         => D,
                           Q         => Q,
                           CLK       => CLK,
                           RESET     => RESET );
                           
  clocking: process
  begin
      CLK <= '0';
      wait for clock_period/2;
      CLK <= '1';
      wait for clock_period/2;
  end process;

  stimulus: process
  begin


    RESET <= '1';
    D <= (others=>'0');
    wait for clock_period/2;
    RESET <= '0';
    wait for clock_period/2;
    D <= "00000001";
    wait for clock_period;
    D <= "00000010";
  end process;

end;