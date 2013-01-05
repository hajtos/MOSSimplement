package gui.tabs;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import javax.swing.JPanel;
import javax.swing.JComboBox;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JLabel;

public class LoginPane extends JPanel implements ActionListener {

    private JComboBox server;
    private JTextField user;
    private JPasswordField password;
    private JButton login;
    private JButton cancel;
    private Observable observatory;

    @Override
    public void actionPerformed(ActionEvent e) {
    }

    public LoginPane() {
        observatory = new Observable();
        setLayout(new GridLayout(0, 2));
        add(new JLabel("server"));
        server = new JComboBox();
        add(server);
        add(new JLabel("user name"));
        user = new JTextField();
        add(user);
        add(new JLabel("password"));
        password = new JPasswordField();
        add(password);
        login = new JButton("login");
        cancel = new JButton("cancel");
        add(login);
        add(cancel);
    }

    public Observable getObservatory() {
        return observatory;
    }
}