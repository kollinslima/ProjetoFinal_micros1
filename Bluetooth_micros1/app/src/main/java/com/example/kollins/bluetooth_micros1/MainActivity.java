package com.example.kollins.bluetooth_micros1;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;

import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.ParcelUuid;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;

import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

import android.widget.Toast;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Set;
import java.util.concurrent.locks.Lock;

public class MainActivity extends AppCompatActivity {
    Button b1, b2, b3, b4, b5, b6,portD,portA,timer;
    private BluetoothAdapter BA;
    private Set<BluetoothDevice> pairedDevices;
    ListView lv;

    private final byte FINAL = 13;

    public BluetoothSocket socket;
    public Object[] devices;
    public ParcelUuid[] uuids;
    public BluetoothDevice device;
    Thread bluetoothCom;

    public OutputStream outputStream;
    public InputStream inputStream;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        b1 = (Button) findViewById(R.id.button);
        b2 = (Button) findViewById(R.id.button2);
        b4 = (Button) findViewById(R.id.button4);
        b5 = (Button) findViewById(R.id.button5);
        portD = (Button) findViewById(R.id.btnPortD);
        portA = (Button) findViewById(R.id.btnPortA);
        timer = (Button) findViewById(R.id.btnTimer);

        timer.setOnClickListener(timer_control());
        portD.setOnClickListener(portD_control());
        portA.setOnClickListener(portA_control());

        b5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (pairedDevices.size() > 0) {
                    devices = (Object[]) pairedDevices.toArray();

                    bluetoothCom = new Thread(new Comunicacao(devices));
                    bluetoothCom.start();

                }
            }
        });

        BA = BluetoothAdapter.getDefaultAdapter();
        pairedDevices = BA.getBondedDevices();

    }

    private View.OnClickListener timer_control() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                while (!Comunicacao.enviado);
                Comunicacao.setOutputBuffer("TIMER");
                Intent port_timer = new Intent(getContext(), Timer.class);
                startActivity(port_timer);
            }
        };
    }

    private View.OnClickListener portA_control() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                while (!Comunicacao.enviado);
                Comunicacao.setOutputBuffer("VOLTIMETRO");
                Intent portA = new Intent(getContext(), PortA_AD.class);
                startActivity(portA);
            }
        };
    }

    private View.OnClickListener portD_control() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                while (!Comunicacao.enviado);
                Comunicacao.setOutputBuffer("LEDS");
                Intent portD = new Intent(getContext(), PortD_Leds.class);
                startActivity(portD);
            }
        };
    }

    public void on(View v) {
        if (!BA.isEnabled()) {
            Intent turnOn = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(turnOn, 0);
            Toast.makeText(getApplicationContext(), "Turned on", Toast.LENGTH_LONG).show();
        } else {
            Toast.makeText(getApplicationContext(), "Already on", Toast.LENGTH_LONG).show();
        }
    }

    public void off(View v) {
        BA.disable();
        Toast.makeText(getApplicationContext(), "Turned off", Toast.LENGTH_LONG).show();
    }


    public void visible(View v) {
        Intent getVisible = new Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
        startActivityForResult(getVisible, 0);
    }


    private Context getContext(){
        return this;
    }

}