package org.example;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Toolkit;

import javax.swing.JPanel;

public class Board extends JPanel {

    private final int X = 30;
    private final int Y = 30;
    private final int WIDTH = 30;
    private final int HEIGHT = 30;
    private final int DELAY = 25;
    private final int VEL = 1;

    private int x, y;
    private int vel_x, vel_y;

    private Thread animator;

    public Board() {
        setBackground(Color.LIGHT_GRAY);
        x = X;
        y = Y;
        vel_x = VEL;
        vel_y = VEL;
        animator = new Thread(() -> task());
        animator.start();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;
        g2d.setStroke(new BasicStroke(14));
        g2d.setColor(Color.black);
        g2d.drawOval(x, y, WIDTH, HEIGHT);
        // make animaton flkuid
        Toolkit.getDefaultToolkit().sync();
    }

    private void loop() {
        x += vel_x;
        y += vel_y;
        if (x + WIDTH > getWidth() || x < 0) {
            vel_x = -vel_x;
        }
        if (y + HEIGHT > getHeight() || y < 0) {
            vel_y = -vel_y;
        }
    }
    private void loop2() {
        x -= vel_x;
        y -= vel_y;
        if (x + WIDTH > getWidth() || x < 0) {
            vel_x = -vel_x;
        }
        if (y + HEIGHT > getHeight() || y < 0) {
            vel_y = -vel_y;
        }
    }

    public void task() {
        while (true) {
            loop();
            repaint();
            try {
                Thread.sleep(DELAY);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

}