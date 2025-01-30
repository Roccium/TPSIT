package org.example;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Toolkit;

import javax.swing.JPanel;

public class Board extends JPanel {
    int WIDTH=400;
    int HEIGHT=400;
    private final int DELAY = 25;
    private Thread animator;
    circle uno =new circle(WIDTH, HEIGHT,30,30);
    circle due =new circle(WIDTH, HEIGHT,90,70);
    public Board() {
        setBackground(Color.LIGHT_GRAY);
        animator = new Thread(() -> task());
        animator.start();
        uno.run();
        due.run();
    }
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;
        g2d.setStroke(new BasicStroke(14));
        g2d.setColor(Color.black);
        g2d.drawOval(uno.getX(), uno.getY(), uno.getraggio(), uno.getraggio());
        Graphics2D g2d2 = (Graphics2D) g;
        g2d2.setStroke(new BasicStroke(14));
        g2d2.setColor(Color.red  );
        g2d2.drawOval(due.getX(), due.getY(), due.getraggio(), due.getraggio());
        // make animaton flkuid
        Toolkit.getDefaultToolkit().sync();
    }

  


    public void task() {
        while (true) {
            uno.loop(due.getX(),due.getY());
            due.loop(uno.getX(),uno.getY());
            repaint();
            try {
                Thread.sleep(DELAY);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    

}