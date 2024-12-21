









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
    parameter EMPTY = 0,
              HALF  = 1,
              FULL  = 2;
    
    reg  [2:0] state;          
    reg  [7:0] extra_buff;
    reg  e_ready_i_d1;
    

    // major
//    assign e_data_o  = (e_ready_i && i_valid_i) ? i_data_i : main_buff;
    assign e_data_o  = (state == EMPTY || state == HALF) ? i_data_i : extra_buff;
//    assign e_data_o  = (state == EMPTY) ? i_data_i   : main_buff;
    assign e_valid_o = (i_valid_i || (state != EMPTY));
//    assign i_ready_o = ((state == EMPTY && i_valid_i) || e_ready_i_d1);
    assign i_ready_o = ((state == EMPTY) || e_ready_i_d1);    
    
    
    always @ (posedge clk or posedge reset) begin 
        if (reset) begin 
            extra_buff   <= 0;
        //    main_buff    <= 0;
            state        <= EMPTY;
            e_ready_i_d1 <= 0;
        end else begin 
            e_ready_i_d1 <= e_ready_i;
            case (state) 
            EMPTY: begin 
                if (i_valid_i && (!e_ready_i)) begin 
                    state <= HALF;
                end else begin 
                    state <= EMPTY;
                end 
                extra_buff <= i_data_i;
            //    main_buff  <= extra_buff;
            end 
            HALF : begin
                if (i_valid_i && (!e_ready_i)) begin 
                    state <= FULL;
            //    end else if (e_ready_i && (!i_valid_i)) begin 
            //        state <= EMPTY;
                end else if (e_ready_i) begin 
                    state <= EMPTY;
                end else begin 
                    state <= HALF;
                end 
                extra_buff <= i_data_i;
            //    main_buff  <= extra_buff;
            end 
            FULL : begin
            //    if (e_ready_i && (!i_valid_i)) begin 
            //        state <= HALF;
                if (e_ready_i) begin 
                    state <= HALF;
                    extra_buff <= i_data_i;
                //    main_buff  <= extra_buff;
                end else begin 
                    state <= FULL;
                    extra_buff <= extra_buff;
                //    main_buff  <= main_buff;
                end 
                
            end 
            endcase
        end 
    end 
    
endmodule