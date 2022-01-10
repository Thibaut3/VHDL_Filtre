----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 08:59:25
-- Design Name: 
-- Module Name: filtre - Behavioral
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
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity filtre is
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
end filtre;

architecture Behavioral of filtre is

--[111][101][111]
signal coefBlur: unsigned (8 downto 0) := "111101111"; 

--pixel
signal p1: unsigned (7 downto 0);
signal p2: unsigned (7 downto 0);
signal p3: unsigned (7 downto 0);
signal p4: unsigned (7 downto 0);
signal p5: unsigned (7 downto 0);
signal p6: unsigned (7 downto 0);
signal p7: unsigned (7 downto 0);
signal p8: unsigned (7 downto 0);
signal p9: unsigned (7 downto 0);

--pixel avec coef
signal pound1 : unsigned (15 downto 0);
signal pound2 : unsigned (15 downto 0);
signal pound3 : unsigned (15 downto 0);
signal pound4 : unsigned (15 downto 0);
signal pound5 : unsigned (15 downto 0);
signal pound6 : unsigned (15 downto 0);
signal pound7 : unsigned (15 downto 0);
signal pound8 : unsigned (15 downto 0);
signal pound9 : unsigned (15 downto 0);

-- Résultat des additions
signal add1 : unsigned (16 downto 0); --Premiere addition
signal add2 : unsigned (16 downto 0); --Deuxième addition
signal add3 : unsigned (16 downto 0); --Troisieme addition
signal add4 : unsigned (16 downto 0); -- Quatrième addition

signal add5 : unsigned (17 downto 0); --5e addition
signal add6 : unsigned (17 downto 0); --6e addition

signal add7 : unsigned (18 downto 0); --7e addition

signal add8 : unsigned (19 downto 0); --8e addition

signal res : unsigned (19 downto 0);

begin
    process(CLK)
    begin
    
    if(RESET_Filtre = '1') then
    
            p9 <= (others=>'0');
            p8 <= (others=>'0');
            p7 <= (others=>'0');
            p6 <= (others=>'0');
            p5 <= (others=>'0');
            p4 <= (others=>'0');
            p3 <= (others=>'0');
            p2 <= (others=>'0');
            p1 <= (others=>'0');
                        
    else if (CLK'event and CLK ='1') then  
                        
            if(inEN_W = '1')then
                outEN_W <= '1';
            else
                outEN_W <= '0';
            end if;
            
            p9 <= unsigned(S8);
            p8 <= unsigned(S7);
            p7 <= unsigned(S6);
            p6 <= unsigned(S5);
            p5 <= unsigned(S4);
            p4 <= unsigned(S3);
            p3 <= unsigned(S2);
            p2 <= unsigned(S1);
            p1 <= unsigned(S0);
            
            pound9 <= p9 * ("0000000" & coefBlur(8));
            pound8 <= p8 * ("0000000" & coefBlur(7));
            pound7 <= p7 * ("0000000" & coefBlur(6));
            pound6 <= p6 * ("0000000" & coefBlur(5));
            pound5 <= p5 * ("0000000" & coefBlur(4));
            pound4 <= p4 * ("0000000" & coefBlur(3));
            pound3 <= p3 * ("0000000" & coefBlur(2));
            pound2 <= p2 * ("0000000" & coefBlur(1));
            pound1 <= p1 * ("0000000" & coefBlur(0));            
            
            add1 <= ('0' & pound9) + ('0' & pound8);
      
            add2 <= ('0' & pound7) + ('0' & pound6);
            add3 <= ('0' & pound5) + ('0' & pound4);
            add4 <= ('0' & pound3) + ('0' & pound2);
            
            add5 <= ('0' & add1) + ('0' & add2);
            add6 <= ('0' & add3) + ('0' & add4);
            
            add7 <= ('0' & add5) + ('0' & add6);
            
            add8 <= ('0' & add7) + ("0000" & pound1);
            
            res <= add8/8;
        end if;
       end if;
    end process;
    
    OUTp <= STD_LOGIC_VECTOR(res(7 downto 0));
    
end Behavioral;
