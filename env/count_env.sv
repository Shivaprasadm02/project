class count_env;

virtual count_if.WR_BFM wr_if;
virtual count_if.WR_MON wr_mon_if;
virtual count_if.RD_MON rd_mon_if;

mailbox #(count_trans)gen2wr=new();
mailbox #(count_trans)wr2rm=new();
mailbox #(count_trans)rd2sb=new();
mailbox #(count_trans)rm2sb=new();

count_gen gen_h;
count_write_bfm wdr_h;
count_read_mon rmon_h;
count_write_mon wmon_h;
count_model mod_h;
count_sb sb_h;

function new(virtual count_if.WR_BFM wr_if,
	virtual count_if.WR_MON wr_mon_if,
	virtual count_if.RD_MON rd_mon_if);
 this.wr_if=wr_if;
 this.wr_mon_if=wr_mon_if;
 this.rd_mon_if=rd_mon_if;
endfunction

virtual task build();
 gen_h=new(gen2wr);
 wdr_h=new(wr_if,gen2wr);
 wmon_h=new(wr_mon_if,wr2rm);
 rmon_h=new(rd_mon_if,rd2sb);
 mod_h=new(wr2rm,rm2sb);
 sb_h=new(rm2sb,rd2sb);
$display("build success");
endtask

virtual task reset_duv();

@(wr_if.wr_dr_cb);
wr_if.wr_dr_cb.resetn<=1'b0;
repeat(2)
@(wr_if.wr_dr_cb);
wr_if.wr_dr_cb.resetn<=1'b1;
endtask

virtual task start();
 gen_h.start;
 wdr_h.start;
 wmon_h.start;
 rmon_h.start;
 mod_h.start;
 sb_h.start;
endtask

virtual task stop();
 wait(sb_h.DONE.triggered);
endtask

virtual task run();
reset_duv();
start();
stop();
sb_h.report();
endtask

endclass
