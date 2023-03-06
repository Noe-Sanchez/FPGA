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

		dx: INTEGER := 60;
		dy: INTEGER := 60; 

		x: INTEGER := 320; 
		y: INTEGER := 240; 

		w_div2: INTEGER := 30; 
		h_div2: INTEGER := 30; 

		w_div4: INTEGER := 10; 
		h_div4: INTEGER := 10); 
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		red_switch, green_switch, blue_switch, s_en, up_sw, down_sw, right_sw, left_sw: IN STD_LOGIC;
		x_origin : out integer range 0 to 640:= x;
		y_origin : out integer range 0 to 480:= y;
		pixel_clk: BUFFER STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		nblanck, nsync : OUT STD_LOGIC);
	END vga_square;

ARCHITECTURE vga_square OF vga_square IS

SIGNAL Hactive, Vactive, dena: STD_LOGIC;
SIGNAL do_up, do_down: STD_LOGIC := '0';
--SIGNAL x_origin : integer RANGE 30 TO 610 := x;
--SIGNAL y_origin : integer RANGE 30 TO 450 := y;

SIGNAL up_e : std_logic := '0';

SIGNAL s : std_logic_vector(3 downto 0);
SIGNAL count : integer RANGE 0 TO 10;

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
		IF (clk'EVENT AND clk='1') THEN 
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
					G <= (OTHERS => '1');
					B <= (OTHERS => '1');
					
				ELSE
					R <= (OTHERS => '0');
					G <= (OTHERS => '0');
					B <= (OTHERS => '1');
				END IF;
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

	END PROCESS;
	/*
	--switch logic
	PROCESS(up_sw)
	BEGIN
		IF rising_edge(up_sw) THEN
			IF (y_origin + dy) > 480-30 THEN
				y_origin <= 480-31;
			ELSE
				y_origin <= y_origin + dy;
			END IF;
		END IF;
	END PROCESS;

	PROCESS(down_sw)
	BEGIN
		IF rising_edge(down_sw) THEN
			IF (y_origin - dy) < 30 THEN
				y_origin <= 31;
			ELSE
				y_origin <= y_origin - dy;
			END IF;
		END IF;
	END PROCESS;
	*/

	/*

	PROCESS(up_sw)
	BEGIN
		IF rising_edge(up_sw) THEN
			IF (y_origin + dy) > 480-30 THEN
				do_up <0
			ELSE
				y_origin <= y_origin + dy;
			END IF;
		END IF;
	END PROCESS;

	PROCESS(down_sw)
	BEGIN
		IF rising_edge(down_sw) THEN
			IF (y_origin - dy) < 30 THEN
				y_origin <= 31;
			ELSE
				y_origin <= y_origin - dy;
			END IF;
		END IF;
	END PROCESS;


	PROCESS(do_up, do_down)
	BEGIN
		IF rising_edge(down_sw) THEN
			IF (y_origin - dy) < 30 THEN
				y_origin <= 31;
			ELSE
				y_origin <= y_origin - dy;
			END IF;
		END IF;
	END PROCESS;
	*/



	/*
	PROCESS(pixel_clk)
		VARIABLE counter : integer range 0 to 1000 := 0;
	BEGIN
		
		IF counter < 975 THEN
			counter := counter + 1;
		else
		IF up_sw'EVENT AND up_sw = '1' THEN
		y_origin <= y_origin + dy;
		--counter := 0;
			END IF;
		END IF;
	END PROCESS;*/

/*
PROCESS(down_sw)
BEGIN
IF rising_edge(down_sw) THEN
y_origin <= y_origin;
END IF;
END PROCESS;

PROCESS(left_sw)
BEGIN
IF rising_edge(left_sw) THEN
x_origin <= x_origin;
END IF;
END PROCESS;

PROCESS(right_sw)
BEGIN
IF rising_edge(right_sw) THEN
x_origin <= x_origin;
END IF;
END PROCESS;*/

PROCESS(s_en)
variable x_tmp : integer := x_origin;
variable y_tmp : integer := y_origin;
--variable up_e : std_logic := '0';
variable up_e_tmp : std_logic := '0';
variable s : std_logic_vector(3 downto 0) := "0000";
BEGIN		
	x_tmp := x_origin;
	y_tmp := y_origin;
	up_e_tmp := up_e;
	s(3) := left_sw; s(2) := up_sw; s(1) := down_sw; s(0) := right_sw;

	IF up_e = '1' and s_en = '0' THEN
		IF left_sw = '1' and right_sw = '1' and up_sw = '1' and down_sw = '1' THEN
			x_tmp := x; y_tmp := y; up_e_tmp := '0';
		ELSE
			IF up_sw = '1' THEN
				y_tmp := y_tmp - dy; up_e_tmp := '0';
			END IF;
			IF down_sw = '1' THEN
				y_tmp := y_tmp + dy; up_e_tmp := '0';
			END IF;
			IF left_sw = '1' THEN
				x_tmp := x_tmp - dx; up_e_tmp := '0';
			END IF;
			IF right_sw = '1' THEN
				x_tmp := x_tmp + dx; up_e_tmp := '0';
			END IF;
		END IF;
	END IF;

	IF s_en = '1' THEN
		up_e_tmp := '1';
	END IF;
	
	IF x_tmp < 1 THEN
		x_tmp := 639;
	ELSIF x_tmp > 639 then
		x_tmp := 1;
	END IF;
	IF y_tmp < 1 THEN
		y_tmp := 479;
	ELSIF y_tmp > 479 then
		y_tmp := 1;
	END IF;

	x_origin <= x_tmp;
	y_origin <= y_tmp;
	up_e <= up_e_tmp;
		
END PROCESS;


END vga_square;