 module InstructionRegister(address,DataIn,clk,R_W,DataOut);

	input [15:0] address; //16-bits to fetch IR 65536 rows with 32-bits word width
	input [31:0] DataIn; //IR DataIn (to initialise IR)
	input clk; //Sequential clock
	input R_W; //1 to read(Reading Instructions), 0 to write(Initialising IR)
	output reg [31:0] DataOut; //IR DataOut(Reading Instructions)
	reg [31:0] IR [0:65535]; //IR 32-bits word width , 65536 rows

	always@(posedge clk) 
          begin
		if(R_W) //if 1 read the data in IR of current address (Reading Instructions) 
                  DataOut<= IR[address]; 
                else //if 0 write the DataIn in IR in current address (Initialising IR)
                  IR[address]<=DataIn;
          end
endmodule