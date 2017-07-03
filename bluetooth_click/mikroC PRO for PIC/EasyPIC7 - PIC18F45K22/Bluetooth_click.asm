
_interrupt:

;Bluetooth_click.c,85 :: 		void interrupt(){
;Bluetooth_click.c,87 :: 		if (TMR0IF_bit) {
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;Bluetooth_click.c,88 :: 		LATD = ~PORTD;
	COMF        PORTD+0, 0 
	MOVWF       LATD+0 
;Bluetooth_click.c,89 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Bluetooth_click.c,90 :: 		TMR0H = reload_TMR0H;
	MOVF        _reload_TMR0H+0, 0 
	MOVWF       TMR0H+0 
;Bluetooth_click.c,91 :: 		TMR0L = reload_TMR0L;
	MOVF        _reload_TMR0L+0, 0 
	MOVWF       TMR0L+0 
;Bluetooth_click.c,92 :: 		}
L_interrupt0:
;Bluetooth_click.c,94 :: 		if (RCIF_bit == 1) {                          // Do we have uart rx interrupt request?
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt1
;Bluetooth_click.c,95 :: 		tmp = UART1_Read();                          // Get received byte
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _tmp+0 
;Bluetooth_click.c,97 :: 		if (CMD_mode){
	MOVF        _CMD_mode+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt2
;Bluetooth_click.c,114 :: 		switch (BT_state) {
	GOTO        L_interrupt3
;Bluetooth_click.c,115 :: 		case  0: {
L_interrupt5:
;Bluetooth_click.c,116 :: 		response = 0;                   // Clear response
	CLRF        _response+0 
;Bluetooth_click.c,117 :: 		if (tmp == 'C')                 // We have 'C', it could be CMD<cr><lf>  or CONN
	MOVF        _tmp+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Bluetooth_click.c,118 :: 		BT_state = 1;                 // Expecting 'M' or 'N'
	MOVLW       1
	MOVWF       _BT_state+0 
L_interrupt6:
;Bluetooth_click.c,119 :: 		if (tmp == 'A')                 // We have 'A', it could be AOK<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;Bluetooth_click.c,120 :: 		BT_state = 11;                // expecting 'O'
	MOVLW       11
	MOVWF       _BT_state+0 
L_interrupt7:
;Bluetooth_click.c,121 :: 		if (tmp == 'E')                 // We have 'E', it could be END<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;Bluetooth_click.c,122 :: 		BT_state = 31;                // expecting 'N'
	MOVLW       31
	MOVWF       _BT_state+0 
L_interrupt8:
;Bluetooth_click.c,123 :: 		break;                          // ...
	GOTO        L_interrupt4
;Bluetooth_click.c,126 :: 		case  1: {
L_interrupt9:
;Bluetooth_click.c,127 :: 		if (tmp == 'M')
	MOVF        _tmp+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;Bluetooth_click.c,128 :: 		BT_state = 2;
	MOVLW       2
	MOVWF       _BT_state+0 
	GOTO        L_interrupt11
L_interrupt10:
;Bluetooth_click.c,129 :: 		else if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;Bluetooth_click.c,130 :: 		BT_state = 22;
	MOVLW       22
	MOVWF       _BT_state+0 
	GOTO        L_interrupt13
L_interrupt12:
;Bluetooth_click.c,132 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt13:
L_interrupt11:
;Bluetooth_click.c,133 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,136 :: 		case  2: {
L_interrupt14:
;Bluetooth_click.c,137 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;Bluetooth_click.c,138 :: 		response = BT_CMD;           // CMD
	MOVLW       1
	MOVWF       _response+0 
;Bluetooth_click.c,139 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,140 :: 		}
	GOTO        L_interrupt16
L_interrupt15:
;Bluetooth_click.c,142 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt16:
;Bluetooth_click.c,143 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,146 :: 		case 11: {
L_interrupt17:
;Bluetooth_click.c,147 :: 		if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt18
;Bluetooth_click.c,148 :: 		BT_state = 12;
	MOVLW       12
	MOVWF       _BT_state+0 
	GOTO        L_interrupt19
L_interrupt18:
;Bluetooth_click.c,150 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt19:
;Bluetooth_click.c,151 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,154 :: 		case 12: {
L_interrupt20:
;Bluetooth_click.c,155 :: 		if (tmp == 'K'){
	MOVF        _tmp+0, 0 
	XORLW       75
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt21
;Bluetooth_click.c,156 :: 		response = BT_AOK;            // AOK
	MOVLW       2
	MOVWF       _response+0 
;Bluetooth_click.c,157 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,158 :: 		}
	GOTO        L_interrupt22
L_interrupt21:
;Bluetooth_click.c,160 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt22:
;Bluetooth_click.c,161 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,164 :: 		case 22: {
L_interrupt23:
;Bluetooth_click.c,165 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt24
;Bluetooth_click.c,166 :: 		BT_state = 23;
	MOVLW       23
	MOVWF       _BT_state+0 
	GOTO        L_interrupt25
L_interrupt24:
;Bluetooth_click.c,168 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt25:
;Bluetooth_click.c,169 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,172 :: 		case 23: {
L_interrupt26:
;Bluetooth_click.c,173 :: 		if (tmp == 'N') {
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt27
;Bluetooth_click.c,174 :: 		response = BT_CONN;           // SlaveCONNECTmikroE
	MOVLW       3
	MOVWF       _response+0 
;Bluetooth_click.c,175 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,176 :: 		responseID = response;
	MOVLW       3
	MOVWF       _responseID+0 
;Bluetooth_click.c,177 :: 		}
L_interrupt27:
;Bluetooth_click.c,178 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,179 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,182 :: 		case 31: {
L_interrupt28:
;Bluetooth_click.c,183 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt29
;Bluetooth_click.c,184 :: 		BT_state = 32;
	MOVLW       32
	MOVWF       _BT_state+0 
	GOTO        L_interrupt30
L_interrupt29:
;Bluetooth_click.c,186 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt30:
;Bluetooth_click.c,187 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,190 :: 		case 32: {
L_interrupt31:
;Bluetooth_click.c,191 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt32
;Bluetooth_click.c,192 :: 		response = BT_END;           // END
	MOVLW       4
	MOVWF       _response+0 
;Bluetooth_click.c,193 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,194 :: 		}
	GOTO        L_interrupt33
L_interrupt32:
;Bluetooth_click.c,196 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt33:
;Bluetooth_click.c,197 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,200 :: 		case 40: {
L_interrupt34:
;Bluetooth_click.c,201 :: 		if (tmp == 13)
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt35
;Bluetooth_click.c,202 :: 		BT_state = 41;
	MOVLW       41
	MOVWF       _BT_state+0 
	GOTO        L_interrupt36
L_interrupt35:
;Bluetooth_click.c,204 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt36:
;Bluetooth_click.c,205 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,208 :: 		case 41: {
L_interrupt37:
;Bluetooth_click.c,209 :: 		if (tmp == 10){
	MOVF        _tmp+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt38
;Bluetooth_click.c,210 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,211 :: 		responseID = response;
	MOVF        _response+0, 0 
	MOVWF       _responseID+0 
;Bluetooth_click.c,212 :: 		}
L_interrupt38:
;Bluetooth_click.c,213 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,214 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,217 :: 		default: {
L_interrupt39:
;Bluetooth_click.c,218 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,219 :: 		break;
	GOTO        L_interrupt4
;Bluetooth_click.c,221 :: 		}
L_interrupt3:
	MOVF        _BT_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt5
	MOVF        _BT_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt9
	MOVF        _BT_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt14
	MOVF        _BT_state+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt17
	MOVF        _BT_state+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt20
	MOVF        _BT_state+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt23
	MOVF        _BT_state+0, 0 
	XORLW       23
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
	MOVF        _BT_state+0, 0 
	XORLW       31
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
	MOVF        _BT_state+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt31
	MOVF        _BT_state+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt34
	MOVF        _BT_state+0, 0 
	XORLW       41
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt37
	GOTO        L_interrupt39
L_interrupt4:
;Bluetooth_click.c,222 :: 		}
	GOTO        L_interrupt40
L_interrupt2:
;Bluetooth_click.c,224 :: 		if (tmp == 13) {
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt41
;Bluetooth_click.c,225 :: 		txt[i] = 0;                            // Puting 0 at the end of the string
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Bluetooth_click.c,226 :: 		DataReady = 1;                         // Data is received
	MOVLW       1
	MOVWF       _DataReady+0 
;Bluetooth_click.c,227 :: 		}
	GOTO        L_interrupt42
L_interrupt41:
;Bluetooth_click.c,229 :: 		txt[i] = tmp;                          // Moving the data received from UART to string txt[]
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
;Bluetooth_click.c,230 :: 		i++;                                   // Increment counter
	INCF        _i+0, 1 
;Bluetooth_click.c,231 :: 		}
L_interrupt42:
;Bluetooth_click.c,232 :: 		RCIF_bit = 0;                            // Disable UART RX interrupt
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Bluetooth_click.c,233 :: 		}
L_interrupt40:
;Bluetooth_click.c,234 :: 		}
L_interrupt1:
;Bluetooth_click.c,235 :: 		}
L_end_interrupt:
L__interrupt80:
	RETFIE      1
; end of _interrupt

_BT_Get_Response:

;Bluetooth_click.c,238 :: 		char BT_Get_Response() {
;Bluetooth_click.c,239 :: 		if (response_rcvd) {
	MOVF        _response_rcvd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_BT_Get_Response43
;Bluetooth_click.c,240 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,241 :: 		return responseID;
	MOVF        _responseID+0, 0 
	MOVWF       R0 
	GOTO        L_end_BT_Get_Response
;Bluetooth_click.c,242 :: 		}
L_BT_Get_Response43:
;Bluetooth_click.c,244 :: 		return 0;
	CLRF        R0 
;Bluetooth_click.c,245 :: 		}
L_end_BT_Get_Response:
	RETURN      0
; end of _BT_Get_Response

_writeLCD:

;Bluetooth_click.c,248 :: 		void writeLCD(char *msg){
;Bluetooth_click.c,250 :: 		int i = 0;
	CLRF        writeLCD_i_L0+0 
	CLRF        writeLCD_i_L0+1 
;Bluetooth_click.c,252 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,254 :: 		while (msg[i] != 0) {
L_writeLCD45:
	MOVF        writeLCD_i_L0+0, 0 
	ADDWF       FARG_writeLCD_msg+0, 0 
	MOVWF       FSR0 
	MOVF        writeLCD_i_L0+1, 0 
	ADDWFC      FARG_writeLCD_msg+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_writeLCD46
;Bluetooth_click.c,255 :: 		Lcd_Chr_CP(msg[i]);       // Displaying the received text on the LCD
	MOVF        writeLCD_i_L0+0, 0 
	ADDWF       FARG_writeLCD_msg+0, 0 
	MOVWF       FSR0 
	MOVF        writeLCD_i_L0+1, 0 
	ADDWFC      FARG_writeLCD_msg+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Bluetooth_click.c,256 :: 		i++;                      // Increment counter
	INFSNZ      writeLCD_i_L0+0, 1 
	INCF        writeLCD_i_L0+1, 1 
;Bluetooth_click.c,257 :: 		}
	GOTO        L_writeLCD45
L_writeLCD46:
;Bluetooth_click.c,258 :: 		}
L_end_writeLCD:
	RETURN      0
; end of _writeLCD

_potencia:

;Bluetooth_click.c,260 :: 		double potencia(int base, int expoente){             //retorna base^expoente
;Bluetooth_click.c,261 :: 		int i = 0;
	CLRF        potencia_i_L0+0 
	CLRF        potencia_i_L0+1 
	MOVLW       0
	MOVWF       potencia_result_L0+0 
	MOVLW       0
	MOVWF       potencia_result_L0+1 
	MOVLW       0
	MOVWF       potencia_result_L0+2 
	MOVLW       127
	MOVWF       potencia_result_L0+3 
;Bluetooth_click.c,264 :: 		for(i = 0; i<expoente; i++){
	CLRF        potencia_i_L0+0 
	CLRF        potencia_i_L0+1 
L_potencia47:
	MOVLW       128
	XORWF       potencia_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_potencia_expoente+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__potencia84
	MOVF        FARG_potencia_expoente+0, 0 
	SUBWF       potencia_i_L0+0, 0 
L__potencia84:
	BTFSC       STATUS+0, 0 
	GOTO        L_potencia48
;Bluetooth_click.c,265 :: 		result *= base;
	MOVF        FARG_potencia_base+0, 0 
	MOVWF       R0 
	MOVF        FARG_potencia_base+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        potencia_result_L0+0, 0 
	MOVWF       R4 
	MOVF        potencia_result_L0+1, 0 
	MOVWF       R5 
	MOVF        potencia_result_L0+2, 0 
	MOVWF       R6 
	MOVF        potencia_result_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       potencia_result_L0+0 
	MOVF        R1, 0 
	MOVWF       potencia_result_L0+1 
	MOVF        R2, 0 
	MOVWF       potencia_result_L0+2 
	MOVF        R3, 0 
	MOVWF       potencia_result_L0+3 
;Bluetooth_click.c,264 :: 		for(i = 0; i<expoente; i++){
	INFSNZ      potencia_i_L0+0, 1 
	INCF        potencia_i_L0+1, 1 
;Bluetooth_click.c,266 :: 		}
	GOTO        L_potencia47
L_potencia48:
;Bluetooth_click.c,268 :: 		return result;
	MOVF        potencia_result_L0+0, 0 
	MOVWF       R0 
	MOVF        potencia_result_L0+1, 0 
	MOVWF       R1 
	MOVF        potencia_result_L0+2, 0 
	MOVWF       R2 
	MOVF        potencia_result_L0+3, 0 
	MOVWF       R3 
;Bluetooth_click.c,269 :: 		}
L_end_potencia:
	RETURN      0
; end of _potencia

_convertToInt:

;Bluetooth_click.c,271 :: 		int convertToInt(char *str){                             //converte a string em inteiro
;Bluetooth_click.c,272 :: 		int conv = 0,i;
	CLRF        convertToInt_conv_L0+0 
	CLRF        convertToInt_conv_L0+1 
;Bluetooth_click.c,273 :: 		int len = strlen(str);
	MOVF        FARG_convertToInt_str+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_convertToInt_str+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       convertToInt_len_L0+0 
	MOVF        R1, 0 
	MOVWF       convertToInt_len_L0+1 
;Bluetooth_click.c,275 :: 		for (i = 0;i<len;i++){
	CLRF        convertToInt_i_L0+0 
	CLRF        convertToInt_i_L0+1 
L_convertToInt50:
	MOVLW       128
	XORWF       convertToInt_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       convertToInt_len_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertToInt86
	MOVF        convertToInt_len_L0+0, 0 
	SUBWF       convertToInt_i_L0+0, 0 
L__convertToInt86:
	BTFSC       STATUS+0, 0 
	GOTO        L_convertToInt51
;Bluetooth_click.c,276 :: 		conv += (str[i] - 48) * potencia(10,(len-1)-i);
	MOVF        convertToInt_i_L0+0, 0 
	ADDWF       FARG_convertToInt_str+0, 0 
	MOVWF       FSR0 
	MOVF        convertToInt_i_L0+1, 0 
	ADDWFC      FARG_convertToInt_str+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       FLOC__convertToInt+4 
	CLRF        FLOC__convertToInt+5 
	MOVLW       0
	SUBWFB      FLOC__convertToInt+5, 1 
	MOVLW       10
	MOVWF       FARG_potencia_base+0 
	MOVLW       0
	MOVWF       FARG_potencia_base+1 
	MOVLW       1
	SUBWF       convertToInt_len_L0+0, 0 
	MOVWF       FARG_potencia_expoente+0 
	MOVLW       0
	SUBWFB      convertToInt_len_L0+1, 0 
	MOVWF       FARG_potencia_expoente+1 
	MOVF        convertToInt_i_L0+0, 0 
	SUBWF       FARG_potencia_expoente+0, 1 
	MOVF        convertToInt_i_L0+1, 0 
	SUBWFB      FARG_potencia_expoente+1, 1 
	CALL        _potencia+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__convertToInt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__convertToInt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__convertToInt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__convertToInt+3 
	MOVF        FLOC__convertToInt+4, 0 
	MOVWF       R0 
	MOVF        FLOC__convertToInt+5, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        FLOC__convertToInt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__convertToInt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__convertToInt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__convertToInt+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__convertToInt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__convertToInt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__convertToInt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__convertToInt+3 
	MOVF        convertToInt_conv_L0+0, 0 
	MOVWF       R0 
	MOVF        convertToInt_conv_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        FLOC__convertToInt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__convertToInt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__convertToInt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__convertToInt+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       convertToInt_conv_L0+0 
	MOVF        R1, 0 
	MOVWF       convertToInt_conv_L0+1 
;Bluetooth_click.c,275 :: 		for (i = 0;i<len;i++){
	INFSNZ      convertToInt_i_L0+0, 1 
	INCF        convertToInt_i_L0+1, 1 
;Bluetooth_click.c,277 :: 		}
	GOTO        L_convertToInt50
L_convertToInt51:
;Bluetooth_click.c,278 :: 		return conv;
	MOVF        convertToInt_conv_L0+0, 0 
	MOVWF       R0 
	MOVF        convertToInt_conv_L0+1, 0 
	MOVWF       R1 
;Bluetooth_click.c,279 :: 		}
L_end_convertToInt:
	RETURN      0
; end of _convertToInt

_main:

;Bluetooth_click.c,282 :: 		void main() {
;Bluetooth_click.c,283 :: 		ANSELC = 0;                   // Configure PORTC pins as digital
	CLRF        ANSELC+0 
;Bluetooth_click.c,284 :: 		ANSELA = 0x01;     //PORTA RA0 COMO ENTRADA ANALOGICA
	MOVLW       1
	MOVWF       ANSELA+0 
;Bluetooth_click.c,285 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;Bluetooth_click.c,287 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Bluetooth_click.c,288 :: 		TRISA = 0x01;      //RA0 como entrada
	MOVLW       1
	MOVWF       TRISA+0 
;Bluetooth_click.c,289 :: 		LATD = 0x00;
	CLRF        LATD+0 
;Bluetooth_click.c,291 :: 		ADC_init();
	CALL        _ADC_Init+0, 0
;Bluetooth_click.c,293 :: 		T0CON = 0x47;            //Timer0 8b prescale 1:256
	MOVLW       71
	MOVWF       T0CON+0 
;Bluetooth_click.c,295 :: 		TMR0H = reload_TMR0H;             //Inicializa timer0
	MOVF        _reload_TMR0H+0, 0 
	MOVWF       TMR0H+0 
;Bluetooth_click.c,296 :: 		TMR0L = reload_TMR0L;
	MOVF        _reload_TMR0L+0, 0 
	MOVWF       TMR0L+0 
;Bluetooth_click.c,298 :: 		GIEH_bit = 1;             //Habilita interrupções
	BSF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;Bluetooth_click.c,300 :: 		TMR0IF_bit = 0;           //Limpa flag timer0
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Bluetooth_click.c,301 :: 		TMR0IE_bit = 1;           //Habilita interrupção timer0
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Bluetooth_click.c,305 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,306 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,307 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,308 :: 		responseID = 0;
	CLRF        _responseID+0 
;Bluetooth_click.c,309 :: 		response = 0;
	CLRF        _response+0 
;Bluetooth_click.c,310 :: 		tmp = 0;
	CLRF        _tmp+0 
;Bluetooth_click.c,311 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,312 :: 		DataReady = 0;
	CLRF        _DataReady+0 
;Bluetooth_click.c,314 :: 		RCIE_bit = 1;                 // Enable UART RX interrupt
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Bluetooth_click.c,315 :: 		PEIE_bit = 1;                 // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Bluetooth_click.c,316 :: 		GIE_bit  = 1;                 // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,318 :: 		Lcd_Init();                   // Lcd Init
	CALL        _Lcd_Init+0, 0
;Bluetooth_click.c,319 :: 		UART1_init(115200);           // Initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       68
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Bluetooth_click.c,320 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,321 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Turn cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,324 :: 		Lcd_Out(1,1,"Projeto Final");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,325 :: 		Delay_ms(1500);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main53:
	DECFSZ      R13, 1, 1
	BRA         L_main53
	DECFSZ      R12, 1, 1
	BRA         L_main53
	DECFSZ      R11, 1, 1
	BRA         L_main53
	NOP
	NOP
;Bluetooth_click.c,327 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,328 :: 		Lcd_Out(1,1,"Conectanto...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,329 :: 		Delay_ms(1500);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main54:
	DECFSZ      R13, 1, 1
	BRA         L_main54
	DECFSZ      R12, 1, 1
	BRA         L_main54
	DECFSZ      R11, 1, 1
	BRA         L_main54
	NOP
	NOP
;Bluetooth_click.c,332 :: 		BT_Configure();
	CALL        _BT_Configure+0, 0
;Bluetooth_click.c,335 :: 		while (BT_Get_Response() != BT_CONN);
L_main55:
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main88
	MOVLW       3
	XORWF       R0, 0 
L__main88:
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
	GOTO        L_main55
L_main56:
;Bluetooth_click.c,337 :: 		Lcd_Cmd(_LCD_CLEAR);          //  Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,338 :: 		CMD_mode = 0;
	CLRF        _CMD_mode+0 
;Bluetooth_click.c,339 :: 		GIE_bit = 0;                  // Disable Global interrupt
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,340 :: 		DataReady = 0;                // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,342 :: 		LCD_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,343 :: 		Lcd_Out(1,1,"Conectado!");    // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,344 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main57:
	DECFSZ      R13, 1, 1
	BRA         L_main57
	DECFSZ      R12, 1, 1
	BRA         L_main57
	DECFSZ      R11, 1, 1
	BRA         L_main57
;Bluetooth_click.c,348 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,349 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,350 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,352 :: 		while (1) {
L_main58:
;Bluetooth_click.c,353 :: 		i = 0;                      // Initialize counter
	CLRF        _i+0 
;Bluetooth_click.c,355 :: 		memset(txt, 0, 16);         // Clear array of chars
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
;Bluetooth_click.c,356 :: 		GIE_bit = 1;                // Interrupts allowed
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,358 :: 		while (!DataReady);          // Wait while the data is received
L_main60:
	MOVF        _DataReady+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main61
	GOTO        L_main60
L_main61:
;Bluetooth_click.c,360 :: 		GIE_bit  = 0;               // Interrupts forbiden
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,361 :: 		DataReady = 0;              // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,364 :: 		if(!memcmp(txt,voltimetro,1)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _voltimetro+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_voltimetro+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       1
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
;Bluetooth_click.c,365 :: 		porta_ad = 1;
	MOVLW       1
	MOVWF       _porta_ad+0 
	MOVLW       0
	MOVWF       _porta_ad+1 
;Bluetooth_click.c,366 :: 		writeLCD(txt);
	MOVLW       _txt+0
	MOVWF       FARG_writeLCD_msg+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_writeLCD_msg+1 
	CALL        _writeLCD+0, 0
;Bluetooth_click.c,367 :: 		}
	GOTO        L_main63
L_main62:
;Bluetooth_click.c,368 :: 		else if(!memcmp(txt,leds,1)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _leds+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_leds+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       1
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main64
;Bluetooth_click.c,369 :: 		LATD = 0x00;
	CLRF        LATD+0 
;Bluetooth_click.c,370 :: 		portd_led = 1;
	MOVLW       1
	MOVWF       _portd_led+0 
	MOVLW       0
	MOVWF       _portd_led+1 
;Bluetooth_click.c,371 :: 		writeLCD(txt);
	MOVLW       _txt+0
	MOVWF       FARG_writeLCD_msg+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_writeLCD_msg+1 
	CALL        _writeLCD+0, 0
;Bluetooth_click.c,372 :: 		}
	GOTO        L_main65
L_main64:
;Bluetooth_click.c,373 :: 		else if(!memcmp(txt,timer,1)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _timer+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       1
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
;Bluetooth_click.c,374 :: 		timer_selected = 1;
	MOVLW       1
	MOVWF       _timer_selected+0 
	MOVLW       0
	MOVWF       _timer_selected+1 
;Bluetooth_click.c,375 :: 		T0CON = 0xC7;
	MOVLW       199
	MOVWF       T0CON+0 
;Bluetooth_click.c,376 :: 		writeLCD(txt);
	MOVLW       _txt+0
	MOVWF       FARG_writeLCD_msg+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_writeLCD_msg+1 
	CALL        _writeLCD+0, 0
;Bluetooth_click.c,377 :: 		}
	GOTO        L_main67
L_main66:
;Bluetooth_click.c,378 :: 		else if(!memcmp(txt,finishLED,7)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _finishLED+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_finishLED+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       7
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main68
;Bluetooth_click.c,379 :: 		portd_led = 0;
	CLRF        _portd_led+0 
	CLRF        _portd_led+1 
;Bluetooth_click.c,380 :: 		LATD = 0x00;
	CLRF        LATD+0 
;Bluetooth_click.c,381 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,382 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,383 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,384 :: 		}
	GOTO        L_main69
L_main68:
;Bluetooth_click.c,385 :: 		else if(!memcmp(txt,finishVOLT,7)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _finishVOLT+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_finishVOLT+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       7
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main70
;Bluetooth_click.c,386 :: 		porta_ad = 0;
	CLRF        _porta_ad+0 
	CLRF        _porta_ad+1 
;Bluetooth_click.c,387 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,388 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,389 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,390 :: 		}
	GOTO        L_main71
L_main70:
;Bluetooth_click.c,391 :: 		else if(!memcmp(txt,finishTIMER,7)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _finishTIMER+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_finishTIMER+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       7
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main72
;Bluetooth_click.c,392 :: 		T0CON = 0x47;
	MOVLW       71
	MOVWF       T0CON+0 
;Bluetooth_click.c,393 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,394 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,395 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,396 :: 		}
	GOTO        L_main73
L_main72:
;Bluetooth_click.c,399 :: 		if(porta_ad){
	MOVF        _porta_ad+0, 0 
	IORWF       _porta_ad+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main74
;Bluetooth_click.c,400 :: 		unsigned int read = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;Bluetooth_click.c,401 :: 		read = ((read*33.0)/1023) * 10;
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       4
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
;Bluetooth_click.c,402 :: 		WordToStr(read,adc_value);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _adc_value+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_adc_value+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Bluetooth_click.c,404 :: 		UART1_Write_Text(adc_value);
	MOVLW       _adc_value+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_adc_value+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_click.c,405 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Bluetooth_click.c,406 :: 		}
	GOTO        L_main75
L_main74:
;Bluetooth_click.c,407 :: 		else if(portd_led){
	MOVF        _portd_led+0, 0 
	IORWF       _portd_led+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main76
;Bluetooth_click.c,408 :: 		LATD = convertToInt(txt);
	MOVLW       _txt+0
	MOVWF       FARG_convertToInt_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_convertToInt_str+1 
	CALL        _convertToInt+0, 0
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Bluetooth_click.c,409 :: 		}
	GOTO        L_main77
L_main76:
;Bluetooth_click.c,410 :: 		else if(timer_selected){
	MOVF        _timer_selected+0, 0 
	IORWF       _timer_selected+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main78
;Bluetooth_click.c,412 :: 		reload_TMR0L =  convertToInt(txt);
	MOVLW       _txt+0
	MOVWF       FARG_convertToInt_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_convertToInt_str+1 
	CALL        _convertToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _reload_TMR0L+0 
	MOVF        R1, 0 
	MOVWF       _reload_TMR0L+1 
;Bluetooth_click.c,413 :: 		}
L_main78:
L_main77:
L_main75:
;Bluetooth_click.c,414 :: 		}
L_main73:
L_main71:
L_main69:
L_main67:
L_main65:
L_main63:
;Bluetooth_click.c,415 :: 		}}
	GOTO        L_main58
L_end_main:
	GOTO        $+0
; end of _main
