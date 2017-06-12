
_BT_Configure:

;BT_Routines.c,9 :: 		void  BT_Configure() {
;BT_Routines.c,11 :: 		do {
L_BT_Configure0:
;BT_Routines.c,12 :: 		UART1_Write_Text("$$$");                  // Enter command mode
	MOVLW       ?lstr1_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,13 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure3:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure3
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure3
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure3
	NOP
;BT_Routines.c,14 :: 		} while (BT_Get_Response() != BT_CMD);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_CMD+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure29
	MOVLW       _BT_CMD
	XORWF       R0, 0 
L__BT_Configure29:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure0
;BT_Routines.c,16 :: 		do {
L_BT_Configure4:
;BT_Routines.c,17 :: 		UART1_Write_Text("SN,BlueTooth-Click");   // Name of device
	MOVLW       ?lstr2_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,18 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,19 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure7:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure7
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure7
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure7
	NOP
;BT_Routines.c,20 :: 		} while (BT_Get_Response() != BT_AOK);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_AOK+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure30
	MOVLW       _BT_AOK
	XORWF       R0, 0 
L__BT_Configure30:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure4
;BT_Routines.c,22 :: 		do {
L_BT_Configure8:
;BT_Routines.c,23 :: 		UART1_Write_Text("SO,Slave");             // Extended status string
	MOVLW       ?lstr3_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,24 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,25 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure11:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure11
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure11
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure11
	NOP
;BT_Routines.c,26 :: 		} while (BT_Get_Response() != BT_AOK);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_AOK+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure31
	MOVLW       _BT_AOK
	XORWF       R0, 0 
L__BT_Configure31:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure8
;BT_Routines.c,28 :: 		do {
L_BT_Configure12:
;BT_Routines.c,29 :: 		UART1_Write_Text("SM,0");                 // Set mode (0 = slave, 1 = master, 2 = trigger, 3 = auto, 4 = DTR, 5 = ANY)
	MOVLW       ?lstr4_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,30 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,31 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure15:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure15
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure15
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure15
	NOP
;BT_Routines.c,32 :: 		} while (BT_Get_Response() != BT_AOK);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_AOK+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure32
	MOVLW       _BT_AOK
	XORWF       R0, 0 
L__BT_Configure32:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure12
;BT_Routines.c,34 :: 		do {
L_BT_Configure16:
;BT_Routines.c,35 :: 		UART1_Write_Text("SA,1");                 // Authentication (1 to enable, 0 to disable)
	MOVLW       ?lstr5_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,36 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,37 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure19:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure19
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure19
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure19
	NOP
;BT_Routines.c,38 :: 		} while (BT_Get_Response() != BT_AOK);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_AOK+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure33
	MOVLW       _BT_AOK
	XORWF       R0, 0 
L__BT_Configure33:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure16
;BT_Routines.c,40 :: 		do {
L_BT_Configure20:
;BT_Routines.c,41 :: 		UART1_Write_Text("SP,1234");              // Security pin code (mikroe)
	MOVLW       ?lstr6_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,42 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,43 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure23:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure23
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure23
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure23
	NOP
;BT_Routines.c,44 :: 		} while (BT_Get_Response() != BT_AOK);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_AOK+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure34
	MOVLW       _BT_AOK
	XORWF       R0, 0 
L__BT_Configure34:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure20
;BT_Routines.c,46 :: 		do {
L_BT_Configure24:
;BT_Routines.c,47 :: 		UART1_Write_Text("---");                  // Security pin code (mikroe)
	MOVLW       ?lstr7_BT_Routines+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_BT_Routines+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BT_Routines.c,48 :: 		UART1_Write(13);                          // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BT_Routines.c,49 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_BT_Configure27:
	DECFSZ      R13, 1, 1
	BRA         L_BT_Configure27
	DECFSZ      R12, 1, 1
	BRA         L_BT_Configure27
	DECFSZ      R11, 1, 1
	BRA         L_BT_Configure27
	NOP
;BT_Routines.c,50 :: 		} while (BT_Get_Response() != BT_END);
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       _BT_END+1
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Configure35
	MOVLW       _BT_END
	XORWF       R0, 0 
L__BT_Configure35:
	BTFSS       STATUS+0, 2 
	GOTO        L_BT_Configure24
;BT_Routines.c,51 :: 		}
L_end_BT_Configure:
	RETURN      0
; end of _BT_Configure
