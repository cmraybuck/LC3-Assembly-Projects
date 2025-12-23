.ORIG x3000
FIRST_IN        LEA R0, FIRSTIN ; Display first prompt to get binary from user
                PUTS

AND R1, R1, #0 ; Clear registers that we'll be using throughout the script (really important for looping)
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R5, ZEROOFF ; Negative ASCII for 0 so we can check if the user's input is a 0
LD R6, ONEOFF ; Negative ASCII for 0 so we can check if the user's input is a 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


STRING1B1       GETC ; Get input from user
                OUT ; Echo to the console

                LD R1, ZEROOFF ; Load R1 with -48
                ADD R1, R1, R0 ; Add input (R0) with offset (R1)
                BRz STOREBIT1Z ; If their sum is 0, then we know the input from the user was a 0. Send to the storage function for zeroes.

                LD R1, ONEOFF ; Load R1 with -49
                ADD R1, R1, R0 ; Add input (R0) with offset (R1)
                BRz STOREBIT1P ; If their sum is 0, we instead now know that the user has input a 1. We'll send it to the storage function for ones.

                LD R1, QKILL1 ; Load R1 with -81, which is the negative decimal value of the ASCII character "Q". This is how we'll end the script if "Q" is pressed
                ADD R1, R1, R0 ; Add input (R0) with offset (R1)
                BRz END_SCRIPT ; If sum is 0, the user has input "Q", and now we'll send this to our section designed to end the script

                LD R1, QKILL2 ; Load R1 with -113, the negative decimal value of the ASCII character "Q".
                ADD R1, R1, R0 ; Add input (R0) with offset (R1)
                BRz END_SCRIPT ; If sum is 0, the user has input "q", send to the script killer

                BR STRING1B1 ; If the user inputs anything else, repeat the loop until we get valid input. 

; Storing the bit if it equals 0...
STOREBIT1Z      AND R0, R0, #0 ; Clear R0
                ADD R0, R5, #0 ; Add R0 and R5, which is our ASCII offset from earlier
                AND R0, R0, #8 ; *BREAD AND BUTTER OF THIS SCRIPT*... By AND'ing R0 with 8, we can specify that this is the MSB. For the next bits, we'll use 4, 2, and 1 to specify the position of the bits in our string of binary. 2^n.
                ADD R2, R2, R0 ; Store the value of R0 into R2. This specifically stores it as the MSB. This will change for the rest of the bits of the first string
                BR STRING1B2 ; After this loop is complete, go to the next section to get the next bit



; Storing the bit if it equals 1...
STOREBIT1P      AND R0, R0, #0 ; Clear R0
                ADD R0, R6, #0 ; Add R0 and R6, another ASCII offset from earlier. This offset is for 1 rather than 0.
                AND R0, R0, #8 ; AND'ing R0 with 8 to specify bit positioning in a 4 bit string
                ADD R2, R2, R0 ; Store R0 into R2
                BR STRING1B2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

STRING1B2       GETC ; Get next input from user. Do all of what we just did above again, but now we're storing it as the next bit.
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT2Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT2P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING1B2


STOREBIT2Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #4 ; Multiply by 4 rather than 8 because we are not on the "middle-left-bit" as I describe it. Ex. 1011, 0 is the middle-left-bit.
                ADD R2, R2, R0 ; Store it
                BR STRING1B3 ; Go to next bit




STOREBIT2P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #4 ; Middle-left-bit
                ADD R2, R2, R0 ; Store it
                BR STRING1B3 ; Go to next bit 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRING1B3       GETC ; All again
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT3Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT3P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING1B3


STOREBIT3Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #2 ; Middle-right-bit
                ADD R2, R2, R0 ; Store it
                BR STRING1B4 ; Next




STOREBIT3P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #2 ; Middle-right-bit
                ADD R2, R2, R0 ; Store it
                BR STRING1B4 ; Next

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRING1B4       GETC ; One more time for the first string
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT4Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT4P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING1B4


STOREBIT4Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #1 ; LSB
                ADD R2, R2, R0 ; Store it
                BR SECOND_IN ; Next prompt because this is a complete string now




STOREBIT4P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #1 ; LSB
                ADD R2, R2, R0 ; Store it
                BR SECOND_IN ; Move on to next prompt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Had to store these here so the script could reach them

ZEROOFF .FILL #-48
QKILL1 .FILL #-81
QKILL2 .FILL #-113
BYEBYE .STRINGZ "\n\nThank you for playing."
ONEOFF .FILL #-49
FIRSTIN .STRINGZ "\n\nEnter first number (4 binary digits): "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Here's the script killer function I mentioned earlier if the user inputs "Q" or "q".
END_SCRIPT      LEA R0, BYEBYE ; Load R0 with the string "BYEBYE" 
                PUTS ; Display it
                HALT ; Stop running the script
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SCRIPT_LOOP     BR FIRST_IN ; Loop that will be used at the end of the script
SECOND_IN       AND R0, R0, #0 ; Clear R0 (not entirely sure if this is necessary but I always clear when in doubt)
                LEA R0, SECONDIN ; Load up the second input prompt
                PUTS ; Show it in the terminal and await user input




STRING2B1       GETC ; This is basically a carbon copy of how we got string 1 so if you want to know what's going on here reference above :)
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT5Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT5P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING2B1


STOREBIT5Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #8
                ADD R3, R3, R0
                BR STRING2B2




STOREBIT5P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #8
                ADD R3, R3, R0
                BR STRING2B2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRING2B2       GETC
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT6Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT6P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING2B2


STOREBIT6Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #4
                ADD R3, R3, R0
                BR STRING2B3




STOREBIT6P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #4
                ADD R3, R3, R0
                BR STRING2B3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRING2B3       GETC
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT7Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT7P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING2B3
STOREBIT7Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #2
                ADD R3, R3, R0
                BR STRING2B4
STOREBIT7P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #2
                ADD R3, R3, R0
                BR STRING2B4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STRING2B4       GETC
                OUT

                LD R1, ZEROOFF
                ADD R1, R1, R0
                BRz STOREBIT8Z

                LD R1, ONEOFF
                ADD R1, R1, R0
                BRz STOREBIT8P

                LD R1, QKILL1
                ADD R1, R1, R0
                BRz END_SCRIPT

                LD R1, QKILL2
                ADD R1, R1, R0
                BRz END_SCRIPT

                BR STRING2B4
STOREBIT8Z      AND R0, R0, #0
                ADD R0, R5, #0
                AND R0, R0, #1
                ADD R3, R3, R0
                BR XOR_PARTY ; XOR_PARTY is my label for actually performing the XOR function, so after we've gotten our values stored in the right place, we have to do that.
STOREBIT8P      AND R0, R0, #0
                ADD R0, R6, #0
                AND R0, R0, #1
                ADD R3, R3, R0
                BR XOR_PARTY ; Go to the XOR section
; R2 holds string 1 and R3 holds string 2
; XOR -> (A' AND B) OR (B' AND A) = Output
; DeMorgan's Law to get... (A' AND B)' AND (B' AND A)' = OUT'
; OUT'=OUT, which is what we need
; R2 = A, R3 = B, R4 = A', R5 = B', R0 = Storage 1, R1 = Storage 2, and we'll use R6 as our output
XOR_PARTY       AND R0, R0, #0 ; Clearing all of our registers except R2 and R3 so we can do the XOR operation
                AND R1, R1, #0
                AND R5, R5, #0
                AND R6, R6, #0
                AND R4, R4, #0

                NOT R4, R2 ; Create A' 
                NOT R5, R3 ; Create B'
                AND R0, R2, R5 ; (A AND B')
                AND R1, R3, R4 ; (B AND A')
                NOT R0, R0 ; (A AND B')' 
                NOT R1, R1 ; (B AND A')' 
                AND R6, R1, R0 ; (A AND B')' AND (B AND A')' = OUT', which we'll store in R6
                NOT R6, R6 ; NOT R6 = NOT OUT' = OUT, which is the value we want now stored in R6. XOR operation is done
XOR_OUTPUT      LEA R0, XOR_OUT ; Load up the string that will show the completed XOR operation
                PUTS ; Display the string
LD R5, ASCIIOFF1 ; Offset for the ASCII character 1 so we can echo a 1 to the terminal if the value is a 1
LD R4, ASCIIOFFZ ; Offset for ASCII character 0
; Similar to what I did at the beginning with grabbing each individual bit from the user, I'll explain in detail for the first bit and 
; elaborate less on the rest of them because it's just the same logic over and over again.
XOR_DISPLAY1    AND R1, R1, #0 ; Clear R1 
                AND R0, R0, #0 ; Clear R0
                ADD R0, R6, R0 ; Move the XOR result from R6 to R0
                AND R1, R0, #8 ; Specify the MSB of the XOR result
                BRz DISPLAYZ1 ; If the value is 0, then we'll go to our display zero function
                BR DISPLAYP1 ; If the value is anything but 0, we'll go to our display one function
DISPLAYZ1       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #8 ; MSB
                ADD R0, R0, R4 ; Add ASCII offset of 0 so Pennsim will adequately display the result
                OUT ; Echo the result to the console
                BR XOR_DISPLAY2 ; Go to the next display bit
DISPLAYP1       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #8 ; MSB
                ADD R0, R0, R5 ; ASCII offset of 1 so it will print a 1
                OUT ; Echo to console
                BR XOR_DISPLAY2 ; Go to next display bit
XOR_DISPLAY2    
                AND R0, R0, #0 ; Same logic as XOR_DISPLAY1
                ADD R0, R6, R0 ; Move XOR result
                AND R1, R0, #4 ; Middle-left-bit
                BRz DISPLAYZ2 
                BR DISPLAYP2
DISPLAYZ2       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #4 ; Middle-left-bit
                ADD R0, R4, R0 ; Add offset
                OUT ; Echo
                BR XOR_DISPLAY3 ; Next
DISPLAYP2       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #4 ; Middle-left-bit (Again, 1011, 0 is what I'm calling the "middle-left-bit")
                ADD R0, R5, R0 ; Add offset
                OUT ; Echo
                BR XOR_DISPLAY3 ; Next
XOR_DISPLAY3    
                AND R0, R0, #0 ; Clear
                ADD R0, R6, R0 ; Move XOR
                AND R1, R0, #2 ; Middle-right-bit
                BRz DISPLAYZ3
                BR DISPLAYP3
DISPLAYZ3       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #2 ; Middle-right-bit
                ADD R0, R4, R0 ; Offset
                OUT ; Echo
                BR XOR_DISPLAY4 ; Next
DISPLAYP3       AND R0, R0, #0 ; Clear R0    
                AND R0, R0, #2 ; Middle-right-bit
                ADD R0, R5, R0 ; Offset        
                OUT ; Echo
                BR XOR_DISPLAY4 ; Next
XOR_DISPLAY4    
                AND R0, R0, #0 ; Clear R0
                ADD R0, R6, R0 ; Move XOR
                AND R1, R0, #1 ; LSB
                BRz DISPLAYZ4
                BR DISPLAYP4
DISPLAYZ4       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #1 ; LSB
                ADD R0, R4, R0 ; Offset
                OUT ; Echo
                BR SCRIPT_LOOP ; Go to the SCRIPT_LOOP function and restart!
DISPLAYP4       AND R0, R0, #0 ; Clear R0
                AND R0, R0, #1 ; LSB
                ADD R0, R5, R0 ; Offset
                OUT ; Echo
                BR SCRIPT_LOOP ; Restart the script
ASCIIOFFZ .FILL #48
ASCIIOFF1 .FILL #49
SECONDIN .STRINGZ "\n\nEnter second number (4 binary digits): "
XOR_OUT .STRINGZ "\n\nThe XOR function of the two numbers is: "
.END
