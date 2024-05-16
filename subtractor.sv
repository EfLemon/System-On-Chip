/*
	====================================================================================================
	Module Name	:	subtractor
	Author		:	Limón Bultrago Efrén Armando
	FileName	:	subtractor.sv
	Type		:	System Verilog Module
	
	Description	:	
	----------------------------------------------------------------------------------------------------
	Clocks		:	
	Reset		:	
	
	Parameters	:
		Name			Comments			Default
		------------------------------------------------------------------------------------------------
		DATA_WIDTH		Signal's sidth			5
	
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
   subtractor 
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

module subtractor (
    input [4:0] a, b,
    output reg [4:0] resultado
);
    always @*
        resultado = a - b;
endmodule
