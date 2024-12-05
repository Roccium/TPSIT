import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
class Zcalc extends JFrame implements ActionListener {
    State A = new State();
    static JFrame f;
    String operando0, operazione, operando2;
    // fai lo schermo
    static JTextField schermo;
    Zcalc()
    {
    operando0=operando2=operazione="";
    }
    public static void main(String args[]) {
        State A = new State();
        f = new JFrame("calcolatrice");

        try {
            // bho senno esce solo l'interfaccia grafica trovato su stackflow
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

        // fai la classe
        Zcalc c = new Zcalc();

        //fai dove scrivi
        schermo = new JTextField(16);
        schermo.setEditable(false);

        // crea gli oggetti bottoni
        JButton bottone0, bottone1, bottone2, bottone3, bottone4, bottone5, bottone6, bottone7, bottone8, bottone9, bottone_piu, bottones, bottoned, bottonem, bottonepunto, bottoneeq, bottoneeq1, bottonepotenza;

        // crea i bottoni
        bottone0 = new JButton("0");
        bottone1 = new JButton("1");
        bottone2 = new JButton("2");
        bottone3 = new JButton("3");
        bottone4 = new JButton("4");
        bottone5 = new JButton("5");
        bottone6 = new JButton("6");
        bottone7 = new JButton("7");
        bottone8 = new JButton("8");
        bottone9 = new JButton("9");
        bottoneeq1 = new JButton("=");
        bottone_piu = new JButton("+");
        bottones = new JButton("-");
        bottoned = new JButton("/");
        bottonem = new JButton("*");
        bottonepotenza = new JButton("^");
        bottoneeq = new JButton("C");
        bottonepunto = new JButton(".");

        // fai un pannello
        JPanel p = new JPanel();

        // metti i trigger
            bottonem.addActionListener(c);
            bottoned.addActionListener(c);
            bottones.addActionListener(c);
            bottone_piu.addActionListener(c);
            bottone9.addActionListener(c);
            bottone8.addActionListener(c);
            bottone7.addActionListener(c);
            bottone6.addActionListener(c);
            bottone5.addActionListener(c);
            bottone4.addActionListener(c);
            bottone3.addActionListener(c);
            bottone2.addActionListener(c);
            bottone1.addActionListener(c);
            bottone0.addActionListener(c);
            bottonepunto.addActionListener(c);
            bottoneeq.addActionListener(c);
            bottoneeq1.addActionListener(c);
            bottonepotenza.addActionListener(c);

            // aggiungi la roba
            p.add(schermo);
            p.add(bottone_piu);
            p.add(bottone1);
            p.add(bottone2);
            p.add(bottone3);
            p.add(bottones);
            p.add(bottone4);
            p.add(bottone5);
            p.add(bottone6);
            p.add(bottonem);
            p.add(bottone7);
            p.add(bottone8);
            p.add(bottone9);
            p.add(bottoned);
            p.add(bottonepunto);
            p.add(bottonepotenza);
            p.add(bottone0);
            p.add(bottoneeq);
            p.add(bottoneeq1);

            p.setBackground(Color.red);
            f.add(p);
            f.setSize(300, 320);
            f.show();

        }
        public void actionPerformed (ActionEvent e){
            String s = e.getActionCommand();
            if ((s.charAt(0) >= '0' && s.charAt(0) <= '9') || s.charAt(0) == '.') {
                schermo.setText(A.aggiunta(s));
            }
            else if (s.charAt(0) == 'C') {
                schermo.setText(A.pulsci(s));
            }
            else if (s.charAt(0) == '=') {
                schermo.setText(A.uguale(s));
            }
            else {
                schermo.setText(A.operazione(s));
            }
        }

    }
