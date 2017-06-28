package com.example.kollins.bluetooth_micros1;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.ParcelUuid;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

/**
 * Created by kollins on 14/06/17.
 */
public class Comunicacao implements Runnable {

    public static final byte FINAL = 13;

    public BluetoothSocket socket;
    public Object[] devices;
    public ParcelUuid[] uuids;
    public BluetoothDevice device;

    public static OutputStream outputStream;
    public static InputStream inputStream;

    public static String OUTPUT_BUFFER = null;
    public static String OUTPUT_BUFFER2 = null;
    public static String INPUT_BUFFER = null;
    public static boolean enviado = true;


    public Comunicacao(Object[] devices) {
        this.devices = devices;
    }

    @Override
    public void run() {

        device = (BluetoothDevice) devices[0];
        uuids = device.getUuids();

        try {
            socket = device.createRfcommSocketToServiceRecord(uuids[0].getUuid());
            socket.connect();
            outputStream = socket.getOutputStream();
            inputStream = socket.getInputStream();
            Log.i("Teste", "Conexão realizada");

            while (true) {
                if (OUTPUT_BUFFER != null) {
                    write(OUTPUT_BUFFER);

                    OUTPUT_BUFFER = null;
                }

                Thread.sleep(250);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void write(String s) {

        final String msg = s;

        try {
            Log.i("Teste", "Enviando " + msg);
            getOutputStream().write(msg.getBytes());
            getOutputStream().write(FINAL);
            Log.i("Teste", "Enviado");
            enviado = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static void read() throws IOException {

        byte[] leitura = new byte[5];
        getInputStream().read(leitura);
        Log.i("Teste", "Bytes: " + leitura);
        setInputBuffer(new String(leitura, StandardCharsets.UTF_8));

    }


    synchronized static void setOutputBuffer(String msg) {
        enviado = false;
        OUTPUT_BUFFER = msg;
    }

    synchronized static void setInputBuffer(String msg) {
        INPUT_BUFFER = msg;
    }

    synchronized static String getInputBuffer() {
        return INPUT_BUFFER;
    }

    public static OutputStream getOutputStream() {
        return outputStream;
    }

    public static InputStream getInputStream() {
        return inputStream;
    }

}

