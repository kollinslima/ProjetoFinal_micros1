#line 1 "F:/Documents/PIC18f45k22/bluetooth_click/mikroC PRO for PIC/EasyPIC7 - PIC18F45K22/BT_Routines.c"


extern const BT_CMD;
extern const BT_AOK;
extern const BT_CONN;
extern const BT_END;
extern char BT_Get_Response();

void BT_Configure() {

 do {
 UART1_Write_Text("$$$");
 Delay_ms(500);
 } while (BT_Get_Response() != BT_CMD);

 do {
 UART1_Write_Text("SN,BlueTooth-Click");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART1_Write_Text("SO,Slave");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART1_Write_Text("SM,0");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART1_Write_Text("SA,1");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART1_Write_Text("SP,1234");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART1_Write_Text("---");
 UART1_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_END);
}
