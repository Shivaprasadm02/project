module count(input clk,resetn,load,up_down ,input [3:0] data_in, output reg [3:0] count);
 always@(posedge clk)
 begin
  if(!resetn)
   count<=4'd0;
  else if(load)
	count<=data_in;
  //else if(load==0)
  //wait(load==0)
  else
  begin
    if(up_down==1)      //Up Mode is selected
       if (count >= 11) 
       count <= 0;
	   else
	   count<=count+1;  //increment counter
		
   else if(up_down==0) 
	   if((count==0)||(count>11))
	   count<=11;
	  else
	   count<=count-1; 
   end
 end
 endmodule