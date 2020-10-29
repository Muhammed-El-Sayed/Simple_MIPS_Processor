module Memory(address,DataIn,clk,R_W,DataOut);

	input [31:0] address; //32-bits to fetch Memory 256 rows(we used only 8-bits from 32-bits of address) with 32-bits word width
	input [31:0] DataIn; //Memory DataIn
	input clk; //Sequential clock
	input R_W; //1 to read, 0 to write
	output reg [31:0] DataOut; //Memory DataOut
	reg [31:0] MemReg [0:255]; //Memory 32-bits word width , 256 rows

	always@(posedge clk) 
          begin
		if(R_W) //if 1 read the data in Memory of current address 
                  DataOut<= MemReg[address]; 
                else //if 0 write the DataIn in MemoryRegister in current address
                  MemReg[address]<=DataIn;
          end
endmodule
