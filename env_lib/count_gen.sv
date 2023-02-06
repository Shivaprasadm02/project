class count_gen;
count_trans trans_h;
count_trans data2wr;

mailbox #(count_trans) gen2wr;

function new(mailbox #(count_trans) gen2wr);
this.gen2wr=gen2wr;
this.trans_h=new;
endfunction

virtual task start();
fork
	begin
	for(int i=0;i<number_of_transactions;i++)
		begin
			assert(trans_h.randomize());
			data2wr=new trans_h;
			gen2wr.put(data2wr);
			trans_h.display("From Gen");
			//$display("gendata--%p", data2send);
		end
	end
join_none
endtask

endclass
