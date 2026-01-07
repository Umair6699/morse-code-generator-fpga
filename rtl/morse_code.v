module MorseCode(SW,KEY,CLOCK_50,LEDR,LEDG);
	input [2:0] SW; 
	input [1:0] KEY; 
	input CLOCK_50; 
	output [0:0] LEDR;  	
	output [2:0]LEDG;
	
	reg [25:0] count;	
	reg [2:0] length;	
	reg [2:0] counter;	
	reg [3:0] M;	//morse code, 1 = dash, 0 = dot
	reg [3:0] Q;	
	reg z;			
	
	reg[2:0] y_Q, Y_D;	
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010,  D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	// States using minimum state encoding 
	parameter S1 = 3'b000, S2 = 3'b001, S3 = 3'b010, S4 = 3'b011, S5 = 3'b100; 
		
	assign LEDR = z;
	
	always @(SW) 
	begin: letter_selection
		case(SW[2:0])
			A: begin
					length = 3'b010;
					M = 4'b0100; // A: .-
				end
			B: begin
					length = 3'b100;
					M = 4'b1000; // B: -...
				end
			C: begin
					length = 3'b100;
					M = 4'b1010; // C: -.-.
				end
			D: begin
					length = 3'b011;
					M = 4'b1000; // D: -..
				end
			E: begin
					length = 3'b001;
					M = 4'b0000; // E: .
				end
			F: begin
					length = 3'b100;
					M = 4'b0010; // F: ..-.
				end
			G: begin
					length = 3'b011;
					M = 4'b1100; // G: --.
				end
			H: begin
					length = 3'b100;
					M = 4'b0000; // H: ....
				end
		endcase
	end	
	
	
	always @(Q[3], KEY[1:0], counter, y_Q) 
	begin: state_table
		case (y_Q)
			
			S1: if (!KEY[1]) Y_D = S2;  
				else Y_D = S1;
			  
			S2: if (!Q[3]) Y_D = S5; 
				else Y_D = S3; 
				
			S3: if (!KEY[0]) Y_D = S1; 
				else Y_D = S4;			
		
			S4: if (!KEY[0]) Y_D = S1; 
				else Y_D = S5;			
				
			S5: if (counter == 0) Y_D = S1; 
				else Y_D = S2;					 
		default: Y_D = 3'bxxx;  
		endcase
	end	
	
	//clock counter
	always @(posedge CLOCK_50)
	begin
		if (count < 50000000/2) // at every 0.5 seconds, activate  
			count <= count + 1;
		else
		begin
			count <= 0;
			y_Q <= Y_D;  
			if (Y_D == S1) begin  
				counter <= length;
				Q <= M;
			end
			if (Y_D == S5) begin     
				counter <= counter - 1;  
				 
				Q[3] <= Q[2];
				Q[2] <= Q[1]; 
				Q[1] <= Q[0];
				Q[0] <= 1'b0;
			end
		end
	end
	
	always @(y_Q)
	begin: zassign
		case (y_Q)
			S2: z = 1; // turn on output 
			S3: z = 1; // turn on output 
			S4: z = 1; // turn on output 
			default: z = 0; // off output at States S5 or S1 
		endcase
	end
endmodule
