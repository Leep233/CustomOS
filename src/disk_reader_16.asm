;// 按两字节 读取硬盘
;// sp:读取内容后需要加载到的内存
;// cl: 读取的扇区数量
;// eax:LBA模式下 最开始读取的扇区下标
read_disk_16:
   ; //保存需要加载到的地址
    push si
    push cx
    push eax
   ; //保存需要读取的扇区数
  
   ; //写入需要读取的扇区数量
    mov dx,0x1F2
    mov ax,cx
    out dx,al

    pop eax

    ;//lba模式低8bit
    mov dx,0x1F3
    out dx,al

    ;//lba模式中8bit
    mov cx,8

    mov dx,0x1F4
    shr eax,cl
    out dx,al

    mov dx,0x1F5
    shr eax,cl
    out dx,al

    shr eax,cl
    and al,0x0F
    or al,0xE0
    mov dx,0x1F6
    out dx,al
    
    mov dx,0x1F7
    mov ax,0x20
    out dx,al

    ;//未准备好读取
    .noready_read:
        nop
        in al,dx
        and al,1000_1000b
        cmp al,0x08
        jnz .noready_read
         
    ;//准备好读取
    .ready_read:
        pop cx    

       ; //计算循环次数 由于每次可读取2byte 所以  循环次数 = 读取扇区数量 * 256
        mov ax,256
        mul cx
        mov cx,ax

        mov dx,0x1f0
    
    ;//读取数据
    .read_data:
        in ax,dx
        mov [si],ax
        add si,2
        loop .read_data

ret





