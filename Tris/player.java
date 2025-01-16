import java.util.Random;
import java.util.concurrent.Semaphore;

public class player implements Runnable {
    Semaphore s;
    int sign;
    boolean pareggio=true;
    int[][]array;
    Random random = new Random();
    public player(Semaphore z,int[][]p,int L){
        this.s=z;
        this.sign=L;
        this.array=p;
    }
    int i;
    @Override
    public void run(){
            while (true){
                if (checkvittoriaepareggio()==0) {
                 try {
                    s.acquire();
                    Thread.sleep(random.nextInt(500)+500);
                        while (true){
                            int a = random.nextInt(3);
                            int b = random.nextInt(3);
                            if (array[a][b]==0){
                                array[a][b]=sign;
                                String allo=" ";
                                for (int i = 0; i < array.length; i++) {
                                    allo=" ";
                                    for (int j = 0; j < 3; j++) {
                                        allo=allo.concat(array[i][j]+"");
                                    }
                                    System.out.println(allo);
                                }
                                System.out.println("\n");
                                break;
                            }
                        
                    }
                }
                catch (InterruptedException e) {
                    e.printStackTrace();
                }
                finally {
                    s.release();
                    try {
                        Thread.sleep(500);    
                    } catch (InterruptedException e) {e.printStackTrace();
                    
                    }
                    
                }
            }  
            else{
                if (checkvittoriaepareggio()==1) {
                    System.out.println("hai vinto ");
                    break;
                }
                else{
                    System.out.println("pareggio");
                    break;
                }
            }  
        }
        }
        
        public int checkvittoriaepareggio() {
            int pareggio=1;
            for (int j = 0; j < 3; j++) {
                if (this.array[j][0]==this.sign&&this.array[j][1]==this.sign&&this.array[j][2]==this.sign){
                    return 1;
                }
                if (this.array[0][j]==this.sign&&this.array[1][j]==this.sign&&this.array[2][j]==this.sign){
                    return 1;
                }
            }
            if (this.array[0][0]==this.sign&&this.array[1][1]==this.sign&&this.array[2][2]==this.sign){
                return 1;
            }
            if (this.array[0][2]==this.sign&&this.array[1][1]==this.sign&&this.array[2][0]==this.sign){
                return 1;
            }
            for (int k = 0; k < array.length; k++) {
                for (int j = 0; j < array.length; j++) {
                    pareggio=array[k][j]*pareggio;
                }
            }
            if(pareggio!=0){
                return 2;
            }
            return 0;
        }

    }