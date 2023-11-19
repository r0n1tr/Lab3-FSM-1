module mux(
    input logic time_out,
    input logic tick,
    input logic cmd_seq,
    output logic out;
)

always_comb begin
    if(cmd_seq == 1)
        out <= tick;
    else
        out <= time_out;
end

endmodule

