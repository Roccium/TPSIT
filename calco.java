import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
class calculator extends JFrame implements ActionListener {
    static JFrame f;
    // fai lo schermo
    static JTextField schermo;
    // operando 0 primonumero operando 1 operazione operando 2 secondonumero
    String operando0, operazione, operando2;
    calculator()
    {
        operando0 = operazione = operando2 = "";
    }

    public static void main(String args[])
    {
        f = new JFrame("calcolatrice");
 
        try {
            // bho senno esce solo l'interfaccia grafica trovato su stackflow
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        }
        catch (Exception e) {
            System.err.println(e.getMessage());
        }
 
        // fai la classe
        calculator c = new calculator();
 
        //fai dove scrivi
        schermo = new JTextField(16);
        schermo.setEditable(false);
 
        // crea gli oggetti bottoni
        JButton bottone0, bottone1, bottone2, bottone3, bottone4, bottone5, bottone6, bottone7, bottone8, bottone9, bottone_piu, bottones, bottoned, bottonem, bottonepunto, bottoneeq, bottoneeq1;
 
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
        p.add(bottone0);
        p.add(bottoneeq);
        p.add(bottoneeq1);
 
        p.setBackground(Color.red);
        f.add(p);
        f.setSize(200, 220);
        f.show();
    }
    public void actionPerformed(ActionEvent e){
        String s = e.getActionCommand();
 
        // se cosa butti dentro è un numero
        if ((s.charAt(0) >= '0' && s.charAt(0) <= '9') || s.charAt(0) == '.') {
            //se l'operazione è vuoto lo metti in operando0(primo posto) se no 2
            if (!operazione.equals(""))
            operando2 = operando2 + s;
            else
            operando0 = operando0 + s;
 
            // scrivi sul display
            schermo.setText(operando0 + operazione + operando2);
        }


        //se scegli l'azzera
        else if (s.charAt(0) == 'C') {
            // pulisci tutto
            operando0 = operazione = operando2 = "";
 
            // scrivi sul display
            schermo.setText(operando0 + operazione + operando2+"pulito");
        }



        //se scegli l'uguale
        else if (s.charAt(0) == '=') {
 
            double risultato;
 
            // nell operazione c'è cosa devi fare
            switch (operazione) {
                case "+":
                risultato = (Double.parseDouble(operando0) + Double.parseDouble(operando2));
                    break;
                case "-":
                risultato = (Double.parseDouble(operando0) - Double.parseDouble(operando2));
                    break;
                case "/":
                risultato = (Double.parseDouble(operando0) / Double.parseDouble(operando2));
                    break;
                default:
                risultato = (Double.parseDouble(operando0) * Double.parseDouble(operando2));
                    break;
            }
 
            // scrivi nel text
            schermo.setText(operando0 + operazione + operando2 + "=" + risultato);
 
            // lo metti come operando1
            operando0 = Double.toString(risultato);
            //pulisci operando2
            operazione = operando2 = "";
        }
        //se scegli un operazione invece che un uguale
        else {
            // se è il primo segno che metti
            if (operazione.equals("") || operando2.equals(""))
            operazione = s;
            // altro calcola e mettilo a operando 1 (pulisci per l'operazione)
            else {
                double operazioneprecedente;
                // salva in operando 0
                switch (operazione) {
                    case "+":
                    operazioneprecedente = (Double.parseDouble(operando0) + Double.parseDouble(operando2));
                        break;
                    case "-":
                    operazioneprecedente = (Double.parseDouble(operando0) - Double.parseDouble(operando2));
                        break;
                    case "/":
                    operazioneprecedente = (Double.parseDouble(operando0) / Double.parseDouble(operando2));
                        break;
                    default:
                    operazioneprecedente = (Double.parseDouble(operando0) * Double.parseDouble(operando2));
                        break;
                }
                // mettilo in String
                operando0 = Double.toString(operazioneprecedente);
                // aggiugni il +-*/
                operazione = s;
                // aspetti per il prossimo operazione
                operando2 = "";
            }
            // scrivi
            schermo.setText(operando0 + operazione + operando2);
        }
    }
}