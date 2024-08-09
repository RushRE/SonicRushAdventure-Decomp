	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public _obj_user_rect_man
_obj_user_rect_man: // 0x02139E2C
	.space 0x10 // OBS_RECT_MANAGER

.public _obj_user_flag_nx
_obj_user_flag_nx: // 0x02139E3C
	.space 0x1 * 0x10

.public _obj_user_flag
_obj_user_flag: // 02139E4C
	.space 0x1 * 0x10

.public _obj_user_resist_nx
_obj_user_resist_nx: // 02139E5C
	.space 0x4 * 0x50 // OBS_RECT_WORK*[0x50]

.public _obj_user_resist
_obj_user_resist: // 02139F9C
	.space 0x4 * 0x50 // OBS_RECT_WORK*[0x50]

.public _obj_user_resist_num_nx
_obj_user_resist_num_nx: // 0213A0DC
	.space 0x1 * 0x08

.public _obj_user_resist_num
_obj_user_resist_num: // 0213A0E4
	.space 0x1 * 0x08