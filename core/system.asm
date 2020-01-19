
#importonce
#import "../core/pseudo.asm"
#import "../core/module.asm"
#import "../core/boot.asm"
#import "../libs/memory.asm"
#import "../libs/math.asm"
#import "../libs/print.asm"
#import "../libs/keyboard.asm"
#import "../libs/screen.asm"
#import "../progs/woz_shell.asm"

.filenamespace System

* = * "System Core"


// ========================================================
// ////// METHODS /////////////////////////////////////////
// ========================================================

// --------------------------------------------------------
// start -
// System Start
// --------------------------------------------------------
start: {


                //      Start Main Program
                jsr     WozShell.start

                //      TODO: Program exited here
                //      We can ask program to set a ram param and let us know
                //      if exit is due to a sort of error.

                rts

                // TODO: Can we use Timed Interrupt to execute small system recurring tasks?
}

// --------------------------------------------------------
// init -
// Module Init.
// --------------------------------------------------------
init: {
                // Init All Modules
                // TODO: How we can make this dynamic?
                jsr     Memory.init
                jsr     Screen.init
                jsr     Print.init
                jsr     Math.init
                jsr     Keyboard.init

                jsr     WozShell.init
                rts
}


// --------------------------------------------------------
// toDebug -
// Print debug info.
// --------------------------------------------------------
toDebug: {
                // Debug All Modules
                jsr     Boot.toDebug
                ModuleToDebug(module_type, module_name, version)

                jsr     Pseudo.toDebug
                jsr     Module.toDebug

                jsr     Keyboard.toDebug
                jsr     Math.toDebug
                jsr     Memory.toDebug
                jsr     Print.toDebug
                jsr     Screen.toDebug

                jsr     WozShell.toDebug
                rts
}


// ========================================================
// ////// DATA ////////////////////////////////////////////
// ========================================================

* = * "System Core Data"
module_type:    .byte   Module.TYPES.CORE
version:        .byte   1, 0, 0

.encoding "screencode_mixed"
module_name:
                .text   "system"
                .byte   0


#import "../core/mem_map.asm"
