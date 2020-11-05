module PC (input wire clk, enabled1, load, reset1, input wire [11:0]D1, output reg [11:0]Q1);
always @(posedge clk or posedge reset1 or posedge load) begin

  if (reset1)
    Q1<=0;
  else if (load)
    Q1<=D1;
  else if (enabled1)
    Q1<=Q1+1'b1;
  end

endmodule

module ROM (input wire [11:0]M, output [7:0]O );

assign O = m[M];
reg[7:0] m[0:4095];

initial begin
  $readmemb("rom.list", m);
end

endmodule

module Fetch (input wire [7:0]D2, input wire enabled2, clk, reset2, output reg [7:0]Q2);
always @(posedge clk or posedge enabled2 or posedge reset2) begin

  if (reset2)
    Q2<=0;
  else if (enabled2)
    Q2<=D2;
  end
endmodule

module P1 (input wire [11:0]D1, input wire clk, enabled1, enabled2, load, reset1, reset2, output wire [7:0] Y);
wire [11:0]Q1;
wire [7:0]O;
PC p1(clk1, enabled1, load, reset1, D1, Q1);
ROM p2(Q1, O);
Fetch p3(O, enabled2, clk, reset2, Y);
endmodule
