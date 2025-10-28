`timescale 1ns/1ps

module vga_state_machine_tb;


    reg sys_clk;
    reg sys_rst_n;
    reg button_press;
    

    wire hsync;
    wire vsync;
    wire [15:0] rgb;
    wire [2:0] state_leds;
    

    vga_state_machine uut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .button_press(button_press),
        .hsync(hsync),
        .vsync(vsync),
        .rgb(rgb),
        .state_leds(state_leds)
    );
    

    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;
    end
    

    initial begin
 
        sys_rst_n = 0;
        button_press = 0;
        

        $dumpfile("vga_state_machine.vcd");
        $dumpvars(0, vga_state_machine_tb);
        
        $display("Starting VGA State Machine Testbench");
        

        #100;
        sys_rst_n = 1;
        #1000;
        

        test_state_switches();
        
        #1000000;
        $display("Test completed!");
        $finish;
    end
    
    task test_state_switches;
        begin

            $display("Switching to MUST state...");
            button_press = 1;
            #1000000;
            button_press = 0;
            #1000000;
            

            $display("Switching to END state...");
            button_press = 1;
            #1000000;
            button_press = 0;
            #1000000;
            

            $display("Switching back to COLOR_BAR state...");
            button_press = 1;
            #1000000;
            button_press = 0;
            #1000000;
        end
    endtask
    
endmodule
