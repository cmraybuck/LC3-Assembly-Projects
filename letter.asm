.ORIG x3000
LD R1, RED ; Load R1 with red so we can initially display NCSU onto the screen in red
BRnzp DRAW ; Break to DRAW, where the program will draw the letters onto the screen with the desired color
COLORS  GETC ; Get a character from the user
        JSR QKILL ; Jump to SR that tests for input q
        JSR RKEY ; Jump to SR that tests for input r
        JSR GKEY ; Jump to SR that tests for input g
        JSR BKEY ; Jump to SR that tests for input b
        JSR YKEY ; Jump to SR that tests for input y
        JSR SPACE ; Jump to SR that tests for input of the space key
        BRnzp COLORS ; If none of the above conditions are met, await valid input
        QKILL   LD R1, QOFF ; Load register with offset for Q to test the key
                ADD R1, R0, R1 ; Add offset with user input
                BRz END_SCRIPT ; If result is 0, input is q. Go to END_SCRIPT to halt the program and print desired string
                RET ; If it is not 0, then the input was not q. Go back to test for other inputs.

                END_SCRIPT  LEA R0, GOODBYE ; Load R0 with the goodbye string
                            PUTS ; Print it to the terminal
                            HALT ; Halt the program

GKEY    LD R1, GOFF ; Load with g offset
        ADD R1, R0, R1 ; Add with user input
        BRz GOGREEN ; If sum is 0, then user input was g. Go to GOGREEN 
        RET
                GOGREEN LD R1, GREEN ; Load R1 with hex for the color green
                        BRnzp DRAW ; After this, go to our DRAW function that uses the stored color in R1 to draw "NCSU"


        
RKEY    LD R1, ROFF ; Load with r offset
        ADD R1, R0, R1 ; Add with user input
        BRz GORED ; If sum is 0, then user input was r. Go to GORED
        RET
                GORED   LD R1, RED ; Load R1 with hex for the color red
                        BRnzp DRAW ; Go to DRAW function to display "NCSU" in red


BKEY    LD R1, BOFF ; Load with b offset
        ADD R1, R0, R1 ; Add with user input
        BRz GOBLUE ; If sum is 0, then user input was b. Go to GOBLUE
        RET
                GOBLUE  LD R1, BLUE ; Load R1 with hex for the color blue
                        BRnzp DRAW ; Go to DRAW function to display "NCSU" in blue


YKEY    LD R1, YOFF ; Load with y offset
        ADD R1, R0, R1 ; Add with user input
        BRz GOYELLOW ; If sum is 0, then user input was y. Go to GOYELLOW
        RET
                GOYELLOW    LD R1, YELLOW ; Load R1 with hex for the color yellow
                            BRnzp DRAW ; Go to DRAW function to display "NCSU" in yellow


SPACE   LD R1, SPOFF ; Load with space key offset
        ADD R1, R0, R1 ; Add with user input
        BRz GOSPACE ; If sum is 0, then user input was the space key. Go to GOSPACE
        RET
                GOSPACE     LD R1, WHITE ; Load R1 with hex for the color white
                            BRnzp DRAW ; Go to DRAW function to display "NCSU" in white


DRAW    JSR INITIAL ; Subroutine to draw the letters "NCSU"
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0 ; Clear all registers
        AND R4, R4, #0
        AND R5, R5, #0
        AND R6, R6, #0
        BRnzp COLORS ; After subroutine has been executed and "NCSU" has been drawn, go back to COLORS and await further user input.
                INITIAL ; We already have a predefined value for R1 from our user input, so this is how we're able to print "NCSU" in whatever color we want without breaking anything.
                        LD R2, NSTART ; Load with coordinate where we will start drawing "N"
                        LD R3, HEIGHT ; Load with height to use as a counter
                        LD R4, ROW ; Load with row so we can go up/down rows depending on which letter we are drawing
                        LD R5, WIDTH ; Load with width to use as another counter
                        LD R6, NEWS ; "NEWS" will be useful for drawing the diagonal portion of our capital "N"
                            N1  STR R1, R2, #0 ; Store color from R1 into current pixel at R2
                                ADD R2, R2, R4 ; Move up a row
                                ADD R3, R3, #-1 ; Decrement height counter
                                BRp N1 ; If counter is still positive, do it again to reach desired height
                                LD R4, BROW
                                BRnz N2 ; If counter has fallen to or below zero, go to the next line function
                            N2      
                                    STR R1, R2, #0 ; Store color
                                    ADD R2, R2, #1 ; Add 1 to shift coordinate over by 1 on the x axis
                                    ADD R2, R2, R4 ; Add the value of one row to shift down a row
                                    STR R1, R2, #0 ; Display color in this new location
                                    ADD R2, R2, R4 ; Go down another row
                                    STR R1, R2, #0 ; Display color
                                    ADD R2, R2, R4 ; Down a row
                                    STR R1, R2, #0 ; Display color
                                    ADD R2, R2, R4 ; Down a row
                                    STR R1, R2, #0 ; Display color
                                    ADD R5, R5, #-1 ; Decrement width counter
                                    BRp N2 ; Repeat until desired width and shape has been achieved
                                    ADD R2, R2, R6 ; Once we've adequately drawn our diagonal line, we add "NEWS" to ensure that the next line of "N" is drawn where we want it to be.
                                    LD R3, HEIGHT ; Load R3 with a slightly different height value to ensure that the letters are evenly displayed
                                    LD R4, ROW ; Load R4 with inverse ROW value so we can now travel through rows in the opposite direction (up vs. down)
                                    BRnz N3 ; After reloading and decrementing counter completely, go to next line
                            N3  STR R1, R2, #0 ; Same logic as before
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp N3
                                BRnz CS ; From here, N has been drawn. Now start on drawing C.
                                ; From here on, the logic is pretty much the same. I'll add notes where something changes to provide clarity, but otherwise
                                ; the rest of this particular function is pretty straightforward
                        CS  
                            LD R2, CSTART ; Load with where we'll start drawing C
                            LD R3, HEIGHT
                            LD R4, ROW
                            LD R5, WIDTH  
                            C1  STR R1, R2, #0
                                ADD R2, R2, #-1
                                ADD R5, R5, #-1
                                BRp C1
                                BRnz C2
                            C2  STR R1, R2, #0
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp C2
                                LD R5, WIDTH
                                BRnz C3
                            C3  STR R1, R2, #0
                                ADD R2, R2, #1
                                ADD R5, R5, #-1
                                BRp C3
                                BRnz SS
                        SS  
                            LD R2, SSTART ; Load with where we'll draw S. 
                            LD R3, HHEIGHT ; "HHEIGHT" stands for "Half Height," which I had to use because S has 2 vertical lines. This way it'll be the same height as other letters.
                            LD R4, ROW
                            LD R5, WIDTH 
                            S1  STR R1, R2, #0
                                ADD R2, R2, #1
                                ADD R5, R5, #-1
                                BRp S1
                                BRnz S2
                            S2  STR R1, R2, #0
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp S2
                                LD R5, WIDTH
                                BRnz S3
                            S3  STR R1, R2, #0
                                ADD R2, R2, #-1
                                ADD R5, R5, #-1
                                BRp S3
                                LD R3 HHEIGHT
                                BRnz S4    
                            S4  STR R1, R2, #0
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp S4
                                LD R5 WIDTH
                                BRnz S5
                            S5  STR R1, R2, #0
                                ADD R2, R2, #1
                                ADD R5, R5, #-1
                                BRp S5
                                BRnz US    
                        US  
                            ADD R2, R2, #6 ; From here, the most efficient way to draw "U" is not to load a new coordinate, but instead start relative to where we finished drawing "S."
                            LD R3, HEIGHT
                            LD R4, BROW 
                            LD R5, WIDTH
                            U1  STR R1, R2, #0
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp U1
                                BRnz U2
                            U2  STR R1, R2, #0
                                ADD R2, R2, #1
                                ADD R5, R5, #-1
                                BRp U2
                                LD R3, NHEIGHT
                                LD R4, ROW
                                BRnz U3
                            U3  STR R1, R2, #0
                                ADD R2, R2, R4
                                ADD R3, R3, #-1
                                BRp U3
                                BRnzp COLORS ; After the letters have been drawn, return back to COLORS and await input from keyboard.
.END
GOODBYE .STRINGZ "\n\nThank you for playing"
NEWS .FILL #385
RED .FILL x7C00
GOFF .FILL #-103
HHEIGHT .FILL #42
WIDTH .FILL #20
BROW .FILL #128
ROW .FILL #-128
HEIGHT .FILL #84
NHEIGHT .FILL #85
NSTART .FILL xF50A
CSTART .FILL xF53A
SSTART .FILL xF542
GREEN .FILL x03E0
BLUE .FILL x001F
YELLOW .FILL x7FED
WHITE .FILL x7FFF
QOFF .FILL #-113
ROFF .FILL #-114
BOFF .FILL #-98
YOFF .FILL #-121
SPOFF .FILL #-32