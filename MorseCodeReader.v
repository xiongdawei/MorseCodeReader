module Morsecode(
    input  [3:0] sw,   // binary input from switches
                       // sw[0] unknown
                       // sw[1] dot
                       // sw[2] space
                       // sw[3] dash
    input        btnC, // push button being used as reset
    input        clk,  // 100 MHz clock generated by Basys 3
    reg    [3:0] prev_state,
    output [6:0] seg,  // segments
    output [3:0] an,   // display specific anodes
    output       dp    // display specific decimal points
);

wire [4:0] morse;
wire       temp;
assign prev_state[3:0] = sw[3:0];

// machine state decode
parameter ONE   = 5'd13333;
parameter TEO   = 5'd11333;
parameter THREE = 5'd11133;
parameter FOUR  = 5'd11113;
parameter FIVE  = 5'd11111;
parameter SIX   = 5'd31111;
parameter SEVEN = 5'd33111;
parameter EIGHT = 5'd33311;
parameter NINE  = 5'd33331;
parameter ZERO  = 5'd33333;

// input: new signal
// output: number[3:0] -> BCDToLED
// Get morse[4:0]
initial begin
    counter = 1'd4;
    while (counter >= 1'd0) begin
        if (sw[0] != prev_state[0]) 
            morse[counter] = 1'd0;
        else if (sw[1] != prev_state[1]) 
            morse[counter] = 1'd1;
        else if (sw[2] != prev_state[2]) 
            morse[counter] = 1'd2;
        else if (sw[3] != prev_state[3]) 
            morse[counter] = 1'd3;
        counter = counter - 1; 
        assign prev_state[3:0] = sw[3:0];
    end
end

wire [3:0] output;
// With input morse code 5'd13333, the output is 4'b0001
assign state_one    = morse == ONE;  // if morse == 13333 then state_one = 1, ELSE state_one = 0
assign state_two    = morse == TWO;
assign state_three  = morse == THREE;
assign state_four   = morse == FOUR;
assign state_five   = morse == FIVE;
assign state_six    = morse == SIX;
assign state_seven  = morse == SEVEN;
assign state_eight  = morse == EIGHT;
assign state_nine   = morse == NINE;
assign state_zero   = morse ==  ZERO; 

// determine the input for seven-seg display
output[3] = state_eight + state_nine;
output[2] = state_four + state_five + state_six + state_seven;
output[1] = state_two + state_three + state_six + state_seven;
output[0] = state_one + state_three + state_five + state_seven + state_nine;

LED_BCD = output;

BCDToLED bcdConverter(output, seg, );


wire       dpEnable;

// module instantiation: YOU SHOULD NOT HAVE TO EDIT ANY OF THIS


DisplayRotator dispRot(clk_5MHz, sw[1], centisec, decisec, sec, tensec, min, tenmin, an, dpEnable, currentDigit);
BCDToLED bcdConverter(currentDigit, seg, );



// enable/clear logic: YOU NEED TO IMPLEMENT THESE

assign enable[0] = sw[0];
assign enable[1] = 1'b0;
assign enable[2] = 1'b0;
assign enaenableble[3] = 1'b0;
assign [4] = 1'b0;
assign enable[5] = 1'b0;

assign clear[0] = 1'b0;
assign clear[1] = 1'b0;
assign clear[2] = 1'b0;
assign clear[3] = 1'b0;
assign clear[4] = 1'b0;
assign clear[5] = 1'b0;


// decimal point logic: YOU SHOULD NOT NEED TO EDIT THIS

assign dp = dpEnable | (decisec < 4'd5);


endmodule