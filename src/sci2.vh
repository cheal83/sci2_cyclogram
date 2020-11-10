/**
  @file
  @date   10.11.2020
  @author aleksandr.chepurin
*/
`ifndef SCI2_VH_
`define SCI2_VH_ 1

/* ширина полей слова в битах */
`define SCI2_W_WORD     13
`define SCI2_W_DATA     9
`define SCI2_W_MARK     1
`define SCI2_W_PARITY   1

/* максимальное количество слов в команде */
`define SCI2_W_WORDS_PER_CMD_MAX 5

/* максимальное длина команды в битах */
`define SCI2_W_CMD_MAX ( `SCI2_W_WORDS_PER_CMD_MAX * `SCI2_W_WORD)

/* ширина полей поля данных командного слова в битах */
`define SCI2_W_ADDR     5
`define SCI2_W_GROUP    1
`define SCI2_W_CMD      3

/* коды команд */
`define SCI2_CMD_CODE_L_PULSE   `SCI2_W_CMD'b001
`define SCI2_CMD_CODE_CH1_CTRL  `SCI2_W_CMD'b010
`define SCI2_CMD_CODE_CH2_CTRL  `SCI2_W_CMD'b011
`define SCI2_CMD_CODE_L_PAUSE   `SCI2_W_CMD'b000   
`define SCI2_CMD_CODE_CTRL_WORD `SCI2_W_CMD'b100
`define SCI2_CMD_CODE_START1    `SCI2_W_CMD'b111
`define SCI2_CMD_CODE_START2    `SCI2_W_CMD'b101
`define SCI2_CMD_CODE_NO        `SCI2_W_CMD'b110

/* длины команд */
`define SCI2_CMD_LEN_L_PULSE    5   
`define SCI2_CMD_LEN_CH1_CTRL   5 
`define SCI2_CMD_LEN_CH2_CTRL   5 
`define SCI2_CMD_LEN_L_PAUSE    2    
`define SCI2_CMD_LEN_CTRL_WORD  4 
`define SCI2_CMD_LEN_START1     1
`define SCI2_CMD_LEN_START2     1 
`define SCI2_CMD_LEN_NO         1



/* коды команда/данные */
`define SCI2_MARK_CMD      `SCI2_W_MARK'b1
`define SCI2_MARK_INFO     `SCI2_W_MARK'b0

/* коды стартовых / стоповых битов */
`define SCI2_START_BIT      1'b0
`define SCI2_STOP_BIT       1'b1

/* колы поля признака группы */
`define SCI2_GROUP_YES      1'b1
`define SCI2_GROUP_NO       1'b0

/* текстовые идентификаторы команд */
`define SCI2_NAME_L_PULSE    "L_PULSE"
`define SCI2_NAME_CH1_CTRL   "CH1_CTRL"
`define SCI2_NAME_CH2_CTRL   "CH2_CTRL"
`define SCI2_NAME_L_PAUSE    "L_PAUSE"
`define SCI2_NAME_CTRL_WORD  "CTRL_WORD"
`define SCI2_NAME_START1     "START1"
`define SCI2_NAME_CMD_START2 "START2"

`endif /* SCI2_VH_ */