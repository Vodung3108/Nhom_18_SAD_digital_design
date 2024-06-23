LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY counter_n IS
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
END counter_n;

ARCHITECTURE rtl OF counter_n IS
    SIGNAL preQ : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL one : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0) := (0 => '1', OTHERS => '0');
BEGIN
    PROCESS (CLK, Reset)
    BEGIN
        IF (Reset = '1') THEN
            preQ <= D;
        ELSIF (CLK'event AND CLK = '1') THEN
            IF ld = '1' THEN
                preQ <= D;
            ELSIF en = '1' THEN
                preQ <= preQ + one;
            END IF;
        END IF;
    END PROCESS; 
    Q <= preQ;

END ARCHITECTURE rtl;