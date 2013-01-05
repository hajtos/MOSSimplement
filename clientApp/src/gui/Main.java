package gui;

import java.awt.BorderLayout;
import java.awt.Container;
import javax.swing.JFrame;

public class Main extends JFrame {
    private Toolbar toolbar;
    private TabsPane tabs;
    Main() {
        super("plagiat project client App");
        setLayout(new BorderLayout());
        Container content = getContentPane();
        tabs = new TabsPane();
        toolbar = new Toolbar(tabs);
        content.add(toolbar, BorderLayout.WEST);
        content.add(tabs, BorderLayout.CENTER);
        setSize(1024, 768);
        setVisible(true);
    }
  public static void main(String[] args) {
      Main main = new Main();
      main.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  }

}