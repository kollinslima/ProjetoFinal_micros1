
_interrupt:

;Bluetooth_click.c,72 :: 		void interrupt(){
;Bluetooth_click.c,73 :: 		if (RCIF_bit == 1) {                          // Do we have uart rx interrupt request?
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt0
;Bluetooth_click.c,74 :: 		tmp = UART1_Read();                          // Get received byte
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _tmp+0 
;Bluetooth_click.c,76 :: 		if (CMD_mode){
	MOVF        _CMD_mode+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;Bluetooth_click.c,93 :: 		switch (BT_state) {
	GOTO        L_interrupt2
;Bluetooth_click.c,94 :: 		case  0: {
L_interrupt4:
;Bluetooth_click.c,95 :: 		response = 0;                   // Clear response
	CLRF        _response+0 
;Bluetooth_click.c,96 :: 		if (tmp == 'C')                 // We have 'C', it could be CMD<cr><lf>  or CONN
	MOVF        _tmp+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;Bluetooth_click.c,97 :: 		BT_state = 1;                 // Expecting 'M' or 'N'
	MOVLW       1
	MOVWF       _BT_state+0 
L_interrupt5:
;Bluetooth_click.c,98 :: 		if (tmp == 'A')                 // We have 'A', it could be AOK<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Bluetooth_click.c,99 :: 		BT_state = 11;                // expecting 'O'
	MOVLW       11
	MOVWF       _BT_state+0 
L_interrupt6:
;Bluetooth_click.c,100 :: 		if (tmp == 'E')                 // We have 'E', it could be END<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;Bluetooth_click.c,101 :: 		BT_state = 31;                // expecting 'N'
	MOVLW       31
	MOVWF       _BT_state+0 
L_interrupt7:
;Bluetooth_click.c,102 :: 		break;                          // ...
	GOTO        L_interrupt3
;Bluetooth_click.c,105 :: 		case  1: {
L_interrupt8:
;Bluetooth_click.c,106 :: 		if (tmp == 'M')
	MOVF        _tmp+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
;Bluetooth_click.c,107 :: 		BT_state = 2;
	MOVLW       2
	MOVWF       _BT_state+0 
	GOTO        L_interrupt10
L_interrupt9:
;Bluetooth_click.c,108 :: 		else if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;Bluetooth_click.c,109 :: 		BT_state = 22;
	MOVLW       22
	MOVWF       _BT_state+0 
	GOTO        L_interrupt12
L_interrupt11:
;Bluetooth_click.c,111 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt12:
L_interrupt10:
;Bluetooth_click.c,112 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,115 :: 		case  2: {
L_interrupt13:
;Bluetooth_click.c,116 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt14
;Bluetooth_click.c,117 :: 		response = BT_CMD;           // CMD
	MOVLW       1
	MOVWF       _response+0 
;Bluetooth_click.c,118 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,119 :: 		}
	GOTO        L_interrupt15
L_interrupt14:
;Bluetooth_click.c,121 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt15:
;Bluetooth_click.c,122 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,125 :: 		case 11: {
L_interrupt16:
;Bluetooth_click.c,126 :: 		if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt17
;Bluetooth_click.c,127 :: 		BT_state = 12;
	MOVLW       12
	MOVWF       _BT_state+0 
	GOTO        L_interrupt18
L_interrupt17:
;Bluetooth_click.c,129 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt18:
;Bluetooth_click.c,130 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,133 :: 		case 12: {
L_interrupt19:
;Bluetooth_click.c,134 :: 		if (tmp == 'K'){
	MOVF        _tmp+0, 0 
	XORLW       75
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt20
;Bluetooth_click.c,135 :: 		response = BT_AOK;            // AOK
	MOVLW       2
	MOVWF       _response+0 
;Bluetooth_click.c,136 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,137 :: 		}
	GOTO        L_interrupt21
L_interrupt20:
;Bluetooth_click.c,139 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt21:
;Bluetooth_click.c,140 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,143 :: 		case 22: {
L_interrupt22:
;Bluetooth_click.c,144 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;Bluetooth_click.c,145 :: 		BT_state = 23;
	MOVLW       23
	MOVWF       _BT_state+0 
	GOTO        L_interrupt24
L_interrupt23:
;Bluetooth_click.c,147 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt24:
;Bluetooth_click.c,148 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,151 :: 		case 23: {
L_interrupt25:
;Bluetooth_click.c,152 :: 		if (tmp == 'N') {
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt26
;Bluetooth_click.c,153 :: 		response = BT_CONN;           // SlaveCONNECTmikroE
	MOVLW       3
	MOVWF       _response+0 
;Bluetooth_click.c,154 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,155 :: 		responseID = response;
	MOVLW       3
	MOVWF       _responseID+0 
;Bluetooth_click.c,156 :: 		}
L_interrupt26:
;Bluetooth_click.c,157 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,158 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,161 :: 		case 31: {
L_interrupt27:
;Bluetooth_click.c,162 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt28
;Bluetooth_click.c,163 :: 		BT_state = 32;
	MOVLW       32
	MOVWF       _BT_state+0 
	GOTO        L_interrupt29
L_interrupt28:
;Bluetooth_click.c,165 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt29:
;Bluetooth_click.c,166 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,169 :: 		case 32: {
L_interrupt30:
;Bluetooth_click.c,170 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt31
;Bluetooth_click.c,171 :: 		response = BT_END;           // END
	MOVLW       4
	MOVWF       _response+0 
;Bluetooth_click.c,172 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,173 :: 		}
	GOTO        L_interrupt32
L_interrupt31:
;Bluetooth_click.c,175 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt32:
;Bluetooth_click.c,176 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,179 :: 		case 40: {
L_interrupt33:
;Bluetooth_click.c,180 :: 		if (tmp == 13)
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt34
;Bluetooth_click.c,181 :: 		BT_state = 41;
	MOVLW       41
	MOVWF       _BT_state+0 
	GOTO        L_interrupt35
L_interrupt34:
;Bluetooth_click.c,183 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt35:
;Bluetooth_click.c,184 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,187 :: 		case 41: {
L_interrupt36:
;Bluetooth_click.c,188 :: 		if (tmp == 10){
	MOVF        _tmp+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt37
;Bluetooth_click.c,189 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,190 :: 		responseID = response;
	MOVF        _response+0, 0 
	MOVWF       _responseID+0 
;Bluetooth_click.c,191 :: 		}
L_interrupt37:
;Bluetooth_click.c,192 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,193 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,196 :: 		default: {
L_interrupt38:
;Bluetooth_click.c,197 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,198 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,200 :: 		}
L_interrupt2:
	MOVF        _BT_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt4
	MOVF        _BT_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt8
	MOVF        _BT_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt13
	MOVF        _BT_state+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt16
	MOVF        _BT_state+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt19
	MOVF        _BT_state+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt22
	MOVF        _BT_state+0, 0 
	XORLW       23
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
	MOVF        _BT_state+0, 0 
	XORLW       31
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt27
	MOVF        _BT_state+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt30
	MOVF        _BT_state+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
	MOVF        _BT_state+0, 0 
	XORLW       41
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt36
	GOTO        L_interrupt38
L_interrupt3:
;Bluetooth_click.c,201 :: 		}
	GOTO        L_interrupt39
L_interrupt1:
;Bluetooth_click.c,203 :: 		if (tmp == 13) {
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt40
;Bluetooth_click.c,204 :: 		txt[i] = 0;                            // Puting 0 at the end of the string
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Bluetooth_click.c,205 :: 		DataReady = 1;                         // Data is received
	MOVLW       1
	MOVWF       _DataReady+0 
;Bluetooth_click.c,206 :: 		}
	GOTO        L_interrupt41
L_interrupt40:
;Bluetooth_click.c,208 :: 		txt[i] = tmp;                          // Moving the data received from UART to string txt[]
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _tmp+0, 0 
	MOVWF       POSTINC1+0 
;Bluetooth_click.c,209 :: 		i++;                                   // Increment counter
	INCF        _i+0, 1 
;Bluetooth_click.c,210 :: 		}
L_interrupt41:
;Bluetooth_click.c,211 :: 		RCIF_bit = 0;                            // Disable UART RX interrupt
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Bluetooth_click.c,212 :: 		}
L_interrupt39:
;Bluetooth_click.c,213 :: 		}
L_interrupt0:
;Bluetooth_click.c,214 :: 		}
L_end_interrupt:
L__interrupt61:
	RETFIE      1
; end of _interrupt

_BT_Get_Response:

;Bluetooth_click.c,217 :: 		char BT_Get_Response() {
;Bluetooth_click.c,218 :: 		if (response_rcvd) {
	MOVF        _response_rcvd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_BT_Get_Response42
;Bluetooth_click.c,219 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,220 :: 		return responseID;
	MOVF        _responseID+0, 0 
	MOVWF       R0 
	GOTO        L_end_BT_Get_Response
;Bluetooth_click.c,221 :: 		}
L_BT_Get_Response42:
;Bluetooth_click.c,223 :: 		return 0;
	CLRF        R0 
;Bluetooth_click.c,224 :: 		}
L_end_BT_Get_Response:
	RETURN      0
; end of _BT_Get_Response

_portD_handle:

;Bluetooth_click.c,226 :: 		void portD_handle(){
;Bluetooth_click.c,228 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;Bluetooth_click.c,229 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Bluetooth_click.c,230 :: 		LATD = 0xFF;
	MOVLW       255
	MOVWF       LATD+0 
;Bluetooth_click.c,232 :: 		while (1) {
L_portD_handle44:
;Bluetooth_click.c,233 :: 		i = 0;                      // Initialize counter
	CLRF        _i+0 
;Bluetooth_click.c,235 :: 		memset(txt, 0, 16);         // Clear array of chars
	MOVLW       _txt+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       16
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;Bluetooth_click.c,236 :: 		GIE_bit = 1;                // Interrupts allowed
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,238 :: 		while (!DataReady);          // Wait while the data is received
L_portD_handle46:
	MOVF        _DataReady+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_portD_handle47
	GOTO        L_portD_handle46
L_portD_handle47:
;Bluetooth_click.c,240 :: 		GIE_bit  = 0;               // Interrupts forbiden
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,241 :: 		DataReady = 0;              // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,243 :: 		LATD = 0x00;
	CLRF        LATD+0 
;Bluetooth_click.c,245 :: 		}
	GOTO        L_portD_handle44
;Bluetooth_click.c,248 :: 		}
L_end_portD_handle:
	RETURN      0
; end of _portD_handle

_main:

;Bluetooth_click.c,250 :: 		void main() {
;Bluetooth_click.c,251 :: 		ANSELC = 0;                   // Configure PORTC pins as digital
	CLRF        ANSELC+0 
;Bluetooth_click.c,254 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,255 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,256 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,257 :: 		responseID = 0;
	CLRF        _responseID+0 
;Bluetooth_click.c,258 :: 		response = 0;
	CLRF        _response+0 
;Bluetooth_click.c,259 :: 		tmp = 0;
	CLRF        _tmp+0 
;Bluetooth_click.c,260 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,261 :: 		DataReady = 0;
	CLRF        _DataReady+0 
;Bluetooth_click.c,263 :: 		RCIE_bit = 1;                 // Enable UART RX interrupt
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Bluetooth_click.c,264 :: 		PEIE_bit = 1;                 // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Bluetooth_click.c,265 :: 		GIE_bit  = 1;                 // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,267 :: 		Lcd_Init();                   // Lcd Init
	CALL        _Lcd_Init+0, 0
;Bluetooth_click.c,268 :: 		UART1_init(115200);           // Initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       68
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Bluetooth_click.c,269 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,270 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Turn cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,273 :: 		Lcd_Out(1,1,"Projeto Final");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,274 :: 		Delay_ms(1500);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main48:
	DECFSZ      R13, 1, 1
	BRA         L_main48
	DECFSZ      R12, 1, 1
	BRA         L_main48
	DECFSZ      R11, 1, 1
	BRA         L_main48
	NOP
	NOP
;Bluetooth_click.c,276 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,277 :: 		Lcd_Out(1,1,"Connecting!");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,278 :: 		Lcd_Out(2,1,"Please, wait...");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,279 :: 		Delay_ms(1500);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main49:
	DECFSZ      R13, 1, 1
	BRA         L_main49
	DECFSZ      R12, 1, 1
	BRA         L_main49
	DECFSZ      R11, 1, 1
	BRA         L_main49
	NOP
	NOP
;Bluetooth_click.c,282 :: 		BT_Configure();
	CALL        _BT_Configure+0, 0
;Bluetooth_click.c,285 :: 		while (BT_Get_Response() != BT_CONN);
L_main50:
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       3
	XORWF       R0, 0 
L__main65:
	BTFSC       STATUS+0, 2 
	GOTO        L_main51
	GOTO        L_main50
L_main51:
;Bluetooth_click.c,287 :: 		Lcd_Cmd(_LCD_CLEAR);          //  Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,288 :: 		CMD_mode = 0;
	CLRF        _CMD_mode+0 
;Bluetooth_click.c,289 :: 		GIE_bit = 0;                  // Disable Global interrupt
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,290 :: 		DataReady = 0;                // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,292 :: 		LCD_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,293 :: 		Lcd_Out(1,1,"Connected!");    // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,294 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main52:
	DECFSZ      R13, 1, 1
	BRA         L_main52
	DECFSZ      R12, 1, 1
	BRA         L_main52
	DECFSZ      R11, 1, 1
	BRA         L_main52
;Bluetooth_click.c,296 :: 		UART1_Write_Text("Bluetooth Click Connected!");         //  Send message on connection
	MOVLW       ?lstr5_Bluetooth_click+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Bluetooth_click+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_click.c,297 :: 		UART1_Write(13);              // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Bluetooth_click.c,298 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,299 :: 		Lcd_Out(1,1,"Receiving...");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,301 :: 		while (1) {
L_main53:
;Bluetooth_click.c,302 :: 		i = 0;                      // Initialize counter
	CLRF        _i+0 
;Bluetooth_click.c,304 :: 		memset(txt, 0, 16);         // Clear array of chars
	MOVLW       _txt+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       16
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;Bluetooth_click.c,305 :: 		GIE_bit = 1;                // Interrupts allowed
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,307 :: 		while (!DataReady);          // Wait while the data is received
L_main55:
	MOVF        _DataReady+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	GOTO        L_main55
L_main56:
;Bluetooth_click.c,309 :: 		GIE_bit  = 0;               // Interrupts forbiden
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,310 :: 		DataReady = 0;              // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,312 :: 		LCD_Cmd(_LCD_CLEAR);        // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,314 :: 		Lcd_Cmd(_LCD_FIRST_ROW);   // Write in second row
	MOVLW       128
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,315 :: 		i = 0;                      // Reset counter
	CLRF        _i+0 
;Bluetooth_click.c,317 :: 		while (txt[i] != 0) {
L_main57:
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _i+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
;Bluetooth_click.c,318 :: 		Lcd_Chr_CP(txt[i]);       // Displaying the received text on the LCD
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _i+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Bluetooth_click.c,319 :: 		i++;                      // Increment counter
	INCF        _i+0, 1 
;Bluetooth_click.c,320 :: 		}
	GOTO        L_main57
L_main58:
;Bluetooth_click.c,322 :: 		if(!memcmp(txt,portd_selected,5)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _portd_selected+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_portd_selected+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
;Bluetooth_click.c,323 :: 		portD_handle();
	CALL        _portD_handle+0, 0
;Bluetooth_click.c,324 :: 		}
L_main59:
;Bluetooth_click.c,326 :: 		}
	GOTO        L_main53
;Bluetooth_click.c,327 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
