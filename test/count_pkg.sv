
package count_pkg;

   int number_of_transactions=1;
  
	`include "count_trans.sv"
	`include "count_gen.sv"
	`include "count_write_bfm.sv"
	`include "count_write_mon.sv"
	`include "count_read_mon.sv"
	`include "count_model.sv"
	`include "count_sb.sv"
	`include "count_env.sv"
	`include "test.sv"
	//include "ram_trans.sv", include "ram_gen.sv", include "ram_write_bfm.sv"
	//"ram_read_bfm.sv", include "ram_write_mon.sv","ram_read_mon.sv"
	//"ram_model.sv", "ram_sb.sv", "ram_env.sv"

endpackage
