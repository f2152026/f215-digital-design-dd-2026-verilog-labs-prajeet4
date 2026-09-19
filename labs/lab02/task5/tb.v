module tb;
reg  [3:0] t_a;
reg  [3:0] t_b;
reg        t_op;
wire [3:0] t_result;
reg  [3:0] expected;
integer errors;
integer total;
integer i, j;

alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
);

string vcd_file;
initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
        $dumpfile(vcd_file);
        $dumpvars(0, DUT);
    end
end

initial begin
    errors = 0;
    total  = 0;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            t_a  = i;
            t_b  = j;
            t_op = 0;
            #1;
            expected = i + j;
            total = total + 1;
            if (t_result !== expected) begin
                $display("FAIL ADD: A=%b B=%b OP=%b | got=%b expected=%b",
                         t_a, t_b, t_op, t_result, expected);
                errors = errors + 1;
            end

            t_op = 1;
            #1;
            expected = i - j;
            total = total + 1;
            if (t_result !== expected) begin
                $display("FAIL SUB: A=%b B=%b OP=%b | got=%b expected=%b",
                         t_a, t_b, t_op, t_result, expected);
                errors = errors + 1;
            end
        end
    end
    $display("SUMMARY: %0d/%0d tests passed, %0d errors",
             total - errors, total, errors);
    $finish;
end

endmodule