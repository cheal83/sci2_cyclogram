`timescale 1ns / 1ps

`include "sci2.vh"

module sci2_word(
    input  [`SCI2_W_DATA - 1 : 0]  word_data_in,
    input  [`SCI2_W_MARK - 1 : 0]  word_mark_in,
    output [`SCI2_W_WORD - 1 : 0]  word_out
);
    
    wire [`SCI2_W_PARITY - 1 : 0] parity_n;
    wire [`SCI2_W_MARK + `SCI2_W_DATA - 1 : 0] tmp;
    assign tmp = {word_mark_in, word_data_in};
    assign parity_n = ^tmp;
    assign word_out = {`SCI2_STOP_BIT, ~parity_n, tmp, `SCI2_START_BIT};

endmodule
