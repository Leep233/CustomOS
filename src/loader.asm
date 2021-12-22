
NOMARL_COLOR EQU 1000_1111B
SWMP_HEX_FLAG EQU 0x534d4150

ARDS_SIZE EQU 20

SECTION loader vstart=0x500

    total_memory_bytes dd 0

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



    ;jmp $

;检测内存
detect_memory_e820:
    xor ebx,ebx
    mov edx,SWMP_HEX_FLAG   
    mov di,ards_buf

    .get_memory_loop_e820:
        mov eax,0xE820
        mov ecx,ARDS_SIZE ;ards地址范围20字节
        int 0x15
        jc detect_memory_e801 ;如果cf标志位 =1 跳转e801 指令读取
        add di,cx
        inc word [ards_count] ;ards数量+1
        cmp ebx,0  ;如果ebx=0，说明ards 全部返回 
        jnz .get_memory_loop_e820

    mov cx,[ards_count]
    mov ebx,ards_buf
    xor edx,edx

    ;寻找最大的内存区域
    .find_max_memory_area:
        mov eax,[ebx]
        add eax,[ebx+8]
        add ebx,ARDS_SIZE   ;指向下一个ards
        cmp edx,eax
        jge .next_ards
        mov edx,eax
        
        .next_ards:
            loop .find_max_memory_area

        jmp get_memory_finshed



    
detect_memory_e801:
    mov ax,0xe801
    int 0x15
    jc detect_memory_88 ;如果标志为cf=1 那么说明获取失败，使用88 形式获取内存
   ; mov cx,1024 
   ; mul cx   ;也可以写做 shl eax,10
    shl eax,10  ;等同于 eax * 2^10 次方 2^10 = 1024
    shl ebx,16  ; edx 的单位为64kb 所以需要 edx*64kb , 64kb = 2^16 = 左移 16位
    add eax,ebx ;eax * 1024 + ebx * 64 * 1024
    mov edx,eax
    jmp get_memory_finshed

detect_memory_88:
    mov ah,0x88
    int 0x15
    jc detect_memory_error
    shl eax,26
    mov edx,eax
    jmp get_memory_finshed

detect_memory_error:
    jmp $

get_memory_finshed:
    mov [total_memory_bytes],edx

SECTION .data:
    ards_buf times (ARDS_SIZE*12) db 0
    ards_count dw 0