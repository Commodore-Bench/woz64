BasicUpstart2(start)

* = $8000 "Main"

// Constants
.namespace constants {
    .label  MAIN_COLOR   = $05
    .label  BORDER_COLOR = $03
    .label  SCREEN_MEM   = $0400
}

.word coldstart             // coldstart vector
.word start                 // start vector
.byte $C3,$C2,$CD,'8','0'   //..CBM80..


#import "screen.asm"
#import "keyb2.asm"
#import "hex.asm"


* = * "Kernel Start"

coldstart:
                ldx #$FF
                sei
                txs
                cld
                stx $d016
                jsr $fda3 // Prepare IRQ
                jsr $fd50 // Init memory. Rewrite this routine to speed up boot process.
                jsr $fd15 // Init I/O
                jsr $ff5b // Init video
                cli
start:
                jsr initApp;
                print(testString)

loop:
                lda #$FF
Raster:        cmp $D012
	            bne Raster
                jsr Keyboard2.ReadKeyb
                jsr Keyboard2.GetKey
                bcs Skip

                .break


                jsr Screen.petToScreen
                //jsr Hex.byteToHex
                //cPrint()
                //txa

                cPrint()


Skip:          jmp loop


initApp: {
                ClearColorRam($00)
                ClearScreen(constants.SCREEN_MEM, ' ')
                SetBorderColor(constants.MAIN_COLOR)
                SetBackgroundColor(constants.BORDER_COLOR)
                jsr Screen.init
                jsr Keyboard2.init
                rts
}


* = * "Kernel Data"

.encoding "screencode_mixed"
testString:
        .text "=stid= os - v 0.1.1a"
        .byte $8e
        .byte 0


* = $9FFF "EpromFiller"
    .byte 0


