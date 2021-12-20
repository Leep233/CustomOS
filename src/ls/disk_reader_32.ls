     1                                  ;// 按两字节 读取硬盘
     2                                  ;// sp:读取内容后需要加载到的内存
     3                                  ;// cl: 读取的扇区数量
     4                                  ;// eax:LBA模式下 最开始读取的扇区下标
     5                                  read_disk_16:
     6                                     ; //保存需要加载到的地址
     7 00000000 54                          push sp
     8 00000001 51                          push cx
     9 00000002 6650                        push eax
    10                                     ; //保存需要读取的扇区数
    11                                    
    12                                     ; //写入需要读取的扇区数量
    13 00000004 BAF201                      mov dx,0x1F2
    14 00000007 89C8                        mov ax,cx
    15 00000009 EE                          out dx,al
    16                                  
    17 0000000A 6658                        pop eax
    18                                  
    19                                      ;//lba模式低8bit
    20 0000000C BAF301                      mov dx,0x1F3
    21 0000000F EE                          out dx,al
    22                                  
    23                                      ;//lba模式中8bit
    24 00000010 B90800                      mov cx,8
    25                                  
    26 00000013 BAF401                      mov dx,0x1F4
    27 00000016 66D3E8                      shr eax,cl
    28 00000019 EE                          out dx,al
    29                                  
    30 0000001A BAF501                      mov dx,0x1F5
    31 0000001D 66D3E8                      shr eax,cl
    32 00000020 EE                          out dx,al
    33                                  
    34 00000021 66D3E8                      shr eax,cl
    35 00000024 240F                        and al,0x0F
    36 00000026 0CE0                        or al,0xE0
    37 00000028 BAF601                      mov dx,0x1F6
    38 0000002B EE                          out dx,al
    39                                      
    40 0000002C BAF701                      mov dx,0x1F7
    41 0000002F B82000                      mov ax,0x20
    42 00000032 EE                          out dx,al
    43                                  
    44                                      ;//未准备好读取
    45                                      _noready_read:
    46 00000033 90                              nop
    47 00000034 EC                              in al,dx
    48 00000035 2488                            and al,1000_1000b
    49 00000037 3C08                            cmp al,0x08
    50 00000039 75F8                            jnz _noready_read
    51                                           
    52                                      ;//准备好读取
    53                                      _ready_read:
    54 0000003B 59                              pop cx    
    55                                  
    56                                         ; //计算循环次数 由于每次可读取2byte 所以  循环次数 = 读取扇区数量 * 256
    57 0000003C B80001                          mov ax,256
    58 0000003F F7E1                            mul cx
    59 00000041 89C1                            mov cx,ax
    60                                  
    61 00000043 BAF001                          mov dx,0x1f0
    62                                      
    63                                      ;//读取数据
    64                                      _read_data:
    65 00000046 ED                              in ax,dx
    66 00000047 89C4                            mov sp,ax
    67 00000049 83C402                          add sp,2
    68 0000004C E2F8                            loop _read_data
    69                                  
    70 0000004E 5C                          pop sp
    71                                  
    72                                      
    73 0000004F CB                      retf
    74                                  
    75                                  
    76                                  
    77                                  
    78                                  
