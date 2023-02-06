class count_write_mon;

virtual count_if.WR_MON wr_mon_if;
mailbox #(count_trans) wr2rm;

count_trans trans_h;
count_trans data2rm;

function new(virtual count_if.WR_MON wr_mon_if, 
		mailbox #(count_trans) wr2rm);
	this.wr_mon_if=wr_mon_if;
	this.wr2rm=wr2rm;
	this.trans_h=new;
endfunction

virtual task monitor();
begin
	@(wr_mon_if.wr_mon_cb);
	begin
	trans_h.data_in=wr_mon_if.wr_mon_cb.data_in;
	trans_h.load=wr_mon_if.wr_mon_cb.load;
	trans_h.up_down=wr_mon_if.wr_mon_cb.up_down;
	trans_h.display("From Write Monitor");
end
end
endtask

virtual task start();
fork
	//forever
	begin
	for(int i=0;i<number_of_transactions;i++)
		begin
		monitor;
		data2rm=new trans_h;
		wr2rm.put(data2rm);
		end
	end
join_none
endtask

endclass
