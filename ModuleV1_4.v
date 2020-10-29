module ModuleV1_4(IRDataIn,IRaddress,IR_R_W,WriteInitialiseAdd,WriteInitialiseData,WriteInitialiseSignal,WriteDataBackSignal,clk,Immediate,Regdest,ZF,AluOut,DataOut,MemR_W,MemtoRegFile);

	input [31:0] IRDataIn; //Data input to Instruction Register(Initialising IR).
	input [15:0] IRaddress;// address of Instruction Register(Reading Instruction or Initialisation).	
	input IR_R_W; // 1 to read Instruction from IR, 0 to write Instruction in IR for initialisation.
	input [4:0] WriteInitialiseAdd; //Addresses of reading Data1,Data2 & writing Initialisation in Registerfile.
	input [31:0] WriteInitialiseData;//Initialisation written
	input WriteInitialiseSignal,WriteDataBackSignal,clk,Immediate,Regdest;//write Initialisation signal,write back signal ,clock & Immediate 0 passes $rt as 2nd operand to Alu , Immediate 1 passes number extended.Regdest 0 makes rt is destination, 1 makes rd is destination.
	output ZF;//Zeroflag of Alu 1 if Alu out = 0
	output [31:0] AluOut;//Alu result
	output [31:0] DataOut;//Data out read from Memory
	input MemR_W,MemtoRegFile;//MemR_W 1 read from Memory, 0 write to Memory.MemtoRegFile 1 writes memory out back to Register file , 0 writes Alu result back in Register file.

	wire [31:0] Data1,Data2,Out1,Out2,Out3,Out4;//Data1 , Data2 are operands of Register file ($rs,$rt).Out1 is sign extension output.Out2 is the output of Mux choose between 2nd operand of Alu($rt or number).Out3 is the output of Mux choose between Alu result or Data out from Memory to be written back in Register File.Out4 is Instruction output from IR. 
	wire [3:0] Out5;//Output of AluControlUnit (Alu ControlLines)
	wire [4:0] Out6,Out7;//Out6 is the Output of AluControlUnit (Alu Shamt).Out7 is the output of Regdest Mux
	wire [3:0] Out8,Out9;//Out8 is the Output of AluIControlUnit (Alu ControlLines). Out9 is the output of Mux choose between control Lines come from R-instructions or I-instructions.
	

	/*Structural design
             This module we can access RegisterFile , make Alu operations on its registers or between a register & number controlled
             by Immediate signal.We can write value in Reg. $rt to memory at address of value of Alu result or read memory at this 
             address controlled by MemR_W signal then Write value read from memory back into Reg.File or Write Alu result back in 
             Register File controlled by MemtoRegFile signal. 
             I add Instruction Register where you can initialise then use its instructions which are decoded to get addresses of two
             operands RegisterFile, address of Register in RegisterFile written back in ,Functionality needed for AluControlUnit to
             determine Alu Control Lines & Shift amount needed for sll operation */

	/*Added feature
             I add I-instructions where in R-format the Alu control lines are taken from LS 4-bits of Funct. while in I-format Alu
             ctrl lines are taken from LS 4-bits of OpCode. I made 16-bit number used in I-format taken from instruction instead of
             being taken from user as an input.I also added Mux which choose between either $rs or $rt is destination register 
             controlled by Regdest where 0 makes rt is destination, 1 makes rd is destination */


 //Take Care: Out3 which is write back value to Register file may be rubbish if written back at the beginning without having a value to be written.
 //Take Care: when Alu result is updated the address of memory is updated so if you was reading from memory now you may read rubbish as you read new address with no written data and if you read from memory rubbish and you use write back memory to register file you will write rubbish in register file.
 //Precautions: After writing back be sure to disable write back signal if you want to write back once so to avoid writing back the updates of values.
      
      InstructionRegister IR1(IRaddress,IRDataIn,clk,IR_R_W,Out4);
      Mux251 Mux251_1(Out4[20:16],Out4[15:11],Regdest,Out7);
      RegisterFileV2 RF1(Out4[25:21],Out4[20:16],WriteInitialiseAdd,WriteInitialiseData,Out7,Out3,WriteInitialiseSignal,WriteDataBackSignal,clk,Data1,Data2);
      AluControlUnit AluCtrl1(Out4[5:0],Out4[10:6],Out5,Out6);
      AluIcontrolUnit AluIctrl1(Out4[31:26],Out8);
      Mux241 Mux241_1(Out5,Out8,Immediate,Out9);
      SignExtend SE1(Out4[15:0],Out1);	
      Mux Mux1(Data2,Out1,Immediate,Out2);
      Aluv2 Alu1(Data1,Out2,Out6,Out9,AluOut,ZF);
      Memory Mem1(AluOut,Data2,clk,MemR_W,DataOut);
      Mux Mux2(AluOut,DataOut,MemtoRegFile,Out3);	
   

endmodule