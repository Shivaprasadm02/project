
//`include "test.sv"
import count_pkg::*;
module top();
  
   parameter cycle = 10;
  
   reg clock;

	count_if DUV_IF(clock);

	test test_h;

	count DUV(.clk(clock),
		 .data_in(DUV_IF.data_in),
		.load(DUV_IF.load),
		.up_down(DUV_IF.up_down),
		.resetn(DUV_IF.resetn),
		.count(DUV_IF.count)
		);

	initial
		begin
			clock=1'b0;
			forever #(cycle/2) clock=~clock;
		end


	initial
		begin
			test_h = new(DUV_IF, DUV_IF, DUV_IF);
			test_h.build_and_run();
			$finish;
		end
/*
initial
	begin
	if($test$plusargs("TEST1"))
		begin
		test_h=new(DUV_IF, DUV_IF, DUV_IF);
		number_of_transactions=20;
		test_h.build();
		test_h.run();
		$finish;
		end
	end	
*/

 endmodule
