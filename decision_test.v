//------------------------------------------------
// Decision_test.v
// Decision Test Module
// Authors: crystal
// Date: 2017/2/26
//------------------------------------------------
`timescale 1ns/1ns
`include "./decision.v"
module decision_test;
parameter WIDTH = 8;
reg start_i,clock,reset;
reg [WIDTH-1:0] x1=0,x2=0,x3=0;
wire [WIDTH-1:0] y_o;
wire y_valid_o;
decision decision(.start_i(start_i),
	.clock(clock),
	.reset(reset),
	.x1(x1),
	.x2(x2),
	.x3(x3),
	.y_o(y_o),
	.y_valid_o(y_valid_o)
	);
always #50 clock = ~ clock;
initial	begin
	clock = 0;
	reset = 0;
	#50 start_i = 1;
	//repeat(5) begin
	#50	x1 = {$random}%255;
		x2 = {$random}%255;
		x3 = {$random}%255;
	//end
	#5000 $finish;
end
initial	begin
		$dumpfile("decision_test.vcd");
		$dumpvars(0,decision_test);
	end


endmodule