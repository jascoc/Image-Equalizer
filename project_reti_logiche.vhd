----------------------------------------------------------------------------------
--
-- Prova Finale (Progetto di Reti Logiche)
--
-- Jasco Chen      (Codice Persona 10662235)
-- Simone Coluccio (Codice Persona 10633129)
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity project_reti_logiche is
port (
      i_clk     : in std_logic;
      i_rst     : in std_logic;
      i_start   : in std_logic;
      i_data    : in std_logic_vector(7 downto 0);
      o_address : out std_logic_vector(15 downto 0);
      o_done    : out std_logic;
      o_en      : out std_logic;
      o_we      : out std_logic;
      o_data    : out std_logic_vector (7 downto 0)
);
end project_reti_logiche;
architecture Behavioral of project_reti_logiche is
component datapath is
Port(i_clk : in std_logic;
    i_rst : in std_logic;
    i_data : in std_logic_vector(7 downto 0);
    o_data : out std_logic_vector (7 downto 0);
    r1_load : in std_logic;
    r2_load : in std_logic;
    r3_sel : in std_logic;
    r3_load : in std_logic;
    r4_sel : in std_logic;
    r4_load : in std_logic;
    r5_sel : in std_logic;
    r5_load : in std_logic;
    r6_load : in std_logic;
    r7_load : in std_logic;
    r8_load : in std_logic;
    r9_load : in std_logic;
    r10_load : in std_logic;
    r11_load : in std_logic;
    r12_load : in std_logic;
    r13_load : in std_logic;
    r15_sel : in std_logic;
    r15_load : in std_logic;
    r16_load : in std_logic;
    o_data_load : in std_logic;
    dim_end : out std_logic;
    in_end : out std_logic;
    out_done: out std_logic;
    max : out std_logic;
    min : out std_logic);
end component;
signal address : std_logic_vector (15 downto 0);
signal r1_load : std_logic;
signal r2_load : std_logic;
signal r3_sel : std_logic;
signal r3_load : std_logic;
signal r4_sel : std_logic;
signal r4_load : std_logic;
signal r5_sel : std_logic;
signal r5_load : std_logic;
signal r6_load : std_logic;
signal r7_load : std_logic;
signal r8_load : std_logic;
signal r9_load : std_logic;
signal r10_load : std_logic;
signal r11_load : std_logic;
signal r12_load : std_logic;
signal r13_load : std_logic;
signal r15_sel : std_logic;
signal r15_load : std_logic;
signal r16_load : std_logic;
signal out_address : std_logic_vector(15 downto 0);
signal o_data_load : std_logic;
signal dim_end : STD_LOGIC;
signal in_end : std_logic;
signal out_done : std_logic;
signal max : std_logic;
signal min : std_logic;
type S is (START, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24, S25, S26, S27, FINISH);
signal current_state, next_state : S;
begin
    DATAPATH0 : datapath port map(
    i_clk => i_clk,
    i_rst => i_rst,
    i_data => i_data,
    o_data => o_data,
    r1_load => r1_load,
    r2_load => r2_load,
    r3_sel => r3_sel,
    r3_load => r3_load,
    r4_sel => r4_sel,
    r4_load => r4_load,
    r5_sel => r5_sel,
    r5_load => r5_load,
    r6_load => r6_load,
    r7_load => r7_load,
    r8_load => r8_load,
    r9_load => r9_load,
    r10_load => r10_load,
    r11_load => r11_load,
    r12_load => r12_load,
    r13_load => r13_load,
    r15_sel => r15_sel,
    r15_load => r15_load,
    r16_load => r16_load,
    o_data_load => o_data_load,
    dim_end => dim_end,
    in_end => in_end,
    out_done => out_done,
    max => max,
    min => min
    );

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            current_state <= START;
        elsif i_clk'event and i_clk = '1' then
            current_state <= next_state;
        end if;
    end process;
    
    process(i_start, current_state, dim_end, in_end, out_done, max, min)
    begin
        next_state <= current_state;
        case current_state is
            when START =>
                if i_start = '1' then next_state <= S1;
                else next_state <= START;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                next_state <= S4;
            when S4 =>
                if dim_end = '0' then next_state <= S5;
                else next_state <= S6;
                end if;
            when S5 =>
                if dim_end = '0' then next_state <= S5;
                else next_state <= S6;
                end if;
            when S6 =>
                next_state <= S7;
            when S7 =>
                if in_end = '0' then next_state <= S8;
                else next_state <= FINISH;
                end if;
            when S8 =>
                next_state <= S9;
            when S9 =>
                next_state <= S10;
            when S10 =>
                if in_end = '0' then next_state <= S11;
                else next_state <= S16;
                end if;
            when S11 =>
                next_state <= S12;
            when S12 =>
                next_state <= S13; 
            when S13 =>
                if min /= '0' then next_state <= S14;
                    elsif max /= '0' then next_state <= S15;
                    else next_state <= S10;
                end if;   
            when S14 =>
                next_state <= S10;
            when S15 =>
                next_state <= S10;
            when S16 =>
                next_state <= S17;
            when S17 =>
                next_state <= S18;
            when S18 =>
                next_state <= S19;
            when S19 =>
                next_state <= S20;
            when S20 =>
                if out_done = '0' then next_state <= S21;
                else next_state <= FINISH;
                end if;
            when S21 =>
                next_state <= S22;    
            when S22 =>
                next_state <= S23;
            when S23 =>
                next_state <= S24;
            when S24 =>
                next_state <= S25;
            when S25 =>
                next_state <= S26;
            when S26 =>
                next_state <= S27;
            when S27 =>
                next_state <= S20;
            when FINISH =>
                if i_start = '0' then next_state <= START;
                end if;
        end case;
    end process;
    
    process(current_state)
    begin
    o_done <= '0';
    o_en <= '0';
    o_we <= '0';
    r1_load <= '0';
    r2_load <= '0';
    r3_sel <= '0';
    r3_load <= '0';
    r4_sel <= '0';
    r4_load <= '0';
    r5_sel <= '0';
    r5_load <= '0';
    r6_load <= '0';
    r7_load <= '0';
    r8_load <= '0';
    r9_load <= '0';
    r10_load <= '0';
    r11_load <= '0';
    r12_load <= '0';
    r13_load <= '0';
    r15_sel <= '0';
    r15_load <= '0';
    r16_load <= '0';
    o_data_load <= '0';
    dim_end <= '0';
    in_end <= '0';
    out_done <= '0';
    max <= '0';
    min <= '0';
    case current_state is
            when START =>
            when S1 =>
                --leggo l'elemento in pos 0
                o_address <= "0000000000000000";
                o_en <= '1';
            when S2 =>
                --carico il primo valore letto nel primo reg
                r1_load <= '1';
                --carico 0 nel risultato
                r3_sel <= '0';
                r3_load <= '1';
                --leggo l'elemento in pos 1
                o_address <= "0000000000000001";
                o_en <= '1';
            when S3 =>
                --carico il secondo valore letto (i_data) in r4
                r4_sel <= '0';
                r4_load <= '1';
            when S4 =>
                --decremento r4
                r4_sel <= '1';
                r4_load <= '1';
            when S5 =>
                --decremento r4
                r4_sel <= '1';
                r4_load <= '1';
                --incremento il risultato della moltiplicazione
                r3_sel <= '1';
                r3_load <= '1';
            when S6 =>
                --copio le dim dell'immagine in r5
                r5_sel <= '0';
                r5_load <= '1';
            when S7 =>
                --se l'immagine non ha dim 0
                --leggo il primo pixel dell'immagine
                if in_end /= '1' then
                address   <= "0000000000000010";
                o_address <= "0000000000000010";
                o_en <= '1';
                end if;
            when S8 =>
                --salvo il current pixel
                r2_load <= '1';
                --decremento r5
                r5_sel <= '1';
                r5_load <= '1';
            when S9 =>
                --il primo valore letto è sia massimo che minimo
                r6_load <= '1';
                r7_load <= '1';
            when S10 =>
                --se l'immagine non ha dimensione 0 (ciclo)
                if in_end = '0' then
                --aggiorno l'indirizzo di lettura
                address <= address + "0000000000000001";
                --decremento r5
                r5_sel <= '1';
                r5_load <= '1';
                end if;
            when S11 =>
                --richiesta di lettura
                address <= address;  
                o_address <= address;
                o_en <= '1';
                --r2_load <= '1';
            when S12 =>
                --salvo il current pixel
                r2_load <= '1';
            when S13 =>    
            when S14 =>
                --aggiorno il min_value
                r6_load <= '1';
            when S15 =>
                --aggiorno il max_value
                r7_load <= '1';
            when S16 =>
                --max - min
                r8_load <= '1';
            when S17 =>
                --delta value + 1
                r9_load <= '1';
                out_address <= address;
            when S18 =>
                --calcolo log
                r10_load <= '1';
                address <= "0000000000000001";
            when S19 =>
                --calcolo shift level
                r11_load <= '1';
                --carico r5 in r15
                r15_load <= '1';
                r15_sel <= '0';
            when S20 =>
                --se ho completato la scrittura (ciclo)
                if out_done = '0' then
                --incremento gli indirizzi di lettura e scrittura
                address <= address + "0000000000000001";
                out_address <= out_address + "0000000000000001";
                end if;
            when S21 =>
                --assegno l'indirizzo di lettura
                o_address <= address;
            when S22 =>
                --richiesta di lettura
                o_en <= '1';
            when S23 =>
                --salvo il current pixel
                r16_load <= '1';
            when S24 =>
                --current-min
               r12_load <= '1';
            when S25 =>
                --shifto il valore ottenuto
                r13_load <= '1';
                --assegno l'indirizzo di scrittura
                o_address <= out_address;
            when S26 =>
                --incremento r15
                r15_sel <= '1';
                r15_load <= '1';
                --carico new pixel value in o_data
                o_data_load <= '1';
            when S27 =>
                --scrittura in memoria
                o_we <= '1';
                o_en <= '1';
            when FINISH =>
                o_done <= '1';
    end case;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity datapath is
Port (
    i_clk         : in std_logic;
    i_rst         : in std_logic;
    i_data        : in std_logic_vector(7 downto 0);
    o_data        : out std_logic_vector (7 downto 0);
    r1_load       : in std_logic;
    r2_load       : in std_logic;
    r3_sel        : in std_logic;
    r3_load       : in std_logic;
    r4_sel        : in std_logic;
    r4_load       : in std_logic;
    r5_sel        : in std_logic;
    r5_load       : in std_logic;
    r6_load       : in std_logic;
    r7_load       : in std_logic;
    r8_load       : in std_logic;
    r9_load       : in std_logic;
    r10_load      : in std_logic;
    r11_load      : in std_logic;
    r12_load      : in std_logic;
    r13_load      : in std_logic;
    r15_sel       : in std_logic;
    r15_load      : in std_logic;
    r16_load      : in std_logic;
    o_data_load   : in std_logic;
    dim_end       : out STD_LOGIC;
    in_end        : out std_logic;
    out_done      : out std_logic;
    max           : out std_logic;
    min           : out std_logic
);
end datapath;
architecture Behavioral of datapath is
signal col : STD_LOGIC_VECTOR (7 downto 0);
signal pixel : STD_LOGIC_VECTOR (7 downto 0);
signal img_dim : std_logic_vector (15 downto 0);
signal o_r4 : STD_LOGIC_VECTOR (7 downto 0);
signal o_r5 : STD_LOGIC_VECTOR (15 downto 0);
signal min_value : STD_LOGIC_VECTOR (7 downto 0);
signal max_value : STD_LOGIC_VECTOR (7 downto 0);
signal delta_value : STD_LOGIC_VECTOR (7 downto 0);
signal delta_value1 : STD_LOGIC_VECTOR (15 downto 0);
signal floor_log : STD_LOGIC_VECTOR (7 downto 0);
signal shift_level : STD_LOGIC_VECTOR (7 downto 0);
signal curr_min : STD_LOGIC_VECTOR (15 downto 0);
signal temp_pixel : STD_LOGIC_VECTOR (15 downto 0);
signal o_r15 : STD_LOGIC_VECTOR (15 downto 0);
signal curr_pixel : STD_LOGIC_VECTOR (7 downto 0);
signal r3_sum : STD_LOGIC_VECTOR(15 downto 0);
signal r9_sum : STD_LOGIC_VECTOR(15 downto 0);
signal r15_sum : STD_LOGIC_VECTOR(15 downto 0);
signal r4_sub : STD_LOGIC_VECTOR(7 downto 0);
signal r5_sub : std_logic_vector(15 downto 0);
signal r8_sub : STD_LOGIC_VECTOR(7 downto 0);
signal r11_sub : STD_LOGIC_VECTOR(7 downto 0);
signal r12_sub : STD_LOGIC_VECTOR(15 downto 0);
signal mux_r3 : STD_LOGIC_VECTOR(15 downto 0);
signal mux_r4 : STD_LOGIC_VECTOR(7 downto 0);
signal mux_r5 : STD_LOGIC_VECTOR(15 downto 0);
signal mux_r15 : STD_LOGIC_VECTOR(15 downto 0);
signal min_out : std_logic;

begin
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            col <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r1_load = '1') then
                col <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            pixel <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r2_load = '1') then
                pixel <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            img_dim <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r3_load = '1') then
                img_dim <= mux_r3;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_r4 <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r4_load = '1') then
                o_r4 <= mux_r4;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_r5 <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r5_load = '1') then
                o_r5 <= mux_r5;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            min_value <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r6_load = '1') then
                min_value <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            max_value <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r7_load = '1') then
                max_value <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            delta_value <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r8_load = '1') then
                delta_value <= r8_sub;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            delta_value1 <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r9_load = '1') then
                delta_value1 <= r9_sum;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            floor_log <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r10_load = '1') then
                if   (delta_value1 < "0000000000000010") then
                    floor_log <= "00000000";
                elsif(delta_value1 < "0000000000000100") then
                    floor_log <= "00000001";
                elsif(delta_value1 < "0000000000001000") then
                    floor_log <= "00000010";
                elsif(delta_value1 < "0000000000010000") then
                    floor_log <= "00000011";
                elsif(delta_value1 < "0000000000100000") then
                    floor_log <= "00000100";
                elsif(delta_value1 < "0000000001000000") then
                    floor_log <= "00000101";
                elsif(delta_value1 < "0000000010000000") then
                    floor_log <= "00000110";
                elsif(delta_value1 < "0000000100000000") then
                    floor_log <= "00000111";
                elsif(delta_value1 = "0000000100000000") then
                    floor_log <= "00001000";
                end if;
            end if;
        end if;
    end process;    
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            shift_level <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r11_load = '1') then
                shift_level <= r11_sub;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            curr_min <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r12_load = '1') then
                curr_min <= r12_sub;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            temp_pixel <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r13_load = '1') then
                temp_pixel <= std_logic_vector(shift_left(unsigned(curr_min), to_integer(unsigned(shift_level))));
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_r15 <= "0000000000000000";
        elsif i_clk'event and i_clk = '1' then
            if(r15_load = '1') then
                o_r15 <= mux_r15;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            curr_pixel <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(r16_load = '1') then
                curr_pixel <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_data <= "00000000";
        elsif i_clk'event and i_clk = '1' then
            if(o_data_load = '1') then
                if min_out = '0' then o_data <= temp_pixel(7 downto 0);
                elsif min_out = '1' then o_data <= "11111111";
                end if;
            end if;
        end if;
    end process;
    
    r3_sum <= ("00000000" & col) + img_dim;
    r9_sum <= ("00000000" & delta_value) + "0000000000000001";
    r15_sum <= o_r15 + "0000000000000001";
    
    r4_sub <= o_r4 - "00000001";
    r5_sub <= o_r5 - "0000000000000001";
    r8_sub <= max_value - min_value;
    r11_sub <= "00001000" - floor_log;
    r12_sub <= "00000000" & (curr_pixel - min_value);
    
    dim_end <= '1' when (o_r4 = "00000000") 
   	    else '0';
    max <= '1' when (i_data > max_value) 
	   else '0'; 
    min <= '1' when (i_data < min_value)
	   else '0';
    in_end <= '1' when (o_r5 = "0000000000000000")
	   else '0';
    out_done <= '1' when (o_r15 = img_dim)
	   else '0';
    min_out <=  '1' when ("0000000011111111" < temp_pixel)
       else '0';

    with r3_sel select
    mux_r3 <= "0000000000000000" when '0',
                r3_sum when '1',
                "XXXXXXXXXXXXXXXX" when others;
                
    with r4_sel select
    mux_r4 <= i_data when '0',
                r4_sub when '1',
                "XXXXXXXX" when others;	
                
    with r5_sel select
    mux_r5 <= img_dim when '0',
                r5_sub when '1',
                "XXXXXXXXXXXXXXXX" when others;
                
    with r15_sel select
    mux_r15 <= o_r5 when '0',
                r15_sum when '1',
                "XXXXXXXXXXXXXXXX" when others;   
                                    
end Behavioral;