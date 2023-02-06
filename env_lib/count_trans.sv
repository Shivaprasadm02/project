class count_trans;
rand logic [3:0] data_in;
rand logic load;
rand logic up_down;
logic resetn;
logic [3:0]count;

constraint C1 {data_in inside{[1:8]};}
constraint C2 {load dist{1:=30,0:=70};}
constraint C3 {up_down dist{0:=50,1:=50};}

function void post_randomize();
	$display("--RANDOMIZED DATA--");
	$display("data_in=%d",this.data_in);
	$display("load=%d",this.load);
	$display("count=%d",this.count);
endfunction

virtual function void display(input string s);
begin
$display("________");
$display("-----%s------",s);
$display("up-down=%d",up_down);
$display("load=%d",load);
$display("data_in=%d",data_in);
$display("count=%d",count);
$display("resetn=%d",resetn);
$display("________");
$display("________");
end
endfunction
endclass 
