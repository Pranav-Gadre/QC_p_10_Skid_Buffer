









module skid_buffer_tb (
	
);

  // Write your logic here...
    reg  clk;
    reg  reset;
    reg  i_valid_i;
    reg  [7:0] i_data_i;
    reg   e_ready_i;
    wire  e_valid_o;
    wire i_ready_o;
    wire [7:0] e_data_o;
    
    
    skid_buffer sb(
    .clk          (    clk          ),
    .reset        (    reset        ),
    .i_valid_i    (    i_valid_i    ),
    .i_data_i     (    i_data_i     ),
    .i_ready_o    (    i_ready_o    ),
    .e_ready_i    (    e_ready_i    ),
    .e_valid_o    (    e_valid_o    ),
    .e_data_o     (    e_data_o     )
    );
    
    always #5 clk = ~clk;
    
    task demo_tc();
    begin 
        #5;
        reset = 0;
        // Using NBAs so that these assignments take
        // place after application of clock edge
        #10;
        i_valid_i <= 1;
        i_data_i  <= 'd90;
        
        #10;
        i_data_i  <= 'd255;
        
        #30;
        e_ready_i <= 1;
        
        #20;
        i_valid_i <= 0;
        i_data_i  <= 'd0;
    end 
    endtask
    
    initial begin 
    clk = 0;
    reset = 1;
    i_valid_i = 0;
    i_data_i  = 0;
    e_ready_i = 0;
    
    demo_tc();
    
    #1000;
    $stop;
    
    end 
endmodule