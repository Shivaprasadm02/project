class count_write_bfm;

virtual count_if.WR_BFM wr_if;
mailbox #(count_trans) gen2wr;
count_trans data2duv;

function new(virtual count_if.WR_BFM wr_if, mailbox #(count_trans) gen2wr);
	this.wr_if=wr_if;
	this.gen2wr=gen2wr;
endfunction

virtual task drive();
begin
@(wr_if.wr_dr_cb);
wr_if.wr_dr_cb.data_in<=data2duv.data_in;
wr_if.wr_dr_cb.load<=data2duv.load;
wr_if.wr_dr_cb.up_down<=data2duv.up_down;
data2duv.display("From Write Driver");
end
endtask

virtual task start();
fork
	//forever
	begin
		for(int i=0;i<number_of_transactions;i++)
		begin
		gen2wr.get(data2duv);
		drive();
		end
	end
join_none
endtask

endclass
