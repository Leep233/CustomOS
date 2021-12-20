
section mbr vstart=0x7c00

    mov si,0x500
    mov cx,1
    mov eax,1

 
    jmp read_disk_16

    jmp 0x0000:0x500

     %include ".\src\disk_reader_16.asm"

times 510-($-$$) db 0
db 0x55,0xaa





