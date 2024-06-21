LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.matrixlib.ALL;

ENTITY Matrix IS
    GENERIC (
        size : INTEGER := 4;
        matrix_size : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001"
    );
    PORT (
        CLK, Reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        Data_A, Data_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

        WE_A, WE_B : IN STD_LOGIC;
        Addr_A_in, Addr_B_in : IN STD_LOGIC_VECTOR((size - 1) DOWNTO 0);

        Done : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        RE_C : OUT STD_LOGIC
    );
END ENTITY Matrix;

ARCHITECTURE rtl OF Matrix IS
    SIGNAL WE_A_control, WE_B_control, RE_A, RE_B : STD_LOGIC;
    SIGNAL WE_A_or, WE_B_or : STD_LOGIC;
    SIGNAL WE_C, RE_C_control : STD_LOGIC;
    SIGNAL dout_sel : STD_LOGIC;
    SIGNAL LD_i, EN_i : STD_LOGIC;
    SIGNAL Zi : STD_LOGIC;
BEGIN
    WE_A_or <= WE_A OR WE_A_control;
    WE_B_or <= WE_B OR WE_B_control;
    RE_C <= RE_C_control;
    data_unit : datapath
    GENERIC MAP(
        size,
        matrix_size
    )
    PORT MAP(
        CLK, Reset,
        start,
        Data_A, Data_B,
        Addr_A_in, Addr_B_in,
        WE_A_or, WE_B_or, RE_A, RE_B,
        WE_C, RE_C_control,
        dout_sel,
        LD_i,
        EN_i,
        Zi,
        data_out
    );

    control_unit : Controller
    PORT MAP(
        CLK, Reset,
        start,
        Zi,
        WE_A_control, WE_B_control, RE_A, RE_B,
        WE_C, RE_C_control,
        dout_sel,
        LD_i,
        EN_i,
        Done
    );
END ARCHITECTURE rtl;