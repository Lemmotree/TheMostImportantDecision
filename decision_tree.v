//------------------------------------------------
// Decision_tree.v
// Decision Tree Ram Module
// Authors: crystal
// Date: 2017/2/26
//------------------------------------------------
`include "./head.v"
module decision_tree 
	(	input wire clk,
		input wire we,
		input wire rst,
		input wire [`WIDTH-1:0] adr,
		output reg [`NODE+`WIDTH+`NS_T+`NS_F+`RAM_OUT-1:0] ram_out
		);

reg [`NODE+`WIDTH+`NS_T+`NS_F+`RAM_OUT-1:0] mem [MAX:0];
initial	begin
  $readmemb("decision.txt",mem);
end
always @(posedge clk) begin
	if(rst)
		ram_out <= 0;
	else if(we) begin
		ram_out <= mem[adr];
	end
end
endmodule
