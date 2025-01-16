import java.util.concurrent.Semaphore;
public class Gioco {
    Semaphore sem=new Semaphore(1);
    int[][] a =new int[3][3];

    public Gioco(){
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                a[i][j] = 0;
            }
        }
    }
    public int[][] getA() {
        return a;
    }
}
