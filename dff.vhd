LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dff IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        En : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END dff;

ARCHITECTURE RTL OF dff IS
BEGIN

    PROCESS (RST, CLK)
    BEGIN
        IF (RST = '1') THEN
            Q <= (OTHERS => '0');
        ELSIF (CLK'event AND CLK = '1') THEN
            IF (EN = '1') THEN
                Q <= D;
            END IF;
        END IF;
    END PROCESS;
END RTL;