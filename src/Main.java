//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        int a[][]=new int[2][2];
        player r = new player();
        player p = new player();
        Thread T = new Thread(r);
        Thread Z = new Thread(p);
        T.start();
        Z.start();
        }
    }
