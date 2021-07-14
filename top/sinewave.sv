
module sinus_gen(
    input logic clk_audio ,
    output logic signed [15:0] level = 16'(0)
    );

parameter SIZE = 1024;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;

initial begin
    $readmemh("sine.mem", rom_memory); //File with the signal
    i = 0;
end
    
//At every positive edge of the clock, output a sine wave sample.
always@(posedge clk_audio)
begin
    level = rom_memory[i];
    i = i + 8;
    if(i == SIZE)
        i = 0;
end

endmodule 
