module tb_convolucion();

    // Parámetros
	parameter DATA_WIDTH_MEMX = 8;
	parameter ADDR_WIDTH_MEMX = 5;
	parameter DATA_WIDTH_MEMZ = 16;
	parameter ADDR_WIDTH_MEMZ = 6;

    // Señales de entrada
    logic 			clk 	= 1'b0;
	logic 			rstn 	= 1'b1;
	logic 			start 	= 1'b1;
	logic 			busy;
	logic 			done;

    // Señales de salida
    logic [7:0] 	rom_data_X;
    logic [7:0] 	mem_data_Y;
    logic [7:0] 	rom_size_X;
    logic [15:0] 	mem_data_Z;
	logic [4:0]		mem_size_Y 	= 10'd10;
	logic [4:0]		mem_addr_Y;
	logic 			write_Z;
	logic [5:0]		mem_addr_Z;

    // Instancia del DUT (Design Under Test)
    convolution dut (
        .clk(clk),
        .rstn(rstn),
        .start(start),
		.busy(busy),
		.done(done),
		.write_Z(write_Z),
        .mem_size_Y(mem_size_Y),
		.mem_data_Y(mem_data_Y),
		.mem_addr_Y(mem_addr_Y),
        .mem_addr_Z(mem_addr_Z),
        .mem_data_Z(mem_data_Z)
    );
	
simple_dual_port_ram_single_clk_sv #(
        .DATA_WIDTH(DATA_WIDTH_MEMX),
        .ADDR_WIDTH(ADDR_WIDTH_MEMX),
        .TXT_FILE("C:/SOC/convolution_2/ram_Y.txt")
)
mem_Y
(
        .clk(clk),
        .write_en_i('b0),
        .write_addr_i('b0),
        .read_addr_i(mem_addr_Y),
        .write_data_i('b0),
        .read_data_o(mem_data_Y)
);

simple_dual_port_ram_single_clk_sv #(
        .DATA_WIDTH(DATA_WIDTH_MEMZ),
        .ADDR_WIDTH(ADDR_WIDTH_MEMZ),
        .TXT_FILE("C:/SOC/convolution_2/ram_Z.txt")
)
mem_Z
(
        .clk(clk),
        .write_en_i(write_Z),
        .write_addr_i(mem_addr_Z),
        .read_addr_i('b0),
        .write_data_i(mem_data_Z),
        .read_data_o()
);

always begin
    clk = 0;
    #50;
    clk = 1;
    #50;
end

initial begin
    rstn = 1'b0;
    #70;
    rstn = 1'b1;
    start = 1'b1;
end

endmodule
