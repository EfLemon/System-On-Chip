module convolution (
    input	clk, rstn,
    input	start,
    input	[4:0]	mem_size_Y,
	input	[7:0]	mem_data_Y,
	output	[4:0]	mem_addr_Y,
	output	[5:0]	mem_addr_Z,
	output	[15:0]	mem_data_Z,
	// FSM
	output	done, busy, write_Z
);
	
	parameter	DATA_WIDTH_MEM_Y =			8;
	parameter	ADDR_WIDTH_MEM_Y =			5;
	
	parameter	DATA_WIDTH_MEM_X =			8;
	parameter	ADDR_WIDTH_MEM_X =			5;
	
	parameter	DATA_WIDTH_MEM_Z =			16;
	parameter	ADDR_WIDTH_MEM_Z =			6;
	
	parameter	COUNT_WIDTH_ADDER =			5;
	parameter	COUNT_WIDTH_MULTIPLIER =	1;
	
	logic	[4:0]	rom_size_X =			5'd5;	// Reprentacion de 5 bits de valor decimal de 5
	logic	[4:0]	res_sub_X;
	logic	[4:0]	rom_addr_X;
	logic	result_comp_m_e_t;
	logic	[DATA_WIDTH_MEM_X-1:0]rom_data_X;
	logic	ROM_SIZE_X;
	
	logic	[5:0]	mem_size_Z;
	logic	[5:0]	res_size_Z;
	logic	[5:0]	result_size_Z;
		
	parameter	COUNT_WIDTH_I =				6;
	logic	[5:0]	count_i_next;
	logic	[5:0]	count_i;
	
	parameter	COUNT_WIDTH_J =				5;
	logic	[4:0]	count_j_next;
	logic	[4:0]	count_j;

	
	logic	set_count_i;
	logic	set_count_j;
	logic	clear_count_i;
	logic	clear_count_j;
	logic	set_mem_addr_Z;
	logic	set_mem_addr_Y;
	logic	set_rom_addr_X;
	logic	clear_mem_addr_Z;
	logic	clear_mem_addr_Y;
	logic	clear_rom_addr_X;
	logic	set_mem_size_Y;
	logic	set_mem_size_Z;
	logic	clear_mem_size_Y;
	logic	clear_mem_size_Z;
	logic	set_add_mem_data_Z;
	logic	set_mem_data_Z;
	logic	clear_add_mem_data_Z;
	logic	[DATA_WIDTH_MEM_Z-1:0]add_mem_data_Z;
	logic	[DATA_WIDTH_MEM_Z-1:0]next_add_mem_data_Z;
	logic	result_comp_l_t_Y;
	logic	result_multiplier;
	logic	result_comp_l_t_Z;
	logic	[DATA_WIDTH_MEM_Z-1:0]resultado_data;
	
	
	// Instancia de la FSM
	convolution_FSM fsm_inst (
		.clk(clk),
		.rstn(rstn),
		.done(done),
		.busy(busy),
		.start(start),
		.set_count_i(set_count_i),
		.set_count_j(set_count_j),
		.clear_count_i(clear_count_i),
		.clear_count_j(clear_count_j),
		.set_mem_addr_Z(set_mem_addr_Z),
		.set_mem_addr_Y(set_mem_addr_Y),
		.set_rom_addr_X(set_rom_addr_X),
		.clear_mem_addr_Z(clear_mem_addr_Z),
		.clear_mem_addr_Y(clear_mem_addr_Y),
		.clear_rom_addr_X(clear_rom_addr_X),
		.set_mem_size_Y(set_mem_size_Y),
		.set_mem_size_Z(set_mem_size_Z),
		.clear_mem_size_Y(clear_mem_size_Y),
		.clear_mem_size_Z(clear_mem_size_Z),
		.write_Z(write_Z),
		.set_mem_data_Z(set_mem_data_Z),
		.clear_add_mem_data_Z(clear_add_mem_data_Z),
		.set_add_mem_data_Z(set_add_mem_data_Z),
		.result_comp_l_t_Y(result_comp_l_t_Y),
		.result_multiplier(result_multiplier),
		.result_comp_l_t_Z(result_comp_l_t_Z)
	);
	
	comparatorGreaterEqualThan 
	#(
		.DATA_WIDTH				(ADDR_WIDTH_MEM_X)
	)
	comp_g_e_t (	// comparator greater equal than
		.A_i					(rom_addr_X),
		.B_i					(5'b0),
		.A_greater_than_B_o		(result_comp_m_e_t)
	);
	
	comparatorEqual
	#(
		.DATA_WIDTH				(ADDR_WIDTH_MEM_X)
	)
	comp_e (		// comparator equal
		.A_i					(rom_addr_X),
		.B_i					(rom_size_X),
		.A_equal_B_o			(result_comp_e)
	);
	
	subtractor    sub_addr_X
   (
      .a				(count_i),
      .b				(count_j), 
      .resultado		(res_sub_X)
   );
   
   register 
	#(
		.DATA_WIDTH 		(ADDR_WIDTH_MEM_X)
	)
	inst_rom_addr_X
	(
		.clk     			(clk),
		.rstn    			(rstn),
		.clrh    			(clear_rom_addr_X),   
		.enh     			(set_rom_addr_X),
		.data_i  			(res_sub_X),
		.data_o  			(rom_addr_X)
	);
	
	multiplier 
	#(
		.DATA_WIDTH				(COUNT_WIDTH_MULTIPLIER)
	)
	multiplier_addr_X (
		.a						(result_comp_m_e_t),
		.b						(result_comp_e),
		.resultado				(result_multiplier)
	);
	
	comparatorLessThan 
	#(
		.DATA_WIDTH				(ADDR_WIDTH_MEM_Y)
	)
	comp_l_t_Y (		// comparator less than
		.A_i					(count_j),
		.B_i					(mem_size_Y),
		.A_less_than_B_o		(result_comp_l_t_Y)
	);
	
	comparatorLessThan 
	#(
		.DATA_WIDTH				(ADDR_WIDTH_MEM_X)
	)
	comp_l_t_X (		// comparator less than
		.A_i					(rom_addr_X),
		.B_i					(8'b0),
		.A_less_than_B_o		(result_comp_l_t_X)
	);
	
	comparatorLessThan 
	#(
		.DATA_WIDTH				(ADDR_WIDTH_MEM_Z)
	)
	comp_l_t_Z (		// comparator less than
		.A_i					(count_i_next),
		.B_i					(result_size_Z),
		.A_less_than_B_o		(result_comp_l_t_Z)
	);
	
	register 
	#(
		.DATA_WIDTH 		(ADDR_WIDTH_MEM_Z)
	)
	size_Z
	(
		.clk     			(clk),
		.rstn    			(rstn),
		.clrh    			(clear_mem_size_Z),   
		.enh     			(set_mem_size_Z),
		.data_i  			(result_size_Z),
		.data_o  			(mem_size_Z)
	);
	
	subtractor    sub_size_Z
   (
      .a				(mem_size_Y),
      .b				(1), 
      .resultado		(res_size_Z)
   );
	
	adder 
	#(
		.DATA_WIDTH		(ADDR_WIDTH_MEM_Z)
	)
	add_size_Z
	(
		.a					({1'b0, rom_size_X}),
		.b					({1'b0, res_size_Z}), 
		.resultado			(result_size_Z)
	);
	
	adder 
	#(
		.DATA_WIDTH			(COUNT_WIDTH_I)
	)
	count_adder_i_inst
	(
		.a					(count_i),
		.b					(1), 
		.resultado			(count_i_next)
	);
	
	register 
	#(
		.DATA_WIDTH 		(COUNT_WIDTH_I)
	)
	count_i_inst
	(
		.clk     			(clk),
		.rstn    			(rstn),
		.clrh    			(clear_count_i),   
		.enh     			(set_count_i),
		.data_i  			(count_i_next),
		.data_o  			(count_i)
	);
	
	adder 
	#(
		.DATA_WIDTH			(COUNT_WIDTH_J)
	)
	count_adder_j_inst
	(
		.a					(count_j),
		.b					(5'b1), 
		.resultado			(count_j_next)
	);
	
	register 
	#(
		.DATA_WIDTH 		(COUNT_WIDTH_J)
	)
	count_j_inst
	(
		.clk     			(clk),
		.rstn    			(rstn),
		.clrh    			(clear_count_j),   
		.enh     			(set_count_j),
		.data_i  			(count_j_next),
		.data_o  			(count_j)
	);
	
	register 
      #(
         .DATA_WIDTH 		(DATA_WIDTH_MEM_Z)
      )
      mem_addr_Z_inst
      (
         .clk     			(clk),
         .rstn    			(rstn),
         .clrh    			(clear_mem_addr_Z),   
         .enh     			(set_mem_addr_Z),
         .data_i  			(count_i),
         .data_o  			(mem_addr_Z)
      );
	
	register 
      #(
         .DATA_WIDTH 		(DATA_WIDTH_MEM_Y)
      )
      mem_addr_Y_inst
      (
         .clk     			(clk),
         .rstn    			(rstn),
         .clrh    			(clear_mem_addr_Y),   
         .enh     			(set_mem_addr_Y),
         .data_i  			(count_j),
         .data_o  			(mem_addr_Y)
      );
	
	multiplier 
	#(
		.DATA_WIDTH			(DATA_WIDTH_MEM_Y)
	)
	multiplier_data_z (
		.a					(rom_data_X),
		.b					(mem_data_Y),
		.resultado			(resultado_data)
	);

	adder 
	#(
		.DATA_WIDTH			(DATA_WIDTH_MEM_Z)
	)
	count_adder_data_Z
	(
		.a					(resultado_data),
		.b					(add_mem_data_Z), 
		.resultado			(next_add_mem_data_Z)
	);
	
	register 
      #(
         .DATA_WIDTH 		(DATA_WIDTH_MEM_Z)
      )
      reg_add_mem_data_Z
      (
         .clk     			(clk),
         .rstn    			(rstn),
         .clrh    			(clear_add_mem_data_Z),   
         .enh     			(set_add_mem_data_Z),
         .data_i  			(next_add_mem_data_Z),
         .data_o  			(add_mem_data_Z)
      );
	  
	register 
      #(
         .DATA_WIDTH 		(DATA_WIDTH_MEM_Z)
      )
      reg_mem_data_Z
      (
         .clk     			(clk),
         .rstn    			(rstn),   
         .enh     			(set_mem_data_Z),
         .data_i  			(add_mem_data_Z),
         .data_o  			(mem_data_Z)
      );
	
	simple_rom_sv 
	#(
		.DATA_WIDTH 		(DATA_WIDTH_MEM_X),
		.ADDR_WIDTH 		(ADDR_WIDTH_MEM_X),
		.TXT_FILE 			("C:/SOC/convolution_2/rom_X.txt")
	)
	reg_rom_addr_X
	(
		.clk				(clk),
		.read_addr_i		(rom_addr_X),
		.read_data_o		(rom_data_X)
	);
	
endmodule
