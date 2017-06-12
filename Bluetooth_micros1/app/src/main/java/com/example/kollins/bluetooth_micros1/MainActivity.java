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
    Button b1, b2, b3, b4, b5, b6,portD,led0;
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
        b6 = (Button) findViewById(R.id.button6);
        portD = (Button) findViewById(R.id.btnPortD);
        led0 = (Button) findViewById(R.id.btnLed0);

        b6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    write("Android");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });

        b5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (pairedDevices.size() > 0) {
                    devices = (Object[]) pairedDevices.toArray();
                    Log.i("Bluetooth", devices.toString());
                    device = (BluetoothDevice) devices[0];
                    uuids = device.getUuids();


                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                socket = device.createRfcommSocketToServiceRecord(uuids[0].getUuid());
                                socket.connect();
                                outputStream = socket.getOutputStream();
                                inputStream = socket.getInputStream();
                                Log.i("Teste", "Conexão realizada");

                                byte teste = (byte) inputStream.read();
                                Log.i("Teste", "byte lido: " + teste);

                            } catch (IOException e) {
                                e.printStackTrace();
                            }

                        }
                    }).start();


                }
            }
        });

        BA = BluetoothAdapter.getDefaultAdapter();
        pairedDevices = BA.getBondedDevices();
        lv = (ListView) findViewById(R.id.listView);
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

    public void write(String s) throws IOException {

        final String msg = s;

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Log.i("Teste", "Enviando");
                    outputStream.write(msg.getBytes());
                    outputStream.write(FINAL);
                    Log.i("Teste", "Enviado");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();

    }

    public void list(View v) {

        ArrayList list = new ArrayList();

        for (BluetoothDevice bt : pairedDevices) list.add(bt.getName());
        Toast.makeText(getApplicationContext(), "Showing Paired Devices", Toast.LENGTH_SHORT).show();

        final ArrayAdapter adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, list);

        lv.setAdapter(adapter);
    }

    public void portD_control(View view) throws IOException {
        write("PORTD SELECTED");
    }

    public void led0(View view) throws IOException {
        write("0");
    }
}