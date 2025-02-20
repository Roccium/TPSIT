package org.example;

public class adder implements Runnable{
    int[][] finale;
    int risultato=0;
    public adder(int[][] a){
    this.finale=a;
    }

    @Override
    public void run() {

        for (int i = 0; i < finale[0].length; i++) {
            for (int j = 0; j < finale[0].length; j++) {
                risultato=finale[i][j]+risultato;
            }
        }
        System.out.println(risultato);
    }
}
