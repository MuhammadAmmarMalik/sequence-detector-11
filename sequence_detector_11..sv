//using Mealy FSM
module melay_11_seq (
  					input wire clk,
  					input wire rst,
  					input wire in,
  					output reg out
					);
  //Step 1: Define State
  reg  p_state; //Present State
  reg  n_state; //Next State
  
  //Step 2: Encoding state
  parameter A = 0; //Ideal
  parameter B = 1; //first one found
  //localparam
  //defparam is used with enum
  //defparam enum logic [2-1:0] {A,B} state_type;
  
  //Step 3: Code the logic for present state
  always @ (posedge clk) begin
    if(rst)
      p_state <= #1 A;
  	else
      p_state <= #1 n_state;
  end
  //Step 4: Code the logic for next state
  always @(*) begin
    case(p_state) 
      A: if (in==1) begin
       		 	n_state = B;
        		//out = 0;
      end
      	   else  begin
             	n_state = A;
      			//out =0;
      end
      
      B: if(in==1) begin
        		n_state = B;
      			//out = 1;
      end
      	  	else begin
            	n_state = A;
              	//out = 0;
      end

      default: begin
       //   out<= 0;
        	n_state = A;
            //p_state = A;
      end
    endcase
   end
      
  //step 5 Define output logic
  //Output in melay FSM is function of PS as well as input
  always @ (*) begin
    if(p_state == B && in == 1)
    	  out = 1;
  	else
    	  out = 0;
  end     
endmodule