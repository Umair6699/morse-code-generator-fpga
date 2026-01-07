module t4(
    input [2:0] SW2_0,   
    input CLK,        
    input KEY1,        
    input KEY0,        
    output reg LEDR0  
);

    reg [2:0] selected_letter;
    always @(*) begin
        case (SW2_0)
            3'b000: selected_letter = 3'b000;  // A (.-)
            3'b001: selected_letter = 3'b001;  // B (-...)
            3'b010: selected_letter = 3'b010;  // C (-.-.)
            3'b011: selected_letter = 3'b011;  // D (-..)
            3'b100: selected_letter = 3'b100;  // E (.)
            3'b101: selected_letter = 3'b101;  // F (..-.)
            3'b110: selected_letter = 3'b110;  // G (--.)
            3'b111: selected_letter = 3'b111;  // H (....)
        endcase
    end

    // Morse Code Lookup Table
    reg [3:0] morse_code [0:7];
    initial begin
        morse_code[3'b000] = 4'b1011; // A (.-)
        morse_code[3'b001] = 4'b0111; // B (-...)
        morse_code[3'b010] = 4'b0101; // C (-.-.)
        morse_code[3'b011] = 4'b0011; // D (-..)
        morse_code[3'b100] = 4'b1011; // E (.)
        morse_code[3'b101] = 4'b0010; // F (..-.)
        morse_code[3'b110] = 4'b1101; // G (--.)
        morse_code[3'b111] = 4'b0001; // H (....)
    end    

    // Timing and Control
    reg [26:0] timer;     
    reg [2:0] counter;    
    reg symbol_duration;  
    reg display_active;   

    always @(posedge CLK or posedge KEY0) begin
        if (KEY0) begin 
            counter <= 3'b000;         
            timer <= 27'd0;            
            LEDR0 <= 1'b0;             
            display_active <= 1'b0;    
        end else begin
            if (KEY1 && !display_active) begin  
                counter <= 3'b000;
                display_active <= 1'b1;
                timer <= 27'd0;       
            end

            if (display_active) begin
                if (timer == (symbol_duration ? 27'd75_000_000 : 27'd25_000_000)) begin 
                    timer <= 27'd0;          
                    LEDR0 <= 1'b0;           

                    if (morse_code[selected_letter][counter] != 1'b1) begin 
                        symbol_duration <= morse_code[selected_letter][counter]; 
                        counter <= counter + 1; 
                    end else begin
                        display_active <= 1'b0; 
                    end
                end else begin
                    timer <= timer + 1;        
                    LEDR0 <= !symbol_duration; 
                end
            end
        end
    end

endmodule
