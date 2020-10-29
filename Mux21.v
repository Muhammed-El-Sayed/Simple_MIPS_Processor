module Mux(In1,In2,Sel,Out); //Mux(2:1)

	input [31:0] In1,In2; // 32-bits two inputs
	input Sel; //1-bit selection signal
	output reg [31:0] Out; //32-bits output

always@(In1,In2,Sel)
  begin
    case(Sel) //0 passes In1 ,1 passes In2
      0: Out <= In1;
      1: Out <= In2;
    endcase
  end
endmodule
