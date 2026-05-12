-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/12/2026 21:02:10"
                                                                        
-- Vhdl Self-Checking Test Bench (with test vectors) for design :       cache_lru
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

PACKAGE cache_lru_vhd_tb_types IS
-- input port types                                                       
-- output port names                                                     
CONSTANT data0_name : STRING (1 TO 5) := "data0";
CONSTANT data1_name : STRING (1 TO 5) := "data1";
CONSTANT data2_name : STRING (1 TO 5) := "data2";
CONSTANT data3_name : STRING (1 TO 5) := "data3";
CONSTANT data_to_cpu_name : STRING (1 TO 11) := "data_to_cpu";
CONSTANT hit_name : STRING (1 TO 3) := "hit";
CONSTANT tag0_name : STRING (1 TO 4) := "tag0";
CONSTANT tag1_name : STRING (1 TO 4) := "tag1";
CONSTANT tag2_name : STRING (1 TO 4) := "tag2";
CONSTANT tag3_name : STRING (1 TO 4) := "tag3";
CONSTANT valid_name : STRING (1 TO 5) := "valid";
-- n(outputs)                                                            
CONSTANT o_num : INTEGER := 11;
-- mismatches vector type                                                
TYPE mmvec IS ARRAY (0 to (o_num - 1)) OF INTEGER;
-- exp o/ first change track vector type                                     
TYPE trackvec IS ARRAY (1 to o_num) OF BIT;
-- sampler type                                                            
SUBTYPE sample_type IS STD_LOGIC;                                          
-- utility functions                                                     
FUNCTION std_logic_to_char (a: STD_LOGIC) RETURN CHARACTER;              
FUNCTION std_logic_vector_to_string (a: STD_LOGIC_VECTOR) RETURN STRING; 
PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0);                                               
PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC_VECTOR; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0);                                        
PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC; real_value : IN STD_LOGIC);                                   
PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC_VECTOR; real_value : IN STD_LOGIC_VECTOR);                     

END cache_lru_vhd_tb_types;

PACKAGE BODY cache_lru_vhd_tb_types IS
        FUNCTION std_logic_to_char (a: STD_LOGIC)  
                RETURN CHARACTER IS                
        BEGIN                                      
        CASE a IS                                  
         WHEN 'U' =>                               
          RETURN 'U';                              
         WHEN 'X' =>                               
          RETURN 'X';                              
         WHEN '0' =>                               
          RETURN '0';                              
         WHEN '1' =>                               
          RETURN '1';                              
         WHEN 'Z' =>                               
          RETURN 'Z';                              
         WHEN 'W' =>                               
          RETURN 'W';                              
         WHEN 'L' =>                               
          RETURN 'L';                              
         WHEN 'H' =>                               
          RETURN 'H';                              
         WHEN '-' =>                               
          RETURN 'D';                              
        END CASE;                                  
        END;                                       

        FUNCTION std_logic_vector_to_string (a: STD_LOGIC_VECTOR)       
                RETURN STRING IS                                        
        VARIABLE result : STRING(1 TO a'LENGTH);                        
        VARIABLE j : NATURAL := 1;                                      
        BEGIN                                                           
                FOR i IN a'RANGE LOOP                                   
                        result(j) := std_logic_to_char(a(i));           
                        j := j + 1;                                     
                END LOOP;                                               
                RETURN result;                                          
        END;                                                            

        PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC; justified: IN SIDE:=RIGHT; field:IN WIDTH:=0) IS 
        BEGIN                                                           
                write(L,std_logic_to_char(VALUE),JUSTIFIED,field);      
        END;                                                            
                                                                        
        PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC_VECTOR; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0) IS                           
        BEGIN                                                               
                write(L,std_logic_vector_to_string(VALUE),JUSTIFIED,field); 
        END;                                                                

        PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC; real_value : IN STD_LOGIC) IS                               
        VARIABLE txt : LINE;                                              
        BEGIN                                                             
        write(txt,string'("ERROR! Vector Mismatch for output port "));  
        write(txt,output_port_name);                                      
        write(txt,string'(" :: @time = "));                             
        write(txt,NOW);                                                   
		writeline(output,txt);                                            
        write(txt,string'("     Expected value = "));                   
        write(txt,expected_value);                                        
		writeline(output,txt);                                            
        write(txt,string'("     Real value = "));                       
        write(txt,real_value);                                            
        writeline(output,txt);                                            
        END;                                                              

        PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC_VECTOR; real_value : IN STD_LOGIC_VECTOR) IS                 
        VARIABLE txt : LINE;                                              
        BEGIN                                                             
        write(txt,string'("ERROR! Vector Mismatch for output port "));  
        write(txt,output_port_name);                                      
        write(txt,string'(" :: @time = "));                             
        write(txt,NOW);                                                   
		writeline(output,txt);                                            
        write(txt,string'("     Expected value = "));                   
        write(txt,expected_value);                                        
		writeline(output,txt);                                            
        write(txt,string'("     Real value = "));                       
        write(txt,real_value);                                            
        writeline(output,txt);                                            
        END;                                                              

END cache_lru_vhd_tb_types;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

USE WORK.cache_lru_vhd_tb_types.ALL;                                         

ENTITY cache_lru_vhd_sample_tst IS
PORT (
	address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	clock : IN STD_LOGIC;
	data_from_memory : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	request_valid : IN STD_LOGIC;
	rst_n : IN STD_LOGIC;
	sampler : OUT sample_type
	);
END cache_lru_vhd_sample_tst;

ARCHITECTURE sample_arch OF cache_lru_vhd_sample_tst IS
SIGNAL tbo_int_sample_clk : sample_type := '-';
SIGNAL current_time : TIME := 0 ps;
BEGIN
t_prcs_sample : PROCESS ( address , clock , data_from_memory , request_valid , rst_n )
BEGIN
	IF (NOW > 0 ps) THEN
		IF (NOW > 0 ps) AND (NOW /= current_time) THEN
			IF (tbo_int_sample_clk = '-') THEN
				tbo_int_sample_clk <= '0';
			ELSE
				tbo_int_sample_clk <= NOT tbo_int_sample_clk ;
			END IF;
		END IF;
		current_time <= NOW;
	END IF;
END PROCESS t_prcs_sample;
sampler <= tbo_int_sample_clk;
END sample_arch;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

USE WORK.cache_lru_vhd_tb_types.ALL;                                         

ENTITY cache_lru_vhd_check_tst IS 
GENERIC (
	debug_tbench : BIT := '0'
);
PORT ( 
	data0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_to_cpu : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	hit : IN STD_LOGIC;
	tag0 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag1 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag2 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag3 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	valid : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	sampler : IN sample_type
);
END cache_lru_vhd_check_tst;
ARCHITECTURE ovec_arch OF cache_lru_vhd_check_tst IS
SIGNAL data0_expected,data0_expected_prev,data0_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data1_expected,data1_expected_prev,data1_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data2_expected,data2_expected_prev,data2_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data3_expected,data3_expected_prev,data3_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data_to_cpu_expected,data_to_cpu_expected_prev,data_to_cpu_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL hit_expected,hit_expected_prev,hit_prev : STD_LOGIC;
SIGNAL tag0_expected,tag0_expected_prev,tag0_prev : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag1_expected,tag1_expected_prev,tag1_prev : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag2_expected,tag2_expected_prev,tag2_prev : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag3_expected,tag3_expected_prev,tag3_prev : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL valid_expected,valid_expected_prev,valid_prev : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL trigger : BIT := '0';
SIGNAL trigger_e : BIT := '0';
SIGNAL trigger_r : BIT := '0';
SIGNAL trigger_i : BIT := '0';
SIGNAL num_mismatches : mmvec := (OTHERS => 0);

BEGIN

-- Update history buffers  expected /o
t_prcs_update_o_expected_hist : PROCESS (trigger) 
BEGIN
	data0_expected_prev <= data0_expected;
	data1_expected_prev <= data1_expected;
	data2_expected_prev <= data2_expected;
	data3_expected_prev <= data3_expected;
	data_to_cpu_expected_prev <= data_to_cpu_expected;
	hit_expected_prev <= hit_expected;
	tag0_expected_prev <= tag0_expected;
	tag1_expected_prev <= tag1_expected;
	tag2_expected_prev <= tag2_expected;
	tag3_expected_prev <= tag3_expected;
	valid_expected_prev <= valid_expected;
END PROCESS t_prcs_update_o_expected_hist;


-- Update history buffers  real /o
t_prcs_update_o_real_hist : PROCESS (trigger) 
BEGIN
	data0_prev <= data0;
	data1_prev <= data1;
	data2_prev <= data2;
	data3_prev <= data3;
	data_to_cpu_prev <= data_to_cpu;
	hit_prev <= hit;
	tag0_prev <= tag0;
	tag1_prev <= tag1;
	tag2_prev <= tag2;
	tag3_prev <= tag3;
	valid_prev <= valid;
END PROCESS t_prcs_update_o_real_hist;



-- expected hit
t_prcs_hit: PROCESS
BEGIN
	hit_expected <= '0';
	WAIT FOR 220000 ps;
	hit_expected <= 'X';
	WAIT FOR 40000 ps;
	hit_expected <= '0';
WAIT;
END PROCESS t_prcs_hit;
-- expected data_to_cpu[15]
t_prcs_data_to_cpu_15: PROCESS
BEGIN
	data_to_cpu_expected(15) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(15) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(15) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_15;
-- expected data_to_cpu[14]
t_prcs_data_to_cpu_14: PROCESS
BEGIN
	data_to_cpu_expected(14) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_14;
-- expected data_to_cpu[13]
t_prcs_data_to_cpu_13: PROCESS
BEGIN
	data_to_cpu_expected(13) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(13) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(13) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_13;
-- expected data_to_cpu[12]
t_prcs_data_to_cpu_12: PROCESS
BEGIN
	data_to_cpu_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_12;
-- expected data_to_cpu[11]
t_prcs_data_to_cpu_11: PROCESS
BEGIN
	data_to_cpu_expected(11) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(11) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_11;
-- expected data_to_cpu[10]
t_prcs_data_to_cpu_10: PROCESS
BEGIN
	data_to_cpu_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_10;
-- expected data_to_cpu[9]
t_prcs_data_to_cpu_9: PROCESS
BEGIN
	data_to_cpu_expected(9) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(9) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_9;
-- expected data_to_cpu[8]
t_prcs_data_to_cpu_8: PROCESS
BEGIN
	data_to_cpu_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_8;
-- expected data_to_cpu[7]
t_prcs_data_to_cpu_7: PROCESS
BEGIN
	data_to_cpu_expected(7) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(7) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_7;
-- expected data_to_cpu[6]
t_prcs_data_to_cpu_6: PROCESS
BEGIN
	data_to_cpu_expected(6) <= '0';
	WAIT FOR 180000 ps;
	data_to_cpu_expected(6) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(6) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(6) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_6;
-- expected data_to_cpu[5]
t_prcs_data_to_cpu_5: PROCESS
BEGIN
	data_to_cpu_expected(5) <= '0';
	WAIT FOR 100000 ps;
	data_to_cpu_expected(5) <= '1';
	WAIT FOR 80000 ps;
	data_to_cpu_expected(5) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(5) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_5;
-- expected data_to_cpu[4]
t_prcs_data_to_cpu_4: PROCESS
BEGIN
	data_to_cpu_expected(4) <= '0';
	WAIT FOR 60000 ps;
	data_to_cpu_expected(4) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(4) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(4) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(4) <= '0';
	WAIT FOR 80000 ps;
	data_to_cpu_expected(4) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_4;
-- expected data_to_cpu[3]
t_prcs_data_to_cpu_3: PROCESS
BEGIN
	data_to_cpu_expected(3) <= '0';
	WAIT FOR 220000 ps;
	data_to_cpu_expected(3) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_3;
-- expected data_to_cpu[2]
t_prcs_data_to_cpu_2: PROCESS
BEGIN
	data_to_cpu_expected(2) <= '0';
	WAIT FOR 180000 ps;
	data_to_cpu_expected(2) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(2) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(2) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_2;
-- expected data_to_cpu[1]
t_prcs_data_to_cpu_1: PROCESS
BEGIN
	data_to_cpu_expected(1) <= '0';
	WAIT FOR 100000 ps;
	data_to_cpu_expected(1) <= '1';
	WAIT FOR 80000 ps;
	data_to_cpu_expected(1) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(1) <= 'U';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_1;
-- expected data_to_cpu[0]
t_prcs_data_to_cpu_0: PROCESS
BEGIN
	data_to_cpu_expected(0) <= '0';
	WAIT FOR 60000 ps;
	data_to_cpu_expected(0) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(0) <= '0';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(0) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(0) <= '0';
	WAIT FOR 80000 ps;
	data_to_cpu_expected(0) <= '1';
	WAIT FOR 40000 ps;
	data_to_cpu_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_data_to_cpu_0;
-- expected data0[15]
t_prcs_data0_15: PROCESS
BEGIN
	data0_expected(15) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(15) <= '1';
WAIT;
END PROCESS t_prcs_data0_15;
-- expected data0[14]
t_prcs_data0_14: PROCESS
BEGIN
	data0_expected(14) <= '0';
WAIT;
END PROCESS t_prcs_data0_14;
-- expected data0[13]
t_prcs_data0_13: PROCESS
BEGIN
	data0_expected(13) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(13) <= '1';
WAIT;
END PROCESS t_prcs_data0_13;
-- expected data0[12]
t_prcs_data0_12: PROCESS
BEGIN
	data0_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_data0_12;
-- expected data0[11]
t_prcs_data0_11: PROCESS
BEGIN
	data0_expected(11) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(11) <= '1';
WAIT;
END PROCESS t_prcs_data0_11;
-- expected data0[10]
t_prcs_data0_10: PROCESS
BEGIN
	data0_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_data0_10;
-- expected data0[9]
t_prcs_data0_9: PROCESS
BEGIN
	data0_expected(9) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(9) <= '1';
WAIT;
END PROCESS t_prcs_data0_9;
-- expected data0[8]
t_prcs_data0_8: PROCESS
BEGIN
	data0_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_data0_8;
-- expected data0[7]
t_prcs_data0_7: PROCESS
BEGIN
	data0_expected(7) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(7) <= '1';
WAIT;
END PROCESS t_prcs_data0_7;
-- expected data0[6]
t_prcs_data0_6: PROCESS
BEGIN
	data0_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_data0_6;
-- expected data0[5]
t_prcs_data0_5: PROCESS
BEGIN
	data0_expected(5) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(5) <= '1';
WAIT;
END PROCESS t_prcs_data0_5;
-- expected data0[4]
t_prcs_data0_4: PROCESS
BEGIN
	data0_expected(4) <= '0';
	WAIT FOR 60000 ps;
	data0_expected(4) <= '1';
	WAIT FOR 160000 ps;
	data0_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_data0_4;
-- expected data0[3]
t_prcs_data0_3: PROCESS
BEGIN
	data0_expected(3) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(3) <= '1';
WAIT;
END PROCESS t_prcs_data0_3;
-- expected data0[2]
t_prcs_data0_2: PROCESS
BEGIN
	data0_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_data0_2;
-- expected data0[1]
t_prcs_data0_1: PROCESS
BEGIN
	data0_expected(1) <= '0';
	WAIT FOR 220000 ps;
	data0_expected(1) <= '1';
WAIT;
END PROCESS t_prcs_data0_1;
-- expected data0[0]
t_prcs_data0_0: PROCESS
BEGIN
	data0_expected(0) <= '0';
	WAIT FOR 60000 ps;
	data0_expected(0) <= '1';
	WAIT FOR 160000 ps;
	data0_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_data0_0;
-- expected data1[15]
t_prcs_data1_15: PROCESS
BEGIN
	data1_expected(15) <= '0';
WAIT;
END PROCESS t_prcs_data1_15;
-- expected data1[14]
t_prcs_data1_14: PROCESS
BEGIN
	data1_expected(14) <= '0';
WAIT;
END PROCESS t_prcs_data1_14;
-- expected data1[13]
t_prcs_data1_13: PROCESS
BEGIN
	data1_expected(13) <= '0';
WAIT;
END PROCESS t_prcs_data1_13;
-- expected data1[12]
t_prcs_data1_12: PROCESS
BEGIN
	data1_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_data1_12;
-- expected data1[11]
t_prcs_data1_11: PROCESS
BEGIN
	data1_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_data1_11;
-- expected data1[10]
t_prcs_data1_10: PROCESS
BEGIN
	data1_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_data1_10;
-- expected data1[9]
t_prcs_data1_9: PROCESS
BEGIN
	data1_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_data1_9;
-- expected data1[8]
t_prcs_data1_8: PROCESS
BEGIN
	data1_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_data1_8;
-- expected data1[7]
t_prcs_data1_7: PROCESS
BEGIN
	data1_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_data1_7;
-- expected data1[6]
t_prcs_data1_6: PROCESS
BEGIN
	data1_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_data1_6;
-- expected data1[5]
t_prcs_data1_5: PROCESS
BEGIN
	data1_expected(5) <= '0';
	WAIT FOR 100000 ps;
	data1_expected(5) <= '1';
WAIT;
END PROCESS t_prcs_data1_5;
-- expected data1[4]
t_prcs_data1_4: PROCESS
BEGIN
	data1_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_data1_4;
-- expected data1[3]
t_prcs_data1_3: PROCESS
BEGIN
	data1_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_data1_3;
-- expected data1[2]
t_prcs_data1_2: PROCESS
BEGIN
	data1_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_data1_2;
-- expected data1[1]
t_prcs_data1_1: PROCESS
BEGIN
	data1_expected(1) <= '0';
	WAIT FOR 100000 ps;
	data1_expected(1) <= '1';
WAIT;
END PROCESS t_prcs_data1_1;
-- expected data1[0]
t_prcs_data1_0: PROCESS
BEGIN
	data1_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_data1_0;
-- expected data2[15]
t_prcs_data2_15: PROCESS
BEGIN
	data2_expected(15) <= '0';
WAIT;
END PROCESS t_prcs_data2_15;
-- expected data2[14]
t_prcs_data2_14: PROCESS
BEGIN
	data2_expected(14) <= '0';
WAIT;
END PROCESS t_prcs_data2_14;
-- expected data2[13]
t_prcs_data2_13: PROCESS
BEGIN
	data2_expected(13) <= '0';
WAIT;
END PROCESS t_prcs_data2_13;
-- expected data2[12]
t_prcs_data2_12: PROCESS
BEGIN
	data2_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_data2_12;
-- expected data2[11]
t_prcs_data2_11: PROCESS
BEGIN
	data2_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_data2_11;
-- expected data2[10]
t_prcs_data2_10: PROCESS
BEGIN
	data2_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_data2_10;
-- expected data2[9]
t_prcs_data2_9: PROCESS
BEGIN
	data2_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_data2_9;
-- expected data2[8]
t_prcs_data2_8: PROCESS
BEGIN
	data2_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_data2_8;
-- expected data2[7]
t_prcs_data2_7: PROCESS
BEGIN
	data2_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_data2_7;
-- expected data2[6]
t_prcs_data2_6: PROCESS
BEGIN
	data2_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_data2_6;
-- expected data2[5]
t_prcs_data2_5: PROCESS
BEGIN
	data2_expected(5) <= '0';
	WAIT FOR 140000 ps;
	data2_expected(5) <= '1';
WAIT;
END PROCESS t_prcs_data2_5;
-- expected data2[4]
t_prcs_data2_4: PROCESS
BEGIN
	data2_expected(4) <= '0';
	WAIT FOR 140000 ps;
	data2_expected(4) <= '1';
WAIT;
END PROCESS t_prcs_data2_4;
-- expected data2[3]
t_prcs_data2_3: PROCESS
BEGIN
	data2_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_data2_3;
-- expected data2[2]
t_prcs_data2_2: PROCESS
BEGIN
	data2_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_data2_2;
-- expected data2[1]
t_prcs_data2_1: PROCESS
BEGIN
	data2_expected(1) <= '0';
	WAIT FOR 140000 ps;
	data2_expected(1) <= '1';
WAIT;
END PROCESS t_prcs_data2_1;
-- expected data2[0]
t_prcs_data2_0: PROCESS
BEGIN
	data2_expected(0) <= '0';
	WAIT FOR 140000 ps;
	data2_expected(0) <= '1';
WAIT;
END PROCESS t_prcs_data2_0;
-- expected data3[15]
t_prcs_data3_15: PROCESS
BEGIN
	data3_expected(15) <= '0';
WAIT;
END PROCESS t_prcs_data3_15;
-- expected data3[14]
t_prcs_data3_14: PROCESS
BEGIN
	data3_expected(14) <= '0';
WAIT;
END PROCESS t_prcs_data3_14;
-- expected data3[13]
t_prcs_data3_13: PROCESS
BEGIN
	data3_expected(13) <= '0';
WAIT;
END PROCESS t_prcs_data3_13;
-- expected data3[12]
t_prcs_data3_12: PROCESS
BEGIN
	data3_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_data3_12;
-- expected data3[11]
t_prcs_data3_11: PROCESS
BEGIN
	data3_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_data3_11;
-- expected data3[10]
t_prcs_data3_10: PROCESS
BEGIN
	data3_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_data3_10;
-- expected data3[9]
t_prcs_data3_9: PROCESS
BEGIN
	data3_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_data3_9;
-- expected data3[8]
t_prcs_data3_8: PROCESS
BEGIN
	data3_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_data3_8;
-- expected data3[7]
t_prcs_data3_7: PROCESS
BEGIN
	data3_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_data3_7;
-- expected data3[6]
t_prcs_data3_6: PROCESS
BEGIN
	data3_expected(6) <= '0';
	WAIT FOR 180000 ps;
	data3_expected(6) <= '1';
WAIT;
END PROCESS t_prcs_data3_6;
-- expected data3[5]
t_prcs_data3_5: PROCESS
BEGIN
	data3_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_data3_5;
-- expected data3[4]
t_prcs_data3_4: PROCESS
BEGIN
	data3_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_data3_4;
-- expected data3[3]
t_prcs_data3_3: PROCESS
BEGIN
	data3_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_data3_3;
-- expected data3[2]
t_prcs_data3_2: PROCESS
BEGIN
	data3_expected(2) <= '0';
	WAIT FOR 180000 ps;
	data3_expected(2) <= '1';
WAIT;
END PROCESS t_prcs_data3_2;
-- expected data3[1]
t_prcs_data3_1: PROCESS
BEGIN
	data3_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_data3_1;
-- expected data3[0]
t_prcs_data3_0: PROCESS
BEGIN
	data3_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_data3_0;
-- expected tag0[11]
t_prcs_tag0_11: PROCESS
BEGIN
	tag0_expected(11) <= '0';
	WAIT FOR 60000 ps;
	tag0_expected(11) <= 'X';
WAIT;
END PROCESS t_prcs_tag0_11;
-- expected tag0[10]
t_prcs_tag0_10: PROCESS
BEGIN
	tag0_expected(10) <= '0';
	WAIT FOR 60000 ps;
	tag0_expected(10) <= 'X';
WAIT;
END PROCESS t_prcs_tag0_10;
-- expected tag0[9]
t_prcs_tag0_9: PROCESS
BEGIN
	tag0_expected(9) <= '0';
	WAIT FOR 60000 ps;
	tag0_expected(9) <= 'X';
WAIT;
END PROCESS t_prcs_tag0_9;
-- expected tag0[8]
t_prcs_tag0_8: PROCESS
BEGIN
	tag0_expected(8) <= '0';
	WAIT FOR 60000 ps;
	tag0_expected(8) <= 'X';
WAIT;
END PROCESS t_prcs_tag0_8;
-- expected tag0[7]
t_prcs_tag0_7: PROCESS
BEGIN
	tag0_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_tag0_7;
-- expected tag0[6]
t_prcs_tag0_6: PROCESS
BEGIN
	tag0_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_tag0_6;
-- expected tag0[5]
t_prcs_tag0_5: PROCESS
BEGIN
	tag0_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_tag0_5;
-- expected tag0[4]
t_prcs_tag0_4: PROCESS
BEGIN
	tag0_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_tag0_4;
-- expected tag0[3]
t_prcs_tag0_3: PROCESS
BEGIN
	tag0_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_tag0_3;
-- expected tag0[2]
t_prcs_tag0_2: PROCESS
BEGIN
	tag0_expected(2) <= '0';
	WAIT FOR 220000 ps;
	tag0_expected(2) <= '1';
WAIT;
END PROCESS t_prcs_tag0_2;
-- expected tag0[1]
t_prcs_tag0_1: PROCESS
BEGIN
	tag0_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_tag0_1;
-- expected tag0[0]
t_prcs_tag0_0: PROCESS
BEGIN
	tag0_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_tag0_0;
-- expected tag1[11]
t_prcs_tag1_11: PROCESS
BEGIN
	tag1_expected(11) <= '0';
	WAIT FOR 100000 ps;
	tag1_expected(11) <= 'X';
WAIT;
END PROCESS t_prcs_tag1_11;
-- expected tag1[10]
t_prcs_tag1_10: PROCESS
BEGIN
	tag1_expected(10) <= '0';
	WAIT FOR 100000 ps;
	tag1_expected(10) <= 'X';
WAIT;
END PROCESS t_prcs_tag1_10;
-- expected tag1[9]
t_prcs_tag1_9: PROCESS
BEGIN
	tag1_expected(9) <= '0';
	WAIT FOR 100000 ps;
	tag1_expected(9) <= 'X';
WAIT;
END PROCESS t_prcs_tag1_9;
-- expected tag1[8]
t_prcs_tag1_8: PROCESS
BEGIN
	tag1_expected(8) <= '0';
	WAIT FOR 100000 ps;
	tag1_expected(8) <= 'X';
WAIT;
END PROCESS t_prcs_tag1_8;
-- expected tag1[7]
t_prcs_tag1_7: PROCESS
BEGIN
	tag1_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_tag1_7;
-- expected tag1[6]
t_prcs_tag1_6: PROCESS
BEGIN
	tag1_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_tag1_6;
-- expected tag1[5]
t_prcs_tag1_5: PROCESS
BEGIN
	tag1_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_tag1_5;
-- expected tag1[4]
t_prcs_tag1_4: PROCESS
BEGIN
	tag1_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_tag1_4;
-- expected tag1[3]
t_prcs_tag1_3: PROCESS
BEGIN
	tag1_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_tag1_3;
-- expected tag1[2]
t_prcs_tag1_2: PROCESS
BEGIN
	tag1_expected(2) <= '0';
	WAIT FOR 100000 ps;
	tag1_expected(2) <= '1';
WAIT;
END PROCESS t_prcs_tag1_2;
-- expected tag1[1]
t_prcs_tag1_1: PROCESS
BEGIN
	tag1_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_tag1_1;
-- expected tag1[0]
t_prcs_tag1_0: PROCESS
BEGIN
	tag1_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_tag1_0;
-- expected tag2[11]
t_prcs_tag2_11: PROCESS
BEGIN
	tag2_expected(11) <= '0';
	WAIT FOR 140000 ps;
	tag2_expected(11) <= 'X';
WAIT;
END PROCESS t_prcs_tag2_11;
-- expected tag2[10]
t_prcs_tag2_10: PROCESS
BEGIN
	tag2_expected(10) <= '0';
	WAIT FOR 140000 ps;
	tag2_expected(10) <= 'X';
WAIT;
END PROCESS t_prcs_tag2_10;
-- expected tag2[9]
t_prcs_tag2_9: PROCESS
BEGIN
	tag2_expected(9) <= '0';
	WAIT FOR 140000 ps;
	tag2_expected(9) <= 'X';
WAIT;
END PROCESS t_prcs_tag2_9;
-- expected tag2[8]
t_prcs_tag2_8: PROCESS
BEGIN
	tag2_expected(8) <= '0';
	WAIT FOR 140000 ps;
	tag2_expected(8) <= 'X';
WAIT;
END PROCESS t_prcs_tag2_8;
-- expected tag2[7]
t_prcs_tag2_7: PROCESS
BEGIN
	tag2_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_tag2_7;
-- expected tag2[6]
t_prcs_tag2_6: PROCESS
BEGIN
	tag2_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_tag2_6;
-- expected tag2[5]
t_prcs_tag2_5: PROCESS
BEGIN
	tag2_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_tag2_5;
-- expected tag2[4]
t_prcs_tag2_4: PROCESS
BEGIN
	tag2_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_tag2_4;
-- expected tag2[3]
t_prcs_tag2_3: PROCESS
BEGIN
	tag2_expected(3) <= '0';
	WAIT FOR 140000 ps;
	tag2_expected(3) <= '1';
WAIT;
END PROCESS t_prcs_tag2_3;
-- expected tag2[2]
t_prcs_tag2_2: PROCESS
BEGIN
	tag2_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_tag2_2;
-- expected tag2[1]
t_prcs_tag2_1: PROCESS
BEGIN
	tag2_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_tag2_1;
-- expected tag2[0]
t_prcs_tag2_0: PROCESS
BEGIN
	tag2_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_tag2_0;
-- expected tag3[11]
t_prcs_tag3_11: PROCESS
BEGIN
	tag3_expected(11) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(11) <= 'X';
WAIT;
END PROCESS t_prcs_tag3_11;
-- expected tag3[10]
t_prcs_tag3_10: PROCESS
BEGIN
	tag3_expected(10) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(10) <= 'X';
WAIT;
END PROCESS t_prcs_tag3_10;
-- expected tag3[9]
t_prcs_tag3_9: PROCESS
BEGIN
	tag3_expected(9) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(9) <= 'X';
WAIT;
END PROCESS t_prcs_tag3_9;
-- expected tag3[8]
t_prcs_tag3_8: PROCESS
BEGIN
	tag3_expected(8) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(8) <= 'X';
WAIT;
END PROCESS t_prcs_tag3_8;
-- expected tag3[7]
t_prcs_tag3_7: PROCESS
BEGIN
	tag3_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_tag3_7;
-- expected tag3[6]
t_prcs_tag3_6: PROCESS
BEGIN
	tag3_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_tag3_6;
-- expected tag3[5]
t_prcs_tag3_5: PROCESS
BEGIN
	tag3_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_tag3_5;
-- expected tag3[4]
t_prcs_tag3_4: PROCESS
BEGIN
	tag3_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_tag3_4;
-- expected tag3[3]
t_prcs_tag3_3: PROCESS
BEGIN
	tag3_expected(3) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(3) <= '1';
WAIT;
END PROCESS t_prcs_tag3_3;
-- expected tag3[2]
t_prcs_tag3_2: PROCESS
BEGIN
	tag3_expected(2) <= '0';
	WAIT FOR 180000 ps;
	tag3_expected(2) <= '1';
WAIT;
END PROCESS t_prcs_tag3_2;
-- expected tag3[1]
t_prcs_tag3_1: PROCESS
BEGIN
	tag3_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_tag3_1;
-- expected tag3[0]
t_prcs_tag3_0: PROCESS
BEGIN
	tag3_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_tag3_0;
-- expected valid[3]
t_prcs_valid_3: PROCESS
BEGIN
	valid_expected(3) <= '0';
	WAIT FOR 180000 ps;
	valid_expected(3) <= '1';
WAIT;
END PROCESS t_prcs_valid_3;
-- expected valid[2]
t_prcs_valid_2: PROCESS
BEGIN
	valid_expected(2) <= '0';
	WAIT FOR 140000 ps;
	valid_expected(2) <= '1';
WAIT;
END PROCESS t_prcs_valid_2;
-- expected valid[1]
t_prcs_valid_1: PROCESS
BEGIN
	valid_expected(1) <= '0';
	WAIT FOR 100000 ps;
	valid_expected(1) <= '1';
	WAIT FOR 160000 ps;
	valid_expected(1) <= 'X';
WAIT;
END PROCESS t_prcs_valid_1;
-- expected valid[0]
t_prcs_valid_0: PROCESS
BEGIN
	valid_expected(0) <= '0';
	WAIT FOR 60000 ps;
	valid_expected(0) <= '1';
WAIT;
END PROCESS t_prcs_valid_0;

-- Set trigger on real/expected o/ pattern changes                        

t_prcs_trigger_e : PROCESS(data0_expected,data1_expected,data2_expected,data3_expected,data_to_cpu_expected,hit_expected,tag0_expected,tag1_expected,tag2_expected,tag3_expected,valid_expected)
BEGIN
	trigger_e <= NOT trigger_e;
END PROCESS t_prcs_trigger_e;

t_prcs_trigger_r : PROCESS(data0,data1,data2,data3,data_to_cpu,hit,tag0,tag1,tag2,tag3,valid)
BEGIN
	trigger_r <= NOT trigger_r;
END PROCESS t_prcs_trigger_r;


t_prcs_selfcheck : PROCESS
VARIABLE i : INTEGER := 1;
VARIABLE txt : LINE;

VARIABLE last_data0_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_data1_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_data2_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_data3_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_data_to_cpu_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_hit_exp : STD_LOGIC := 'U';
VARIABLE last_tag0_exp : STD_LOGIC_VECTOR(11 DOWNTO 0) := "UUUUUUUUUUUU";
VARIABLE last_tag1_exp : STD_LOGIC_VECTOR(11 DOWNTO 0) := "UUUUUUUUUUUU";
VARIABLE last_tag2_exp : STD_LOGIC_VECTOR(11 DOWNTO 0) := "UUUUUUUUUUUU";
VARIABLE last_tag3_exp : STD_LOGIC_VECTOR(11 DOWNTO 0) := "UUUUUUUUUUUU";
VARIABLE last_valid_exp : STD_LOGIC_VECTOR(3 DOWNTO 0) := "UUUU";

VARIABLE on_first_change : trackvec := "11111111111";
BEGIN

WAIT UNTIL (sampler'LAST_VALUE = '1'OR sampler'LAST_VALUE = '0')
	AND sampler'EVENT;
IF (debug_tbench = '1') THEN
	write(txt,string'("Scanning pattern "));
	write(txt,i);
	writeline(output,txt);
	write(txt,string'("| expected "));write(txt,data0_name);write(txt,string'(" = "));write(txt,data0_expected_prev);
	write(txt,string'("| expected "));write(txt,data1_name);write(txt,string'(" = "));write(txt,data1_expected_prev);
	write(txt,string'("| expected "));write(txt,data2_name);write(txt,string'(" = "));write(txt,data2_expected_prev);
	write(txt,string'("| expected "));write(txt,data3_name);write(txt,string'(" = "));write(txt,data3_expected_prev);
	write(txt,string'("| expected "));write(txt,data_to_cpu_name);write(txt,string'(" = "));write(txt,data_to_cpu_expected_prev);
	write(txt,string'("| expected "));write(txt,hit_name);write(txt,string'(" = "));write(txt,hit_expected_prev);
	write(txt,string'("| expected "));write(txt,tag0_name);write(txt,string'(" = "));write(txt,tag0_expected_prev);
	write(txt,string'("| expected "));write(txt,tag1_name);write(txt,string'(" = "));write(txt,tag1_expected_prev);
	write(txt,string'("| expected "));write(txt,tag2_name);write(txt,string'(" = "));write(txt,tag2_expected_prev);
	write(txt,string'("| expected "));write(txt,tag3_name);write(txt,string'(" = "));write(txt,tag3_expected_prev);
	write(txt,string'("| expected "));write(txt,valid_name);write(txt,string'(" = "));write(txt,valid_expected_prev);
	writeline(output,txt);
	write(txt,string'("| real "));write(txt,data0_name);write(txt,string'(" = "));write(txt,data0_prev);
	write(txt,string'("| real "));write(txt,data1_name);write(txt,string'(" = "));write(txt,data1_prev);
	write(txt,string'("| real "));write(txt,data2_name);write(txt,string'(" = "));write(txt,data2_prev);
	write(txt,string'("| real "));write(txt,data3_name);write(txt,string'(" = "));write(txt,data3_prev);
	write(txt,string'("| real "));write(txt,data_to_cpu_name);write(txt,string'(" = "));write(txt,data_to_cpu_prev);
	write(txt,string'("| real "));write(txt,hit_name);write(txt,string'(" = "));write(txt,hit_prev);
	write(txt,string'("| real "));write(txt,tag0_name);write(txt,string'(" = "));write(txt,tag0_prev);
	write(txt,string'("| real "));write(txt,tag1_name);write(txt,string'(" = "));write(txt,tag1_prev);
	write(txt,string'("| real "));write(txt,tag2_name);write(txt,string'(" = "));write(txt,tag2_prev);
	write(txt,string'("| real "));write(txt,tag3_name);write(txt,string'(" = "));write(txt,tag3_prev);
	write(txt,string'("| real "));write(txt,valid_name);write(txt,string'(" = "));write(txt,valid_prev);
	writeline(output,txt);
	i := i + 1;
END IF;
IF ( data0_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (data0_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (data0_prev /= data0_expected_prev) AND (
	(data0_expected_prev /= last_data0_exp) OR
	(on_first_change(1) = '1')
		) THEN
	throw_error("data0",data0_expected_prev,data0_prev);
	num_mismatches(0) <= num_mismatches(0) + 1;
	on_first_change(1) := '0';
	last_data0_exp := data0_expected_prev;
END IF;
IF ( data1_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (data1_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (data1_prev /= data1_expected_prev) AND (
	(data1_expected_prev /= last_data1_exp) OR
	(on_first_change(2) = '1')
		) THEN
	throw_error("data1",data1_expected_prev,data1_prev);
	num_mismatches(1) <= num_mismatches(1) + 1;
	on_first_change(2) := '0';
	last_data1_exp := data1_expected_prev;
END IF;
IF ( data2_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (data2_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (data2_prev /= data2_expected_prev) AND (
	(data2_expected_prev /= last_data2_exp) OR
	(on_first_change(3) = '1')
		) THEN
	throw_error("data2",data2_expected_prev,data2_prev);
	num_mismatches(2) <= num_mismatches(2) + 1;
	on_first_change(3) := '0';
	last_data2_exp := data2_expected_prev;
END IF;
IF ( data3_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (data3_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (data3_prev /= data3_expected_prev) AND (
	(data3_expected_prev /= last_data3_exp) OR
	(on_first_change(4) = '1')
		) THEN
	throw_error("data3",data3_expected_prev,data3_prev);
	num_mismatches(3) <= num_mismatches(3) + 1;
	on_first_change(4) := '0';
	last_data3_exp := data3_expected_prev;
END IF;
IF ( data_to_cpu_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (data_to_cpu_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (data_to_cpu_prev /= data_to_cpu_expected_prev) AND (
	(data_to_cpu_expected_prev /= last_data_to_cpu_exp) OR
	(on_first_change(5) = '1')
		) THEN
	throw_error("data_to_cpu",data_to_cpu_expected_prev,data_to_cpu_prev);
	num_mismatches(4) <= num_mismatches(4) + 1;
	on_first_change(5) := '0';
	last_data_to_cpu_exp := data_to_cpu_expected_prev;
END IF;
IF ( hit_expected_prev /= 'X' ) AND (hit_expected_prev /= 'U' ) AND (hit_prev /= hit_expected_prev) AND (
	(hit_expected_prev /= last_hit_exp) OR
	(on_first_change(6) = '1')
		) THEN
	throw_error("hit",hit_expected_prev,hit_prev);
	num_mismatches(5) <= num_mismatches(5) + 1;
	on_first_change(6) := '0';
	last_hit_exp := hit_expected_prev;
END IF;
IF ( tag0_expected_prev /= "XXXXXXXXXXXX" ) AND (tag0_expected_prev /= "UUUUUUUUUUUU" ) AND (tag0_prev /= tag0_expected_prev) AND (
	(tag0_expected_prev /= last_tag0_exp) OR
	(on_first_change(7) = '1')
		) THEN
	throw_error("tag0",tag0_expected_prev,tag0_prev);
	num_mismatches(6) <= num_mismatches(6) + 1;
	on_first_change(7) := '0';
	last_tag0_exp := tag0_expected_prev;
END IF;
IF ( tag1_expected_prev /= "XXXXXXXXXXXX" ) AND (tag1_expected_prev /= "UUUUUUUUUUUU" ) AND (tag1_prev /= tag1_expected_prev) AND (
	(tag1_expected_prev /= last_tag1_exp) OR
	(on_first_change(8) = '1')
		) THEN
	throw_error("tag1",tag1_expected_prev,tag1_prev);
	num_mismatches(7) <= num_mismatches(7) + 1;
	on_first_change(8) := '0';
	last_tag1_exp := tag1_expected_prev;
END IF;
IF ( tag2_expected_prev /= "XXXXXXXXXXXX" ) AND (tag2_expected_prev /= "UUUUUUUUUUUU" ) AND (tag2_prev /= tag2_expected_prev) AND (
	(tag2_expected_prev /= last_tag2_exp) OR
	(on_first_change(9) = '1')
		) THEN
	throw_error("tag2",tag2_expected_prev,tag2_prev);
	num_mismatches(8) <= num_mismatches(8) + 1;
	on_first_change(9) := '0';
	last_tag2_exp := tag2_expected_prev;
END IF;
IF ( tag3_expected_prev /= "XXXXXXXXXXXX" ) AND (tag3_expected_prev /= "UUUUUUUUUUUU" ) AND (tag3_prev /= tag3_expected_prev) AND (
	(tag3_expected_prev /= last_tag3_exp) OR
	(on_first_change(10) = '1')
		) THEN
	throw_error("tag3",tag3_expected_prev,tag3_prev);
	num_mismatches(9) <= num_mismatches(9) + 1;
	on_first_change(10) := '0';
	last_tag3_exp := tag3_expected_prev;
END IF;
IF ( valid_expected_prev /= "XXXX" ) AND (valid_expected_prev /= "UUUU" ) AND (valid_prev /= valid_expected_prev) AND (
	(valid_expected_prev /= last_valid_exp) OR
	(on_first_change(11) = '1')
		) THEN
	throw_error("valid",valid_expected_prev,valid_prev);
	num_mismatches(10) <= num_mismatches(10) + 1;
	on_first_change(11) := '0';
	last_valid_exp := valid_expected_prev;
END IF;
    trigger_i <= NOT trigger_i;
END PROCESS t_prcs_selfcheck;


t_prcs_trigger_res : PROCESS(trigger_e,trigger_i,trigger_r)
BEGIN
	trigger <= trigger_i XOR trigger_e XOR trigger_r;
END PROCESS t_prcs_trigger_res;

t_prcs_endsim : PROCESS
VARIABLE txt : LINE;
VARIABLE total_mismatches : INTEGER := 0;
BEGIN
WAIT FOR 500000 ps;
total_mismatches := num_mismatches(0) + num_mismatches(1) + num_mismatches(2) + num_mismatches(3) + num_mismatches(4) + num_mismatches(5) + num_mismatches(6) + num_mismatches(7) + num_mismatches(8) + num_mismatches(9) + num_mismatches(10);
IF (total_mismatches = 0) THEN                                              
        write(txt,string'("Simulation passed !"));                        
        writeline(output,txt);                                              
ELSE                                                                        
        write(txt,total_mismatches);                                        
        write(txt,string'(" mismatched vectors : Simulation failed !"));  
        writeline(output,txt);                                              
END IF;                                                                     
WAIT;
END PROCESS t_prcs_endsim;

END ovec_arch;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

USE WORK.cache_lru_vhd_tb_types.ALL;                                         

ENTITY cache_lru_vhd_vec_tst IS
END cache_lru_vhd_vec_tst;
ARCHITECTURE cache_lru_arch OF cache_lru_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL clock : STD_LOGIC;
SIGNAL data0 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data_from_memory : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data_to_cpu : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL hit : STD_LOGIC;
SIGNAL request_valid : STD_LOGIC;
SIGNAL rst_n : STD_LOGIC;
SIGNAL tag0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL tag3 : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL valid : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL sampler : sample_type;

COMPONENT cache_lru
	PORT (
	address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	clock : IN STD_LOGIC;
	data0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	data1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	data2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	data3 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_from_memory : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_to_cpu : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	hit : OUT STD_LOGIC;
	request_valid : IN STD_LOGIC;
	rst_n : IN STD_LOGIC;
	tag0 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag2 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag3 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
COMPONENT cache_lru_vhd_check_tst
PORT ( 
	data0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_to_cpu : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	hit : IN STD_LOGIC;
	tag0 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag1 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag2 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	tag3 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	valid : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	sampler : IN sample_type
);
END COMPONENT;
COMPONENT cache_lru_vhd_sample_tst
PORT (
	address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	clock : IN STD_LOGIC;
	data_from_memory : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	request_valid : IN STD_LOGIC;
	rst_n : IN STD_LOGIC;
	sampler : OUT sample_type
	);
END COMPONENT;
BEGIN
	i1 : cache_lru
	PORT MAP (
-- list connections between master ports and signals
	address => address,
	clock => clock,
	data0 => data0,
	data1 => data1,
	data2 => data2,
	data3 => data3,
	data_from_memory => data_from_memory,
	data_to_cpu => data_to_cpu,
	hit => hit,
	request_valid => request_valid,
	rst_n => rst_n,
	tag0 => tag0,
	tag1 => tag1,
	tag2 => tag2,
	tag3 => tag3,
	valid => valid
	);

-- clock
t_prcs_clock: PROCESS
BEGIN
	FOR i IN 1 TO 12
	LOOP
		clock <= '0';
		WAIT FOR 20000 ps;
		clock <= '1';
		WAIT FOR 20000 ps;
	END LOOP;
	clock <= '0';
WAIT;
END PROCESS t_prcs_clock;

-- rst_n
t_prcs_rst_n: PROCESS
BEGIN
	rst_n <= '0';
	WAIT FOR 60000 ps;
	rst_n <= '1';
WAIT;
END PROCESS t_prcs_rst_n;

-- request_valid
t_prcs_request_valid: PROCESS
BEGIN
	request_valid <= '0';
	WAIT FOR 60000 ps;
	request_valid <= '1';
	WAIT FOR 240000 ps;
	request_valid <= '0';
WAIT;
END PROCESS t_prcs_request_valid;

-- address[7]
t_prcs_address_7: PROCESS
BEGIN
	address(7) <= '0';
WAIT;
END PROCESS t_prcs_address_7;

-- address[6]
t_prcs_address_6: PROCESS
BEGIN
	address(6) <= '0';
WAIT;
END PROCESS t_prcs_address_6;

-- address[5]
t_prcs_address_5: PROCESS
BEGIN
	address(5) <= '0';
WAIT;
END PROCESS t_prcs_address_5;

-- address[4]
t_prcs_address_4: PROCESS
BEGIN
	address(4) <= '0';
	WAIT FOR 260000 ps;
	address(4) <= '1';
	WAIT FOR 40000 ps;
	address(4) <= '0';
WAIT;
END PROCESS t_prcs_address_4;

-- address[3]
t_prcs_address_3: PROCESS
BEGIN
	address(3) <= '0';
	WAIT FOR 140000 ps;
	address(3) <= '1';
	WAIT FOR 80000 ps;
	address(3) <= '0';
WAIT;
END PROCESS t_prcs_address_3;

-- address[2]
t_prcs_address_2: PROCESS
BEGIN
	address(2) <= '0';
	WAIT FOR 100000 ps;
	address(2) <= '1';
	WAIT FOR 40000 ps;
	address(2) <= '0';
	WAIT FOR 40000 ps;
	address(2) <= '1';
	WAIT FOR 80000 ps;
	address(2) <= '0';
WAIT;
END PROCESS t_prcs_address_2;

-- address[1]
t_prcs_address_1: PROCESS
BEGIN
	address(1) <= '0';
WAIT;
END PROCESS t_prcs_address_1;

-- address[0]
t_prcs_address_0: PROCESS
BEGIN
	address(0) <= '0';
WAIT;
END PROCESS t_prcs_address_0;
-- data_from_memory[15]
t_prcs_data_from_memory_15: PROCESS
BEGIN
	data_from_memory(15) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(15) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(15) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_15;
-- data_from_memory[14]
t_prcs_data_from_memory_14: PROCESS
BEGIN
	data_from_memory(14) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_14;
-- data_from_memory[13]
t_prcs_data_from_memory_13: PROCESS
BEGIN
	data_from_memory(13) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(13) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(13) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_13;
-- data_from_memory[12]
t_prcs_data_from_memory_12: PROCESS
BEGIN
	data_from_memory(12) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_12;
-- data_from_memory[11]
t_prcs_data_from_memory_11: PROCESS
BEGIN
	data_from_memory(11) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(11) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(11) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_11;
-- data_from_memory[10]
t_prcs_data_from_memory_10: PROCESS
BEGIN
	data_from_memory(10) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_10;
-- data_from_memory[9]
t_prcs_data_from_memory_9: PROCESS
BEGIN
	data_from_memory(9) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(9) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(9) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_9;
-- data_from_memory[8]
t_prcs_data_from_memory_8: PROCESS
BEGIN
	data_from_memory(8) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_8;
-- data_from_memory[7]
t_prcs_data_from_memory_7: PROCESS
BEGIN
	data_from_memory(7) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(7) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(7) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_7;
-- data_from_memory[6]
t_prcs_data_from_memory_6: PROCESS
BEGIN
	data_from_memory(6) <= '0';
	WAIT FOR 180000 ps;
	data_from_memory(6) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(6) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(6) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(6) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_6;
-- data_from_memory[5]
t_prcs_data_from_memory_5: PROCESS
BEGIN
	data_from_memory(5) <= '0';
	WAIT FOR 100000 ps;
	data_from_memory(5) <= '1';
	WAIT FOR 80000 ps;
	data_from_memory(5) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(5) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(5) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_5;
-- data_from_memory[4]
t_prcs_data_from_memory_4: PROCESS
BEGIN
	data_from_memory(4) <= '0';
	WAIT FOR 60000 ps;
	data_from_memory(4) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(4) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(4) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(4) <= '0';
	WAIT FOR 80000 ps;
	data_from_memory(4) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(4) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_4;
-- data_from_memory[3]
t_prcs_data_from_memory_3: PROCESS
BEGIN
	data_from_memory(3) <= '0';
	WAIT FOR 220000 ps;
	data_from_memory(3) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(3) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_3;
-- data_from_memory[2]
t_prcs_data_from_memory_2: PROCESS
BEGIN
	data_from_memory(2) <= '0';
	WAIT FOR 180000 ps;
	data_from_memory(2) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(2) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(2) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(2) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_2;
-- data_from_memory[1]
t_prcs_data_from_memory_1: PROCESS
BEGIN
	data_from_memory(1) <= '0';
	WAIT FOR 100000 ps;
	data_from_memory(1) <= '1';
	WAIT FOR 80000 ps;
	data_from_memory(1) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(1) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(1) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_1;
-- data_from_memory[0]
t_prcs_data_from_memory_0: PROCESS
BEGIN
	data_from_memory(0) <= '0';
	WAIT FOR 60000 ps;
	data_from_memory(0) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(0) <= '0';
	WAIT FOR 40000 ps;
	data_from_memory(0) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(0) <= '0';
	WAIT FOR 80000 ps;
	data_from_memory(0) <= '1';
	WAIT FOR 40000 ps;
	data_from_memory(0) <= '0';
WAIT;
END PROCESS t_prcs_data_from_memory_0;
tb_sample : cache_lru_vhd_sample_tst
PORT MAP (
	address => address,
	clock => clock,
	data_from_memory => data_from_memory,
	request_valid => request_valid,
	rst_n => rst_n,
	sampler => sampler
	);

tb_out : cache_lru_vhd_check_tst
PORT MAP (
	data0 => data0,
	data1 => data1,
	data2 => data2,
	data3 => data3,
	data_to_cpu => data_to_cpu,
	hit => hit,
	tag0 => tag0,
	tag1 => tag1,
	tag2 => tag2,
	tag3 => tag3,
	valid => valid,
	sampler => sampler
	);
END cache_lru_arch;
