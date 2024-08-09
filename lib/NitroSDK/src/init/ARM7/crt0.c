#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM7

#define HW_CARD_ROM_HEADER         0x27FFA80
#define HW_CARD_ROM_HEADER_SIZE    0x160
#define HW_DOWNLOAD_PARAMETER_SIZE 0x20

#define HW_RESET_VECTOR 0xFFFF0000

extern void OS_IrqHandler(void);

extern void NitroMain(void);
static void do_autoload(void);
void _start_AutoloadDoneCallback(void *argv[]);
extern void *const _start_ModuleParams[];
static void detect_main_memory_size(void);
void _start(void);

// from LCF
extern void SDK_IRQ_STACKSIZE(void);
extern void SDK_AUTOLOAD_START(void);    // autoload data will start from here
extern void SDK_AUTOLOAD_LIST(void);     // start pointer to autoload information
extern void SDK_AUTOLOAD_LIST_END(void); // end pointer to autoload information
extern void SDK_STATIC_BSS_START(void);  // static bss start address
extern void SDK_STATIC_BSS_END(void);    // static bss end address

SDK_WEAK_SYMBOL asm void _start(void)
{
    // clang-format off
	mov ip, #HW_REG_BASE
	str ip, [ip, #0x208]
	ldr r1, =SDK_STATIC_BSS_END
	mov r0, #HW_PRV_WRAM
	cmp r0, r1
	movpl r1, r0
	ldr r2, =0x0380FF00
	mov r0, #0
_02380020:
	cmp r1, r2
	stmltia r1!, {r0}
	blt _02380020
	mov r0, #HW_PSR_SVC_MODE
	msr cpsr_c, r0
	ldr sp, =HW_PRV_WRAM_SVC_STACK_END
	mov r0, #HW_PSR_IRQ_MODE
	msr cpsr_c, r0
	ldr r0, =HW_PRV_WRAM_IRQ_STACK_END
	mov sp, r0
	ldr r1, =SDK_IRQ_STACKSIZE
	sub r1, r0, r1
	mov r0, #HW_PSR_SYS_MODE
	msr cpsr_fsxc, r0
	sub sp, r1, #4
	ldr r0, =0x023FE940
	ldr r1, =HW_CARD_ROM_HEADER
	add r2, r1, #HW_CARD_ROM_HEADER_SIZE
_02380068:
	ldr r3, [r0], #4
	str r3, [r1], #4
	cmp r1, r2
	bmi _02380068
	ldr r0, =0x023FE904
	add r2, r1, #HW_DOWNLOAD_PARAMETER_SIZE
_02380080:
	ldr r3, [r0], #4
	str r3, [r1], #4
	cmp r1, r2
	bmi _02380080
	bl do_autoload
	ldr r0, =_start_ModuleParams
	ldr r1, [r0, #0xc]
	ldr r2, [r0, #0x10]
	mov r0, #0
_023800A4:
	cmp r1, r2
	strlo r0, [r1], #4
	blo _023800A4
	bl detect_main_memory_size
	ldr r1, =0x0380FFFC
	ldr r0, =OS_IrqHandler
	str r0, [r1]
	ldr r1, =NitroMain
	ldr lr, =HW_RESET_VECTOR
	bx r1
    // clang-format on
}

// clang-format off
void *const _start_ModuleParams[] = {
	(void *)SDK_AUTOLOAD_LIST,
	(void *)SDK_AUTOLOAD_LIST_END,
	(void *)SDK_AUTOLOAD_START,
	(void *)SDK_STATIC_BSS_START,
	(void *)SDK_STATIC_BSS_END,
};
// clang-format on

static asm void do_autoload(void)
{
#define ptable     r0
#define infop      r1
#define infop_end  r2
#define src        r3
#define dest       r4
#define dest_begin r5
#define dest_end   r6
#define tmp        r7

    // clang-format off
	ldr ptable, =_start_ModuleParams
	ldr infop, [ptable, #0]
	ldr infop_end, [ptable, #4]
	ldr src, [ptable, #8]

@1:
	cmp infop, infop_end
	beq @skipout
	ldr dest, [infop], #4
	ldr dest_begin, [infop], #4
	add dest_end, dest, dest_begin

@2:
	cmp dest, dest_end
	ldrmi tmp, [r3], #4
	strmi tmp, [r4], #4
	bmi @2
	ldr dest_begin, [r1], #4
	add dest_end, dest, dest_begin
	mov tmp, #0

@3:
	cmp dest, dest_end
	strlo tmp, [r4], #4
	blo @3
	beq @1

@skipout:
	b _start_AutoloadDoneCallback
    // clang-format on
}

SDK_WEAK_SYMBOL asm void _start_AutoloadDoneCallback(void *argv[]){
    // clang-format off
	bx lr
    // clang-format on
}

SDK_WEAK_SYMBOL asm void detect_main_memory_size(void){
    // clang-format off
    mov r0, #1
	mov r1, #0
	ldr r2, =0x027FFFFA
	sub r3, r2, #0x400000

_0238016C:
	strh r1, [r2]
	ldrh ip, [r3]
	cmp r1, ip
	movne r0, #2
	bne _0238018C
	add r1, r1, #1
	cmp r1, #2
	bne _0238016C

_0238018C:
	strh r0, [r2]
	bx lr
    // clang-format on
}

SDK_WEAK_SYMBOL void NitroStartUp(void) {}

#endif