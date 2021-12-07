module decoder(
    input      [1:0] sw,
    input            clk,
    input      	  reset,
    output reg [4:0] morse
);

reg [1:0] prev_sw;
reg [4:0] temp_morse;

integer i = 5;

always @(posedge clk) begin
    if(sw[0] != prev_sw[0]) begin
        temp_morse[i] = 1'b0;
        i = i - 1;
        prev_sw = sw;
    end
    if(sw[1] != prev_sw[1]) begin
        temp_morse[i] = 1'b1;
        i = i - 1;
        prev_sw = sw;
    end
    if(i == 0) begin
        morse = temp_morse;
        i = 5;
    end
end

endmodule