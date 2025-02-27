	.include "asm/macros.inc"
	.include "global.inc"
	
.public savedataBlockOffsets
.public savedataBlockSizes
.public SaveGame__ClearCallbacks
.public _02110DDC

	.text

// https://decomp.me/scratch/3UIwx -> 57.17%
	thumb_func_start SaveGame__LoadData2
SaveGame__LoadData2: // 0x0205E49C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0xe0
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #0x68]
	mov r0, #1
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _0205E7C0 // =0xEDB88320
	str r0, [sp, #0x64]
	bl MATHi_CRC32InitTableRev
	mov r0, #1
	str r0, [sp, #0x60]
	b _0205EAC6
_0205E4BC:
	ldr r0, [sp, #0x60]
	mov r1, #1
	lsl r1, r0
	ldr r0, [sp]
	tst r0, r1
	bne _0205E4CA
	b _0205EAC0
_0205E4CA:
	ldr r0, [sp, #0x60]
	mov r7, #0
	lsl r0, r0, #2
	str r0, [sp, #4]
	b _0205E600
_0205E4D4:
	mov r0, #0
	str r0, [sp, #0x4c]
	ldr r1, _0205E7C4 // =savedataBlockSizes
	ldr r0, [sp, #4]
	ldr r0, [r1, r0]
	str r0, [sp, #0x54]
	lsl r0, r0, #1
	str r0, [sp, #0x50]
	add r0, #8
	str r0, [sp, #0x50]
	bl _AllocHeadHEAP_USER
	mov r5, r0
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r7
	str r0, [sp, #0x14]
	add r0, #0x80
	str r0, [sp, #0x14]
	ldr r1, _0205E7C8 // =_02110DDC
	ldr r0, [sp, #4]
	ldr r2, [sp, #0x50]
	ldr r1, [r1, r0]
	ldr r0, [sp, #0x14]
	add r0, r1, r0
	mov r1, r5
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E516
	mov r0, #2
	str r0, [sp, #0x4c]
	b _0205E5E0
_0205E516:
	ldr r0, [sp, #0x50]
	mov r1, #2
	sub r0, #8
	bl FX_DivS32
	str r0, [sp, #0x58]
	mov r0, r5
	mov r4, #0
	str r0, [sp, #0x6c]
	add r0, #8
	mov r6, r4
	str r0, [sp, #0x6c]
_0205E52E:
	ldr r0, [r5, #0]
	add r1, sp, #0xac
	str r0, [sp, #0x5c]
	ldr r0, [r5, #4]
	add r2, sp, #0xa8
	str r0, [sp, #0xa8]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0xac]
	ldr r0, [sp, #0x64]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp, #0x58]
	ldr r0, [sp, #0x64]
	mov r2, r3
	ldr r3, [sp, #0x6c]
	mul r2, r6
	add r2, r3, r2
	ldr r3, [sp, #0x58]
	add r1, sp, #0xac
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0xac]
	mvn r1, r0
	ldr r0, [sp, #0x5c]
	cmp r0, r1
	bne _0205E56C
	mov r0, #1
	lsl r0, r6
	orr r4, r0
_0205E56C:
	add r6, r6, #1
	cmp r6, #2
	blo _0205E52E
	cmp r4, #3
	beq _0205E5E0
	cmp r4, #0
	bne _0205E580
	mov r0, #4
	str r0, [sp, #0x4c]
	b _0205E5E0
_0205E580:
	mov r0, #0
	b _0205E58E
_0205E584:
	mov r1, #1
	lsl r1, r0
	tst r1, r4
	bne _0205E592
	add r0, r0, #1
_0205E58E:
	cmp r0, #2
	blt _0205E584
_0205E592:
	mov r1, r5
	str r1, [sp, #0x70]
	add r1, #8
	str r1, [sp, #0x70]
	ldr r1, [sp, #0x54]
	mov r6, #0
	mul r0, r1
	str r0, [sp, #0x74]
_0205E5A2:
	mov r0, #1
	lsl r0, r6
	tst r0, r4
	bne _0205E5C0
	ldr r1, [sp, #0x70]
	ldr r0, [sp, #0x74]
	ldr r2, [sp, #0x54]
	add r0, r1, r0
	mov r1, r2
	ldr r2, [sp, #0x70]
	mul r1, r6
	add r1, r2, r1
	ldr r2, [sp, #0x54]
	bl MIi_CpuCopy16
_0205E5C0:
	add r6, r6, #1
	cmp r6, #2
	blt _0205E5A2
	ldr r1, _0205E7C8 // =_02110DDC
	ldr r0, [sp, #4]
	ldr r2, [sp, #0x50]
	ldr r1, [r1, r0]
	ldr r0, [sp, #0x14]
	add r0, r1, r0
	mov r1, r5
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205E5E0
	mov r0, #4
	str r0, [sp, #0x4c]
_0205E5E0:
	cmp r5, #0
	beq _0205E5EA
	mov r0, r5
	bl _FreeHEAP_USER
_0205E5EA:
	ldr r0, [sp, #0x4c]
	cmp r0, #0
	beq _0205E5FA
	cmp r0, #2
	bne _0205E5FA
	mov r0, #2
	str r0, [sp, #0x68]
	b _0205EACE
_0205E5FA:
	add r0, r7, #1
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
_0205E600:
	cmp r7, #4
	bhs _0205E606
	b _0205E4D4
_0205E606:
	mov r0, #0
	str r0, [sp, #0x20]
	ldr r1, _0205E7C4 // =savedataBlockSizes
	ldr r0, [sp, #4]
	ldr r0, [r1, r0]
	str r0, [sp, #0xc]
	bl _AllocHeadHEAP_USER
	mov r4, #0
	str r0, [sp, #0x1c]
	mov r7, #0x37
	ldr r1, _0205E7C8 // =_02110DDC
	ldr r0, [sp, #4]
	str r4, [sp, #0x3c]
	ldr r0, [r1, r0]
	mov r5, r4
	str r0, [sp, #0x24]
	add r6, sp, #0xc0
	lsl r7, r7, #8
	b _0205E650
_0205E62E:
	mov r1, r5
	mul r1, r7
	ldr r0, [sp, #0x24]
	add r1, #0x80
	add r0, r0, r1
	lsl r1, r5, #3
	add r1, r6, r1
	mov r2, #8
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E64A
	mov r0, #0
	b _0205E656
_0205E64A:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205E650:
	cmp r5, #4
	blo _0205E62E
	mov r0, #1
_0205E656:
	cmp r0, #0
	bne _0205E660
	mov r0, #2
	str r0, [sp, #0x3c]
	b _0205E8B8
_0205E660:
	mov r4, #0
	add r2, sp, #0xc0
	add r1, sp, #0xb0
_0205E666:
	lsl r0, r4, #3
	add r3, r2, r0
	lsl r0, r4, #2
	str r3, [r1, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #4
	blo _0205E666
	mov r3, #0
_0205E67A:
	mov r6, #0
_0205E67C:
	lsl r7, r6, #2
	add r0, sp, #0xb0
	add r5, r0, r7
	ldr r4, [r5, #4]
	ldr r0, [r0, r7]
	ldr r1, [r4, #4]
	ldr r7, [r0, #4]
	mov r2, #0
	cmp r7, r1
	bls _0205E694
	mov r2, #1
	b _0205E69E
_0205E694:
	cmp r7, r1
	bne _0205E69E
	cmp r0, r4
	bls _0205E69E
	mov r2, #1
_0205E69E:
	cmp r2, #0
	beq _0205E6A6
	str r4, [r5]
	str r0, [r5, #4]
_0205E6A6:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	cmp r6, #3
	blt _0205E67C
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
	cmp r3, #3
	blt _0205E67A
	ldr r0, [sp, #0xc]
	lsl r0, r0, #1
	str r0, [sp, #0x38]
	add r0, #8
	str r0, [sp, #0x38]
	bl _AllocHeadHEAP_USER
	mov r4, r0
	ldr r0, [sp, #0x38]
	mov r5, #0
	str r0, [sp, #0x10]
	sub r0, #8
	str r0, [sp, #0x10]
	mov r0, r4
	str r0, [sp, #0x78]
	add r0, #8
	str r0, [sp, #0x78]
	b _0205E7DA
_0205E6DE:
	mov r1, #3
	sub r1, r1, r5
	lsl r1, r1, #0x10
	lsr r2, r1, #0xe
	add r1, sp, #0xb0
	mov r0, #0
	ldr r2, [r1, r2]
	b _0205E6FE
_0205E6EE:
	lsl r3, r0, #3
	add r1, sp, #0xc0
	add r1, r1, r3
	cmp r1, r2
	beq _0205E702
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
_0205E6FE:
	cmp r0, #4
	blo _0205E6EE
_0205E702:
	mov r1, #0x37
	lsl r1, r1, #8
	mul r1, r0
	ldr r0, [sp, #0x24]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0x38]
	mov r1, r4
	mov r7, #0
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E720
	mov r6, #2
	b _0205E782
_0205E720:
	ldr r0, [sp, #0x10]
	mov r1, #2
	bl FX_DivS32
	str r0, [sp, #0x30]
	mov r6, r7
_0205E72C:
	ldr r0, [r4, #0]
	add r1, sp, #0x94
	str r0, [sp, #0x34]
	ldr r0, [r4, #4]
	add r2, sp, #0x90
	str r0, [sp, #0x90]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x94]
	ldr r0, [sp, #0x64]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp, #0x30]
	ldr r0, [sp, #0x64]
	mov r2, r3
	ldr r3, [sp, #0x78]
	mul r2, r6
	add r2, r3, r2
	ldr r3, [sp, #0x30]
	add r1, sp, #0x94
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x94]
	mvn r1, r0
	ldr r0, [sp, #0x34]
	cmp r0, r1
	bne _0205E76A
	mov r0, #1
	lsl r0, r6
	orr r7, r0
_0205E76A:
	add r6, r6, #1
	cmp r6, #2
	blo _0205E72C
	cmp r7, #0
	bne _0205E778
	mov r6, #4
	b _0205E782
_0205E778:
	cmp r7, #3
	beq _0205E780
	mov r6, #3
	b _0205E782
_0205E780:
	mov r6, #0
_0205E782:
	cmp r6, #0
	beq _0205E78A
	cmp r6, #3
	bne _0205E7CC
_0205E78A:
	mov r1, #0
	mov r0, #1
	b _0205E79E
_0205E790:
	mov r2, r0
	lsl r2, r1
	tst r2, r7
	bne _0205E7A2
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E79E:
	cmp r1, #2
	blo _0205E790
_0205E7A2:
	ldr r0, [sp, #0xc]
	mov r2, r4
	add r2, #8
	mul r1, r0
	add r0, r2, r1
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0xc]
	bl MIi_CpuCopy16
	cmp r6, #3
	bne _0205E7E0
	mov r0, #3
	str r0, [sp, #0x3c]
	b _0205E7E0
	nop
_0205E7C0: .word 0xEDB88320
_0205E7C4: .word savedataBlockSizes
_0205E7C8: .word _02110DDC
_0205E7CC:
	cmp r6, #4
	bne _0205E7D4
	mov r0, #3
	str r0, [sp, #0x3c]
_0205E7D4:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205E7DA:
	cmp r5, #4
	bhs _0205E7E0
	b _0205E6DE
_0205E7E0:
	cmp r5, #4
	bne _0205E7EA
	mov r0, #4
	str r0, [sp, #0x3c]
	b _0205E8B8
_0205E7EA:
	mov r0, r4
	str r0, [sp, #0x7c]
	add r0, #8
	str r0, [sp, #0x7c]
	b _0205E8B4
_0205E7F4:
	mov r1, #3
	sub r1, r1, r5
	lsl r1, r1, #0x10
	lsr r2, r1, #0xe
	add r1, sp, #0xb0
	mov r0, #0
	ldr r2, [r1, r2]
	b _0205E814
_0205E804:
	lsl r3, r0, #3
	add r1, sp, #0xc0
	add r1, r1, r3
	cmp r1, r2
	beq _0205E818
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
_0205E814:
	cmp r0, #4
	blo _0205E804
_0205E818:
	mov r1, #0
	beq _0205E81E
	str r1, [r1]
_0205E81E:
	mov r1, #0x37
	lsl r1, r1, #8
	mul r1, r0
	ldr r0, [sp, #0x24]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0x38]
	mov r1, r4
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E83A
	mov r0, #2
	b _0205E8A4
_0205E83A:
	ldr r0, [sp, #0x10]
	mov r1, #2
	bl FX_DivS32
	mov r6, #0
	str r0, [sp, #0x28]
	mov r7, r6
_0205E848:
	ldr r0, [r4, #0]
	add r1, sp, #0x8c
	str r0, [sp, #0x2c]
	ldr r0, [r4, #4]
	add r2, sp, #0x88
	str r0, [sp, #0x88]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x8c]
	ldr r0, [sp, #0x64]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp, #0x28]
	ldr r0, [sp, #0x64]
	mov r2, r3
	ldr r3, [sp, #0x7c]
	mul r2, r7
	add r2, r3, r2
	ldr r3, [sp, #0x28]
	add r1, sp, #0x8c
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x8c]
	mvn r1, r0
	ldr r0, [sp, #0x2c]
	cmp r0, r1
	bne _0205E886
	mov r0, #1
	lsl r0, r7
	orr r6, r0
_0205E886:
	add r7, r7, #1
	cmp r7, #2
	blo _0205E848
	mov r0, #0
	beq _0205E892
	str r6, [r0]
_0205E892:
	cmp r6, #0
	bne _0205E89A
	mov r0, #4
	b _0205E8A4
_0205E89A:
	cmp r6, #3
	beq _0205E8A2
	mov r0, #3
	b _0205E8A4
_0205E8A2:
	mov r0, #0
_0205E8A4:
	sub r0, r0, #3
	cmp r0, #1
	bhi _0205E8AE
	mov r0, #3
	str r0, [sp, #0x3c]
_0205E8AE:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205E8B4:
	cmp r5, #4
	blo _0205E7F4
_0205E8B8:
	cmp r4, #0
	beq _0205E8C2
	mov r0, r4
	bl _FreeHEAP_USER
_0205E8C2:
	ldr r0, [sp, #0x3c]
	cmp r0, #2
	bne _0205E8CE
	mov r0, #2
	str r0, [sp, #0x20]
	b _0205EAA0
_0205E8CE:
	cmp r0, #4
	bne _0205E948
	mov r0, #4
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r1, #1
	ldr r0, [sp, #0x60]
	mov r6, r1
	lsl r6, r0
	ldr r0, _0205EAE0 // =0x000001FE
	mov r1, r6
	and r1, r0
	cmp r1, r0
	bne _0205E8F8
	ldr r2, _0205EAE4 // =0x00001A68
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	b _0205E91C
_0205E8F8:
	mov r5, #0
	mov r7, #1
_0205E8FC:
	mov r0, r7
	lsl r0, r5
	tst r0, r6
	beq _0205E916
	ldr r1, _0205EAE8 // =savedataBlockOffsets
	lsl r3, r5, #2
	ldr r2, _0205EAEC // =savedataBlockSizes
	ldr r1, [r1, r3]
	ldr r2, [r2, r3]
	mov r0, #0
	add r1, r4, r1
	bl MIi_CpuClear16
_0205E916:
	add r5, r5, #1
	cmp r5, #9
	blt _0205E8FC
_0205E91C:
	mov r5, #0
	ldr r7, _0205EAF0 // =SaveGame__ClearCallbacks
	b _0205E92E
_0205E922:
	lsl r2, r5, #2
	ldr r2, [r7, r2]
	mov r0, r4
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205E92E:
	cmp r5, #3
	blo _0205E922
	ldr r1, _0205EAE8 // =savedataBlockOffsets
	ldr r0, [sp, #4]
	ldr r2, [sp, #0xc]
	ldr r0, [r1, r0]
	ldr r1, [sp, #0x1c]
	add r0, r4, r0
	bl MIi_CpuCopy16
	mov r0, r4
	bl _FreeHEAP_USER
_0205E948:
	ldr r0, [sp, #0xc]
	mov r5, #0
	lsl r7, r0, #1
	add r7, #8
	mov r0, r7
	str r0, [sp, #0x18]
	sub r0, #8
	str r0, [sp, #0x18]
	b _0205EA9A
_0205E95A:
	ldr r1, _0205EAF4 // =_02110DDC
	ldr r0, [sp, #4]
	ldr r4, [r1, r0]
	mov r0, r7
	bl _AllocHeadHEAP_USER
	str r0, [sp, #0x48]
	mov r0, #0
	beq _0205E96E
	str r0, [r0]
_0205E96E:
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r5
	str r0, [sp, #8]
	add r0, #0x80
	str r0, [sp, #8]
	ldr r1, [sp, #0x48]
	add r0, r4, r0
	mov r2, r7
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E98C
	mov r4, #2
	b _0205EA02
_0205E98C:
	ldr r0, [sp, #0x18]
	mov r1, #2
	bl FX_DivS32
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x48]
	mov r4, #0
	str r0, [sp, #0x80]
	add r0, #8
	mov r6, r4
	str r0, [sp, #0x80]
_0205E9A2:
	ldr r0, [sp, #0x48]
	add r1, sp, #0x9c
	ldr r0, [r0, #0]
	add r2, sp, #0x98
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x48]
	mov r3, #4
	ldr r0, [r0, #4]
	str r0, [sp, #0x98]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x9c]
	ldr r0, [sp, #0x64]
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp, #0x40]
	ldr r0, [sp, #0x64]
	mov r2, r3
	ldr r3, [sp, #0x80]
	mul r2, r6
	add r2, r3, r2
	ldr r3, [sp, #0x40]
	add r1, sp, #0x9c
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x9c]
	mvn r1, r0
	ldr r0, [sp, #0x44]
	cmp r0, r1
	bne _0205E9E4
	mov r0, #1
	lsl r0, r6
	orr r4, r0
_0205E9E4:
	add r6, r6, #1
	cmp r6, #2
	blo _0205E9A2
	mov r0, #0
	beq _0205E9F0
	str r4, [r0]
_0205E9F0:
	cmp r4, #0
	bne _0205E9F8
	mov r4, #4
	b _0205EA02
_0205E9F8:
	cmp r4, #3
	beq _0205EA00
	mov r4, #3
	b _0205EA02
_0205EA00:
	mov r4, #0
_0205EA02:
	ldr r0, [sp, #0x48]
	bl _FreeHEAP_USER
	cmp r4, #2
	bne _0205EA12
	mov r0, #2
	str r0, [sp, #0x20]
	b _0205EAA0
_0205EA12:
	cmp r4, #4
	bne _0205EA94
	mov r0, r7
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r7
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0xa4]
	sub r0, r0, #1
	str r0, [sp, #0xa0]
	ldr r0, [sp, #0x64]
	add r1, sp, #0xa0
	add r2, sp, #0xa4
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x64]
	ldr r2, [sp, #0x1c]
	ldr r3, [sp, #0xc]
	add r1, sp, #0xa0
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0xa0]
	mvn r0, r0
	str r0, [r6]
	mov r0, #0
	str r0, [r6, #4]
	mov r4, r0
	mov r0, r6
	str r0, [sp, #0x84]
	add r0, #8
	str r0, [sp, #0x84]
_0205EA5C:
	ldr r2, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	mov r1, r2
	ldr r2, [sp, #0x84]
	mul r1, r4
	add r1, r2, r1
	ldr r2, [sp, #0xc]
	bl MIi_CpuCopy16
	add r4, r4, #1
	cmp r4, #2
	blt _0205EA5C
	ldr r1, _0205EAF4 // =_02110DDC
	ldr r0, [sp, #4]
	mov r2, r7
	ldr r1, [r1, r0]
	ldr r0, [sp, #8]
	add r0, r1, r0
	mov r1, r6
	bl WriteToCardBackup
	cmp r0, #0
	beq _0205EA8E
	mov r0, #4
	str r0, [sp, #0x20]
_0205EA8E:
	mov r0, r6
	bl _FreeHEAP_USER
_0205EA94:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205EA9A:
	cmp r5, #4
	bhs _0205EAA0
	b _0205E95A
_0205EAA0:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	beq _0205EAAA
	bl _FreeHEAP_USER
_0205EAAA:
	ldr r0, [sp, #0x20]
	cmp r0, #2
	beq _0205EAB6
	cmp r0, #4
	beq _0205EABC
	b _0205EAC0
_0205EAB6:
	mov r0, #2
	str r0, [sp, #0x68]
	b _0205EACE
_0205EABC:
	mov r0, #1
	str r0, [sp, #0x68]
_0205EAC0:
	ldr r0, [sp, #0x60]
	add r0, r0, #1
	str r0, [sp, #0x60]
_0205EAC6:
	ldr r0, [sp, #0x60]
	cmp r0, #9
	bge _0205EACE
	b _0205E4BC
_0205EACE:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	beq _0205EAD8
	bl _FreeHEAP_USER
_0205EAD8:
	ldr r0, [sp, #0x68]
	add sp, #0xe0
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0205EAE0: .word 0x000001FE
_0205EAE4: .word 0x00001A68
_0205EAE8: .word savedataBlockOffsets
_0205EAEC: .word savedataBlockSizes
_0205EAF0: .word SaveGame__ClearCallbacks
_0205EAF4: .word _02110DDC
	thumb_func_end SaveGame__LoadData2