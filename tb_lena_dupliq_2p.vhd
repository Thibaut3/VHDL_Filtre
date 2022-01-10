library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_lena_dupliq is
       
end;

architecture arch_tb_lena_dupliq of tb_lena_dupliq is


  signal I1 : std_logic_vector (7 downto 0);
  signal CLK : std_logic;
  signal O1 : std_logic_vector (7 downto 0); 
  signal DATA_AVAILABLE : std_logic;
  
  component structure
      Port ( CLK : in STD_LOGIC;
             RESET_ALL : in STD_LOGIC;
             CAMERA : in STD_LOGIC_VECTOR (7 downto 0);
             P : out STD_LOGIC_VECTOR (7 downto 0);
             EN_R : in STD_LOGIC;
             EN_W : out STD_LOGIC);
  end component;

  signal RESET_ALL: STD_LOGIC;
  signal EN_W: STD_LOGIC;
  
  constant clk_period : time := 10 ns;
  
begin

clk_process :process
   begin
		CLK <= '0';
		wait for clk_period;
		CLK <= '1';
		wait for clk_period;
   end process;

struct: structure  port map ( 
                         CLK => CLK,
                         RESET_ALL => RESET_ALL,
                         CAMERA => I1,
                         P => O1,
                         EN_R => DATA_AVAILABLE,
                         EN_W => EN_W );
                         
init_struct : process
    begin
       RESET_ALL <= '1';
       wait for clk_period*10;
       RESET_ALL <= '0';
       wait;
 end process;
   
 p_read : process
  FILE vectors : text;
  variable Iline : line;
  variable I1_var :std_logic_vector (7 downto 0);
 
    begin
	DATA_AVAILABLE <= '0';
	RESET_ALL <= '1';
    file_open (vectors,"C:\Users\tj868158\Lena128x128g_8bits.dat", read_mode);
    wait for 100 ns;
    RESET_ALL <= '0';
    wait for 100 ns;
    
    while not endfile(vectors) loop
      readline (vectors,Iline);
      read (Iline,I1_var);
                
      I1 <= I1_var;
	  DATA_AVAILABLE <= '1';
	  wait for 10 ns;
    end loop;
    DATA_AVAILABLE <= '0';
    wait for 10 ns;
    file_close (vectors);
    wait;
 end process;

p_write: process
  file results : text;
  variable OLine : line;
  variable O1_var :std_logic_vector (7 downto 0);
    
    begin
    file_open (results,"C:\Users\tj868158\Lena128x128g_8bits_r.dat", write_mode);
    wait for 10 ns;
    wait until EN_W = '1';

    while EN_W ='1' loop
      write (Oline, O1, right, 2);
      writeline (results, Oline);
      wait for 10 ns;  
    end loop;
    file_close (results);
    wait;
 end process;
--Instancier composant filtre à place de la simple recopie entre I1 vers sortie O1 (top)
--O1 <= I1;
  
end arch_tb_lena_dupliq;

