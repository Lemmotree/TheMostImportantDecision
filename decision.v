//------------------------------------------------
// Decision.v
// Decision Module
// Authors: crystal
// Date: 2017/2/26
//------------------------------------------------
`include "./head.v"
`include "./decision_tree.v"
module decision 
	(input wire start_i,
	input wire clock,
	input wire reset,
	input wire [`WIDTH-1:0] x1,
	input wire [`WIDTH-1:0] x2,
	input wire [`WIDTH-1:0] x3,
	output reg [`WIDTH-1:0] y_o,
	output reg  y_valid_o
	);
wire [`WIDTH*4:0] ram_out;
reg [`WIDTH-1:0] x[`X_NUM:0];
reg node_type;
reg i = 0;
reg [`WIDTH-1:0] state = 0,cmp = 0,next_state = 0,
	next_state_T = 0,next_state_F = 0,y_out;
decision_tree decision_tree(.clk(clock),.we(start_i),
	.rst(reset),.adr(state),.ram_out(ram_out));
always @(*) begin 
	x[0] <= x1;
	x[1] <= x2;
	x[2] <= x3;
	node_type <= ram_out[32];
	cmp <= ram_out[`WIDTH*4-1:`WIDTH*3];
	next_state_T <= ram_out[`WIDTH*3-1:`WIDTH*2];
	next_state_F <= ram_out[`WIDTH*2-1:`WIDTH];
	y_out <= ram_out[`WIDTH-1:0];
end
always @(posedge clock) begin
	if(reset) begin
		 y_o <= 0;
		 y_valid_o <= `INVALID;
	end else if(start_i) begin	
		if(node_type == `DECISION_NODE)	begin
			if(x[i] > cmp) begin
				next_state <= next_state_T;
				end else begin
					next_state <= next_state_F;
				end
				i <= i + 1;
				state <= next_state;
			end
		end
		if(node_type == `OUT_NODE) begin
			y_o <= y_out;
			y_valid_o <= `VALID;
		end
	end
endmodule // decision
