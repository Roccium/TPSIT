package org.example;

import java.util.concurrent.Semaphore;

public class multiplier extends Thread{
    int[] orizzontale;
    int[] verticale;
    int risultato =0;
    int[][] addenf;
    int k=0;
    int f=0;
    Semaphore Z;
    public multiplier(int[] a, int[] b,int[][] c,int ka,int fa, Semaphore pp){
        this.orizzontale=a;
        this.verticale=b;
        this.addenf=c;
        this.k=ka;
        this.f=fa;
        this.Z=pp;
    }
    @Override
    public void run() {
        try {
            this.Z.acquire();
            for (int i = 0; i < verticale.length; i++) {
            risultato=risultato+(orizzontale[i]*verticale[i]);
            System.out.println(risultato);
        }
        addenf[k][f]=risultato;
            this.Z.release();
    }
    catch (InterruptedException e) {
        e.printStackTrace();
    }
    }
}
