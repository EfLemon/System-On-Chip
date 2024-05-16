/*
	====================================================================================================
	Module Name	:	multiplier
	Author		:	Limón Bultrago Efrén Armando
	FileName	:	multiplier.sv
	Type		:	System Verilog Module
	
	Description	:	
	----------------------------------------------------------------------------------------------------
	Clocks		:	
	Reset		:	
	
	Parameters	:
		Name			Comments			Default
		------------------------------------------------------------------------------------------------
		DATA_WIDTH		Signal's sidth			32
	
	----------------------------------------------------------------------------------------------------
	Version		:	1.0
	Date		:	01	Mayo	2024
	Revision	:	Doc. Vidkar Anibal Delgado Gallardo
	Reviser		:	Doc. Vidkar Anibal Delgado Gallardo
	----------------------------------------------------------------------------------------------------
	Any modification Log "Please Register All the modifications in this area and put the date"
	Example:	
	Date		:	01	Mayo	2124
	Modification of module lemon#(blabla);
	
   ----------------------
   // Instance template
   ----------------------
   multiplier 
   #(
      .DATA_WIDTH		(),
   )
   "MODULE_NAME"
   (
      .a				(),
      .b				(), 
      .resultado		()
   );
*/

module multiplier #(
	parameter DATA_WIDTH = 32
)(
    input	wire	[DATA_WIDTH-1:0]		a,
    input	wire	[DATA_WIDTH-1:0]		b,
    output	wire	[2*DATA_WIDTH-1:0]		resultado
);

    assign	resultado = a * b;
	
endmodule
