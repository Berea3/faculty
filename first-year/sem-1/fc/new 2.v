module ex3(input [15:0]intrare_1, input[3:0]intrare_2);
  integer i;
  always@(*) begin
    for (i=0;i<intrare_1;i=i+1) begin
      if (i%intrare_2==0) begin
        #1;
        $display("%d",i);
      end
    end
  end
endmodule

module ex3_tb;
  reg [15:0]x;
  reg [3:0] y;
  ex3 randomname(.intrare_1(x),.intrare_2(y));
  initial begin
    x=10;
    y=2;
  end
endmodule

module TRANSFORM(input[11:0] NR_IN, output reg[14:0] NR_OUT); //problema 1
  reg[9:0] nr_conv;
  always @(*) begin
    nr_conv=NR_IN[3:0]+10*NR_IN[7:4]+100*NR_in[11:8];
    if (nr_conv>=0 && nr_conv<=99)  begin // sau NR_IN[11:8]==0
      NR_OUT[3:0]=NR_IN[3:0]+3;
      NR_OUT[7:4]=NR_IN[7:4]+3;
      NR_OUT[11:8]=NR_IN[11:8]+3;
      NR_OUT[14:12]=0;
    end
    if (nr_conv>=100 && nr_conv<-449) begin  // aici se face la 2-5 74210
      if (NR_IN[3:0]==0) begin
        NR_OUT[4:0]=5'b11000;
      end
      if (NR_IN[3:0]==1) begin
        NR_OUT[4:0]=5'b00011;
      end
    end
    if (nr_conv>=450 && nr_conv<900) begin  // aici se face la 2-5 63210
      if (NR_IN[3:0]==0) begin
        NR_OUT[4:0]=5b11111;
      end
    end
    if (nr_conv>=900 && nr_conv<=999) 
      NR_OUT=nr_conv;
endmodule

module ex2(input[7:0] a,b, input[15:0] c, input comp_en,minmax_en,sel_ab,sel_c,sel_minmax, 
          output reg comp_out, output reg[7:0] minmax_out, output reg[7:0] sum_ab, output reg[15:0] xor_out);
  initial begin
    comp_out=1;
    minmax_out=8'hFF;  // se poate face 2 la 8 -1 care il faci cu shiftare (1<<8)-1
    sum_ab=7;
    xor_out16'hFFFF;
  end
  integer i;
  reg [7:0] y,z;
  reg [15:0] x;
  always@(comp_en,minmax_en) begin
    if (comp_en==1) begin
      if (a>b)
        c_out=1;
      if (a<b)
        c_out=1;
      if (a==b)
        c_out=~c_out;
    end
    if (minmax_en==1) begin
      if (sel_ab==0 && sel_c==0 && sel_minmax==0)
        minmax_out=a<c[7:0]?a:c[7:0];
      if (sel_ab==0 && sel_c==0 && sel_minmax==0)
        minmax_out=a<c[7:0]?a:c[7:0];
      case ({sel_ab,sel_c,sel_minmax})
        0:minmax_out=a<c[7:0]?a:c[7:0];
        1:minmax_out=a<c[7:0]?a:c[7:0];
    end
    // iii
    sum_ab=0;
    for (i=0;i<8;i=i+2)
      sum_ab=a[i]+b[i+1]+sum_ab;
    // iv
     z=a|b;
     y=a&b;
     x={y,z};
     xor_out=c^x;
   end
 endmodule