package com.example.kollins.bluetooth_micros1;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ToggleButton;

/**
 * Created by kollins on 14/06/17.
 */
public class PortD_Leds extends AppCompatActivity {

    ToggleButton led0;
    ToggleButton led1;
    ToggleButton led2;
    ToggleButton led3;
    ToggleButton led4;
    ToggleButton led5;
    ToggleButton led6;
    ToggleButton led7;

    int status = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.portd_layout);

        led0 = (ToggleButton) findViewById(R.id.btnLed0);
        led1 = (ToggleButton) findViewById(R.id.btnLed1);
        led2 = (ToggleButton) findViewById(R.id.btnLed2);
        led3 = (ToggleButton) findViewById(R.id.btnLed3);
        led4 = (ToggleButton) findViewById(R.id.btnLed4);
        led5 = (ToggleButton) findViewById(R.id.btnLed5);
        led6 = (ToggleButton) findViewById(R.id.btnLed6);
        led7 = (ToggleButton) findViewById(R.id.btnLed7);

        Button finishLED = (Button) findViewById(R.id.finishLED);
        finishLED.setOnClickListener(terminaLED());

        led0.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led0.isChecked()) {
                    status += Math.pow(2,0);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,0);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led1.isChecked()) {
                    status += Math.pow(2,1);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,1);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led2.isChecked()) {
                    status += Math.pow(2,2);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,2);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led3.isChecked()) {
                    status += Math.pow(2,3);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,3);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led4.isChecked()) {
                    status += Math.pow(2,4);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,4);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led5.isChecked()) {
                    status += Math.pow(2,5);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,5);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led6.isChecked()) {
                    status += Math.pow(2,6);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,6);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });

        led7.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (led7.isChecked()) {
                    status += Math.pow(2,7);
                    //status = changeCharInPosition(0, '1', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
                else{
                    status -= Math.pow(2,7);
                    //status = changeCharInPosition(0, '0', status);
                    Comunicacao.setOutputBuffer(convertDecimal(status));
                }
            }
        });
    }

    private View.OnClickListener terminaLED() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Comunicacao.setOutputBuffer("finishLED");
                finish();
            }
        };
    }

    private String convertDecimal(int status) {

        Log.i("Teste", "Conversao: " + String.valueOf(status));
        return String.valueOf(status);
    }

    public String changeCharInPosition(int position, char ch, String str) {
        char[] charArray = str.toCharArray();
        charArray[position] = ch;
        return new String(charArray);
    }

}
