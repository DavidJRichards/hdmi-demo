
module ebaz4205_top
(
  input CLK_33MHZ,
  // output [1:0] LED,

  // HDMI output
  output [2:0] HDMI_TX,
  output [2:0] HDMI_TX_N,
  output HDMI_CLK,
  output HDMI_CLK_N,
  // input HDMI_CEC,
  // inout HDMI_SDA,
  // inout HDMI_SCL,
  // input HDMI_HPD,

  // pwm audio output
  output pwm_left,
  output pwm_right,
  
  // debug output
  output led_blue,
  output led_button
);

// 1:  640x480     25.2  MHz
// 4:  1280x720    74.25 MHz
// 16: 1920x1080  148.5  MHz - unimplemented
// 5:  800x600     40.0  MHz
// 6: 1024x600       MHz

localparam vidio_id_code = 5;

wire clk_pixel_x5;
wire clk_pixel;
wire clk_audio;

hdmi_clock #(.VIDEO_ID_CODE(vidio_id_code)) hdmi_clock (.clk_33(CLK_33MHZ), .clk_pixel(clk_pixel), .clk_pixel_x5(clk_pixel_x5));

logic [11:0] counter = 1'd0;
generate
  case (vidio_id_code)
    1:  // 640x480, 25.2MHz
      begin
        always_ff @(posedge clk_pixel) // 48 kbit from 25.2 MHz
          counter <= counter == 11'd524 ? 1'd0 : counter + 1'd1;
        assign clk_audio = clk_pixel && counter == 11'd524;
      end
      
    4:  // 1280x720, 74.25MHz
      begin
        always_ff @(posedge clk_pixel) // 48 kbit from 74.375 MHz
          counter <= counter == 11'd1548 ? 1'd0 : counter + 1'd1;
        assign clk_audio = clk_pixel && counter == 11'd1548;
      end
    5:  // 800x600, 40 MHz
      begin
        always_ff @(posedge clk_pixel) // 48 kbit from 40 MHz
          counter <= counter == 11'd832 ? 1'd0 : counter + 1'd1;
        assign clk_audio = clk_pixel && counter == 11'd832;
      end
    6:  // 1024x600, 
      begin
        always_ff @(posedge clk_pixel) // 48 kbit from 
          counter <= counter == 11'd1019 ? 1'd0 : counter + 1'd1;
        assign clk_audio = clk_pixel && counter == 11'd1019;
      end
  endcase
endgenerate
// outputs to measure actual generated clock frequency 
assign led_blue = counter > 250;    // clk_audio but more square
assign led_button = clk_pixel;

localparam AUDIO_BIT_WIDTH = 16;
localparam AUDIO_RATE = 48000;
localparam WAVE_RATE = 480;

logic [AUDIO_BIT_WIDTH-1:0] audio_sample_word = 16'd0;
logic [AUDIO_BIT_WIDTH-1:0] audio_sample_word_dampened; // This is to avoid giving you a heart attack -- it'll be really loud if it uses the full dynamic range.
assign audio_sample_word_dampened = audio_sample_word >> 4;

// todo: these modules produce no output for some unknown reason
// inline versions below seem just fine
//sawtooth #(.BIT_WIDTH(AUDIO_BIT_WIDTH), .SAMPLE_RATE(AUDIO_RATE), .WAVE_RATE(WAVE_RATE)) sawtooth (.clk_audio(clk_audio), .level(audio_sample_word));
//sinus_gen sinus_gen( .clk_audio(clk_audio), .level(audio_sample_word) );

`ifndef do_sawtooth
//todo: restore - sawtooth #(.BIT_WIDTH(AUDIO_BIT_WIDTH), .SAMPLE_RATE(AUDIO_RATE), .WAVE_RATE(WAVE_RATE)) sawtooth (.clk_audio(clk_audio), .level(audio_sample_word));
localparam int NUM_PCM_STEPS = (AUDIO_BIT_WIDTH + 1)'(2)**(AUDIO_BIT_WIDTH + 1)'(AUDIO_BIT_WIDTH) - 1;
localparam real FREQUENCY_RATIO = real'(WAVE_RATE) / real'(AUDIO_RATE);
localparam bit [AUDIO_BIT_WIDTH-1:0] INCREMENT = AUDIO_BIT_WIDTH'(NUM_PCM_STEPS * FREQUENCY_RATIO);
always @(posedge clk_audio)
  audio_sample_word <= audio_sample_word + INCREMENT; 

`else
//todo: restore - sinus_gen sinus_gen( .clk_audio(clk_audio), .level(audio_sample_word) );
parameter SIZE = 1024;    
reg [15:0] rom_memory [SIZE-1:0];
integer j;

initial 
  begin
    $readmemh("sine.mem", rom_memory); //File with the signal
    j = 0;
  end    

always@(posedge clk_audio)
  begin
    audio_sample_word = rom_memory[j];
    j = j + 8;
    if(j >= SIZE)
      j = 0;
  end

parameter integer dwidth_g = 8;
//input clk,reset;
reg [dwidth_g-1:0] sig_in;
reg pwm_out;
reg convert;
reg [dwidth_g-1:0] cnt;
integer k;
parameter cnt_max_c = 20'hFF;

always@(posedge clk_pixel)
  begin
    //if(reset == 1'b1)
    //    cnt <= 0;
    //else
    if(convert == 1'b1) 
      begin
        cnt <= 0;
        sig_in=rom_memory[k] >> 8;
        k = k + 4;
        if(k >= SIZE)
          k = 0;
      end
    else
       cnt <= cnt +1;
    if(cnt < sig_in)
      pwm_out <= 1'b1;
    else
      pwm_out <= 1'b0;
  end 
  
//decode max counter value and output the pwm conversion start
  assign convert = (cnt == cnt_max_c) ? 1'b1 : 1'b0;
  assign pwm_left = pwm_out;
  assign pwm_right = pwm_out;
`endif


logic [23:0] rgb;
logic [10:0] cx, cy;
logic [2:0] tmds;
logic tmds_clock;
logic [10:0] screen_width, screen_height;

hdmi #(.VIDEO_ID_CODE(vidio_id_code), .VIDEO_REFRESH_RATE(60.0), .AUDIO_RATE(AUDIO_RATE), .AUDIO_BIT_WIDTH(AUDIO_BIT_WIDTH)) hdmi(.clk_pixel_x5(clk_pixel_x5), .clk_pixel(clk_pixel), .clk_audio(clk_audio), .rgb(rgb), .audio_sample_word('{audio_sample_word_dampened, audio_sample_word_dampened}), .tmds(tmds), .tmds_clock(tmds_clock), .cx(cx), .cy(cy), .screen_width(screen_width), .screen_height(screen_height) );

genvar i;
generate
    for (i = 0; i < 3; i++)
    begin: obufds_gen
        OBUFDS #(.IOSTANDARD("TMDS_33")) obufds (.I(tmds[i]), .O(HDMI_TX[i]), .OB(HDMI_TX_N[i]));
    end
    OBUFDS #(.IOSTANDARD("TMDS_33")) obufds_clock(.I(tmds_clock), .O(HDMI_CLK), .OB(HDMI_CLK_N));
endgenerate

`ifndef nothing
// console text output test
logic [7:0] character = 8'h30;
logic [5:0] prevcy = 6'd0;
always @(posedge clk_pixel)
begin
    if (cy == 10'd0)
    begin
        character <= 8'h30;
        prevcy <= 6'd0;
    end
    else if (prevcy != cy[9:4])
    begin
        character <= character + 8'h01;
        prevcy <= cy[9:4];
    end
end
console console(.clk_pixel(clk_pixel), .codepoint(character), .attribute({cx[9], cy[8:6], cx[8:5]}), .cx(cx), .cy(cy), .rgb(rgb));

`else
// Border test (left = red, top = green, right = blue, bottom = blue, fill = black)
always @(posedge clk_pixel)
//                  red                     green                                                             blue  
  rgb <= {cx == 0 ? ~8'd0 : 8'd0, cy == 0 ? ~8'd0 : 8'd0, cx == screen_width - 1 || cy == screen_height - 1 ? ~8'd0 : 8'd0};
`endif

endmodule
