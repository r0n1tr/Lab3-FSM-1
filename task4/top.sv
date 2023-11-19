module top (

    input logic flagVbd;
)

endmodule

    logic tick,
    logic [6:0] lfsrDelay,
    logic mux,
    logic time_out,
    logic muxF1;

lfsr mylfsr(
    .clk(clk),
    .data_out(lfsrDelay)
)


clktick myclktick(
    .en(cmd_seq),
    .rst(rst),
    .clk(clk),
    .N(5'd24),
    .tick(tick)
)

delay mydelay(
    .n(lfsrDelay),
    .trigger(cmd_delay)
    .rst(rst)
    .clk(clk),
    .time_out(time_out)
)

mux mymux(
    .tick(tick),
    .time_out(time_out),
    .out(muxF1)
)

f1_fsm myfsm(
    .rst(rst),
    .en(muxF1),
    .trigger(flagVbd),
    .clk(clk),
    
)