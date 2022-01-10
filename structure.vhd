----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2021 15:42:27
-- Design Name: 
-- Module Name: structure - Behavioral
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

entity structure_m is
    Port ( CLK : in STD_LOGIC;
           RESET_ALL : in STD_LOGIC;
           CAMERA : in STD_LOGIC_VECTOR (7 downto 0); --Entrée           
           S1,S2,S3,S4,S5,S6,S7,S8,S0 : out STD_LOGIC_VECTOR (7 downto 0); --Sortie
           EN_R : in STD_LOGIC; 
           EN_W : out STD_LOGIC);
end structure_m;

architecture Behavioral of structure_m is

signal p8:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p7:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p6:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p5:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p4:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p3:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p2:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal p1:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');

signal outfifo2:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal outfifo1:STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');

signal flipflopWait: STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');
signal flipflopWait2: STD_LOGIC_VECTOR(8 downto 0) := (others=>'0');

component flipflop
  generic (Bus_Width: integer := 9);
    Port ( D : in STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
           Q : out STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC);
  end component;
  
  signal D: STD_LOGIC_VECTOR (8 downto 0);
  signal Q: STD_LOGIC_VECTOR (8 downto 0);
  signal RESET: STD_LOGIC;
 
 component fifo_generator_0
  Port (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
end component;

    signal rst : STD_LOGIC;
    signal wr_en : STD_LOGIC;
    signal rd_en : STD_LOGIC;
    signal prog_full_thresh : STD_LOGIC_VECTOR(9 DOWNTO 0):="0001111100";
    signal full : STD_LOGIC;
    signal almost_full : STD_LOGIC;
    signal empty : STD_LOGIC;
    signal data_count : STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal prog_full : STD_LOGIC;
    signal wr_rst_busy : STD_LOGIC;
    signal rd_rst_busy : STD_LOGIC;
    
    signal rst2 : STD_LOGIC;
    signal wr_en2 : STD_LOGIC;
    signal rd_en2 : STD_LOGIC;
    signal prog_full_thresh2 : STD_LOGIC_VECTOR(9 DOWNTO 0):="0001111100";
    signal full2 : STD_LOGIC;
    signal almost_full2 : STD_LOGIC;
    signal empty2 : STD_LOGIC;
    signal data_count2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal prog_full2 : STD_LOGIC;
    signal wr_rst_busy2 : STD_LOGIC;
    signal rd_rst_busy2 : STD_LOGIC;

    signal INPUT: STD_LOGIC_VECTOR (8 downto 0);
    signal OUTPUT: STD_LOGIC_VECTOR (8 downto 0);
    
    signal inWait1 : STD_LOGIC_VECTOR (8 downto 0);
    signal outWait1 : STD_LOGIC_VECTOR (8 downto 0);
    
    signal inWait2 : STD_LOGIC_VECTOR (8 downto 0);
    signal outWait2 : STD_LOGIC_VECTOR (8 downto 0);
    
begin

bascule_9: flipflop port map (D => INPUT, Q => p8, CLK => CLK, RESET => RESET_ALL );
bascule_8: flipflop port map (D => p8, Q => p7,CLK => CLK,RESET => RESET_ALL );
bascule_7: flipflop port map (D => p7, Q => p6,CLK => CLK,RESET => RESET_ALL );
                         
fifo_2: fifo_generator_0 port map(
                         clk => CLK, 
                         rst => RESET_ALL, 
                         din => p6, 
                         wr_en => p6(0), 
                         rd_en => prog_full, 
                         prog_full_thresh => prog_full_thresh, 
                         dout => outfifo2, 
                         full => full,
                         almost_full => almost_full,
                         empty => empty,
                         data_count => data_count,
                         prog_full => prog_full, 
                         wr_rst_busy => wr_rst_busy,
                         rd_rst_busy => rd_rst_busy 
);

bascule_temp1: flipflop port map ( 
                         D     => inWait1,
                         Q     => outWait1,
                         CLK   => CLK,
                         RESET => RESET_ALL );

bascule_6: flipflop port map (D => flipflopWait,Q => p5,CLK => CLK,RESET => RESET_ALL );
bascule_5: flipflop port map (D => p5,Q => p4,CLK   => CLK,RESET => RESET_ALL );
bascule_4: flipflop port map (D => p4,Q => p3,CLK   => CLK,RESET => RESET_ALL );

fifo_1: fifo_generator_0 port map(
                         clk => CLK, 
                         rst => RESET_ALL, 
                         din => p3, 
                         wr_en => p3(0), 
                         rd_en => prog_full2, 
                         prog_full_thresh => prog_full_thresh2, 
                         dout => outfifo1, 
                         full => full2,
                         almost_full => almost_full2,
                         empty => empty2,
                         data_count => data_count2,
                         prog_full => prog_full2, 
                         wr_rst_busy => wr_rst_busy2,
                         rd_rst_busy => rd_rst_busy2 
);

bascule_temp2: flipflop port map ( 
                         D     => inWait2,
                         Q     => outWait2,
                         CLK   => CLK,
                         RESET => RESET_ALL );
                         
bascule_3: flipflop port map (D => flipflopWait2,Q => p2,CLK   => CLK,RESET => RESET_ALL );
bascule_2: flipflop port map (D => p2,Q => p1,CLK   => CLK,RESET => RESET_ALL );

bascule_1: flipflop port map (D => p1, Q => OUTPUT,CLK   => CLK,RESET => RESET_ALL );
                         
process (CLK,RESET_ALL)

    begin
    
    if(RESET_ALL = '1')then
        INPUT <= (others=>'0');
        EN_W <= '0';
    else
        if (CLK'event and CLK ='1') then  
                    
            inWait1 <= "00000000" & prog_full; 
            flipflopWait <= outfifo2(8 downto 1) & outWait1(0);
            
            inWait2 <= "00000000" & prog_full2; 
            flipflopWait2 <= outfifo1(8 downto 1) & outWait2(0);
             
            INPUT <= CAMERA & EN_R;    
            S0 <= OUTPUT(8 downto 1);
            S1 <= p1(8 downto 1);
            S2 <= p2(8 downto 1);
            S3 <= p3(8 downto 1);
            S4 <= p4(8 downto 1);
            S5 <= p5(8 downto 1);
            S6 <= p6(8 downto 1);
            S7 <= p7(8 downto 1);
            S8 <= p8(8 downto 1);
            
            if(prog_full='1' or empty = '0') and p1(0)='1' then
                EN_W <= OUTPUT(0);
            else
                EN_W <= '0';
            end if;        
        end if;
    end if;
    
    end process;
                         
end architecture Behavioral;
