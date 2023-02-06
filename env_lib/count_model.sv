class count_model;

count_trans w_data;
static logic[3:0]ref_count=0;

mailbox #(count_trans) wr2rm;
mailbox #(count_trans) rm2sb;

function new(mailbox #(count_trans) wr2rm,
             mailbox #(count_trans) rm2sb);
         this.wr2rm=wr2rm;
         this.rm2sb=rm2sb;
        this.w_data=new;
endfunction

virtual task count_mod(count_trans counter);
begin
if(counter.resetn==0)
	ref_count<=0;
else if(counter.load)
	ref_count<=counter.data_in;
else
	begin
		if(counter.up_down==0)
		begin
			if(ref_count>=11)
			  ref_count<= 4'd0;
			else
			  ref_count<=ref_count+1'b1;
		end
		else if(counter.up_down==1)
		begin
			if((ref_count>11)||(ref_count<1))
			ref_count<=4'd11;
			else
			ref_count<=ref_count-1'b1;
		end
	end
end
endtask

virtual task start();
	fork
		begin
		for(int i=0;i<number_of_transactions;i++)
		begin
			wr2rm.get(w_data);
		//$display("---%p--",w_data);
			count_mod(w_data);
			w_data.count=ref_count;
			rm2sb.put(w_data);
		end
		end
	join_none
endtask

endclass
