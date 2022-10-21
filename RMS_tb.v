`include "header.v"

module RMS_tb();
    reg clk, rst, start;
    reg [7:0] a;
    wire done;
    wire [11:0] RMS_code;
    
    RMS_top RMS_top1(.clk(clk), .rst(rst), .start(start), .a(a), .RMS_code(RMS_code), .done(done));
    
    initial begin
		$fsdbDumpfile("Simulation_Result/RMS_rtl.fsdb");
		$fsdbDumpvars;
	end
    
    always #5 clk <= ~clk;
    
    initial
    begin
        clk = 1;
        rst = 1;
    #100
        rst = 0;
        a = 8'd42;
        start = 1;
    #10
        start = 0;
    #410
        rst = 0;
        a = 8'd45;
        start = 1;
    #10
        start = 0;
    #410
        rst = 0;
        a = 8'd47;
        start = 1;
    #10
        start = 0;
    #410
        rst = 0;
        a = 8'd51;
        start = 1;
    #10
        start = 0;
    #410
        rst = 0;
        a = 8'd49;
        start = 1;
    #10
        start = 0;
    #410
        rst = 0;
        a = 8'd50;
        start = 1;
    #10
        start = 0;
    #820
        $finish;
    end
    
endmodule
