public class player implements Runnable {
    int i;
    @Override
    public void run()
    {
        i = 0;
        while (true) {
            System.out.println("Ciao " + i++);
            if ( i == 20 ) break;
        }
    }
}
