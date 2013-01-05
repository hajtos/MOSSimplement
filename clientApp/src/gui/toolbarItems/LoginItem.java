package gui.toolbarItems;

import gui.TabsPane;
import gui.tabs.LoginPane;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;
import javax.swing.JButton;

public class LoginItem extends JButton implements ActionListener, Observer {

    private TabsPane tabs;
    private LoginPane loginPane;

    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();
        if (source.equals(this)) {
            if (loginPane == null) {
                loginPane = new LoginPane();
                tabs.add(loginPane);
            }
        }
    }

    public LoginItem(TabsPane tabs) {
        super("login");
        this.tabs = tabs;
        this.loginPane = null;
        addActionListener(this);
    }

    @Override
    public void update(Observable o, Object arg) {
    }
}