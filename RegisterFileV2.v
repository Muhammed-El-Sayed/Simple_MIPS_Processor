module RegisterFileV2(Read1Add,Read2Add,WriteInitialiseAdd,WriteInitialiseData,WriteBackAdd,WriteBackData,WriteInitialiseSignal,WriteDataBackSignal,clk,Data1,Data2);

	input [4:0] Read1Add,Read2Add,WriteInitialiseAdd; //Addresses of reading Data1,Data2 & writing Initialisation in Registerfile. 
	input [31:0] WriteInitialiseData;//Initialisation written
	input [4:0] WriteBackAdd; //Address of Writing back in Register file. 
	input [31:0] WriteBackData;//Data written back in Register file
	input WriteInitialiseSignal,WriteDataBackSignal,clk;//write Initialisation signal,write back signal & clock
	output [31:0] Data1,Data2;//Data out from Register file
	reg [31:0] Reg[0:31]; //32 Registers of width 32-bits in Register file

   assign Data1 = Reg[Read1Add];//Data1 always has value of address Read1Add independent on clock
   assign Data2 = Reg[Read2Add];//Data2 always has value of address Read2Add independent on clock

      always@(posedge clk)
         begin
	    if(WriteInitialiseSignal)//at positive edges if both WriteInitialiseSignal & WriteDataBackSignal are HIGH,I give priority to Initialising. If one of two signals is HIGH then its data will be written.
		Reg[WriteInitialiseAdd]<=WriteInitialiseData;
	    else if (WriteDataBackSignal)	
	        Reg[WriteBackAdd]<=WriteBackData;
         end
endmodule

