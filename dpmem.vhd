-- Single-port RAM in VHDL
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY dpmem IS
    GENERIC (
        datawidth : INTEGER
    );
    PORT (
        RAM_ADDR : IN STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0); -- Address to write/read RAM
        RAM_DATA_IN : IN STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0); -- Data to write into RAM
        en_wr : IN STD_LOGIC; -- Write enable
        en_re : IN STD_LOGIC; -- 
        RAM_CLOCK : IN STD_LOGIC; -- Clock input for RAM
        RAM_DATA_OUT : OUT STD_LOGIC_VECTOR((datawidth-1) DOWNTO 0) -- Data output of RAM
    );
END dpmem;

ARCHITECTURE rtl OF dpmem IS
    TYPE RAM_ARRAY IS ARRAY (0 TO (2**16 - 1)) OF STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);

    -- Initial values in the RAM
    SIGNAL RAM : RAM_ARRAY := (OTHERS => (OTHERS => '0')); -- Khởi tạo bộ nhớ với giá trị 0
BEGIN
    PROCESS (RAM_CLOCK)
    BEGIN
        IF rising_edge(RAM_CLOCK) THEN
            IF en_wr = '1' THEN
                -- When write enable = 1, write input data into RAM at the provided address
                RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (RAM_CLOCK)
    BEGIN
        IF rising_edge(RAM_CLOCK) THEN
            IF en_re = '1' THEN
                RAM_DATA_OUT <= RAM(to_integer(unsigned(RAM_ADDR)));
            END IF;
        END IF;
    END PROCESS;
    -- Read data from RAM
END rtl;