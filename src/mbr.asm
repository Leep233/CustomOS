
section mbr vstart=0x7c00

;clear display
    mov ax,0x0600
    mov bx,0x0700
    mov cx,0
    mov dx,0x184f
    int 0x10

    mov si,0x500
    mov cx,5
    mov eax,1

    jmp read_disk_16

    jmp 0x0000:0x500

    ;jmp $
   
    %include ".\src\disk_reader_16.asm"


    times 510-($-$$) db 0
    
    db 0x55,0xaa





