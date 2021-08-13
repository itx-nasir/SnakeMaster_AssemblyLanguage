.model small
.stack 100h
.data

SnakeHead db 2,2,2,2,0,0,0,0,0,0,2,2,2
	      db 2,2,0,14,15,15,15,0,14,0,0,2,2
		  db 2,0,14,15,15,15,15,0,14,14,0,2,2
		  db 0,14,14,14,15,15,15,15,14,14,14,0,2
		  db 0,14,4,14,4,14,14,14,14,14,14,15,0
		  db 14,14,14,4,14,4,14,14,0,2,2,15,2
		  db 14,14,14,14,14,14,14,14,0,2,2,2,2
		  db 14,4,4,4,14,14,14,14,0,0,0,0,0
		  db 14,14,14,14,4,4,4,14,14,14,14,0,2
		  db 14,4,4,4,14,14,14,14,14,0,2,2,2
		  db 0,0,0,0,0,0,0,0,0,0,2,2,2
		  
SnakeTail db 4,4,14,14,4,4,14,14
		  db 14,14,4,4,14,14,4,4
		  db 4,4,14,14,4,4,14,14
		  db 14,14,4,4,14,14,4,4
		  db 4,4,14,14,4,4,14,14
		  db 14,14,4,4,14,14,4,4
		  db 4,4,14,14,4,4,14,14
		  db 14,14,4,4,14,14,4,4
		  
Snakefood db 2,2,2,2,2,0,0,2,2,2,2,2
		  db 2,2,2,2,2,0,0,2,2,2,2,2
		  db 2,2,4,4,4,0,0,4,4,4,2,2
          db 2,4,4,4,4,4,4,4,4,4,4,2
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 4,4,4,4,4,4,4,4,4,4,4,4
		  db 2,4,4,4,4,4,4,4,4,4,4,2
		  db 2,2,4,4,4,4,4,4,4,4,2,2
food_x dw 150,300,400,550,230
food_y dw 250,300,150,230,400
food_var db 5
		  
coordinate_x dw 130,121,112,103,100 DUP(0)
coordinate_y dw 95,98,98,98,100 DUP(0)

hurdle_x dw  0
hurdle_y dw  0
i dw 0
snakesize dw 3
Movx       dw    0
Movy        dw   0

food_row dw 12
food_col dw 12
;snake_xaxis dw 130
;snake_yaxis dw 95
snake_cols dw 13
snake_rows dw 11

;tail_xaxis dw 122
;tail_yaxis dw 98
tail_x1 dw 120
tail_y1 dw 100
tail_rows dw 8
tail_cols dw 8		   

check_x dw 0
check_y dw 0

Score_x dw 43
Score_y dw 3
i1    dw    0
j1     dw    0
Score_var dw 0
col   db    0
row  db    0
num1  dw   0
boxes dw 1

temp5    dw   0

temp_x dw 0
temp_y dw 0
count dw 0
direction dw 'R'
sc db "Score=$"
score_variable dw 1066	
temp dw 0
x db 0
y db 0
j db 20

menu_msg  db  "Start Game,Resume Game,Change Level,High Score,Game History,Exit,$"
menu_temp      dw  0
menu_x0       dw   70
menu_x1       dw   105
menu_y0      dw    60
menu_y1      dw    180
menu_count   db     1
.code
main proc
mov ax,@data
mov ds,ax


mov ah,0h
mov al,12h           ;12h screen
int 10h

mov ah,06h           ;Background color
mov al,0
mov cx,0
mov dh,80
mov dl,80
mov bh,02h
int 10h 

call Menu

mov ah,4ch
int 21h

main endp

;;;;;;;;;;;;;;;;;;;;;;;Menu Proc;;;;;;;;;;;;;;;;;;;;;;;;;
Menu proc

call DrawRec
call DrawMenu
menu_LOOP1:
     call Clear
     call DrawRec
     call DrawMenu
   
	 mov ah,0h
     int 16h
     mov bh,ah
     cmp bh,48h
	  je menu_Up
	 cmp bh,50h
	  je menu_down
	  cmp bh,28d
	   je menu_Enter
	  cmp bh,01h
	   je menu_Exit1
	jmp menu_LOOP1
	   
	   
menu_Up:
mov ah,menu_count
dec ah
cmp ah,0
jle menu_LOOP1
dec menu_count
mov ax,menu_x1
sub ax,menu_x0
mov dx,menu_x0
sub menu_x0,ax
mov menu_x1,dx 
add menu_x0,3
add menu_x1,3

jmp menu_LOOP1	 
menu_down:
mov ah,menu_count
inc ah
cmp ah,6
ja menu_LOOP1
inc menu_count

mov ax,menu_x1
sub ax,menu_x0
mov dx,menu_x1
add menu_x1,ax
mov menu_x0,dx
sub menu_x0,3
sub menu_x1,3

jmp menu_LOOP1
menu_Exit1:
mov ah,4ch
int 21h
menu_Enter:
cmp menu_count,1 
je RunLoop
jmp menu_LOOP1

RunLoop:
call Run
ret
Menu endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Clear Proc;;;;;;;;;;;;;;;;;;;;;;;;
Clear proc



mov ah,0h
mov al,12h           
int 10h

mov ah,06h
mov al,0
mov cx,0
mov dh,80
mov dl,80
mov bh,02h
int 10h 
ret
Clear endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;DrawMenu Proc;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMenu proc
mov bx,offset menu_msg
mov menu_temp,bx
 mov dh,5
 mov si,0
 M_L2:
 mov dl,10
    M_L1:
       mov ah,02h
        mov bh,0
       int 10h
       mov bx,menu_temp
       mov al,[bx+si]
       mov bl,15
       mov cx,1
       mov ah,09h
       int 10h
       add dl,1
       inc si
	   mov bx,menu_temp
	   mov al,[bx+si]
      cmp al,','
      jne M_L1
 inc si	  
 add dh,2
 mov bx,menu_temp
 mov al,[bx+si]
 cmp al,'$'
 jne M_L2
ret
DrawMenu endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Run Proc;;;;;;;;;;;;;;;;;;;;;;;;;
Run Proc

lab:

mov ah,0h
mov al,12h           ;12h screen
int 10h

mov ah,06h           ;Background color
mov al,0
mov cx,0
mov dh,80
mov dl,80
mov bh,02h
int 10h 


call Snake
call Snake_tail
;call Border
call Score
call Create_food
;call Hurdle
mov ah,11h          ;;;;;checking wether key is pressed or not
int 16h
jnz Check_key
back2::

cmp direction,'L'
JE left
cmp direction,'U'
JE up
cmp direction,'D'
JE down

right:           ;;;;;;right
mov si,snakesize
mov ax,2
mul si
mov si,ax
mov ax,coordinate_x[0]
add ax,9

mov cx,snakesize
L:	
	mov bx,coordinate_x[si-2]
	mov coordinate_x[si],bx
	
	mov bx,coordinate_y[si-2]
	mov coordinate_y,bx
	sub si,2
loop L
mov coordinate_x[0],ax

JMP next

left:              ;;;;;;left
mov si,snakesize
mov ax,2
mul si
mov si,ax
mov ax,coordinate_x[0]
sub ax,9

mov cx,snakesize
L1:	
	mov bx,coordinate_x[si-2]
	mov coordinate_x[si],bx
	
	mov dx,coordinate_y[si-2]
	mov coordinate_y,dx
	sub si,2
loop L1
mov coordinate_x[0],ax

JMP next

up:               ;;;;;;;Up
mov si,snakesize
mov ax,2
mul si
mov si,ax
mov ax,coordinate_y[0]
sub ax,9

mov cx,snakesize
L3:	
	mov bx,coordinate_y[si-2]
	mov coordinate_y[si],bx
	
	mov dx,coordinate_x[si-2]
	mov coordinate_x[si],dx
	sub si,2
loop L3
mov coordinate_y[0],ax
JMP next

down:             ;;;;;;;;Down
mov si,snakesize
mov ax,2
mul si
mov si,ax
mov ax,coordinate_y[0]
add ax,9

mov cx,snakesize
L2:	
	mov bx,coordinate_y[si-2]
	mov coordinate_y[si],bx
	
	mov dx,coordinate_x[si-2]
	mov coordinate_x[si],dx
	sub si,2
loop L2
mov coordinate_y[0],ax


next:
mov cx,01h ;;;;;;delay function
mov dx,5000h
mov ah,86h
int 15h

JMP lab
ret
Run endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Check Key;;;;;;;;;;;;;;;;;;;;;;;;
Check_key proc  ;uses ax,bx,cx,dx,si,di    
     mov ah,01h
     int 16h
     mov bh,ah
     mov ah,0ch
     mov al,0
     int 21h
     cmp bh,48h
     je up
     cmp bh,4Bh
     je left
     cmp bh,4Dh
     je right
     cmp bh,50h
     je down
	 cmp bh,27d
	 JE Exit
     ret
up:
cmp direction,'U'
JE back2
mov direction,'U'
sub coordinate_y[0],2
JMP back2

down:
cmp direction,'D'
JE back2
mov direction,'D'
add coordinate_y[0],4

JMP back2

left:
cmp direction,'L'
JE back2
mov direction,'L'
sub coordinate_y[0],2
JMP back2

right:
cmp direction,'R'
JE back2
mov direction,'R'
;sub coordinate_y[0],9
JMP back2


Check_key endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Snake Proc;;;;;;;;;;;;;;;;;;;;;;;;
Snake Proc
mov bx,offset SnakeHead
mov temp5,bx
cmp direction,'R'
je Rightdir

cmp direction,'L'
je Leftdir

cmp direction,'U'
je Updir


Downdir:
mov i1,0
mov cx,coordinate_x[0]
sub cx,3
mov si,0
 LL8:   
     ;mov cx,
   mov dx,coordinate_y[0]
   sub dx,5
   mov j1,0
   LL9:   
      
	  mov bx,temp5
      mov al,[bx+si]
	  mov bh,0
	  mov ah,0ch
      int 10h
	  inc dx
	  inc si
      inc j1
	  mov ax,j1
      cmp ax,snake_cols
      jb LL9 
inc cx	  
 inc i1
 mov ax,i1
cmp ax,snake_rows
jb LL8

ret

Leftdir:
mov i1,0
;mov cx,snake_xaxis
mov dx,coordinate_y[0]
mov si,0
 LL3:   
     mov cx,coordinate_x[0]
   mov j1,0
   LL4:   
      
	  mov bx,temp5
      mov al,[bx+si]
	  mov bh,0
	  mov ah,0ch
      int 10h
	  dec cx
	  inc si
      inc j1
	  mov ax,j1
      cmp ax,snake_cols
      jb LL4 
inc dx	  
 inc i1
 mov ax,i1
cmp ax,snake_rows
jb LL3
ret

updir:
mov i1,0
mov cx,coordinate_x[0]

mov si,0
 LL5:   
   
   mov dx,coordinate_y[0]
   mov j1,0
   LL6:   
      
	  mov bx,temp5
      mov al,[bx+si]
	  mov bh,0
	  mov ah,0ch
      int 10h
	  dec dx
	  inc si
      inc j1
	  mov ax,j1
      cmp ax,snake_cols
      jb LL6 
inc cx	  
 inc i1
 mov ax,i1
cmp ax,snake_rows
jb LL5
ret
Rightdir:
mov i1,0

mov dx,coordinate_y[0]
mov si,0
 LL:   
    mov cx,coordinate_x[0]
 
   mov j1,0
   LL2:   
      
	  mov bx,temp5
      mov al,[bx+si]
	  mov bh,0
	  mov ah,0ch
      int 10h
	  inc cx
	  inc si
      inc j1
	  mov ax,j1
      cmp ax,snake_cols
      jb LL2 
inc dx	  
 inc i1
 mov ax,i1
cmp ax,snake_rows
jb LL	

ret
Snake endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Snake Tail;;;;;;;;;;;;;;;;;;;;;;;;
Snake_tail proc    uses ax bx cx dx
mov di,2
mov bx,offset SnakeTail
push snakesize      

outer:
mov si,0
mov x,0
mov dx,coordinate_y[di]
L:
	mov cx,coordinate_x[di]
	mov tail_cols,8
	L1:
		mov ah,0ch
		mov al,SnakeTail[si]
		int 10h
		inc si
	dec tail_cols
	inc cx
	cmp tail_cols,0
	JNE L1

dec tail_rows	
inc dx
cmp tail_rows,0
JNE L

mov tail_rows,8
mov tail_cols,8

add di,2
dec snakesize
cmp snakesize,0
JNE outer

pop snakesize
ret		
Snake_tail endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Score Proc;;;;;;;;;;;;;;;;;;;;;;;;
Score proc
mov bx,offset sc
mov temp,bx
 mov dh,0
 mov dl,140
 mov si,0
    L1:
       mov ah,02h
        mov bh,0
       int 10h
       mov bx,temp
       mov al,[bx+si]
       mov bl,3
       mov cx,1
       mov ah,09h
       int 10h
       inc dl
       inc si
      cmp si,5
      jbe L1
call Print_Score
ret
Score endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Print Score;;;;;;;;;;;;;;;;;;;;;;;
Print_Score Proc
mov col,146
mov row,0
mov count,0
mov ax,Score_var
mov num1,ax
    countl:
       mov bx,10
       mov ax,num1
       mov dx,0
       div bx
       push dx
       mov num1,ax
       inc count
       cmp ax,0
       jne  countl
       
       
display:
            pop dx
            add dl,48
            mov cl,dl
            mov dl,col
            mov dh,row
            mov ah,02h
            mov bh,0            
            int 10h
            mov al,cl
            mov bl,6
            mov cx,1
            mov ah,09h
            int 10h
	    dec count
            inc col
	    cmp count,0
            jne display
 ret
Print_Score endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;Border Proc;;;;;;;;;;;;;;;;;;;;;;;
Border proc
push menu_x0
push menu_x1
push menu_y0
push menu_y1
mov menu_x0,15
mov menu_x1,20
mov menu_y0,0
mov menu_y1,640	
call DrawRec
;mov menu_x0,15
;mov menu_x1,480
;mov menu_y0,0
;mov menu_y1,15
;call DrawRec
mov menu_x0,475
mov menu_x1,480
mov menu_y0,0
mov menu_y1,640	
call DrawRec
;mov menu_x0,15
;mov menu_x1,480
;mov menu_y0,625
;mov menu_y1,640
;call DrawRec



pop menu_y1
pop menu_y0
pop menu_x1
pop menu_x0	

ret
Border endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;DrawRec Proc;;;;;;;;;;;;;;;;;;;;;;;;;

DrawRec proc
mov dx,menu_x0
R1:
   mov cx,menu_y0
   R2:
    mov bh,0
    mov ah,0ch
    mov al,6
    int 10h
	inc cx
	cmp cx,menu_y1
	jle R2
inc dx
cmp dx,menu_x1
jle R1

ret	
DrawRec endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;Hurdle Proc;;;;;;;;;;;;;;;;;;;;;;;;;
Hurdle proc

push cx
mov cx,hurdle_x
mov dx,hurdle_y
mov check_x,cx
add check_x,4
mov check_y,dx
add check_y,14
L:
	mov cx,hurdle_x
	
	L1:
		mov ah,0ch
		mov al,6
		int 10h
		
		INC cx
	cmp cx,check_x
	JNE L1
	INC dx
cmp dx,check_y
JNE L

add hurdle_y,14
mov cx,hurdle_x
mov dx,hurdle_y

mov check_x,cx
mov check_y,dx
add check_x,18
add check_y,4

L2:
	mov cx,hurdle_x
	
	L3:
		mov ah,0ch
		mov al,6
		int 10h
		INC cx
	cmp cx,check_x
	JNE L3
	INC dx
cmp dx,check_y
JNE L2


ret
Hurdle endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;creating Food;;;;;;;;;;;;;;;;;;;;;;
Create_food proc

call Food

ret
Create_food endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Food proc

mov di,0

outer:
push food_col
push food_row
mov si,0
mov dx,food_y[di]
L:
	mov cx,food_x[di]
	mov food_col,12
	L1:
		mov ah,0ch
		mov al,Snakefood[si]
		int 10h
		inc si
	dec food_col
	inc cx
	cmp food_col,0
	JNE L1
	
dec food_row
inc dx
cmp food_row,0
JNE L

pop food_row
pop food_col

inc di
inc di
dec food_var
cmp food_var,0
JNE outer
mov food_var,5
ret
Food endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;Exit;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Exit:
	.exit
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end main