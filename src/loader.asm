
NOMARL_COLOR EQU 1000_1111B

SECTION loader vstart=0x500
    mov ax,0xb800
    mov fs,ax
    
    
    mov byte [fs:0x00],'c'
    mov byte [fs:0x01],NOMARL_COLOR

    mov byte [fs:0x02],'o'
    mov byte [fs:0x03],NOMARL_COLOR

    mov byte [fs:0x04],'m'
    mov byte [fs:0x05],NOMARL_COLOR

     mov byte [fs:0x06],'p'
    mov byte [fs:0x07],NOMARL_COLOR

     mov byte [fs:0x08],'l'
    mov byte [fs:0x09],NOMARL_COLOR

    mov byte [fs:0x0a],'e'
    mov byte [fs:0x0b],NOMARL_COLOR

      mov byte [fs:0x0c],'t'
    mov byte [fs:0x0d],NOMARL_COLOR

      mov byte [fs:0x0e],'e'
    mov byte [fs:0x0f],NOMARL_COLOR

      mov byte [fs:0x10],'d'
    mov byte [fs:0x11],NOMARL_COLOR

        mov byte [fs:0x12],' '
    mov byte [fs:0x13],NOMARL_COLOR

        mov byte [fs:0x14],'!'
    mov byte [fs:0x15],NOMARL_COLOR

    jmp $