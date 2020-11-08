module ALU (input wire [3:0]A, B, input wire [2:0]F, output reg [3:0]Y, output reg FZ, FC);
  always @(*) begin
    case (F)
      3'b000: Y= A;
      3'b001: Y= (A<B) ? 4'b0001: 4'b0000;
      3'b010: Y= B;
      3'b011: Y= A + B;
      3'b100: Y= ~(A & B);
      default: Y= A;
    endcase

    if (Y==4'b0000)
      FZ<=1;
    else
      FZ<=0;
    if (Y==5'b1xxxx)
      FC<=1;
    else
      FC<=0;
  end
endmodule

module Bus(input wire [3:0]D, input wire B, output reg [3:0]Q);
  always @(*) begin
    if (B)
      Q<=D;
    else
      Q<=4'bz;
  end
endmodule

module Accu(input wire [3:0]D1, input wire enabled, clk, reset, output reg [3:0]Q1);
always @(posedge clk or posedge enabled or posedge reset) begin

  if (reset)
    Q1<=0;
  else if (enabled)
    Q1<=D1;
  end
endmodule

module P2(input wire clk, enabled, reset, B1, B2, input wire [3:0]D, input wire [2:0]F, output wire [3:0]O, output wire FZ, FC);
wire [3:0]Q1;
wire [3:0]Q2;
wire [3:0]A;
  Bus b1(D, B1, Q1);
  ALU  A3(A, Q1, F, Q2, FZ, FC);
  Accu A2(Q2, enabled, clk, reset, A);
  Bus b2(Q2, B2, O);

endmodule
