LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY vga_square IS
	GENERIC (
		Ha: INTEGER := 96; --Hpulse
		Hb: INTEGER := 144; --Hpulse+HBP
		Hc: INTEGER := 784; --Hpulse+HBP+Hactive
		Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
		Va: INTEGER := 2; --Vpulse
		Vb: INTEGER := 35; --Vpulse+VBP
		Vc: INTEGER := 515; --Vpulse+VBP+Vactive
		Vd: INTEGER := 525; --Vpulse+VBP+Vactive+VFP
		P_time: INTEGER := 1; --Vpulse+VBP+Vactive+VFP

		rest_time: INTEGER := 750000000;
		--rest_time: INTEGER := 10;

		Hc_div2: INTEGER := 320; 
		Vc_div2: INTEGER := 240; 

		dx: INTEGER := 5;
		dy: INTEGER := 5; 

		x: INTEGER := 320; 
		y: INTEGER := 240; 

		w_div2: INTEGER := 30; 
		h_div2: INTEGER := 30; 

		w_div4: INTEGER := 10; 
		h_div4: INTEGER := 10); 
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		l_sw, u_sw, d_sw, r_sw : IN STD_LOGIC;
		pixel_clk: BUFFER STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		nblanck, nsync : OUT STD_LOGIC);
	END vga_square;

ARCHITECTURE vga_square OF vga_square IS
	SIGNAL Hactive, Vactive, dena: STD_LOGIC;
	SIGNAL x_origin :  	integer:= x;
	SIGNAL y_origin : 	integer:= y;
BEGIN
-------------------------------------------------------
--Part 1: CONTROL GENERATOR
-------------------------------------------------------
	--Static signals for DACs:
	nblanck <= '1'; --no direct blanking
	nsync <= '0'; --no sync on green
	--Create pixel clock (50MHz->25MHz):
	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN 
			pixel_clk <= NOT pixel_clk;
		END IF;
	END PROCESS;
	--Horizontal signals generation:
	PROCESS (pixel_clk)
	VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
	BEGIN
		IF (pixel_clk'EVENT AND pixel_clk='1') THEN Hcount := Hcount + 1;
			IF (Hcount=Ha) THEN Hsync <= '1';
			ELSIF (Hcount=Hb) THEN Hactive <= '1';
			ELSIF (Hcount=Hc) THEN Hactive <= '0';
			ELSIF (Hcount=Hd) THEN Hsync <= '0'; Hcount := 0;
			END IF;
		END IF;
	END PROCESS;
	--Vertical signals generation:
	PROCESS (Hsync)
	VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
	BEGIN
		IF (Hsync'EVENT AND Hsync='0') THEN Vcount := Vcount + 1;
			IF (Vcount=Va) THEN Vsync <= '1';
			ELSIF (Vcount=Vb) THEN Vactive <= '1';
			ELSIF (Vcount=Vc) THEN Vactive <= '0';
			ELSIF (Vcount=Vd) THEN Vsync <= '0'; Vcount := 0;
			END IF;
		END IF;
	END PROCESS;
	---Display enable generation:
	dena <= Hactive AND Vactive;
	-------------------------------------------------------
	--Part 2: IMAGE GENERATOR
	-------------------------------------------------------
	PROCESS (Hsync, Vsync, Vactive, Hactive, dena, x_origin, y_origin)
	VARIABLE line_counter: INTEGER RANGE 0 TO Vc;
	VARIABLE col_counter: INTEGER RANGE 0 TO Hc;
	BEGIN

		IF (Vsync='0') THEN
			line_counter := 0;
		ELSIF (Hsync'EVENT AND Hsync='1') THEN
			IF (Vactive='1') THEN
				line_counter := line_counter + 1;
			END IF;
		END IF;
		
		IF (Hsync='0') THEN
			col_counter := 0;
		ELSIF (pixel_clk'EVENT AND pixel_clk='1') THEN
			IF (Hactive='1') THEN
				col_counter := col_counter + 1;
			END IF;
		END IF;
		
		IF (dena='1') THEN
			IF(col_counter> (x_origin - w_div2) and col_counter< (x_origin + w_div2) and line_counter> (y_origin - h_div2) and line_counter< (y_origin + h_div2)) THEN
				IF(col_counter> (x_origin - w_div4) and col_counter< (x_origin + w_div4) and line_counter> (y_origin - h_div4) and line_counter< (y_origin + h_div4)) THEN
					R <= (OTHERS => '1');
					G <= (OTHERS => '0');
					B <= (OTHERS => '0');
					
				ELSE
					R <= (OTHERS => '1');
					G <= (OTHERS => '1');
					B <= (OTHERS => '1');
				END IF;
			ELSE
				R <= (OTHERS => '0');
				G <= (OTHERS => '0');
				B <= (OTHERS => '0');
				END IF;
				ELSE
			R <= (OTHERS => '0');
			G <= (OTHERS => '0');
			B <= (OTHERS => '0');
		END IF;
	END PROCESS;

	PROCESS(clk)
		variable x_tmp : integer := x_origin;
		variable y_tmp : integer := y_origin;
		variable counter : integer range 0 to 999999999 := 0;
		variable s_en : std_logic := '0';
	BEGIN
		IF rising_edge(clk) then
			counter := counter + 1;
			if counter = 999999 then
				counter := 0;
				x_tmp := x_origin;
				y_tmp := y_origin;
				
				IF u_sw = '1' THEN
					y_tmp := y_tmp - dy;
				END IF;
				IF d_sw = '1' THEN
					y_tmp := y_tmp + dy;
				END IF;

				IF l_sw = '1' THEN
					x_tmp := x_tmp - dx;
				END IF;

				IF r_sw = '1' THEN
					x_tmp := x_tmp + dx;
				END IF;

				IF x_tmp < 31 THEN
					x_tmp := 30;
				ELSIF x_tmp > 608 then
					x_tmp := 609;
				END IF;
				IF y_tmp < 32 THEN
					y_tmp := 31;
				ELSIF y_tmp > 449 then
					y_tmp := 450;
				END IF;
			END IF;
			
			x_origin <= x_tmp;
			y_origin <= y_tmp;
		end if;
	END PROCESS;
END vga_square;