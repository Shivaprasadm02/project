import count_pkg::*;

class test;

    virtual count_if.WR_BFM wr_if; 
    virtual count_if.WR_MON wr_mon_if;
    virtual count_if.RD_MON rd_mon_if; 

    count_env env;
	
	function new( virtual count_if.WR_BFM wr_if, 
				virtual count_if.WR_MON wr_mon_if,
				virtual count_if.RD_MON rd_mon_if);
    		this.wr_if = wr_if;
		this.wr_mon_if = wr_mon_if;
		this.rd_mon_if = rd_mon_if;
    	env = new(wr_if,wr_mon_if,rd_mon_if);
	endfunction

	task build_and_run();
		begin
			if($test$plusargs("TEST1"))
				begin
					number_of_transactions = 5;
					env.build();
					env.run();
					$finish;
				end
/*
			if($test$plusargs("TEST2"))
			   begin
				   data_h1=new;
				   number_of_transactions = 500;
				   env.build();
				   env.gen.gen_trans= data_h1;
				   env.run(); 
				   $finish;
			   end
			if($test$plusargs("TEST3"))
			   begin
				   data_h2=new;
				   number_of_transactions = 200;
				   env.build();
				   env.gen.gen_trans= data_h2;
				   env.run(); 
				   $finish;
			   end
*/
		end
endtask
/*
task build();
	env.build;
endtask
task run();
	env.run;
endtask
	
*/
endclass


