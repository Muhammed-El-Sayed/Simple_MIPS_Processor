module Aluv2 (In1,In2,Shamt,ControlLines,Out,ZF);

	input [31:0] In1,In2; //32-bits two inputs
	input [4:0] Shamt; //Shift amount of shifting left In2 of Alu
	input [3:0] ControlLines; //4-bits control signals
	output reg [31:0] Out; //32-bits output
	output ZF;

assign ZF = (Out==0)?1:0; //zeroflag is 1 if AluOutput = 0

always@(In1,In2,ControlLines)
  begin
   case(ControlLines)
      0: Out <= In1 & In2;//and
      1: Out <= In1 | In2;//or
      2: Out <= In1 + In2;//add
      6: Out <= In1 - In2;//sub
      7: Out <= (In1 < In2)?1:0;//slt(set on less than)
     12: Out <= ~(In1 | In2);//nor
      8: Out <= In2 << Shamt;//sll(2nd operand of Alu)
   endcase
  end
endmodule
