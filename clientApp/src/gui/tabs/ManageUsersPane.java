package gui.tabs;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JComboBox;

public class ManageUsersPane extends JPanel implements ActionListener{

    private JButton addNew;
    private JButton delete;
    private JComboBox userList;
    private JButton ok;

    @Override
    public void actionPerformed(ActionEvent e) {
    }

    public ManageUsersPane() {
    }
}