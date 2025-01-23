import java.awt.Color;
import java.awt.Font;
import javax.swing.*;
import java.util.concurrent.Semaphore;
public class Gioco extends JFrame {

    Semaphore sem1=new Semaphore(1);
    Semaphore sem2=new Semaphore(1);
    int[][] a =new int[3][3];
    static JFrame f;
    public Gioco(){
        f = new JFrame("tris");
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                a[i][j] = 0;
            }
        }

        // fai un pannello
        JPanel p = new JPanel();

        p.setBackground(Color.green);
        f.add(p);
        f.setSize(380, 470);
        f.show();
    }
    public int[][] getA() {
        return a;
    }
}