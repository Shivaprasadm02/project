interface count_if(input bit clock);
logic [3:0]data_in;
logic [3:0]count;
logic load;
logic up_down;
logic resetn;

clocking wr_dr_cb@(posedge clock);
	default input #1 output #1;
	output data_in;
	output load;
	output resetn;
	output up_down;
endclocking

clocking wr_mon_cb@(posedge clock);
	default input #1 output #1;
	input data_in;
	input load;
	input up_down;
endclocking

clocking rd_mon_cb@(posedge clock);
	default input #1 output #1;
	input count;
endclocking

modport WR_BFM(clocking wr_dr_cb);
modport WR_MON(clocking wr_mon_cb);
modport RD_MON(clocking rd_mon_cb);
endinterface
