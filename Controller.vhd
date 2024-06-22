LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Controller IS
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
END ENTITY Controller;

ARCHITECTURE rtl OF Controller IS
    TYPE State_type IS (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
    SIGNAL state : State_type;
BEGIN
    Done <= '1' WHEN state = s8 OR state = s9 ELSE
        '0';
    LD_Addr_A <= '1' WHEN state = s0 ELSE
    '0';
    LD_Addr_B <= '1' WHEN state = s0 ELSE
    '0';
    dout_sel <= '1' WHEN state = s0 ELSE
        '0';
    WE_C <= '1' WHEN state = s0 OR state = s5 ELSE
        '0';
    LD_i <= '1' WHEN state = s2 OR state = s0 ELSE
        '0';
    RE_A <= '1' WHEN state = s4 ELSE
        '0';
    RE_B <= '1' WHEN state = s4 ELSE
        '0';
    RE_C <= '1' WHEN state = s6 OR state = s0 ELSE
        '0';
    EN_i <= '1' WHEN state = s7 ELSE
        '0';
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            state <= S0;
        ELSIF (clk'event AND clk = '1') THEN
            CASE state IS
                WHEN s0 =>
                    state <= s1;
                WHEN s1 =>
                    IF start = '1' THEN
                        state <= s2;
                    ELSE
                        state <= s1;
                    END IF;
                WHEN s2 =>
                    state <= s3;
                WHEN s3 =>
                    IF Zi = '0' THEN
                        state <= s4;
                    ELSE
                        state <= s8;
                    END IF;
                WHEN s4 =>
                    state <= s5;
                WHEN s5 =>
                    state <= s6;
                WHEN s6 =>
                    state <= s7;
                WHEN s7 =>
                    state <= s3;
                WHEN s8 =>
                    state <= s9;
                WHEN s9 =>
                    IF start = '0' THEN
                        state <= s0;
                    ELSE
                        state <= s9;
                    END IF;
            END CASE;
        END IF;
    END PROCESS; -- 

END ARCHITECTURE rtl;