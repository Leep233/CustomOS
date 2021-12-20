     1                                  
     2                                  NOMARL_COLOR EQU 1000_1111B
     3                                  
     4                                  SECTION loader vstart=0x500
     5 00000000 B800B8                      mov ax,0xb800
     6 00000003 8EE0                        mov fs,ax
     7                                  
     8 00000005 64C606000063                mov byte [fs:0x00],'c'
     9 0000000B 64C60601008F                mov byte [fs:0x01],NOMARL_COLOR
    10                                  
    11 00000011 64C60602006F                mov byte [fs:0x02],'o'
    12 00000017 64C60603008F                mov byte [fs:0x03],NOMARL_COLOR
    13                                  
    14 0000001D 64C60604006D                mov byte [fs:0x04],'m'
    15 00000023 64C60605008F                mov byte [fs:0x05],NOMARL_COLOR
    16                                  
    17 00000029 64C606060070                 mov byte [fs:0x06],'p'
    18 0000002F 64C60607008F                mov byte [fs:0x07],NOMARL_COLOR
    19                                  
    20 00000035 64C60608006C                 mov byte [fs:0x08],'l'
    21 0000003B 64C60609008F                mov byte [fs:0x09],NOMARL_COLOR
    22                                  
    23 00000041 64C6060A0065                  mov byte [fs:0x0a],'e'
    24 00000047 64C6060B008F                mov byte [fs:0x0b],NOMARL_COLOR
    25                                  
    26 0000004D 64C6060C0074                  mov byte [fs:0x0c],'t'
    27 00000053 64C6060D008F                mov byte [fs:0x0d],NOMARL_COLOR
    28                                  
    29 00000059 64C6060E0065                  mov byte [fs:0x0e],'e'
    30 0000005F 64C6060F008F                mov byte [fs:0x0f],NOMARL_COLOR
    31                                  
    32 00000065 64C606100064                  mov byte [fs:0x10],'d'
    33 0000006B 64C60611008F                mov byte [fs:0x11],NOMARL_COLOR
    34                                  
    35 00000071 64C606120020                    mov byte [fs:0x12],' '
    36 00000077 64C60613008F                mov byte [fs:0x13],NOMARL_COLOR
    37                                  
    38 0000007D 64C606140021                    mov byte [fs:0x14],'!'
    39 00000083 64C60615008F                mov byte [fs:0x15],NOMARL_COLOR
    40                                  
    41 00000089 EBFE                        jmp $
