LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY dpmem IS
    GENERIC (
        datawidth : INTEGER
    );
    PORT (
        RAM_ADDR : IN STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0);
        RAM_DATA_IN : IN STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0); 
        WE : IN STD_LOGIC; 
        RE : IN STD_LOGIC; 
        CLK : IN STD_LOGIC; 
        RAM_DATA_OUT : OUT STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0) 
    );
END dpmem;

ARCHITECTURE rtl OF dpmem IS
    TYPE RAM_ARRAY IS ARRAY (0 TO (2**16 - 1)) OF STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);

    -- Initial values in the RAM
    SIGNAL RAM : RAM_ARRAY := (OTHERS => (OTHERS => '0'));

BEGIN
    -- Write matrix data to RAM
    PROCESS (CLK)
    BEGIN
        IF CLK'EVENT and CLK = '1' THEN
            IF WE = '1' THEN
                RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
            END IF;
        END IF;
    END PROCESS;

    -- Read matrix data from RAM
    PROCESS (CLK)
    BEGIN
        IF CLK'EVENT and CLK = '1' THEN
            IF RE = '1' THEN
                RAM_DATA_OUT <= RAM(to_integer(unsigned(RAM_ADDR)));
            END IF;
        END IF;
    END PROCESS;
END rtl;