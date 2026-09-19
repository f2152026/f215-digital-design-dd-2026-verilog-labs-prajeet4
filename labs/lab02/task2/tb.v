module tb;
reg  [2:0] t_sel;
wire [7:0] t_dout;

lut #(.WIDTH(8), .DEPTH(8)) U1 (
    .sel(t_sel),
    .dout(t_dout)
);

string vcd_file;
initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
        $dumpfile(vcd_file);
        $dumpvars(0, U1);
    end
end

initial begin
    t_sel=3'b000;
    #5 t_sel=3'b001;
    #5 t_sel=3'b010;
    #5 t_sel=3'b011;
    #5 t_sel=3'b100;
    #5 t_sel=3'b101;
    #5 t_sel=3'b110;
    #5 t_sel=3'b111;
    #5 $finish;
end

initial
    $monitor($time, " sel=%b | dout=%d", t_sel, t_dout);

endmodule