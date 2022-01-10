-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity structure_tb is
end;

architecture bench of structure_tb is

  component structure
      Port ( CLK : in STD_LOGIC;
             RESET_ALL : in STD_LOGIC;
             CAMERA : in STD_LOGIC_VECTOR (7 downto 0);
             P : out STD_LOGIC_VECTOR (7 downto 0);
             EN_W : out STD_LOGIC);
  end component;

  signal CLK: STD_LOGIC;
  signal RESET_ALL: STD_LOGIC;
  signal CAMERA: STD_LOGIC_VECTOR (7 downto 0);
  signal P: STD_LOGIC_VECTOR (7 downto 0);
  signal EN_W: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: structure port map ( CLK       => CLK,
                            RESET_ALL => RESET_ALL,
                            CAMERA    => CAMERA,
                            P         => P,
                            EN_W      => EN_W );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;