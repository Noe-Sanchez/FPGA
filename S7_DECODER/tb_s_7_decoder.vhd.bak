LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;
USE	ieee.std_logic_signed.ALL;
USE	ieee.std_logic_textio.ALL;
USE	std.textio.ALL;

--Entity: no port list!
ENTITY  tb_mux_4to1 IS
END	tb_mux_4to1;

--Architecture
ARCHITECTURE test_arch OF tb_mux_4to1 IS
	COMPONENT mux_4to1
		PORT(
			x0, x1, x2, x3	:	IN	STD_LOGIC;
			sel		:	IN	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			y		:	OUT	STD_LOGIC
		);
	END COMPONENT;
	
SIGNAL	x0_tb, x1_tb, x2_tb, x3_tb	:	STD_LOGIC;			--INPUT
SIGNAL	sel_tb				:	STD_LOGIC_VECTOR( 1 DOWNTO 0 );	--INPUT
SIGNAL	y_tb				:	STD_LOGIC;			--OUTPUT
SIGNAL	expect				:	STD_LOGIC;			--expected

BEGIN
	--DUT Instantiation
	DUT		:	mux_4to1 PORT MAP( x0_tb, x1_tb, x2_tb, x3_tb, sel_tb, y_tb );
	
	--Stimulus by hand drawn waves, poor coverage
	stim_proc	:	PROCESS
			  		BEGIN
					WAIT FOR 0 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "00"; expect <= '0';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "01"; expect <= '1';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "10"; expect <= '0';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "11"; expect <= '1';
					WAIT;
				END PROCESS;
						
	--Monitor
	txt_out		:	PROCESS( y_tb )
				VARIABLE str_o	:	LINE;
			  		BEGIN
					WRITE( str_o, STRING'( " x0= " 		));	WRITE( str_o, x0_tb 	);
					WRITE( str_o, STRING'( " x1= " 		));	WRITE( str_o, x1_tb 	);
					WRITE( str_o, STRING'( " x2= " 		));	WRITE( str_o, x2_tb 	);
					WRITE( str_o, STRING'( " x3= " 		));	WRITE( str_o, x3_tb 	);
					WRITE( str_o, STRING'( " sel= " 	));	WRITE( str_o, sel_tb  	);
					WRITE( str_o, STRING'( " y= " 		));	WRITE( str_o, y_tb 	);
					WRITE( str_o, STRING'( " expect= "  	));	WRITE( str_o, expect	);
					ASSERT false REPORT TIME'IMAGE( NOW ) & str_o.ALL
						SEVERITY note;
					DEALLOCATE( str_o );
				END PROCESS;		

END ARCHITECTURE;