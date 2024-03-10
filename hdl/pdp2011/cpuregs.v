//======================================================================================================
//   Регистровый файл процессора PDP2011
//======================================================================================================
module cpuregs (

   input[5:0] raddr, 
   input[5:0] waddr, 
   input[15:0] d, 
   output [15:0] o, 
   input we, 
   input clk
);

 
// выделение памяти под регистровый файл 
reg[15:0] regs[15:0]; 
// локальные адреса в массиве регистров
wire[3:0] loc_raddr; 
wire[3:0] loc_waddr; 

// Формат входящего адреса
//  0-2 - номер регистра
//    3 - psw[11] - используемый набор регистров, 0 или 1
//  4-5 - режим процессора:
//            00 - kernel
//            01 - supervisor
//            11 - user

// Распределение адресного пространства регистрового файла
//
//  0           R0, набор 0
//  1           R1, набор 0
//  2           R2, набор 0
//  3           R3, набор 0
//  4           R4, набор 0
//  5           R5, набор 0
//  6           SP режима KERNEL
//  7           *   PC - не используется
//  8           R0, набор 1
//  9           R1, набор 1
//  10          R2, набор 1 
//  11          R3, набор 1 
//  12          R4, набор 1
//  13          R5, набор 1 
//  14          SP режима Supervisor
//  15          SP режима USER      
//   
assign loc_raddr = (raddr[2:1] != 2'b11) ? raddr[3:0] :                       // Регистры R0-R5 - одинаковы во всех вариантах
                   (raddr[2:0] == 3'b110 & raddr[5:4] == 2'b00) ? 4'b0110 :   // SP режима KERNEL
                   (raddr[2:0] == 3'b110 & raddr[5:4] == 2'b01) ? 4'b1110 :   // SP режима Supervisor
                   (raddr[2:0] == 3'b110 & raddr[5:4] == 2'b11) ? 4'b1111 :   // SP режима USER
                   4'b0111 ;
               
assign loc_waddr = (waddr[2:1] != 2'b11) ? waddr[3:0] : 
                    (waddr[2:0] == 3'b110 & waddr[5:4] == 2'b00) ? 4'b0110 : 
                    (waddr[2:0] == 3'b110 & waddr[5:4] == 2'b01) ? 4'b1110 : 
                    (waddr[2:0] == 3'b110 & waddr[5:4] == 2'b11) ? 4'b1111 : 
                    4'b0111 ;

// выходные данные - чтение
assign o = regs[loc_raddr] ;

// запись данных  
always @(posedge clk) begin
   if (we == 1'b1) regs[loc_waddr] <= d ; 
end 

   
   
endmodule