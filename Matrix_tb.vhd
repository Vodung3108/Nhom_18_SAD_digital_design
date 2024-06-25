LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.matrixlib.ALL;

ENTITY Matrix_tb IS

END ENTITY Matrix_tb;

ARCHITECTURE rtl OF Matrix_tb IS
    SIGNAL CLK, Reset : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL Data_A, Data_B : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL WE_A, WE_B : STD_LOGIC;
    SIGNAL Done : STD_LOGIC;
    SIGNAL data_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RE_C : STD_LOGIC;
BEGIN
    Clock_signal : PROCESS
    BEGIN
        CLK <= '1';
        WAIT FOR 10 ns;
        CLK <= '0';
        WAIT FOR 10 ns;
    END PROCESS; -- Clock_signal

    Reset_signal : PROCESS
    BEGIN
        Reset <= '1';
        WAIT FOR 50 ns;
        Reset <= '0';
        WAIT;
    END PROCESS; -- Reset_sig

    Data_A_signal : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        Data_A <= "1111111100000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000001";
        WAIT FOR 100 ns;
        Data_A <= "1111010000000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000011";
        WAIT FOR 100 ns;
        Data_A <= "1111000000000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000101";
        WAIT FOR 100 ns;
        Data_A <= "1111100000000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000001011";
        WAIT FOR 100 ns;
        Data_A <= "0000000000100000";
        WAIT FOR 100 ns;
        Data_A <= "1111111100000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000001";
        WAIT FOR 100 ns;
        Data_A <= "1111010000000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000011";
        WAIT FOR 100 ns;
        Data_A <= "1111000000000000";
        WAIT FOR 100 ns;
        Data_A <= "0000000000000101";
        WAIT FOR 100 ns;
        Data_A <= "1111100000000000";
        WAIT;

    END PROCESS; -- Data_A_sig

    Data_B_signal : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        Data_B <= "0000000000001000";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000111";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000110";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000101";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000100";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000011";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000010";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000001";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000000";
        WAIT FOR 100 ns;
        Data_B <= "0000000000001000";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000111";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000110";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000101";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000011";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000010";
        WAIT FOR 100 ns;
        Data_B <= "0000000000000001";
        WAIT;
    END PROCESS; -- Data_B_sig


    WE_A_signal : PROCESS
    BEGIN
        WE_A <= '0';
        WAIT FOR 100 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_A <= '1';
        WAIT FOR 20 ns;
        WE_A <= '0';
        WAIT FOR 70 ns;
        WAIT;
    END PROCESS; -- WE_A_sig

    WE_B_sig : PROCESS
    BEGIN
        WE_B <= '0';
        WAIT FOR 100 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT FOR 10 ns;
        WE_B <= '1';
        WAIT FOR 20 ns;
        WE_B <= '0';
        WAIT FOR 70 ns;
        WAIT;
    END PROCESS; -- WE_B_sig

    start_signal : PROCESS
    BEGIN
        start <= '0';
        WAIT FOR 2500 ns;
        start <= '1';
        WAIT FOR 2000 ns;
        start <= '0';
        WAIT;
    END PROCESS; -- start_sig

    test : Matrix
    PORT MAP(
        CLK, Reset,
        start,
        Data_A, Data_B,
        WE_A, WE_B,
        Done,
        data_out,
        RE_C
    );
END ARCHITECTURE rtl;