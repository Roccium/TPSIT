package org.example;

public class circle implements Runnable{
    private int altezza;
    private int larghezza;
    public final int raggio = 30;
    private final int VEL = 3;
    public   int x=30;
    public   int y=30;
    private int vel_x=this.VEL;
    private int vel_y=this.VEL;
    public circle(int ab,int ba,int xa,int ya){
        altezza=ab;
        x=xa;
        y=ya;
        larghezza=ba;
    }
    public void loop(int a,int b) {
        int other_x=a;
        int other_y=b;
        this.x += this.vel_x;
        this.y += this.vel_y;
        
        if (this.x + this.raggio > this.larghezza || x <= 0) {
            this.vel_x = this.vel_x*-1;
            
        }
        if (this.y + this.raggio > this.altezza || x <= 0) {
            this.vel_y = this.vel_y*-1;
        }
    
        if (Math.sqrt(Math.pow(Math.abs(this.x-other_x),2)+ Math.pow(Math.abs(this.y-other_y),2))<(this.raggio*1.5)){
            this. vel_y = this.vel_y*-1;
            this. vel_x = this.vel_x*-1;
            System.out.println("a");
            System.out.println(vel_x);
        }
    
    }
    @Override
    public void run() {
        // TODO Auto-generated method stub
        
    }
    public int getX(){
        return x; 
    }
    public int getY(){
        return y;
    }
    public int getraggio(){
        return this.raggio; 
    }
  
}
