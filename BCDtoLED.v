module BCDToLED(
    input  [3:0] in,  // binary input from switches
    output [6:0] seg, // segments
    output [3:0] an   // display specific anodes
);

assign w = in[3];
assign x = in[2];
assign y = in[1];
assign z = in[0];
// assign seg outputs here

assign seg[0] = (~w & ~x & ~y & z) | (x & ~y & ~z);                 // A
assign seg[1] = (x & ~y & z) | (x & y & ~z);                        // B
assign seg[2] = ~x & y & ~z;                                        // C
assign seg[3] = (~w & ~x & ~y & z) | (x & ~y & ~z) | (x & y & z);   // D
assign seg[4] = z |(x & ~y);                                        // E
assign seg[5] = (y & z) | (~w & ~x & z) | (~w & ~x & y);            // F
assign seg[6] = (~w & ~x & ~y) | (x & y & z);                       // G

// assign an output here
assign an[0] = 0;
assign an[1] = 1;
assign an[2] = 1;
assign an[3] = 0;

endmodule