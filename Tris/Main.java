//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main extends Thread{
    public static void main(String[] args) {
        Gioco partita = new Gioco();
        player p = new player(partita.sem,partita.a,2);
        player r = new player(partita.sem,partita.a,1);
        Thread Z = new Thread(p);
        Thread T = new Thread(r);
        
        T.run();
        Z.run();
        }

    }