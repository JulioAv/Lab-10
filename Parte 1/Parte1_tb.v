module testbench();
reg [11:0]D1;
reg clk, enabled1, enabled2, load, reset1, reset2;
wire [7:0]Y;

P1 F1(D1, clk, enabled1, enabled2, load, reset1, reset2, Y);
always
  #1 clk=~clk;

initial begin
  #1
  $display("Procesador Parte 1");
  $display("clk D1  Q1  O   Y");
  $display("------");
  $monitor("%b  %b", clk, Y);

  #1
  reset1=1; reset2=1; load=0; enabled1=1; enabled2=1; clk=0; D1=0;
  #1 reset1=0; reset2=0;
end

initial
  #20 $finish;
initial begin
  $dumpfile("Parte1_tb.vcd");
  $dumpvars(0, testbench);
end
endmodule
