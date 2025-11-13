`timescale 1ns/1ps
module tb_stopwatch;
reg clk;
reg reset;
reg start;
reg stop;
wire [5:0] seconds;
wire [5:0] minutes;
wire run;
stopwatch DUT(
    .clk(clk),
    .reset(reset),
    .start(start),
    .stop(stop),
    .seconds(seconds),
    .minutes(minutes),
    .run(run)
);
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    reset = 1; start = 0; stop = 0;
    #20 reset = 0;
    #30 start = 1; #10 start = 0;
    #300 stop = 1; #10 stop = 0;
    #200 start = 1; #10 start = 0;
    #300 reset = 1; #20 reset = 0;
    #200 $finish;
end
initial begin
    $dumpfile("stopwatch.vcd");
    $dumpvars(0, tb_stopwatch);
end
endmodule
