module convolution_FSM (
    input logic		clk, rstn,
	input logic		start,
	input logic		result_multiplier,
	input logic		result_comp_l_t_Z,
	input logic		result_comp_l_t_Y,

	output logic	busy, done,
    output logic	set_count_i,
    output logic	set_count_j,
	output logic	clear_count_i,
    output logic	clear_count_j,
    output logic	set_mem_addr_Z,
    output logic	set_mem_addr_Y,
	output logic	set_rom_addr_X,
	output logic	clear_mem_addr_Z,
    output logic	clear_mem_addr_Y,
    output logic	clear_rom_addr_X,
    output logic	set_mem_size_Y,
    output logic	set_mem_size_Z,
	output logic	clear_mem_size_Y,
    output logic	clear_mem_size_Z,
    output logic	write_Z,
    output logic	set_add_mem_data_Z,
	output logic	clear_add_mem_data_Z,
	output logic	set_mem_data_Z
);
	
	typedef enum logic [4:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21,XX = 'x} state;
	state current_state;
	state next_state;

	always_ff @(posedge clk, negedge rstn) begin
		if(!rstn)
			current_state <= S0;
		else
			current_state <= next_state;
	end
	
	always_comb begin
	next_state = XX;
	unique case(current_state)
		S0:			next_state = (start)? S1 : S0;						// SI : NO
		S1: 		next_state = S2;
		S2: 		next_state = S3;
		S3:			next_state = S4;
		S4:			next_state = S5;
		S5: 		next_state = S6;
		S6: 		next_state = S7;
		S7:			next_state = (result_comp_l_t_Z)? S8 : S11;			// SI : NO
		S8:			next_state = S9;
		S9:			next_state = S10;
		S10:		next_state = (result_comp_l_t_Y)? S13 : S16;		// SI : NO
		S11:		next_state = S12;
		S12:		next_state = S1;
		S13:		next_state = S14;
		S14:		next_state = S15;
		S15:		next_state = (result_multiplier)? S20 : S21;		// NO : SI
		S16:		next_state = S17;
		S17:		next_state = S18;
		S18:		next_state = S19;
		S19:		next_state = (result_comp_l_t_Z)? S8 : S11;			// SI : NO
		S20:		next_state = S21;
		S21:		next_state = (result_comp_l_t_Y)? S16 : S16;		// SI : NO
		default:	next_state = XX;
	endcase
end



always_ff@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		busy <= 1'b0;
	end
	else begin
        write_Z							<= 1'b0;
		busy							<= 1'b1;
		done							<= 1'b0;
		clear_count_i					<= 1'b0;
		clear_count_j					<= 1'b0;
		clear_mem_addr_Y				<= 1'b0;
		clear_mem_addr_Z				<= 1'b0;
		clear_add_mem_data_Z			<= 1'b0;
		clear_mem_size_Y				<= 1'b0;
		clear_mem_size_Z				<= 1'b0;
		clear_rom_addr_X				<= 1'b0;
		set_count_i						<= 1'b0;
		set_count_j						<= 1'b0;
		set_mem_addr_Z					<= 1'b0;
		set_mem_addr_Y					<= 1'b0;
		set_mem_size_Y					<= 1'b0;
		set_mem_size_Z					<= 1'b0;
		set_mem_data_Z					<= 1'b0;
		set_add_mem_data_Z				<= 1'b0;
		set_rom_addr_X					<= 1'b0;
		
	unique case(next_state)
		S0:		busy 					<= 1'b0;
		S1:		busy					<= 1'b1;
		S2:		clear_mem_addr_Z		<= 1'b1;
		S3:		clear_rom_addr_X		<= 1'b1;
		S4:		clear_mem_addr_Y		<= 1'b1;
		S5:		set_mem_size_Y			<= 1'b1;
		S6:		clear_count_i			<= 1'b1;
		S7:		set_mem_size_Z			<= 1'b1;
		S8:		clear_add_mem_data_Z	<= 1'b1;
		S9:		clear_count_j			<= 1'b1;
		S10:	set_mem_addr_Z			<= 1'b1;
		S11:	busy					<= 1'b1;
		S12:	done					<= 1'b1;
		S13:	set_rom_addr_X			<= 1'b1;
		S14:	set_mem_addr_Y			<= 1'b1;
		S15:	busy					<= 1'b1;
		S16:	set_mem_data_Z			<= 1'b1;
		S17:	write_Z					<= 1'b1;
		S18:	write_Z					<= 1'b0;
		S19:	set_count_i				<= 1'b1;
		S20:	set_add_mem_data_Z		<= 1'b1;
		S21:	set_count_j				<= 1'b1;
	endcase
	end
    end
	
endmodule
