LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.matrixlib.ALL;

ENTITY datapath IS
    GENERIC (
        size : INTEGER;
        matrix_size : STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    PORT (
        CLK, Reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        Data_A, Data_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Addr_A_in, Addr_B_in : IN STD_LOGIC_VECTOR((size - 1) DOWNTO 0);
        WE_A, WE_B, RE_A, RE_B : IN STD_LOGIC;
        WE_C, RE_C : IN STD_LOGIC;
        dout_sel : IN STD_LOGIC;
        LD_i : IN STD_LOGIC;
        EN_i : IN STD_LOGIC;

        Zi : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

    );
END ENTITY datapath;

ARCHITECTURE rtl OF datapath IS
    SIGNAL i : STD_LOGIC_VECTOR((size - 1) DOWNTO 0);
    SIGNAL addr_A, addr_B, addr_C : STD_LOGIC_VECTOR((size - 1) DOWNTO 0);
    SIGNAL MA_out, MB_out, diff_A_B : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Data_C : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MC_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    Zi <= '0' WHEN i < matrix_size ELSE
        '1';

    diff_A_B <= MA_out - MB_out WHEN signed(MA_out - MB_out) > 0 ELSE
        (MB_out - MA_out);
    Data_C <= "00000000" WHEN dout_sel = '1' ELSE
        (MC_out + diff_A_B);
    addr_A <= i when start = '1' else Addr_A_in;
    addr_B <= i when start = '1' else Addr_B_in;
    addr_C <= i;
    data_out <= MC_out;

    cnt_i : counter_n
    GENERIC MAP(
        size)
    PORT MAP(
        CLK, Reset,
        EN_i,
        LD_i,
        "0000",
        i
    );

    MA : dpmem
    PORT MAP(
        addr_A,
        Data_A,
        WE_A,
        RE_A,
        CLK,
        MA_out
    );

    MB : dpmem
    PORT MAP(
        addr_B,
        Data_B,
        WE_B,
        RE_B,
        CLK,
        MB_out
    );

    MC : dpmem
    PORT MAP(
        addr_C,
        Data_C,
        WE_C,
        RE_C,
        CLK,
        MC_out
    );

END ARCHITECTURE rtl;