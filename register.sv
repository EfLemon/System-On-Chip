/*	
   ===================================================================
   Module Name : register
         
   Filename    : register.sv
   Type        : Verilog Module
      
   Description : A parametrizable register with async reset
   ------------------------------------------------------------------
      clocks   : posedge clock "clk"
      reset    : async negedge "rstn"
               : sync posedge "clrh"
      enable   : high active enable "enh" 
      
   Parameters  :
         NAME            Comments                Default
         ---------------------------------------------------
         DATA_WIDTH      Register's data width     16
      
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
      register 
      #(
         .DATA_WIDTH ()
      )
      "MODULE_NAME"
      (
         .clk     (),
         .rstn    (),
         .clrh    (),   
         .enh     (),
         .data_i  (),
         .data_o  ()
      );
*/

module register
#(
	parameter DATA_WIDTH =  8
)(
	input wire                    clk,
	input wire                    rstn,
   input wire                    clrh,   
   //--------Control signals----------//
	input wire                    enh,
   //--------Data/addr signals--------//
	input wire [DATA_WIDTH-1:0]   data_i,
	output reg [DATA_WIDTH-1:0]   data_o
);

// ---------------------------------------------

always@(posedge clk, negedge rstn) begin
	if(~rstn) 
		data_o <= {DATA_WIDTH{1'b0}};
	else if (enh)
		data_o <= data_i;
   else if (clrh)
      data_o <= {DATA_WIDTH{1'b0}};
	
end


endmodule