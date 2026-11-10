section .data
    ; 1. Команда очистки экрана: ESC [ 2 J
    clear_cmd     db 0x1B, "[2J"
    clear_len     equ $ - clear_cmd

    ; 2. Команда установки цвета: ESC [ 32 ; 44 m (Зеленый текст на синем фоне)
    color_green_blue db 0x1B, "[32;44m"
    color_len1       equ $ - color_green_blue

    ; 3. Команда установки цвета: ESC [ 31 ; 40 m (Красный текст на черном фоне)
    color_red_black  db 0x1B, "[31;40m"
    color_len2       equ $ - color_red_black

    ; 4. Команда сброса цвета: ESC [ 0 m
    reset_color   db 0x1B, "[0m"
    reset_len     equ $ - reset_color

    ; 5. Команды позиционирования курсора: ESC [ Строка ; Столбец H
    cursor_pos1   db 0x1B, "[5;20H"   ; 5 строка, 20 столбец
    cursor_len1   equ $ - cursor_pos1

    cursor_pos2   db 0x1B, "[10;10H"  ; 10 строка, 10 столбец
    cursor_len2   equ $ - cursor_pos2
    
    ; 6. Команда перемещения курсора в самый низ
    exit_pos      db 0x1B, "[15;1H"
    exit_pos_len  equ $ - exit_pos

    ; Текстовые данные для буфера вывода
    msg1 db "=== SYSTEM PROGRAMMING TERMINAL BUFFER ==="
    msg1_len equ $ - msg1

    msg2 db "CRITICAL MONITOR: ACTIVE"
    msg2_len equ $ - msg2

section .text
    global _start

_start:
    ; --- ШАГ 1: Очистка экрана ---
    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    ; --- ШАГ 2: Вывод первой строки ---
    mov rax, 1
    mov rdi, 1
    mov rsi, cursor_pos1
    mov rdx, cursor_len1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, color_green_blue
    mov rdx, color_len1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, msg1_len
    syscall

    ; --- ШАГ 3: Вывод второй строки ---
    mov rax, 1
    mov rdi, 1
    mov rsi, cursor_pos2
    mov rdx, cursor_len2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, color_red_black
    mov rdx, color_len2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2_len
    syscall

    ; --- ШАГ 4: Сброс атрибутов терминала ---
    mov rax, 1
    mov rdi, 1
    mov rsi, reset_color
    mov rdx, reset_len
    syscall

    ; Перемещаем курсор вниз
    mov rax, 1
    mov rdi, 1
    mov rsi, exit_pos
    mov rdx, exit_pos_len
    syscall

    ; --- ШАГ 5: Завершение ---
    mov rax, 60
    xor rdi, rdi
    syscall
