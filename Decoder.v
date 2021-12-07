module decoder(
    input reg  [1:0] sw,
    input            clk,
    input      	  reset,
    output reg [4:0] morse
);

reg prev_sw[1:0];
reg temp_morse[4:0];
assign prev_sw = sw;
integer i;
assign i = 4;
always @(posedge clk) begin
    if(sw[0] != prev_sw[0]) begin
        temp_morse[i] = 1'b0;
        i = i - 1;
    end
    if(sw[1] != prev_sw[1]) begin
        temp_morse[i] = 1'b1;
        i = i - 1;
    end
    if(i == 0) begin
        assign morse[4:0] = temp_morse[4:0];
        i = 4;
    end
end

endmodule