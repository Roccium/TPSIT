

public class State {
    boolean check=false;
    String operando0, operazione, operando2;
    State(){
        operando0=operando2=operazione="";
    }
    public  String aggiunta(String s){
        if (!operazione.equals(""))
            this.operando2 = this.operando2 + s;
        else
            this.operando0 = this.operando0 + s;

        // scrivi sul display
        if (check&&!s.equals(".")&&operazione.equals(""){
            check=false;
            return "stai sovrascrivendo";
        }
        return operando0 + operazione + operando2 ;
    }

    public String pulsci(String s){
        // pulisci tutto
        operando0 = operazione = operando2 = "";

        // scrivi sul display
        return operando0 + operazione + operando2 + "pulito";
    }

    public String uguale(String s){
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
            case "^":
                risultato = Math.pow((Double.parseDouble(operando0)), Double.parseDouble(operando2));
                break;
            case "v-":
                risultato = Math.sqrt((Double.parseDouble(operando0)));;
                break;
            default:
                risultato = (Double.parseDouble(operando0) * Double.parseDouble(operando2));
                break;
        }
        this.check=true;
        String finale=operando0 + operazione + operando2 + "=" + risultato;

        // lo metti come operando1
        operando0 = Double.toString(risultato);
        //pulisci operando2
        operazione = operando2 = "";

        // scrivi nel text
        return finale;
    }
    public String operazione(String s){


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
                    this.check=true;
                    break;
                case "-":
                    operazioneprecedente = (Double.parseDouble(operando0) - Double.parseDouble(operando2));
                    this.check=true;
                    break;
                case "/":
                    operazioneprecedente = (Double.parseDouble(operando0) / Double.parseDouble(operando2));
                    this.check=true;
                    break;
                case "^":
                    operazioneprecedente = Math.pow((Double.parseDouble(operando0)), Double.parseDouble(operando2));
                    this.check=true;
                    break;
                case "v-":
                    operazioneprecedente = Math.sqrt((Double.parseDouble(operando0)));;
                    this.check=true;
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

        return operando0 + operazione + operando2;
    }

}
