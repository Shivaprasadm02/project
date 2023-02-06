class count_read_mon;

virtual count_if.RD_MON rd_mon_if;
mailbox #(count_trans) rd2sb;

count_trans trans_h;
count_trans data2sb;

function new(virtual count_if.RD_MON rd_mon_if, 
	mailbox #(count_trans) rd2sb);
	this.rd_mon_if=rd_mon_if;
	this.rd2sb=rd2sb;
	this.trans_h=new;
endfunction

virtual task monitor();
begin
	@(rd_mon_if.rd_mon_cb);
	begin
	trans_h.count=rd_mon_if.rd_mon_cb.count;
	trans_h.display("From Read Monitor");
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
                               // $display("--trans--%p",trans_h);
		data2sb=new trans_h;
		//$display("--data2 mailbox--%p",data2sb);
		rd2sb.put(data2sb);
		//$display("--mailbox-wr2rm--%p",rd2sb);
		end
	end
join_none
endtask

endclass
