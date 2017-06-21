package com.example.kollins.bluetooth_micros1;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * Created by kollins on 21/06/17.
 */
public class PortA_AD extends AppCompatActivity {

    TextView tensao;
    Button finalizar,ler_tensao;

    boolean continua = true;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.porta_layout);

        tensao = (TextView) findViewById(R.id.tensao);
        finalizar = (Button) findViewById(R.id.finalizaA);
        ler_tensao = (Button) findViewById(R.id.ler_tensao);

        finalizar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                continua = false;
                Comunicacao.setOutputBuffer("finishA");
                finish();
            }
        });

        ler_tensao.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Comunicacao.setInputBuffer(null);
                Comunicacao.setOutputBuffer("leitura_ad");
                try {
                    Comunicacao.read();
                } catch (IOException e) {
                    e.printStackTrace();
                }

                while(Comunicacao.getInputBuffer() == null){
                    try {
                        Thread.sleep(500);
                        Comunicacao.setOutputBuffer("leitura_ad");
                        Comunicacao.read();
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                String valorAD = new String(Comunicacao.getInputBuffer());

                tensao.setText(valorAD);

            }
        });

        new Thread() {

            @Override
            public void run() {
                while (continua) {
                    Comunicacao.setInputBuffer(null);
                    Comunicacao.setOutputBuffer("leitura_ad");
                    try {
                        Comunicacao.read();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    while(Comunicacao.getInputBuffer() == null){
                        try {
                            Thread.sleep(500);
                            Comunicacao.setOutputBuffer("leitura_ad");
                            Comunicacao.read();
                        } catch (IOException e) {
                            e.printStackTrace();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            tensao.setText(new String(Comunicacao.getInputBuffer()));
                        }
                    });
                }
            }
        }.start();

    }

}

