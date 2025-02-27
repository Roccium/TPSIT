package org.example;

import java.util.concurrent.Semaphore;

public class Multiplier extends Thread{
    int[] prima;
    int[] seconda;
    int risultato =0;
    int[][] addenf;
    int k=0;
    int f=0;
    Semaphore Z;
    public Multiplier(int[][] a, int[][] b,int[][] c,int riga,int colonna, Semaphore pp){
        this.prima=a[riga];
        this.seconda=getcolumn(b,colonna);
        this.addenf=c;
        this.k=riga;
        this.f=colonna;
        this.Z=pp;
    }
    @Override
    public void run() {
        try {
            this.Z.acquire();
            for (int i = 0; i < prima.length; i++) {
                risultato=risultato+(seconda[i]*prima[i]);
                System.out.println(risultato);
            }
            addenf[k][f]=risultato;
            this.Z.release();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    public static int[] getcolumn(int[][] a, int index){
        int[] back=new int[a.length];
        for (int i = 0; i < a.length; i++) {
            back[i]=a[i][index];
        }
        return back;
    }
}
