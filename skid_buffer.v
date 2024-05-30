









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
    reg  [7:0] extra_buff;
    reg  [7:0] main_buff
    reg  i_valid_i_p1;
    reg  i_valid_i_p2;
    reg  e_ready_i_p1;
    reg  e_ready_i_p2;
    wire just_ivi;
    wire just_just_ivi;
//    wire ivi_fall_1;
//    wire ivi_fall_2;
    wire ready_rise_1;
    wire ready_rise_2;
    
    assign just_ivi      = ((!i_valid_i_p1) && i_valid_i);
    assign just_just_ivi = ((!i_valid_i_p2) && i_valid_i_p1);
    assign ready_rise_1  = ((!e_ready_i_p1) && e_ready_i);
    assign ready_rise_2  = ((!e_ready_i_p2) && e_ready_i_p1);
    
    // major
    assign e_data_o = (e_ready_i && i_valid_i) ? i_data_i : main_buff;
    
    always @ (posedge clk or posedge reset) begin 
        if (reset) begin 
            count        <= 0;
            i_valid_i_p1 <= 0;
            i_valid_i_p2 <= 0;
            e_ready_i_p1 <= 0;
            extra_buff   <= 0;
            main_buff    <= 0;
        end else begin 
            i_valid_i_p1 <= i_valid_i;
            i_valid_i_p2 <= i_valid_i_p1;
            e_ready_i_p1 <= e_ready_i;
            if (just_ivi || just_just_ivi) begin 
                extra_buff <= i_data_i;
                main_buff  <= extra_buff;
            end else begin
                extra_buff <= extra_buff;
                main_buff  <= main_buff;
            end            
        end 
    end 
    
endmodule