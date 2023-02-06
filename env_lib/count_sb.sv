class count_sb;
event DONE;

count_trans rm_data;
count_trans sb_data;
//count_trans cov_data;

static int ref_data=0;
static int rd_data=0;
static int data_verified=0;

mailbox #(count_trans) rm2sb;
mailbox #(count_trans) rd2sb;

/*
covergroup count_coverage;
	option.per_instance=1;
	DATA : coverpoint cov_data.data_in{bins din={[0:13]};}
	LOAD : coverpoint cov_data.load{};
	MODE : coverpoint cov_data.up_down{};
	DATAxLOAD : cross DATA,LOAD;
	DATAxMODE : cross DATA,MODE;
endgroup
*/

function new(mailbox #(count_trans) rm2sb,
             mailbox #(count_trans) rd2sb);
         this.rm2sb=rm2sb;
         this.rd2sb=rd2sb;
         //count_coverage=new;
endfunction

virtual task start();
fork
    forever
       begin
	 rm2sb.get(rm_data);
	 ref_data++;

	 rd2sb.get(sb_data);
	 rd_data++;

	 check(sb_data);
      end
join_none
endtask

virtual task check(count_trans rdata);
	begin
		if(rm_data.count==rdata.count)
		   $display("count matches");
		else
		   $display("count not matching");
		//$finish();
	end
	data_verified++;
	$display("data verified=%d",data_verified);

//cov_data=new rm_data;
//count_coverage.sample();

	if(data_verified>=number_of_transactions)
		begin
			->DONE;
		end
endtask

virtual function void report();
	$display(".............SCOREBOARD REPORT................");
	$display("data_generated-%d",rm_data);
	$display("data_verified-%d",data_verified);
	$display(".................................................");
endfunction

endclass
