
section .data
  int: db "%d", 0
  scan: db "%d", 0
  print: db "%08x%08x%08x%08x", 10, 0
  num: dd 0
  n1: dd 1
  
section .bss
  result resb 16
  
section .text
  global main
  extern scanf
  extern printf

main:
    mov ebp, esp; for correct debugging
  push ebp                                ;ramka pamieciowa do scanf
  mov ebp, esp
  push num
  push dword scan
  call scanf
  add esp, 8                              ;czyszczenie stosu
  mov esp, ebp
  pop ebp                 
  mov ecx, dword [num]
  movd xmm1,dword [n1]
  
  multiplyloop:
    ;do
    movd xmm2,ecx
    pmuludq xmm1,xmm2
    dec ecx
    cmp ecx, 1
    je end
    jmp multiplyloop
  
end:
  movdqu oword[result],xmm1
  push ebp
  mov ebp, esp
  push dword [result]
  push dword [result+4]
  push dword [result+8]
  push dword [result+12]
  push dword print
  call printf
  add esp, 20
  mov esp, ebp
  pop ebp
  mov eax, 1
  int 0x80