module testbench();
reg clk, enabled, reset, B1, B2;
reg [2:0]F;
reg [3:0]D;
wire [3:0]O;
wire FZ, FC;

P2 F2(clk, enabled, reset, B1, B2, D, F, O, FZ, FC);
always
  #1 clk=~clk;

initial begin
  #1
  $display("Procesador Parte 2");
  $display("clk  D  FZ  FC  B1  B2  Q");
  $display("----------------------------");
  $monitor("%b  %b  %b  %b  %b  %b  %b", clk, D, FZ, FC, B1, B2, O);

  #1
  reset=1; D=1; B1=0; B2=1; clk=0; enabled=1; F=3'b010;
  #1  reset=0; B1=1;
  #3  D=2; F=3'b011;
  #1  D=0;
  #1  F=3'b000;


end

initial
#10 $finish;
initial begin
  $dumpfile("Parte2_tb.vcd");
  $dumpvars(0, testbench);
end
endmodule
