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
    Thread voltimetro;
    Button finalizar;

    static String info;
    static String numbers;

    boolean continua = true;
    static boolean zero = false;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.porta_layout);

        tensao = (TextView) findViewById(R.id.tensao);
        finalizar = (Button) findViewById(R.id.finalizaA);
        //ler_tensao = (Button) findViewById(R.id.ler_tensao);

        finalizar.setOnClickListener(terminaVoltimetro());
//        finalizar.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                continua = false;
//                Comunicacao.setOutputBuffer("finishA");
//                finish();
//            }
//        });

//        ler_tensao.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Comunicacao.setInputBuffer(null);
//                Comunicacao.setOutputBuffer("leitura_ad");
//                try {
//                    Comunicacao.read();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//
//                while(Comunicacao.getInputBuffer() == null){
//                    try {
//                        Thread.sleep(500);
//                        Comunicacao.setOutputBuffer("leitura_ad");
//                        Comunicacao.read();
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    } catch (InterruptedException e) {
//                        e.printStackTrace();
//                    }
//                }
//
//                String valorAD = new String(Comunicacao.getInputBuffer());
//
//                tensao.setText(valorAD);
//
//            }
//        });

        voltimetro = new Thread() {

            @Override
            public void run() {
                while (continua) {
                    zero = false;
                    Comunicacao.setOutputBuffer("leitura_ad");

                    try {
                        Comunicacao.read();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    do {
                        Comunicacao.setInputBuffer(null);
                        while (Comunicacao.getInputBuffer() == null) {
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

                        info = new String(Comunicacao.getInputBuffer());
                        numbers = extractDigits(info);

                        try {
                            if (Integer.valueOf(numbers) == 0)
                                zero = true;
                        }catch (NumberFormatException e){
                                zero = false;
                        }

                    }while (numbers.length()<2 && !zero);

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                                Log.i("Teste", "Atualiza Interface");

                                String inteiro = String.valueOf(Integer.valueOf(numbers)/100);
                                String decimal = String.valueOf((Integer.valueOf(numbers)/10)%10);
                                String centesimal = String.valueOf(Integer.valueOf(numbers)%10);

                                tensao.setText(inteiro + "." + decimal + centesimal);

                        }
                    });
                }
            }
        };

        voltimetro.start();

    }

    private View.OnClickListener terminaVoltimetro() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                continua = false;
                try {
                    voltimetro.join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                Comunicacao.setOutputBuffer("finishVOLT");
                finish();
            }
        };
    }

    public String extractDigits(String src) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < src.length(); i++) {
            char c = src.charAt(i);
            if (Character.isDigit(c)) {
                builder.append(c);
            }
        }
        return builder.toString();
    }

}

