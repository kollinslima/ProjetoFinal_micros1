
_interrupt:

;Bluetooth_click.c,80 :: 		void interrupt(){
;Bluetooth_click.c,81 :: 		if (RCIF_bit == 1) {                          // Do we have uart rx interrupt request?
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt0
;Bluetooth_click.c,82 :: 		tmp = UART1_Read();                          // Get received byte
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _tmp+0 
;Bluetooth_click.c,84 :: 		if (CMD_mode){
	MOVF        _CMD_mode+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;Bluetooth_click.c,101 :: 		switch (BT_state) {
	GOTO        L_interrupt2
;Bluetooth_click.c,102 :: 		case  0: {
L_interrupt4:
;Bluetooth_click.c,103 :: 		response = 0;                   // Clear response
	CLRF        _response+0 
;Bluetooth_click.c,104 :: 		if (tmp == 'C')                 // We have 'C', it could be CMD<cr><lf>  or CONN
	MOVF        _tmp+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;Bluetooth_click.c,105 :: 		BT_state = 1;                 // Expecting 'M' or 'N'
	MOVLW       1
	MOVWF       _BT_state+0 
L_interrupt5:
;Bluetooth_click.c,106 :: 		if (tmp == 'A')                 // We have 'A', it could be AOK<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Bluetooth_click.c,107 :: 		BT_state = 11;                // expecting 'O'
	MOVLW       11
	MOVWF       _BT_state+0 
L_interrupt6:
;Bluetooth_click.c,108 :: 		if (tmp == 'E')                 // We have 'E', it could be END<cr><lf>
	MOVF        _tmp+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;Bluetooth_click.c,109 :: 		BT_state = 31;                // expecting 'N'
	MOVLW       31
	MOVWF       _BT_state+0 
L_interrupt7:
;Bluetooth_click.c,110 :: 		break;                          // ...
	GOTO        L_interrupt3
;Bluetooth_click.c,113 :: 		case  1: {
L_interrupt8:
;Bluetooth_click.c,114 :: 		if (tmp == 'M')
	MOVF        _tmp+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
;Bluetooth_click.c,115 :: 		BT_state = 2;
	MOVLW       2
	MOVWF       _BT_state+0 
	GOTO        L_interrupt10
L_interrupt9:
;Bluetooth_click.c,116 :: 		else if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;Bluetooth_click.c,117 :: 		BT_state = 22;
	MOVLW       22
	MOVWF       _BT_state+0 
	GOTO        L_interrupt12
L_interrupt11:
;Bluetooth_click.c,119 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt12:
L_interrupt10:
;Bluetooth_click.c,120 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,123 :: 		case  2: {
L_interrupt13:
;Bluetooth_click.c,124 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt14
;Bluetooth_click.c,125 :: 		response = BT_CMD;           // CMD
	MOVLW       1
	MOVWF       _response+0 
;Bluetooth_click.c,126 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,127 :: 		}
	GOTO        L_interrupt15
L_interrupt14:
;Bluetooth_click.c,129 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt15:
;Bluetooth_click.c,130 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,133 :: 		case 11: {
L_interrupt16:
;Bluetooth_click.c,134 :: 		if (tmp == 'O')
	MOVF        _tmp+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt17
;Bluetooth_click.c,135 :: 		BT_state = 12;
	MOVLW       12
	MOVWF       _BT_state+0 
	GOTO        L_interrupt18
L_interrupt17:
;Bluetooth_click.c,137 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt18:
;Bluetooth_click.c,138 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,141 :: 		case 12: {
L_interrupt19:
;Bluetooth_click.c,142 :: 		if (tmp == 'K'){
	MOVF        _tmp+0, 0 
	XORLW       75
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt20
;Bluetooth_click.c,143 :: 		response = BT_AOK;            // AOK
	MOVLW       2
	MOVWF       _response+0 
;Bluetooth_click.c,144 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,145 :: 		}
	GOTO        L_interrupt21
L_interrupt20:
;Bluetooth_click.c,147 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt21:
;Bluetooth_click.c,148 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,151 :: 		case 22: {
L_interrupt22:
;Bluetooth_click.c,152 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;Bluetooth_click.c,153 :: 		BT_state = 23;
	MOVLW       23
	MOVWF       _BT_state+0 
	GOTO        L_interrupt24
L_interrupt23:
;Bluetooth_click.c,155 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt24:
;Bluetooth_click.c,156 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,159 :: 		case 23: {
L_interrupt25:
;Bluetooth_click.c,160 :: 		if (tmp == 'N') {
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt26
;Bluetooth_click.c,161 :: 		response = BT_CONN;           // SlaveCONNECTmikroE
	MOVLW       3
	MOVWF       _response+0 
;Bluetooth_click.c,162 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,163 :: 		responseID = response;
	MOVLW       3
	MOVWF       _responseID+0 
;Bluetooth_click.c,164 :: 		}
L_interrupt26:
;Bluetooth_click.c,165 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,166 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,169 :: 		case 31: {
L_interrupt27:
;Bluetooth_click.c,170 :: 		if (tmp == 'N')
	MOVF        _tmp+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt28
;Bluetooth_click.c,171 :: 		BT_state = 32;
	MOVLW       32
	MOVWF       _BT_state+0 
	GOTO        L_interrupt29
L_interrupt28:
;Bluetooth_click.c,173 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt29:
;Bluetooth_click.c,174 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,177 :: 		case 32: {
L_interrupt30:
;Bluetooth_click.c,178 :: 		if (tmp == 'D') {
	MOVF        _tmp+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt31
;Bluetooth_click.c,179 :: 		response = BT_END;           // END
	MOVLW       4
	MOVWF       _response+0 
;Bluetooth_click.c,180 :: 		BT_state = 40;
	MOVLW       40
	MOVWF       _BT_state+0 
;Bluetooth_click.c,181 :: 		}
	GOTO        L_interrupt32
L_interrupt31:
;Bluetooth_click.c,183 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt32:
;Bluetooth_click.c,184 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,187 :: 		case 40: {
L_interrupt33:
;Bluetooth_click.c,188 :: 		if (tmp == 13)
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt34
;Bluetooth_click.c,189 :: 		BT_state = 41;
	MOVLW       41
	MOVWF       _BT_state+0 
	GOTO        L_interrupt35
L_interrupt34:
;Bluetooth_click.c,191 :: 		BT_state = 0;
	CLRF        _BT_state+0 
L_interrupt35:
;Bluetooth_click.c,192 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,195 :: 		case 41: {
L_interrupt36:
;Bluetooth_click.c,196 :: 		if (tmp == 10){
	MOVF        _tmp+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt37
;Bluetooth_click.c,197 :: 		response_rcvd = 1;
	MOVLW       1
	MOVWF       _response_rcvd+0 
;Bluetooth_click.c,198 :: 		responseID = response;
	MOVF        _response+0, 0 
	MOVWF       _responseID+0 
;Bluetooth_click.c,199 :: 		}
L_interrupt37:
;Bluetooth_click.c,200 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,201 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,204 :: 		default: {
L_interrupt38:
;Bluetooth_click.c,205 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,206 :: 		break;
	GOTO        L_interrupt3
;Bluetooth_click.c,208 :: 		}
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
;Bluetooth_click.c,209 :: 		}
	GOTO        L_interrupt39
L_interrupt1:
;Bluetooth_click.c,211 :: 		if (tmp == 13) {
	MOVF        _tmp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt40
;Bluetooth_click.c,212 :: 		txt[i] = 0;                            // Puting 0 at the end of the string
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;Bluetooth_click.c,213 :: 		DataReady = 1;                         // Data is received
	MOVLW       1
	MOVWF       _DataReady+0 
;Bluetooth_click.c,214 :: 		}
	GOTO        L_interrupt41
L_interrupt40:
;Bluetooth_click.c,216 :: 		txt[i] = tmp;                          // Moving the data received from UART to string txt[]
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
;Bluetooth_click.c,217 :: 		i++;                                   // Increment counter
	INCF        _i+0, 1 
;Bluetooth_click.c,218 :: 		}
L_interrupt41:
;Bluetooth_click.c,219 :: 		RCIF_bit = 0;                            // Disable UART RX interrupt
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Bluetooth_click.c,220 :: 		}
L_interrupt39:
;Bluetooth_click.c,221 :: 		}
L_interrupt0:
;Bluetooth_click.c,222 :: 		}
L_end_interrupt:
L__interrupt70:
	RETFIE      1
; end of _interrupt

_BT_Get_Response:

;Bluetooth_click.c,225 :: 		char BT_Get_Response() {
;Bluetooth_click.c,226 :: 		if (response_rcvd) {
	MOVF        _response_rcvd+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_BT_Get_Response42
;Bluetooth_click.c,227 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,228 :: 		return responseID;
	MOVF        _responseID+0, 0 
	MOVWF       R0 
	GOTO        L_end_BT_Get_Response
;Bluetooth_click.c,229 :: 		}
L_BT_Get_Response42:
;Bluetooth_click.c,231 :: 		return 0;
	CLRF        R0 
;Bluetooth_click.c,232 :: 		}
L_end_BT_Get_Response:
	RETURN      0
; end of _BT_Get_Response

_writeLCD:

;Bluetooth_click.c,235 :: 		void writeLCD(char *msg){
;Bluetooth_click.c,237 :: 		int i = 0;
	CLRF        writeLCD_i_L0+0 
	CLRF        writeLCD_i_L0+1 
;Bluetooth_click.c,239 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,241 :: 		while (msg[i] != 0) {
L_writeLCD44:
	MOVF        writeLCD_i_L0+0, 0 
	ADDWF       FARG_writeLCD_msg+0, 0 
	MOVWF       FSR0 
	MOVF        writeLCD_i_L0+1, 0 
	ADDWFC      FARG_writeLCD_msg+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_writeLCD45
;Bluetooth_click.c,242 :: 		Lcd_Chr_CP(msg[i]);       // Displaying the received text on the LCD
	MOVF        writeLCD_i_L0+0, 0 
	ADDWF       FARG_writeLCD_msg+0, 0 
	MOVWF       FSR0 
	MOVF        writeLCD_i_L0+1, 0 
	ADDWFC      FARG_writeLCD_msg+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Bluetooth_click.c,243 :: 		i++;                      // Increment counter
	INFSNZ      writeLCD_i_L0+0, 1 
	INCF        writeLCD_i_L0+1, 1 
;Bluetooth_click.c,244 :: 		}
	GOTO        L_writeLCD44
L_writeLCD45:
;Bluetooth_click.c,245 :: 		}
L_end_writeLCD:
	RETURN      0
; end of _writeLCD

_potencia:

;Bluetooth_click.c,247 :: 		double potencia(int base, int expoente){
;Bluetooth_click.c,248 :: 		int i = 0;
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
;Bluetooth_click.c,251 :: 		for(i = 0; i<expoente; i++){
	CLRF        potencia_i_L0+0 
	CLRF        potencia_i_L0+1 
L_potencia46:
	MOVLW       128
	XORWF       potencia_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_potencia_expoente+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__potencia74
	MOVF        FARG_potencia_expoente+0, 0 
	SUBWF       potencia_i_L0+0, 0 
L__potencia74:
	BTFSC       STATUS+0, 0 
	GOTO        L_potencia47
;Bluetooth_click.c,252 :: 		result *= base;
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
;Bluetooth_click.c,251 :: 		for(i = 0; i<expoente; i++){
	INFSNZ      potencia_i_L0+0, 1 
	INCF        potencia_i_L0+1, 1 
;Bluetooth_click.c,253 :: 		}
	GOTO        L_potencia46
L_potencia47:
;Bluetooth_click.c,255 :: 		return result;
	MOVF        potencia_result_L0+0, 0 
	MOVWF       R0 
	MOVF        potencia_result_L0+1, 0 
	MOVWF       R1 
	MOVF        potencia_result_L0+2, 0 
	MOVWF       R2 
	MOVF        potencia_result_L0+3, 0 
	MOVWF       R3 
;Bluetooth_click.c,256 :: 		}
L_end_potencia:
	RETURN      0
; end of _potencia

_convertToInt:

;Bluetooth_click.c,258 :: 		int convertToInt(char *str){
;Bluetooth_click.c,259 :: 		int conv = 0,i;
	CLRF        convertToInt_conv_L0+0 
	CLRF        convertToInt_conv_L0+1 
;Bluetooth_click.c,260 :: 		int len = strlen(str);
	MOVF        FARG_convertToInt_str+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_convertToInt_str+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       convertToInt_len_L0+0 
	MOVF        R1, 0 
	MOVWF       convertToInt_len_L0+1 
;Bluetooth_click.c,262 :: 		for (i = 0;i<len;i++){
	CLRF        convertToInt_i_L0+0 
	CLRF        convertToInt_i_L0+1 
L_convertToInt49:
	MOVLW       128
	XORWF       convertToInt_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       convertToInt_len_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convertToInt76
	MOVF        convertToInt_len_L0+0, 0 
	SUBWF       convertToInt_i_L0+0, 0 
L__convertToInt76:
	BTFSC       STATUS+0, 0 
	GOTO        L_convertToInt50
;Bluetooth_click.c,263 :: 		conv += (str[i] - 48) * potencia(10,(len-1)-i);
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
;Bluetooth_click.c,262 :: 		for (i = 0;i<len;i++){
	INFSNZ      convertToInt_i_L0+0, 1 
	INCF        convertToInt_i_L0+1, 1 
;Bluetooth_click.c,264 :: 		}
	GOTO        L_convertToInt49
L_convertToInt50:
;Bluetooth_click.c,265 :: 		return conv;
	MOVF        convertToInt_conv_L0+0, 0 
	MOVWF       R0 
	MOVF        convertToInt_conv_L0+1, 0 
	MOVWF       R1 
;Bluetooth_click.c,266 :: 		}
L_end_convertToInt:
	RETURN      0
; end of _convertToInt

_main:

;Bluetooth_click.c,269 :: 		void main() {
;Bluetooth_click.c,270 :: 		ANSELC = 0;                   // Configure PORTC pins as digital
	CLRF        ANSELC+0 
;Bluetooth_click.c,271 :: 		ANSELA = 0x01;     //PORTA RA0 COMO ENTRADA ANALOGICA
	MOVLW       1
	MOVWF       ANSELA+0 
;Bluetooth_click.c,272 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;Bluetooth_click.c,274 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Bluetooth_click.c,275 :: 		TRISA = 0x01;      //RA0 como entrada
	MOVLW       1
	MOVWF       TRISA+0 
;Bluetooth_click.c,276 :: 		LATD = 0x00;
	CLRF        LATD+0 
;Bluetooth_click.c,278 :: 		ADC_init();
	CALL        _ADC_Init+0, 0
;Bluetooth_click.c,281 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,282 :: 		BT_state = 0;
	CLRF        _BT_state+0 
;Bluetooth_click.c,283 :: 		response_rcvd = 0;
	CLRF        _response_rcvd+0 
;Bluetooth_click.c,284 :: 		responseID = 0;
	CLRF        _responseID+0 
;Bluetooth_click.c,285 :: 		response = 0;
	CLRF        _response+0 
;Bluetooth_click.c,286 :: 		tmp = 0;
	CLRF        _tmp+0 
;Bluetooth_click.c,287 :: 		CMD_mode = 1;
	MOVLW       1
	MOVWF       _CMD_mode+0 
;Bluetooth_click.c,288 :: 		DataReady = 0;
	CLRF        _DataReady+0 
;Bluetooth_click.c,290 :: 		RCIE_bit = 1;                 // Enable UART RX interrupt
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Bluetooth_click.c,291 :: 		PEIE_bit = 1;                 // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Bluetooth_click.c,292 :: 		GIE_bit  = 1;                 // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,294 :: 		Lcd_Init();                   // Lcd Init
	CALL        _Lcd_Init+0, 0
;Bluetooth_click.c,295 :: 		UART1_init(115200);           // Initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       68
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Bluetooth_click.c,296 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,297 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Turn cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,300 :: 		Lcd_Out(1,1,"Projeto Final");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,301 :: 		Delay_ms(1500);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main52:
	DECFSZ      R13, 1, 1
	BRA         L_main52
	DECFSZ      R12, 1, 1
	BRA         L_main52
	DECFSZ      R11, 1, 1
	BRA         L_main52
	NOP
	NOP
;Bluetooth_click.c,303 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,304 :: 		Lcd_Out(1,1,"Conectanto...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,305 :: 		Delay_ms(1500);
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
;Bluetooth_click.c,308 :: 		BT_Configure();
	CALL        _BT_Configure+0, 0
;Bluetooth_click.c,311 :: 		while (BT_Get_Response() != BT_CONN);
L_main54:
	CALL        _BT_Get_Response+0, 0
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main78
	MOVLW       3
	XORWF       R0, 0 
L__main78:
	BTFSC       STATUS+0, 2 
	GOTO        L_main55
	GOTO        L_main54
L_main55:
;Bluetooth_click.c,313 :: 		Lcd_Cmd(_LCD_CLEAR);          //  Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,314 :: 		CMD_mode = 0;
	CLRF        _CMD_mode+0 
;Bluetooth_click.c,315 :: 		GIE_bit = 0;                  // Disable Global interrupt
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,316 :: 		DataReady = 0;                // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,318 :: 		LCD_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,319 :: 		Lcd_Out(1,1,"Conectado!");    // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,320 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main56:
	DECFSZ      R13, 1, 1
	BRA         L_main56
	DECFSZ      R12, 1, 1
	BRA         L_main56
	DECFSZ      R11, 1, 1
	BRA         L_main56
;Bluetooth_click.c,323 :: 		UART1_Write(13);              // CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Bluetooth_click.c,324 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,325 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,326 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,328 :: 		while (1) {
L_main57:
;Bluetooth_click.c,329 :: 		i = 0;                      // Initialize counter
	CLRF        _i+0 
;Bluetooth_click.c,331 :: 		memset(txt, 0, 16);         // Clear array of chars
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
;Bluetooth_click.c,332 :: 		GIE_bit = 1;                // Interrupts allowed
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,334 :: 		while (!DataReady);          // Wait while the data is received
L_main59:
	MOVF        _DataReady+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main60
	GOTO        L_main59
L_main60:
;Bluetooth_click.c,336 :: 		GIE_bit  = 0;               // Interrupts forbiden
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Bluetooth_click.c,337 :: 		DataReady = 0;              // Data not received
	CLRF        _DataReady+0 
;Bluetooth_click.c,340 :: 		if(!memcmp(txt,porta_selected,5)){
	MOVLW       _txt+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _porta_selected+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_porta_selected+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main61
;Bluetooth_click.c,341 :: 		porta_ad = 1;
	MOVLW       1
	MOVWF       _porta_ad+0 
	MOVLW       0
	MOVWF       _porta_ad+1 
;Bluetooth_click.c,342 :: 		writeLCD(txt);
	MOVLW       _txt+0
	MOVWF       FARG_writeLCD_msg+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_writeLCD_msg+1 
	CALL        _writeLCD+0, 0
;Bluetooth_click.c,343 :: 		}
	GOTO        L_main62
L_main61:
;Bluetooth_click.c,344 :: 		else if(!memcmp(txt,portd_selected,5)){
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
	GOTO        L_main63
;Bluetooth_click.c,345 :: 		portd_led = 1;
	MOVLW       1
	MOVWF       _portd_led+0 
	MOVLW       0
	MOVWF       _portd_led+1 
;Bluetooth_click.c,346 :: 		writeLCD(txt);
	MOVLW       _txt+0
	MOVWF       FARG_writeLCD_msg+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_writeLCD_msg+1 
	CALL        _writeLCD+0, 0
;Bluetooth_click.c,347 :: 		}
	GOTO        L_main64
L_main63:
;Bluetooth_click.c,348 :: 		else if(porta_ad){
	MOVF        _porta_ad+0, 0 
	IORWF       _porta_ad+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
;Bluetooth_click.c,349 :: 		unsigned int read = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;Bluetooth_click.c,350 :: 		read = ((read*50.0)/1023) * 10;
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
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
;Bluetooth_click.c,351 :: 		WordToStr(read,adc_value);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _adc_value+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_adc_value+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Bluetooth_click.c,352 :: 		UART1_Write_Text(adc_value);
	MOVLW       _adc_value+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_adc_value+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_click.c,353 :: 		}
	GOTO        L_main66
L_main65:
;Bluetooth_click.c,354 :: 		else if(portd_led){
	MOVF        _portd_led+0, 0 
	IORWF       _portd_led+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main67
;Bluetooth_click.c,355 :: 		LATD = convertToInt(txt);
	MOVLW       _txt+0
	MOVWF       FARG_convertToInt_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_convertToInt_str+1 
	CALL        _convertToInt+0, 0
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Bluetooth_click.c,356 :: 		}
	GOTO        L_main68
L_main67:
;Bluetooth_click.c,358 :: 		portd_led = 0;
	CLRF        _portd_led+0 
	CLRF        _portd_led+1 
;Bluetooth_click.c,359 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_click.c,360 :: 		Lcd_Out(1,1,"Aguardando");  // Display message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,361 :: 		Lcd_Out(2,1,"Comando...");  // Display message
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Bluetooth_click+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Bluetooth_click+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_click.c,362 :: 		}
L_main68:
L_main66:
L_main64:
L_main62:
;Bluetooth_click.c,364 :: 		}
	GOTO        L_main57
;Bluetooth_click.c,365 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
