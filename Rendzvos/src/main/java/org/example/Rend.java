package org.example;

import java.util.Arrays;
import java.util.Scanner;
import java.util.concurrent.Semaphore;

public class Rend {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int n = scan.nextInt();
        int [][] prima = new  int[n][n];
        int [][] seconda = new  int[n][n];
        int [][] risultati = new int[n][n];
        Semaphore semaphorez = new Semaphore(n*n);
        for(int i=0; i < n ; i++){
            for (int j = 0; j < n; j++) {
                prima[i][j]= (int)(Math.floor(Math.random()*5));
                seconda[i][j]= (int)(Math.floor(Math.random()*5));
            }
            System.out.println(Arrays.toString(prima[i]));
        }
        System.out.println("\n");
        for (int i = 0; i < n; i++) {
            System.out.println(Arrays.toString(seconda[i]));
        }
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                //System.out.println("\n"+Arrays.toString(prima[i]));
                //System.out.println(Arrays.toString(seconda[j])+"\n");
                multiplier N = new multiplier(prima[i],getcolumn(seconda,j), risultati, i, j,semaphorez);
                N.start();
            }
            System.out.println("\n"+Arrays.toString(risultati[i]));

        }

        finale(risultati,n,semaphorez);
        System.out.println("\n"+Arrays.toString(risultati[0]));
        System.out.println("\n"+Arrays.toString(risultati[1]));

    }
    public static void finale(int[][] risultat, int n, Semaphore semaphore){
        while (true){
            if (semaphore.availablePermits()==((n*n))){
                adder add=new adder(risultat);
                add.run();
                break;
            }
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
