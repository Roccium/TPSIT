//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main extends Thread{
    public static void main(String[] args) {
        Gioco partita = new Gioco();
        player r = new player(partita.sem,partita.a,1);
        player p = new player(partita.sem,partita.a,2);
        Thread T = new Thread(r);
        Thread Z = new Thread(p);
        T.run();
        Z.run();
        }

    }
