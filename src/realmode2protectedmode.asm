;cpu real mode to protected mode
;last update : 2022-1-10

;=====================================

DESC_G_4K   EQU 1_0_0_0_0000_0_00_0_0000_00000000B
DESC_DB_32  EQU 0_1_0_0_0000_0_00_0_0000_00000000B
DESC_L_32   EQU 0_0_0_0_0000_0_00_0_0000_00000000B
DESC_L_64   EQU 0_0_1_0_0000_0_00_0_0000_00000000B
DESC_AVL    EQU 0_0_0_0_0000_0_00_0_0000_00000000B
DESC_P      EQU 1_00_0_0000_00000000B
DESC_DPL    EQU 00_0_0000_00000000B
DESC_S_F    EQU 1_0000_00000000B
DESC_S_T    EQU 0_0000_00000000B
TI_GDT EQU 000b
TI_LDT EQU 100b

RPL_0 EQU 00B
RPL_1 EQU 01B
RPL_2 EQU 10B
RPL_3 EQU 11B

;descriptor limit hight 4bit mask
LIMIT_HIGHT_4_MASK EQU 0xF0000
;descriptor limit low 16 bit mask
LIMIT_LOW_16_MASK   EQU 0x0FFFF

ADDR_HIGHT_8_MASK EQU 0xFF000000
ADDR_MID_8_MASK   EQU 0x00FF0000
ADDR_LOW_16_MASK  EQU 0x0000FFFF


;=====[code descriptor]======
;code's descriptor base address
DESC_CODE_BASE_ADDR EQU 0x00000000
;code's descriptor limit
DESC_CODE_LIMIT EQU 0xFFFFF

DESC_CODE_LIMIT_HIGH_4 EQU (DESC_CODE_LIMIT & LIMIT_HIGHT_4_MASK)>>16

DESC_CODE_LIMIT_LOW_16 EQU DESC_CODE_LIMIT & LIMIT_LOW_16_MASK

DESC_CODE_ADDR_HIGHT_8 EQU (DESC_CODE_BASE_ADDR & ADDR_HIGHT_8_MASK)>>24

DESC_CODE_ADDR_MID_8   EQU (DESC_CODE_BASE_ADDR & ADDR_MID_8_MASK)>>16

DESC_CODE_ADDR_LOW_16   EQU DESC_CODE_BASE_ADDR & ADDR_LOW_16_MASK

DESC_CODE_TYPE         EQU 1000_00000000B
;==================================================================================================================================
;=| addr's high 8bit | G | D/B | L | AVL | code limit's high 4bit | P | DPL | is system segment | desc's type | addr's mid 8 bit |=
;==================================================================================================================================
;                                                                    1   01           1             1000          0000 0000
DESC_CODE_HIGHT_32    EQU  (DESC_CODE_ADDR_HIGHT_8<<24) + DESC_G_4K + DESC_DB_32 + DESC_L_32 + DESC_AVL + (DESC_CODE_LIMIT_HIGH_4<<16) + DESC_P + DESC_DPL + DESC_S_F + DESC_CODE_TYPE + DESC_CODE_ADDR_MID_8

;00000000_1_1_0_0_1111_1_10_1_1000_00000000b

;=====[end code discriptor]===== 

;=====[data discriptor]=====
DESC_DATA_BASE_ADDR EQU 0
DESC_DATA_LIMIT EQU 0xFFFFF
DESC_DATA_LIMIT_HIGHT_4 EQU (DESC_DATA_LIMIT  & LIMIT_HIGHT_4_MASK) >>16
DESC_DATA_LIMIT_LOW_16  EQU  DESC_DATA_LIMIT & LIMIT_LOW_16_MASK
DESC_DATA_ADDR_HIGHT_8  EQU (DESC_DATA_BASE_ADDR & ADDR_HIGHT_8_MASK)>>24
DESC_DATA_ADDR_MID_8    EQU (DESC_DATA_BASE_ADDR & ADDR_MID_8_MASK)>>16
DESC_DATA_ADDR_LOW_16   EQU DESC_DATA_BASE_ADDR & ADDR_LOW_16_MASK
DESC_DATA_TYPE EQU 0010_00000000B

DESC_DATA_HIGT_32 EQU (DESC_DATA_ADDR_HIGHT_8<<24) + DESC_G_4K + DESC_DB_32 + DESC_L_32 + DESC_AVL + (DESC_DATA_LIMIT_HIGHT_4<<16) + DESC_P + DESC_DPL + DESC_S_F + DESC_DATA_TYPE + DESC_DATA_ADDR_MID_8

;=====[end data discriptor]=====

;=====[video discriptor]=====
DESC_VIDEO_BASE_ADDR EQU 0x000B8000
DESC_VIDEO_LIMIT EQU ((0xBFFFF - 0xB8000)/4096);4k
DESC_VIDEO_LIMIT_HIGHT_4 EQU (DESC_VIDEO_LIMIT  & LIMIT_HIGHT_4_MASK)>>16
DESC_VIDEO_LIMIT_LOW_16  EQU  DESC_VIDEO_LIMIT & LIMIT_LOW_16_MASK
DESC_VIDEO_ADDR_HIGHT_8 EQU (DESC_VIDEO_BASE_ADDR & ADDR_HIGHT_8_MASK)>>24
DESC_VIDEO_ADDR_MID_8   EQU (DESC_VIDEO_BASE_ADDR & ADDR_MID_8_MASK)>>16
DESC_VIDEO_ADDR_LOW_16  EQU DESC_VIDEO_BASE_ADDR & ADDR_LOW_16_MASK
DESC_VIDEO_TYPE EQU 0010_00000000B
DESC_VIDEO_HIGT_32 EQU (DESC_VIDEO_ADDR_HIGHT_8<<24) + DESC_G_4K + DESC_DB_32 + DESC_L_32 + DESC_AVL + (DESC_VIDEO_LIMIT_HIGHT_4<<16) + DESC_P + DESC_DPL + DESC_S_F + DESC_VIDEO_TYPE + DESC_VIDEO_ADDR_MID_8

;=====[end video discriptor]=====

GDT_BASE_ADDR:
    dd 0
    dd 0    
GDT_DESC_CODE:;(DESC_CODE_ADDR_LOW_16<<16)
    dd  (DESC_CODE_ADDR_LOW_16<<16)+ DESC_CODE_LIMIT_LOW_16
    dd DESC_CODE_HIGHT_32

GDT_DESC_DATA:
    dd (DESC_DATA_ADDR_LOW_16<<16) + DESC_DATA_LIMIT_LOW_16
    dd DESC_DATA_HIGT_32
GDT_DESC_VIDEO:
    dd (DESC_VIDEO_ADDR_LOW_16<<16) + DESC_VIDEO_LIMIT_LOW_16 ;0x80000007;
    dd DESC_VIDEO_HIGT_32

GDT_SIZE EQU $-GDT_BASE_ADDR
GDT_LIMIT EQU GDT_SIZE-1

selector_code EQU (0x0001<<3) + RPL_0 + TI_GDT
selector_data EQU (0x0002<<3) + RPL_0 + TI_GDT
selector_video EQU (0x0003<<3) + RPL_0 + TI_GDT

;open 20a

gdt_ptr dw GDT_LIMIT
        dd GDT_BASE_ADDR

loader_start:
in al,0x92
or al,0000_0010b
out 0x92,al
;load gdt
lgdt [gdt_ptr]
; set cr0 reg first bit to 1
mov eax,cr0
or eax,1
mov cr0,eax

jmp dword selector_code:mode_start

[bits 32]
mode_start:
    mov ax,selector_data
    mov ds,ax,
    mov es,ax,
    mov ss,ax,
    mov esp,0x500
    mov ax,selector_video
    mov gs,ax

    mov byte [gs:160],'p' 

    jmp $

