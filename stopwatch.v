module stopwatch(
    input clk,
    input reset,
    input start,
    input stop,
    output reg [5:0] seconds,
    output reg [5:0] minutes,
    output reg run
);
reg [25:0] divider;
reg tick;
always @(posedge clk) begin
    if (divider == 9) begin
        divider <= 0;
        tick <= 1;
    end else begin
        divider <= divider + 1;
        tick <= 0;
    end
end
always @(posedge clk) begin
    if (reset) begin
        run <= 0;
    end else begin
        if (start) run <= 1;
        if (stop)  run <= 0;
    end
end
always @(posedge clk) begin
    if (reset) begin
        seconds <= 0;
        minutes <= 0;
    end else if (tick && run) begin
        if (seconds == 59) begin
            seconds <= 0;
            if (minutes == 59) minutes <= 0;
            else minutes <= minutes + 1;
        end else begin
            seconds <= seconds + 1;
        end
    end
end
endmodule
