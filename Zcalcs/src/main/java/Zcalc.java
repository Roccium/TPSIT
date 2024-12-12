import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;

import com.formdev.flatlaf.FlatDarculaLaf;
import com.formdev.flatlaf.FlatDarkLaf;
import com.formdev.flatlaf.FlatIntelliJLaf;
import com.formdev.flatlaf.themes.FlatMacDarkLaf;
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
            UIManager.setLookAndFeel(new FlatMacDarkLaf());
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

        // fai la classe
        Zcalc c = new Zcalc();

        //fai dove scrivi
        schermo = new JTextField(16);
        schermo.setEditable(false);
        schermo.setFont(new Font("Arial", Font.PLAIN, 24));
        schermo.setEditable(false);
        schermo.setBackground(Color.WHITE);
        schermo.setForeground(Color.BLACK);
        // fai un pannello
        JPanel p = new JPanel();


        // aggiungi la roba
        p.add(schermo);

        p.setBackground(Color.green);

        // crea gli oggetti bottoni
        JButton[] bottoni=new JButton[18];
        for (int i = 0; i < bottoni.length; i++) {

            switch (i) {
                case 0:
                    bottoni[i]=new JButton("1");
                    break;
                case 1:
                    bottoni[i]=new JButton("2");
                    break;
                case 2:
                    bottoni[i]=new JButton("3");
                    break;
                case 3:
                    bottoni[i]=new JButton("/");
                    break;
                case 4:
                    bottoni[i]=new JButton("4");
                    break;
                case 5:
                    bottoni[i]=new JButton("5");
                    break;
                case 6:
                    bottoni[i]=new JButton("6");
                    break;
                case 7:
                    bottoni[i]=new JButton("*");
                    break;
                case 8:
                    bottoni[i]=new JButton("7");
                    break;
                case 9:
                    bottoni[i]=new JButton("8");
                    break;
                case 10:
                    bottoni[i]=new JButton("9");
                    break;
                case 11:
                    bottoni[i]=new JButton("+");
                    break;
                case 12:
                    bottoni[i]=new JButton("C");
                    break;
                case 13:
                    bottoni[i]=new JButton("0");
                    break;
                case 14:
                    bottoni[i]=new JButton("=");
                    break;
                case 15:
                    bottoni[i]=new JButton("^");
                    break;
                case 16:
                    bottoni[i]=new JButton("v-");
                    break;
                case 17:
                    bottoni[i]=new JButton(".");
                    break;
                case 18:
                    bottoni[i]=new JButton("/");
                    break;
                default:
                    throw new AssertionError();
            }
            bottoni[i].setPreferredSize(new java.awt.Dimension(70,70));

            bottoni[i].setFont(new Font("Arial", Font.PLAIN, 24));
            bottoni[i].setFocusPainted(false);
            bottoni[i].setBackground(new Color(45, 45, 45));
        }
        for (int j = 0; j < bottoni.length; j++) {
            JButton corso;
            corso=bottoni[j];
            corso.addActionListener(c);
            p.add(corso);
        }


        f.add(p);
        f.setSize(380, 470);
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
