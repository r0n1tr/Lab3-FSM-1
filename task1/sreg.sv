module sreg4 (
    input logic clk,
    input logic rst,
    input logic data_in, 
    input logi data_cout
);

    logic [4:1] sreg;

    always_ff @ (posedge clk)
        if(rst)
            sreg <= 4'b0;
        else begin
            sreg[4] <= sreg[3];
            sreg[3] <= sreg[2];
            sreg[2] <= sreg[1];
            sreg[1] <= data_in;
        end
    assign data_cout = sreg[4];
endmodule

