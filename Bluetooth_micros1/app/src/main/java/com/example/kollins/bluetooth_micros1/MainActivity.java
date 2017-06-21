package com.example.kollins.bluetooth_micros1;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;

import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.Bundle;
import android.os.ParcelUuid;
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

public class MainActivity extends Activity {
    Button b1, b2, b3, b4, b5, b6,portD,portA;
    private BluetoothAdapter BA;
    private Set<BluetoothDevice> pairedDevices;
    ListView lv;

    private final byte FINAL = 13;

    public BluetoothSocket socket;
    public Object[] devices;
    public ParcelUuid[] uuids;
    public BluetoothDevice device;

    public OutputStream outputStream;
    public InputStream inputStream;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        b1 = (Button) findViewById(R.id.button);
        b2 = (Button) findViewById(R.id.button2);
        b3 = (Button) findViewById(R.id.button3);
        b4 = (Button) findViewById(R.id.button4);
        b5 = (Button) findViewById(R.id.button5);
        portD = (Button) findViewById(R.id.btnPortD);
        portA = (Button) findViewById(R.id.btnPortA);



        b5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (pairedDevices.size() > 0) {
                    devices = (Object[]) pairedDevices.toArray();

                    Thread bluetoothCom = new Thread(new Comunicacao(devices));
                    bluetoothCom.start();

                }
            }
        });

        BA = BluetoothAdapter.getDefaultAdapter();
        pairedDevices = BA.getBondedDevices();

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

    public void list(View v) {

        ArrayList list = new ArrayList();

        for (BluetoothDevice bt : pairedDevices) list.add(bt.getName());
        Toast.makeText(getApplicationContext(), "Showing Paired Devices", Toast.LENGTH_SHORT).show();

        final ArrayAdapter adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, list);

        lv.setAdapter(adapter);
    }

    public void portD_control(View view) throws IOException {
        Comunicacao.setOutputBuffer("PORTD SELECTED");
        Intent portD = new Intent(this, PortD_Leds.class);
        startActivity(portD);
    }

    public void portA_control(View view) {
        Comunicacao.setOutputBuffer("PORTA SELECTED");
        Intent portA = new Intent(this, PortA_AD.class);
        startActivity(portA);
    }
}