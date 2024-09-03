// Behavioral description of majority over 3 Boolean inputs

module MAJ (a, b, c, m);
    input a, b, c;
    output m;

    assign m = a && b || a && c || b && c;
endmodule