#line 1 "F:/Documents/PIC18f45k22/bluetooth_click/mikroC PRO for PIC/EasyPIC7 - PIC18F45K22/Bluetooth_click.c"
#line 1 "f:/documents/pic18f45k22/bluetooth_click/mikroc pro for pic/easypic7 - pic18f45k22/bt_routines.h"
char BT_Get_Response();
void BT_Configure();
#line 37 "F:/Documents/PIC18f45k22/bluetooth_click/mikroC PRO for PIC/EasyPIC7 - PIC18F45K22/Bluetooth_click.c"
const BT_CMD = 1;
const BT_AOK = 2;
const BT_CONN = 3;
const BT_END = 4;


sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;


char txt[16];
unsigned short i, tmp, DataReady;
char CMD_mode;

char BT_state;
char response_rcvd;
char responseID, response = 0;

char porta_selected[] = "PORTA";
char portb_selected[] = "PORTB";
char portd_selected[] = "PORTD";
char porte_selected[] = "PORTE";


void interrupt(){
 if (RCIF_bit == 1) {
 tmp = UART1_Read();

 if (CMD_mode){
#line 93 "F:/Documents/PIC18f45k22/bluetooth_click/mikroC PRO for PIC/EasyPIC7 - PIC18F45K22/Bluetooth_click.c"
 switch (BT_state) {
 case 0: {
 response = 0;
 if (tmp == 'C')
 BT_state = 1;
 if (tmp == 'A')
 BT_state = 11;
 if (tmp == 'E')
 BT_state = 31;
 break;
 }

 case 1: {
 if (tmp == 'M')
 BT_state = 2;
 else if (tmp == 'O')
 BT_state = 22;
 else
 BT_state = 0;
 break;
 }

 case 2: {
 if (tmp == 'D') {
 response = BT_CMD;
 BT_state = 40;
 }
 else
 BT_state = 0;
 break;
 }

 case 11: {
 if (tmp == 'O')
 BT_state = 12;
 else
 BT_state = 0;
 break;
 }

 case 12: {
 if (tmp == 'K'){
 response = BT_AOK;
 BT_state = 40;
 }
 else
 BT_state = 0;
 break;
 }

 case 22: {
 if (tmp == 'N')
 BT_state = 23;
 else
 BT_state = 0;
 break;
 }

 case 23: {
 if (tmp == 'N') {
 response = BT_CONN;
 response_rcvd = 1;
 responseID = response;
 }
 BT_state = 0;
 break;
 }

 case 31: {
 if (tmp == 'N')
 BT_state = 32;
 else
 BT_state = 0;
 break;
 }

 case 32: {
 if (tmp == 'D') {
 response = BT_END;
 BT_state = 40;
 }
 else
 BT_state = 0;
 break;
 }

 case 40: {
 if (tmp == 13)
 BT_state = 41;
 else
 BT_state = 0;
 break;
 }

 case 41: {
 if (tmp == 10){
 response_rcvd = 1;
 responseID = response;
 }
 BT_state = 0;
 break;
 }

 default: {
 BT_state = 0;
 break;
 }
 }
 }
 else {
 if (tmp == 13) {
 txt[i] = 0;
 DataReady = 1;
 }
 else {
 txt[i] = tmp;
 i++;
 }
 RCIF_bit = 0;
 }
 }
}


char BT_Get_Response() {
 if (response_rcvd) {
 response_rcvd = 0;
 return responseID;
 }
 else
 return 0;
}

void portD_handle(){

 ANSELD = 0;
 TRISD = 0;
 LATD = 0xFF;

 while (1) {
 i = 0;

 memset(txt, 0, 16);
 GIE_bit = 1;

 while (!DataReady);

 GIE_bit = 0;
 DataReady = 0;

 LATD = 0x00;

 }


}

void main() {
 ANSELC = 0;


 CMD_mode = 1;
 BT_state = 0;
 response_rcvd = 0;
 responseID = 0;
 response = 0;
 tmp = 0;
 CMD_mode = 1;
 DataReady = 0;

 RCIE_bit = 1;
 PEIE_bit = 1;
 GIE_bit = 1;

 Lcd_Init();
 UART1_init(115200);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 Lcd_Out(1,1,"Projeto Final");
 Delay_ms(1500);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Connecting!");
 Lcd_Out(2,1,"Please, wait...");
 Delay_ms(1500);


 BT_Configure();


 while (BT_Get_Response() != BT_CONN);

 Lcd_Cmd(_LCD_CLEAR);
 CMD_mode = 0;
 GIE_bit = 0;
 DataReady = 0;

 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Connected!");
 Delay_ms(1000);

 UART1_Write_Text("Bluetooth Click Connected!");
 UART1_Write(13);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Receiving...");

 while (1) {
 i = 0;

 memset(txt, 0, 16);
 GIE_bit = 1;

 while (!DataReady);

 GIE_bit = 0;
 DataReady = 0;

 LCD_Cmd(_LCD_CLEAR);

 Lcd_Cmd(_LCD_FIRST_ROW);
 i = 0;

 while (txt[i] != 0) {
 Lcd_Chr_CP(txt[i]);
 i++;
 }

 if(!memcmp(txt,portd_selected,5)){
 portD_handle();
 }

 }
}