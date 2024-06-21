LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY counter_n IS
    GENERIC (
        size : INTEGER
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        en : IN STD_LOGIC;
        ld : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR((size - 1) DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR((size - 1) DOWNTO 0)
    );
END counter_n;

ARCHITECTURE rtl OF counter_n IS
    SIGNAL preQ : STD_LOGIC_VECTOR((size - 1) DOWNTO 0);
BEGIN
    PROCESS (rst, clk)
    BEGIN
        IF (rst = '1') THEN
            preQ <= D;
        ELSIF (clk'event AND clk = '1') THEN
            IF ld = '1' THEN
                preQ <= D;
            ELSIF en = '1' THEN
                preQ <= preQ + "0001";
            END IF;
        END IF;
    END PROCESS; -- 
    Q <= preQ;

END ARCHITECTURE rtl;