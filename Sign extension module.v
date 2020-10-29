module SignExtend(In,Out);

    input [15:0] In; //Input 16-bits
    output [31:0] Out; //Output 32-bits where Most significant 16-bits are sign-extend

  //concatenating Most significant 16-bits sign-extension beside 16-bits of input in Out 
assign Out ={In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15],In[15:0]};


endmodule
