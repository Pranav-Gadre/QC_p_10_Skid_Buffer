









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
    reg  [2:0] count;
    reg  i_valid_i_p1;
    reg  i_valid_i_p2;
    wire just_ivi;
    wire just_just_ivi;
    
    assign just_ivi      = ((!i_valid_i_p1) && i_valid_i);
    assign just_just_ivi = ((!i_valid_i_p2) && i_valid_i_p2);
    
    always @ (posedge clk or posedge reset) begin 
        if (reset) begin 
            count        <= 0;
            i_valid_i_p1 <= 0;
            i_valid_i_p2 <= 0;
        end else begin 
            i_valid_i_p1 <= i_valid_i;
            i_valid_i_p2 <= i_valid_i_p1;
        end 
    end 
    
endmodule