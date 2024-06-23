LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.matrixlib.ALL;

ENTITY datapath IS
    GENERIC (
        datawidth : INTEGER
    );
    PORT (
        CLK, Reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        Data_A, Data_B : IN STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
        WE_A, WE_B, RE_A, RE_B,LD_Addr_A,LD_Addr_B : IN STD_LOGIC;
        WE_C, RE_C : IN STD_LOGIC;
        dout_sel : IN STD_LOGIC;
        LD_i : IN STD_LOGIC;
        EN_i : IN STD_LOGIC;

        Zi : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0)

    );
END ENTITY datapath;

ARCHITECTURE rtl OF datapath IS
    SIGNAL i : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL addr_A, addr_B, addr_C : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL addr_A_in, addr_B_in : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL MA_out, MB_out, diff_A_B, diff_A_B_bu_2, abs_diff : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL diff_gt_zero : STD_LOGIC;
    SIGNAL Data_C : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL MC_out : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
    SIGNAL matrix_size : STD_LOGIC_VECTOR((datawidth - 1) DOWNTO 0);
BEGIN
    -- Comparator of i and matrix_size
    Zi <= '0' WHEN i < matrix_size ELSE 
        '1';

    -- Subtractor A - B
    diff_A_B <= MA_out - MB_out;

    -- Opposite number of A - B (by two's complement)
    diff_A_B_bu_2 <= NOT(diff_A_B) + 1;

    -- Comparator to check the difference is positive or negative
    diff_gt_zero <= '1' WHEN diff_A_B(datawidth - 1) > '0' ELSE
        '0';

    -- Multiplexor for Absolute difference
    abs_diff <= diff_A_B WHEN diff_gt_zero = '0' ELSE
        diff_A_B_bu_2;

    -- Multiplexor for SAD
    Data_C <= (others => '0') WHEN dout_sel = '1' ELSE (MC_out + abs_diff);

    -- Multiplexor for address of matrix A
    addr_A <= i WHEN start = '1' ELSE
        Addr_A_in;

    -- Multiplexor for address of matrix B
    addr_B <= i WHEN start = '1' ELSE
        Addr_B_in;

    addr_C <= i;

    data_out <= MC_out;

    -- Register matrix size
    matrix_size_dff : dff
    GENERIC MAP(datawidth)
    PORT MAP(
        Reset, CLK,
        start,
        Addr_A_in,
        matrix_size
    );

    -- Counter Address of matrix A
    cnt_Addr_A_in : counter_n
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        CLK, Reset,
        WE_A,
        LD_Addr_A,
        (others => '0'),
        Addr_A_in
    );

    -- Counter Address of matrix A
    cnt_Addr_B_in : counter_n
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        CLK, Reset,
        WE_B,
        LD_Addr_B,
        (others => '0'),
        Addr_B_in
    );

    -- Counter Address of matrix SAD
    cnt_calc : counter_n
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        CLK, Reset,
        EN_i,
        LD_i,
        (others => '0'),
        i
    );

    -- Memory for Matrix A
    MA : dpmem
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        addr_A,
        Data_A,
        WE_A,
        RE_A,
        CLK,
        MA_out
    );

    -- Memory for Matrix B
    MB : dpmem
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        addr_B,
        Data_B,
        WE_B,
        RE_B,
        CLK,
        MB_out
    );

    -- Memory for Matrix SAD
    MC : dpmem
    GENERIC MAP(
        datawidth
    )
    PORT MAP(
        addr_C,
        Data_C,
        WE_C,
        RE_C,
        CLK,
        MC_out
    );

END ARCHITECTURE rtl;