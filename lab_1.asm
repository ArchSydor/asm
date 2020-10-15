.586
.model flat, stdcall
option casemap :none


include masm32\include\windows.inc
include masm32\include\kernel32.inc
include masm32\include\masm32.inc
include masm32\include\debug.inc
include masm32\include\user32.inc


includelib masm32\lib\kernel32.lib
includelib masm32\lib\masm32.lib
includelib masm32\lib\debug.lib
includelib masm32\lib\user32.lib

.data

 A dd -1, 2, 3, 4, 5 

 K dd 2
 const_c dd -2    
 const_d dd 1 

k_error db 13,10,'Error! K equal or less then zero!',13,10

result dd 0

.code 
start:
    cmp K, 0
    jg kValid
    invoke StdOut, addr k_error
    invoke ExitProcess, 0

    kValid: 

        mov ecx, K
        make_result:
            mov eax, [A+ecx*4-4]
            cmp eax,const_c 
            jge check_smaller_d 

            dec ecx
            cmp ecx, 0
            jnz make_result
            
            check_smaller_d:
            cmp eax,const_d 
            jle check_neg 

            dec ecx
            cmp ecx, 0
            jnz make_result
            
            check_neg:
            cmp eax, 0
            jl num_is_neg

            dec ecx
            cmp ecx, 0
            jnz make_result
            
            num_is_neg:
            add eax, result
            mov result, eax
            dec ecx
            cmp ecx, 0
            jnz make_result

            PrintDec result, "Result"
            invoke ExitProcess, 0

end start
