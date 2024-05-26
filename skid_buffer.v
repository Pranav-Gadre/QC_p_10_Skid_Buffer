









module skid_buffer (
	input   wire        clk,
	input   wire        reset,

	input   wire        i_valid_i,
	input   wire [7:0]  i_data_i,
	output  wire        i_ready_o,

	input   wire        e_ready_i,
	output  wire        e_valid_o,
	output  wire [7:0]  e_data_o
);

  // Write your logic here...

endmodule