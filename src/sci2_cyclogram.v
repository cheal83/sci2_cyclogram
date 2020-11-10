
`include "sci2.vh"


module sci2_cyclogram (
  output clk_a,
  output clk_b,
  output data_a,
  output data_b
);


   parameter PERIOD = 2;
   reg clk;
   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end
   assign clk_a = clk;
   assign clk_b = ~clk;
   
   reg data = 1; /* dafault state */
   assign data_a = data;
   assign data_b = ~data;
   
   reg [`SCI2_W_ADDR - 1 : 0]  cmd_addr     = `SCI2_W_ADDR'd0;
   reg [`SCI2_W_GROUP - 1 : 0] cmd_group    = `SCI2_GROUP_NO;
   reg [`SCI2_W_CMD - 1 : 0]   cmd_code     = `SCI2_CMD_CODE_NO;

   wire [`SCI2_W_DATA - 1 : 0] word_cmd_data = {cmd_code, cmd_group, cmd_addr};
   wire [`SCI2_W_WORD - 1 : 0] word_cmd;
   sci2_word sci2_word_cmd_i (
     .word_data_in(word_cmd_data),
     .word_mark_in(`SCI2_MARK_CMD),
     .word_out(word_cmd)
   );
   
   reg  [`SCI2_W_DATA - 1 : 0] word_info1_data = `SCI2_W_DATA'd0;
   wire [`SCI2_W_WORD - 1 : 0] word_info1;
   sci2_word inst_word_info1 (
     .word_data_in(word_info1_data),
     .word_mark_in(`SCI2_MARK_INFO),
     .word_out(word_info1)
   );
  
   reg  [`SCI2_W_DATA - 1 : 0] word_info2_data = `SCI2_W_DATA'd0;
   wire [`SCI2_W_WORD - 1 : 0] word_info2;
   sci2_word inst_word_info2 (
     .word_data_in(word_info2_data),
     .word_mark_in(`SCI2_MARK_INFO),     
     .word_out(word_info2)
   );

   reg  [`SCI2_W_DATA - 1 : 0] word_info3_data = `SCI2_W_DATA'd0;
   wire [`SCI2_W_WORD - 1 : 0] word_info3;
   sci2_word inst_word_info3 (
     .word_data_in(word_info3_data),
     .word_mark_in(`SCI2_MARK_INFO),     
     .word_out(word_info3)
   );

   reg  [`SCI2_W_DATA - 1 : 0] word_info4_data = `SCI2_W_DATA'd0;
   wire [`SCI2_W_WORD - 1 : 0] word_info4;
   sci2_word inst_word_info4 (
     .word_data_in(word_info4_data),
     .word_mark_in(`SCI2_MARK_INFO),     
     .word_out(word_info4)
   );
   
   wire [`SCI2_W_CMD_MAX - 1 : 0] cmd5;
   assign cmd5 = {word_info4, word_info3, word_info2, word_info1, word_cmd};
   
   integer cmd_bit = -1;
   integer word_bit = -1;
   integer data_bit = -1;
   integer word_num = -1;
   reg [8*3:0] id = "n/a";
   
   
   task shift;
     input [(5*`SCI2_W_WORD) - 1 : 0] cmd;
     input integer cmd_length_words;
     
     integer i;
     integer bit_count; 

     begin
        word_bit = -1;
        cmd_bit = -1;
        word_num = 0;
        bit_count = cmd_length_words * `SCI2_W_WORD;
        for (i = 0; i <= bit_count; i = i + 1) begin
           @(negedge clk);
           data = cmd[i];
           word_bit = word_bit + 1;
           cmd_bit = cmd_bit + 1;
           
           if (word_bit == `SCI2_W_WORD) begin 
                word_bit = 0;
                word_num = word_num + 1;
           end
          
           if ((word_bit < 1) || (word_bit > 9)) data_bit = -1;            
           else data_bit = data_bit + 1;
           
        end
        word_num = -1;
        data = 1;     
     end
     
   endtask   

   initial begin
   
   
     //#(PERIOD);
     cmd_addr        = `SCI2_W_ADDR'd1;
     cmd_group       = `SCI2_GROUP_NO;
     cmd_code        = `SCI2_CMD_CODE_CTRL_WORD;
     word_info1_data = `SCI2_W_DATA'h084;
     word_info2_data = `SCI2_W_DATA'h000;
     word_info3_data = `SCI2_W_DATA'h000;
     $display("");
     $display($time, " ns");
     $display("cmd code:\t\t%b", cmd_code);
     $display("chip address:\t%h", cmd_addr);
     $display("group flag:\t\t%h", cmd_group);
     $display("info word 1:\t%h", word_info1_data);
     $display("info word 2:\t%h", word_info2_data);
     $display("info word 3:\t%h", word_info3_data);
     
     
     #(PERIOD);
     shift(cmd5, `SCI2_CMD_LEN_CTRL_WORD);

     #(PERIOD*5);
     
     cmd_addr        = `SCI2_W_ADDR'd1;
     cmd_group       = `SCI2_GROUP_NO;
     cmd_code        = `SCI2_CMD_CODE_L_PULSE;
     word_info1_data = `SCI2_W_DATA'h084;
     word_info2_data = `SCI2_W_DATA'h000;
     word_info3_data = `SCI2_W_DATA'h000;
     word_info4_data = `SCI2_W_DATA'h000;
     $display("");
     $display($time, " ns");
     $display("cmd code:\t\t%b", cmd_code);
     $display("chip address:\t%h", cmd_addr);
     $display("group flag:\t\t%h", cmd_group);
     $display("info word 1:\t%h", word_info1_data);
     $display("info word 2:\t%h", word_info2_data);
     $display("info word 3:\t%h", word_info3_data);
     $display("info word 4:\t%h", word_info3_data);
     
     
     #(PERIOD);
     shift(cmd5, `SCI2_CMD_LEN_L_PULSE);
   
   end
   
   always begin
       @(negedge clk);
       if (word_bit == 0) id = "S>";
       else if (word_bit == 12) id = "<S";
       else if (word_bit == 11) id = "p"; 
       else if (word_bit == 10) id = "cf";
       else if (word_num == 0) begin
          if ((data_bit >= 0) && (data_bit <= 4))  id = "adr";
          else if ((data_bit >= 5) && (data_bit <= 5))  id = "g";
          else if ((data_bit >= 6) && (data_bit <= 8))  id = "cmd";
          else id = "n/a";
       end 
       else id = "n/a";
   end

endmodule