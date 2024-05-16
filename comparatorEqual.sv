/*
	====================================================================================================
	Module Name	:	comparatorEqual
	Author		:	Limón Bultrago Efrén Armando
	FileName	:	comparatorEqual.sv
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
   comparatorEqual 
   #(
      .DATA_WIDTH		(),
   )
   "MODULE_NAME"
   (
      .A_i				(),
      .B_i				(), 
      .A_equal_B_o		()
   );
*/

module comparatorEqual
#(
   parameter DATA_WIDTH = 13
)(
	input [DATA_WIDTH-1:0]  A_i,
	input [DATA_WIDTH-1:0]  B_i, 
	output                  A_equal_B_o
);

assign A_equal_B_o = ( A_i == B_i ) ? 1'b1 :  1'b0;

endmodule
