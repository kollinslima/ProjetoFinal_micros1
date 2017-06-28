package com.example.kollins.bluetooth_micros1;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.SeekBar;

/**
 * Created by kollins on 28/06/17.
 */
public class Timer extends AppCompatActivity {

    Button finalizaTimer;
    SeekBar seekTimer;

    boolean enable_listener = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.timer_layout);

        finalizaTimer = (Button) findViewById(R.id.finalizaTimer);
        finalizaTimer.setOnClickListener(terminaTimer());

        seekTimer = (SeekBar) findViewById(R.id.seekTimer);
        seekTimer.setOnSeekBarChangeListener(trataSeekBar());

    }

    private SeekBar.OnSeekBarChangeListener trataSeekBar() {
        return new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {

                final int progress_T = progress;
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        int timer_value = (int) ((65353 * (progress_T / 100.0)) + 1);

                        int timer_L = 0;
                        int timer_H = 0;

                        for (int i = 0; i < timer_value; i++) {
                            timer_L = (timer_L + 1) % 256;

                            if (timer_L == 0) {
                                timer_H = (timer_H + 1) % 256;
                            }
                        }

                        Log.i("Teste", "Progress: " + progress_T);
                        Log.i("Teste", "SeekBar: " + timer_value);

                        Log.i("Teste", "Low: " + timer_L);
                        Log.i("Teste", "Hight: " + timer_H);


//                        Comunicacao.setOutputBuffer("L");
//                        while (!Comunicacao.enviado);
//                        Comunicacao.setOutputBuffer(String.valueOf(timer_L));
//                        while (!Comunicacao.enviado);
//                        Comunicacao.setOutputBuffer("H");
//                        while (!Comunicacao.enviado);
                        Comunicacao.setOutputBuffer(String.valueOf(timer_H));

                    }
                }).start();

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        };
    }

    private View.OnClickListener terminaTimer() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Comunicacao.setOutputBuffer("finishTIMER");
                finish();
            }
        };
    }


}
