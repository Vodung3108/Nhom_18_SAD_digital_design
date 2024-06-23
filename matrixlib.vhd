LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

PACKAGE matrixlib IS

    --Counter
    COMPONENT counter_n IS
        GENERIC (
            datawidth : INTEGER
        );
        PORT (
            CLK, Reset : IN STD_LOGIC;
            en : IN STD_LOGIC;
            ld : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0)
        );
    END COMPONENT;

    --Memory
    COMPONENT dpmem IS
        GENERIC (
            datawidth : INTEGER
        );
        PORT (
            RAM_ADDR : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0); 
            RAM_DATA_IN : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0); 
            WE : IN STD_LOGIC; 
            RE : IN STD_LOGIC; 
            CLK : IN STD_LOGIC; 
            RAM_DATA_OUT : OUT STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0) 
        );
    END COMPONENT;

    --Datapath
    COMPONENT datapath IS
        GENERIC (
            datawidth : INTEGER
        );
        PORT (
            CLK, Reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            Data_A, Data_B : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
            WE_A, WE_B, RE_A, RE_B, LD_Addr_A, LD_Addr_B : IN STD_LOGIC;
            WE_C, RE_C : IN STD_LOGIC;
            dout_sel : IN STD_LOGIC;
            LD_i : IN STD_LOGIC;
            EN_i : IN STD_LOGIC;

            Zi : OUT STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0)

        );
    END COMPONENT;

    --Controller
    COMPONENT Controller IS
        PORT (
            CLK, Reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            Zi : IN STD_LOGIC;

            RE_A, RE_B, LD_Addr_A, LD_Addr_B : OUT STD_LOGIC;
            WE_C, RE_C : OUT STD_LOGIC;
            dout_sel : OUT STD_LOGIC;
            LD_i : OUT STD_LOGIC;
            EN_i : OUT STD_LOGIC;
            Done : OUT STD_LOGIC
        );
    END COMPONENT;

    --Matrix
    COMPONENT Matrix IS
        GENERIC (
            datawidth : INTEGER := 16
        );
        PORT (
            CLK, Reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            Data_A, Data_B : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
            WE_A, WE_B : IN STD_LOGIC;
            Done : OUT STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
            RE_C : OUT STD_LOGIC
        );
    END COMPONENT;

    --Register
    COMPONENT dff IS
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            Reset, CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;

END PACKAGE matrixlib;