// Write your modules here!
module alu(input [31:0] a, b,
    input [2:0] f,
    output [31:0] result,
    output [31:0] zero,
    output overflow, // implemented
    output carry, // implemented
    output negative);

      wire [31:0] mux1;
      wire [31:0] mux2or, mux2and, sum, slt;
      wire [32:0] temp;
      wire cout;
  
//small mux
      assign mux1 = f[0] ? (~b) : b;

//Adder
      assign temp = a + mux1 + f[0];
      assign sum = temp[31:0];
      assign cout = temp[32];

//overflow
     assign overflow = ~(f[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & ~f[1];

//carry
      assign carry = ~f[1] & cout;

// slt
      assign slt = sum[31] ^ overflow;

// big mux
      assign mux2or = a | b;
      assign mux2and = a & b;
      assign result = f[2] ? slt : (f[1] ? (f[0] ? mux2or : mux2and) : sum); 

// negative
      assign negative = result[31];     
// zero
      assign zero = (result == 0);

endmodule
