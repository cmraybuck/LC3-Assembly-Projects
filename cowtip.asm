.ORIG x3000
PROG    JSR MAKEGRASS              ; This section essentially sets the program up by painting both the cow and the grass.
        JSR MAKECOW ; Two subroutines in this section: one to make the grass, one to make the cow. After this, reload R5 with the
        LD R5, START ; origin of the cow so that we know where it is on the display, then clear all registers for a clean slate. 
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        AND R6, R6, #0
        BRnzp KEYS ; After the subroutines execute, go to the section "KEYS," which is where we'll instruct the program on what to do with different inputs
MAKEGRASS                               LD R1, GREEN ; Load color
                                        LD R2, COORDL ; Load starting coordinate of the grass
                                        LD R3, GRASSPIXELSH ; Load height of grass
                                        LD R5, ROW ; Load value of moving up a row (-128) so we can move to the next row
                                        LD R6, SLIDE ; Load value of moving to next blade of grass
                                BLADE1  STR R1, R2, #0 ; "BLADE" functions display the first column of pixels. This stores the color into the coordinate, therefore displaying it.
                                        ADD R2, R2, R5 ; Move the coordinate up one row to continue displaying pixels
                                        ADD R3, R3, #-1 ; Tick height counter down by one
                                        BRp BLADE1 ; If height value is still positive, repeat this loop to get to desired height. 
                                LD R3, THICCSLIDE ; "THICCSLIDE" is what makes our grass thicker (2 pixels). Similar logic applies as before. 
                                LD R2, COORDL 
                                ADD R2, R2, R3 ; Move coordinate over by 1 pixel
                                LD R3, GRASSPIXELSH ; Reload height 
                                BLADE1T STR R1, R2, #0 ; "BLADET" functions just increase the width of the previously drawn blade of grass. 
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE1T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDL
                                ADD R2, R2, R6   ; Slide coordinate over to next blade of grass.  
                                BLADE2  STR R1, R2, #0 ; From here, it's just the same logic applied over and over again for the blades on the left side of the cow.
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE2
                                LD R3, THICCSLIDE
                                LD R2, COORDL
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADE2T STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE2T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDL
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADE3  STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE3 
                                LD R3, THICCSLIDE
                                LD R2, COORDL
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADE3T STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE3T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDL
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADE4   STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE4
                                LD R3, THICCSLIDE
                                LD R2, COORDL
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADE4T STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE4T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDL
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADE5 STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE5
                                LD R3, THICCSLIDE
                                LD R2, COORDL
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADE5T STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADE5T
                                LD R1, GREEN
                                LD R2, COORDR ; Load coordinates for the right side of the cow instead of the left so we can display on BOTH sides
                                LD R3, GRASSPIXELSH
                                LD R4, NUMOFGRASS
                                LD R5, ROW
                                LD R6, SLIDE
                                BLADER1 STR R1, R2, #0 ; Same logic as before, but now we're using a different starting coordinate. 
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADER1
                                LD R3, THICCSLIDE
                                LD R2, COORDR
                                ADD R2, R2, R3
                                LD R3, GRASSPIXELSH
                                BLADER1T STR R1, R2, #0
                                         ADD R2, R2, R5
                                         ADD R3, R3, #-1
                                         BRp BLADER1T

                                LD R3, GRASSPIXELSH
                                LD R2, COORDR
                                ADD R2, R2, R6
                                BLADER2 STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADER2
                                LD R3, THICCSLIDE
                                LD R2, COORDR
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADER2T STR R1, R2, #0
                                         ADD R2, R2, R5
                                         ADD R3, R3, #-1
                                         BRp BLADER2T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDR
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADER3 STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADER3 
                                LD R3, THICCSLIDE
                                LD R2, COORDR
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADER3T STR R1, R2, #0
                                         ADD R2, R2, R5
                                         ADD R3, R3, #-1
                                         BRp BLADER3T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDR
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADER4 STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADER4
                                LD R3, THICCSLIDE
                                LD R2, COORDR
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADER4T STR R1, R2, #0
                                         ADD R2, R2, R5
                                         ADD R3, R3, #-1
                                         BRp BLADER4T
                                LD R3, GRASSPIXELSH
                                LD R2, COORDR
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                BLADER5 STR R1, R2, #0
                                        ADD R2, R2, R5
                                        ADD R3, R3, #-1
                                        BRp BLADER5
                                LD R3, THICCSLIDE
                                LD R2, COORDR
                                ADD R2, R2, R3
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                ADD R2, R2, R6
                                LD R3, GRASSPIXELSH
                                BLADER5T STR R1, R2, #0
                                         ADD R2, R2, R5
                                         ADD R3, R3, #-1
                                         BRp BLADER5T
                                RET

KEYS    GETC ; "KEYS" stores subroutines on how the program should react if given an input. Start with GETC to await user input.
        JSR QKILL ; If input = q, go to this subroutine
        JSR WMOV ; If input = w, go to this subroutine
        JSR TFLIP ; If input = t, go to this subroutine
        JSR SMOV ; If input = s, go to this subroutine 
        JSR AMOV ; If input = a, go to this subroutine
        JSR DMOV ; If input = d, go to this subroutine
        JSR RESET ; If input = return (or enter), go to this subroutine
        BRnzp KEYS ; If input isn't any of the above, loop back and await a valid input

RESET   LD R1, RESETKEY ; Load R1 with offset of return/enter
        ADD R1, R0, R1 ; Add it with user input
        BRz GORESET ; If user input + offset = 0, they have pressed this key. Execute operation associated with this key
        RET

                GORESET LD R5, TOPLEFT ; Top left of display
                        LD R1, BLACK2 ; Load color "black" into register
                        LD R2, DISPW ; Display width
                        LD R3, DISPH ; Display height

                        CLEAR   STR R1, R5, #0 ; Display black pixel in current position
                                ADD R5, R5, #1 ; Shift to the right 1 pixel
                                ADD R2, R2, #-1 ; Tick width counter down by 1
                                BRp CLEAR ; If the width counter is still positive, restart this process until the whole row is filled. 
                                LD R2, DISPW ; If width counter has decremented, reload width
                                ADD R3, R3, #-1 ; Tick down height counter
                                BRp CLEAR ; If more rows need to be filled, restart the function to do so
                                BRz PROG ; After this is done, go back to PROG to repaint the grass and the cow. 


START .FILL xD8B1  

MAKECOW 
        AND R1, R1, #0 ; Clear all registers
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        AND R5, R5, #0
        
        
        
        LD R5, START ; Where the top left of the cow will be displayed. This is where we start drawing the cow so it's centered
        LD R1, COW ; Load address of cow pixels
        LD R2, COWW ; Cow width
        LD R3, NEXT ; Go to the next row 
        LD R4, COWH ; Cow height

        MOO   LDR R4, R1, #0 ; Load cow pixel into R4
                STR R4, R5, #0 ; Display bit from storage onto starting location
                ADD R1, R1, #1 ; Shift storage over 1
                ADD R5, R5, #1 ; Shift display over 1
                ADD R2, R2, #-1 ; Tick width counter down
                BRp MOO ; Repeat if there are more width pixels to be drawn
                ADD R5, R5, R3 ; If width value is zero, go to next row by adding R3
                LD R2, COWW ; Reset R2 to original width to display fully
                ADD R4, R4, #-1 ; Tick height down by 1
                BRp MOO ; If we haven't reached desired height, restart loop to draw completely
                RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
JUMP_POINT BRnzp KEYS ; Jump point added later in scripting so that functions can reach back to the KEYS section
QKILL   LD R1, QKILL1 ; Load R1 with offset of q
        ADD R1, R1, R0 ; Add user input with offset
        BRz END_SCRIPT ; If the sum of the two numbers is 0, the input is q, so go to the END_SCRIPT section to halt the program
        RET ; Return from subroutine
        END_SCRIPT      HALT ; Terminate the program
QKILL1 .FILL #-113
GREEN .FILL x03E0
TOPLEFT .FILL xC000
DISPW .FILL #128
DISPH .FILL #124
COORDL .FILL xE51A 
COORDR .FILL xE555
ROW .FILL #-128
NUMOFGRASS .FILL #5
SLIDE .FILL #4
GRASSPIXELSH .FILL #25
THICCSLIDE .FILL #1
BOTL .FILL xE531 
T .FILL #-116
WKEY .FILL #-119
UP .FILL #-512
FLIPNUM .FILL #3328
FLIPNUMN .FILL #-3200
RESETKEY .FILL #-10
TNEXT .FILL #-158
COWHT .FILL #-25
ROWBACK .FILL #128
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TFLIP   LD R1, T ; Load offset
        ADD R1, R0, R1 ; Add input and offset
        BRz GOT ; If input is t, go to the flip function
        RET
                GOT     AND R4, R4, #0 ; Clear registers
                        AND R6, R6, #0
                        LD R6, FLIPNUM ; Load R6 with the value to change the origin to the bottom left of the picture so we can draw it backwards
                        ADD R5, R5, R6 ; Add R6 and R5 to change our current location
                        LD R6, ROW ; Load R6 with the value of 1 row change
                        ADD R5, R5, R6 ; Add these together because cow will leave behind lines of grey without this after flipping
                        LD R1, COW ; Load register with address of cow pixels
                        LD R2, COWW ; Cow width
                        LD R3, TNEXT ; Next row but a different number as we're displaying this backwards
                        LD R4, COWHT ; Cow height, but in reverse since we're displaying it backwards
                        JSR FLIPT
                        BRnzp KEYS
                        FLIPT   LDR R4, R1, #0 ; Redraw cow under new conditions
                                STR R4, R5, #0 
                                ADD R1, R1, #1 
                                ADD R5, R5, #1
                                ADD R2, R2, #-1 
                                BRp FLIPT
                                ADD R5, R5, R3 
                                LD R2, COWW 
                                ADD R4, R4, #-1 
                                BRp FLIPT 
                                BRnz FLIPBACK ; After this finished, wait for user input to see if they want to flip it again. 

                        FLIPBACK        GETC ; Await user input 
                                        LD R1, T ; Test for t
                                        ADD R1, R0, R1
                                        BRz REDO ; If input is t again, flip the cow back to the way it was before

                                                REDO    AND R6, R6, #0
                                                        AND R1, R1, #0
                                                        ADD R5, R5, R6
                                                        LD R6, ROWBACK ; ROWBACK is used to get back to the original location of the cow before flipping
                                                        ADD R5, R5, R6
                                                        LD R1, COW ; Load cow values
                                                        LD R2, COWW
                                                        LD R3, NEXT
                                                        LD R4, COWH
                                                        BRnzp REDOLOOP

                                                        REDOLOOP        LDR R4, R1, #0 ; Redisplay cow
                                                                        STR R4, R5, #0 
                                                                        ADD R1, R1, #1 
                                                                        ADD R5, R5, #1 
                                                                        ADD R2, R2, #-1 
                                                                        BRp REDOLOOP
                                                                        ADD R5, R5, R3 
                                                                        LD R2, COWW 
                                                                        ADD R4, R4, #-1 
                                                                        BRp REDOLOOP 
                                                                        LD R6, FLIPNUM
                                                                        NOT R6, R6
                                                                        ADD R6, R6, #1
                                                                        ADD R5, R5, R6
                                                                        BRnzp KEYS ; Go back to the KEYS function and await user input
                                                        
                                        BRnp KEYS ; If user input is not q, send back to KEYS and go from there

                        
                                
                                RET
WMOV     
        LD R6, WKEY ; Test for w 
        ADD R6, R0, R6
        BRz GOW ; If input is w, go to its move function
        RET ; If input isn't w, return to KEYS to perform other tests
        GOW     
                AND R6, R6, #0 ; Clear R6
                LD R6, UP ; Load R6 with the value of moving the cow "up" 4 pixels
                ADD R5, R6, R5 ; Add up value to location of cow
                AND R6, R6, #0
                ADD R6, R5, R6 ; Store current value of R5 into R6 so we can continue to reference this as the "current" location
                LD R1, COW ; Load cow values
                LD R2, COWW
                LD R3, NEXT
                LD R4, COWH
                JSR MOVW
                LD R2, BLACKWIDE ; After subroutine is finished, paint the remnants of previous cow black. Load required width of leftover cow pixels
                LD R4, BLACKHEIGHT ; Height of leftover pixels
                AND R6, R6, #0 ; Clear R6
                LD R6, WSOFF ; Load R6 with the required value to relocate our origin to the pixels we want to paint over
                ADD R6, R5, R6 ; Add it to our current location
                COVER1  LD R1, BLACK2 ; All "COVER" functions paint black pixels over leftover pixels of the initial cow picture. Load R1 with the color black
                        LD R3, SCOOT2 ; "SCOOT" slides the location over 1 so we can paint over all of the pixels
                        STR R1, R6, #0 ; Display a black pixel at current location
                        ADD R6, R6, R3 ; Shift location over 1
                        ADD R2, R2, #-1 ; Decrement width counter
                        BRp COVER1 ; Repeat if width requirements have not been met yet
                LD R2, BLACKWIDE ; Reload everything
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                LD R6, WSOFF
                ADD R6, R5, R6 
                LD R3, ROW
                ADD R6, R6, R3 ; Add the value of moving up a row to recalibrate our current location to be the next row of pixels. Repeat the same process for every cover function going forward throughout the script.
                COVER2  LD R1, BLACK2
                        LD R3, SCOOT2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER2
                LD R2, BLACKWIDE
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                LD R6, WSOFF
                ADD R6, R5, R6
                LD R3, ROW
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER3  LD R1, BLACK2
                        LD R3, SCOOT2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER3       
                LD R2, BLACKWIDE
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                LD R6, WSOFF
                ADD R6, R5, R6
                LD R3, ROW
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER4  LD R1, BLACK2
                        LD R3, SCOOT2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER4
                BRnzp KEYS
                        MOVW     
                                LDR R4, R1, #0 ; Redraw cow at new location
                                STR R4, R5, #0 
                                ADD R1, R1, #1 
                                ADD R5, R5, #1 
                                ADD R2, R2, #-1 
                                BRp MOVW
                                ADD R5, R5, R3 
                                LD R2, COWW 
                                ADD R4, R4, #-1 
                                BRp MOVW 
                                AND R5, R5, #0 ; Clear R5
                                ADD R5, R6, R5 ; Add previous value stored in R6 back into R5 so our location is constant throughout the script
                                RET
;;;;;;;;;;;;;;;;;;;
BLACK2 .FILL x0000
SCOOT2 .FILL #1
WSOFF .FILL #3584
COW .FILL x5000
COWW .FILL #30
COWH .FILL #25
NEXT .FILL #98
ROW2 .FILL #-128
BLACKWIDE .FILL #30
BLACKHEIGHT .FILL #4
JUMP_POINT2 BRnzp JUMP_POINT
;;;;;;;;;;;;;;;;;;;;;;;;
SMOV    LD R1, SKEY ; Test for s
        ADD R1, R1, R0
        BRz GOS
        RET     
        GOS     AND R6, R6, #0
                LD R6, DOWN ; Load R6 with value of moving down
                ADD R5, R6, R5 ; Move currently location down
                AND R6, R6, #0
                ADD R6, R5, R6 ; Store location 
                LD R1, COW ; Reload cow
                LD R2, COWW
                LD R3, NEXT
                LD R4, COWH
                JSR MOVS ; Go to subroutine to redraw the cow
                LD R2, BLACKWIDE ; Paint previous pixels black
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                LD R3, ROW
                ADD R6, R5, R6
                ADD R6, R6, R3
                COVER5  LD R1, BLACK
                        LD R3, SCOOT
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER5
                LD R2, BLACKWIDE
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                ADD R6, R5, R6
                LD R3, ROW
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER6  LD R1, BLACK
                        LD R3, SCOOT
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER6
                LD R2, BLACKWIDE
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                ADD R6, R5, R6
                LD R3, ROW
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER7  LD R1, BLACK
                        LD R3, SCOOT
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER7       
                LD R2, BLACKWIDE
                LD R4, BLACKHEIGHT
                AND R6, R6, #0
                
                ADD R6, R5, R6
                LD R3, ROW
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER8  LD R1, BLACK
                        LD R3, SCOOT
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER8
                BRnzp JUMP_POINT ; After this is done, we're now going to have to use a jump point to return to the KEYS function due to the PC offset being too large
                        MOVS     
                                LDR R4, R1, #0 ; Redraw cow at new location
                                STR R4, R5, #0 
                                ADD R1, R1, #1 
                                ADD R5, R5, #1 
                                ADD R2, R2, #-1 
                                BRp MOVS
                                ADD R5, R5, R3 
                                LD R2, COWW 
                                ADD R4, R4, #-1 
                                BRp MOVS 
                                AND R5, R5, #0
                                ADD R5, R6, R5
                                RET


AMOV    LD R1, AKEY ; Test for a
        ADD R1, R0, R1
        BRz GOA ; If input is a, perform operation
        RET
                GOA     AND R6, R6, #0
                        LD R6, LEFT ; Load R6 with value to move to the left
                        ADD R5, R6, R5 ; Shift to the left
                        AND R6, R6, #0
                        ADD R6, R5, R6 ; Store origin
                        LD R1, COW ; Reload cow values
                        LD R2, COWW
                        LD R3, NEXT
                        LD R4, COWH
                        JSR MOVA ; Go to subroutine to redraw the cow at the new point
                LD R2, BLACKHEIGHT2 ; Cover remnants with pixels
                AND R6, R6, #0
                LD R6, AOFF ; Offset to move location to the required point to paint previous pixels
                ADD R6, R5, R6 ; Moves location to new point
                COVER9  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER9
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, AOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                COVER10  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER10
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, AOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER11  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER11   
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, AOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER12  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER12
                        BRnzp JUMP_POINT2 ; Use jump point to jump back to KEYS
                                        MOVA     
                                                LDR R4, R1, #0 ; Redraw cow
                                                STR R4, R5, #0 
                                                ADD R1, R1, #1 
                                                ADD R5, R5, #1 
                                                ADD R2, R2, #-1 
                                                BRp MOVS
                                                ADD R5, R5, R3 
                                                LD R2, COWW 
                                                ADD R4, R4, #-1 
                                                BRp MOVS 
                                                AND R5, R5, #0
                                                ADD R5, R6, R5 ; Store current location
                                                RET
DMOV    LD R1, DKEY ; Test for d
        ADD R1, R0, R1
        BRz GOD ; If input is d, perform operation
        RET
                GOD     AND R6, R6, #0
                        LD R6, RIGHT ; Load R6 with value to shift cow to the right
                        ADD R5, R6, R5
                        AND R6, R6, #0
                        ADD R6, R5, R6
                        LD R1, COW ; Reload cow
                        LD R2, COWW
                        LD R3, NEXT
                        LD R4, COWH
                        JSR MOVD ; Subroutine to redraw at new location
                LD R2, BLACKHEIGHT2 ; Paint over pixels
                AND R6, R6, #0
                LD R6, DOFF ; Offset to move current location to the required point to begin painting
                ADD R6, R5, R6 ; Add offset to current location 
                COVER13  LD R1, BLACK 
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER13
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, DOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                COVER14  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER14
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, DOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER15  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER15   
                LD R2, BLACKHEIGHT2
                AND R6, R6, #0
                LD R6, DOFF
                ADD R6, R5, R6
                LD R3, SCOOT
                ADD R6, R6, R3
                ADD R6, R6, R3
                ADD R6, R6, R3
                COVER16  LD R1, BLACK
                        LD R3, ROW2
                        STR R1, R6, #0
                        ADD R6, R6, R3
                        ADD R2, R2, #-1
                        BRp COVER16
                        BRnzp JUMP_POINT2 ; Use jump point to get back to KEYS
                                        MOVD     
                                                LDR R4, R1, #0 ; Redraw cow
                                                STR R4, R5, #0 
                                                ADD R1, R1, #1 
                                                ADD R5, R5, #1
                                                ADD R2, R2, #-1 
                                                BRp MOVD
                                                ADD R5, R5, R3 
                                                LD R2, COWW 
                                                ADD R4, R4, #-1 
                                                BRp MOVD 
                                                AND R5, R5, #0
                                                ADD R5, R6, R5 ; Save current location
                                                RET
HALT
BLACK .FILL x0000
RIGHT .FILL #4
BLACKHEIGHT2 .FILL #25
BLACKWIDE2 .FILL #4
BLUE .FILL x001F
SOFF .FILL #-3584
AOFF .FILL #3102
DOFF .FILL #3068 
SKEY .FILL #-115
DKEY .FILL #-100
AKEY .FILL #-97
DOWN .FILL #512
LEFT .FILL #-4
SCOOT .FILL #1
.END