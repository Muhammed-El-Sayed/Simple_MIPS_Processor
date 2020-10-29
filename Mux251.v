module Mux251(In1,In2,Sel,Out); //Mux(2:1)

	input [4:0] In1,In2; // 5-bits two inputs
	input Sel; //1-bit selection signal
	output reg [4:0] Out; //32-bits output

always@(In1,In2,Sel)
  begin
    case(Sel) //0 passes In1 ,1 passes In2
      0: Out <= In1;
      1: Out <= In2;
    endcase
  end
endmodule
