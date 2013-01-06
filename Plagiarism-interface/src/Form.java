/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.*;

/**
 *
 * @author Hajtos
 */
public class Form extends javax.swing.JFrame {

    ResultSet rs;
    Statement stmt;
    PreparedStatement pstmt;
    CallableStatement cstmt;
    Connection con;
    int group_id;
    int assignment_id;
    /**
     * Creates new form Form
     */
    
    private String StringAllign(String input, int size) {
        do {
            input+=" ";
        } while (input.length()<size);
        return input;
    }
    
    public Form() {
        initComponents();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost/anti_plagiarism?user=root&password=Sur0k4tk4";
            con = DriverManager.getConnection(dbUrl);
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM user_groups");
            while (rs.next()) {
                usergroups.addItem(rs.getString("group_name"));
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Form.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        Programs = new javax.swing.JComboBox();
        users_list = new java.awt.List();
        selected_users = new java.awt.List();
        jRadioButton1 = new javax.swing.JRadioButton();
        jRadioButton2 = new javax.swing.JRadioButton();
        add_user = new javax.swing.JButton();
        add_all = new javax.swing.JButton();
        unadd_all = new javax.swing.JButton();
        unadd_user = new javax.swing.JButton();
        usergroups = new javax.swing.JComboBox();
        matching_button = new javax.swing.JButton();
        jPanel3 = new javax.swing.JPanel();
        match_list = new java.awt.List();
        fingerprints = new java.awt.List();
        button1 = new java.awt.Button();
        button2 = new java.awt.Button();
        source1 = new java.awt.List();
        source2 = new java.awt.List();
        jPanel4 = new javax.swing.JPanel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 507, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 355, Short.MAX_VALUE)
        );

        jTabbedPane1.addTab("File sending", jPanel1);

        Programs.setName(""); // NOI18N

        jRadioButton1.setSelected(true);
        jRadioButton1.setText("All programs");
        jRadioButton1.setToolTipText("");
        jRadioButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jRadioButton1ActionPerformed(evt);
            }
        });

        jRadioButton2.setText("Only latest");
        jRadioButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jRadioButton2ActionPerformed(evt);
            }
        });

        add_user.setText(">");
        add_user.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                add_userActionPerformed(evt);
            }
        });

        add_all.setText(">>");
        add_all.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                add_allActionPerformed(evt);
            }
        });

        unadd_all.setText("<<");
        unadd_all.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                unadd_allActionPerformed(evt);
            }
        });

        unadd_user.setText("<");
        unadd_user.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                unadd_userActionPerformed(evt);
            }
        });

        usergroups.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                usergroupsActionPerformed(evt);
            }
        });

        matching_button.setText("Find matches");
        matching_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                matching_buttonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(54, 54, 54)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(users_list, javax.swing.GroupLayout.DEFAULT_SIZE, 105, Short.MAX_VALUE)
                            .addComponent(usergroups, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(add_user, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(unadd_all, javax.swing.GroupLayout.DEFAULT_SIZE, 50, Short.MAX_VALUE)
                            .addComponent(unadd_user, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(add_all, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(Programs, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(selected_users, javax.swing.GroupLayout.DEFAULT_SIZE, 105, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jRadioButton1)
                            .addComponent(jRadioButton2)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(133, 133, 133)
                        .addComponent(matching_button, javax.swing.GroupLayout.PREFERRED_SIZE, 112, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(78, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(Programs, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(usergroups, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jRadioButton1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jRadioButton2))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(4, 4, 4)
                        .addComponent(add_user)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(add_all)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(unadd_all)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(unadd_user))
                    .addComponent(users_list, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(selected_users, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(matching_button)
                .addContainerGap(155, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("File managing", jPanel2);

        button1.setLabel("Investigate");
        button1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button1ActionPerformed(evt);
            }
        });

        button2.setLabel("Show Code");
        button2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(38, 38, 38)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(fingerprints, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(match_list, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(button2, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addComponent(source1, javax.swing.GroupLayout.PREFERRED_SIZE, 229, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(1, 1, 1)
                        .addComponent(source2, javax.swing.GroupLayout.DEFAULT_SIZE, 229, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(match_list, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(2, 2, 2)
                .addComponent(button1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(2, 2, 2)
                .addComponent(fingerprints, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(2, 2, 2)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addComponent(button2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)
                        .addComponent(source1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(source2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(49, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("Match results", jPanel3);

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 507, Short.MAX_VALUE)
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 355, Short.MAX_VALUE)
        );

        jTabbedPane1.addTab("Assignmets", jPanel4);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1, javax.swing.GroupLayout.Alignment.TRAILING)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void usergroupsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_usergroupsActionPerformed
        try {
            rs = stmt.executeQuery("SELECT id from user_groups where group_name='"+usergroups.getSelectedItem().toString()+"'");
            rs.next();
            group_id = rs.getInt("id");
            rs = stmt.executeQuery("select * from assignments where user_group = "+Integer.toString(group_id));
            while (rs.next()) {
                Programs.addItem(rs.getString("program_name"));
            }
            rs = stmt.executeQuery("select * from users where user_group = "+Integer.toString(group_id));
            while (rs.next()) {
                users_list.add(rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Form.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_usergroupsActionPerformed

    private void jRadioButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jRadioButton1ActionPerformed
        jRadioButton1.setSelected(true);
        jRadioButton2.setSelected(false);
    }//GEN-LAST:event_jRadioButton1ActionPerformed

    private void jRadioButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jRadioButton2ActionPerformed
        jRadioButton2.setSelected(true);
        jRadioButton1.setSelected(false);
    }//GEN-LAST:event_jRadioButton2ActionPerformed

    private void add_userActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_add_userActionPerformed
        String user = users_list.getSelectedItem();
        users_list.remove(users_list.getSelectedIndex());
        selected_users.add(user);
    }//GEN-LAST:event_add_userActionPerformed

    private void unadd_userActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_unadd_userActionPerformed
        String user = selected_users.getSelectedItem();
        selected_users.remove(selected_users.getSelectedIndex());
        users_list.add(user);
    }//GEN-LAST:event_unadd_userActionPerformed

    private void add_allActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_add_allActionPerformed
        while (users_list.getItemCount() > 0) {
            String user = users_list.getItem(0);
            users_list.remove(0);
            selected_users.add(user);
        }
    }//GEN-LAST:event_add_allActionPerformed

    private void unadd_allActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_unadd_allActionPerformed
        while (selected_users.getItemCount() > 0) {
            String user = selected_users.getItem(0);
            selected_users.remove(0);
            users_list.add(user);
        }
    }//GEN-LAST:event_unadd_allActionPerformed

    private void matching_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_matching_buttonActionPerformed
        try {
            pstmt = con.prepareStatement("create temporary table users_to_match(user_id int)");
            pstmt.executeUpdate();
            String statement = "insert into users_to_match select user_id from users where name in (";
            for (int i=1;i<selected_users.getItemCount();++i) {
                statement+="?,";
            }
            statement+="?)";
            pstmt = con.prepareStatement(statement);
            for (int i=0;i<selected_users.getItemCount();++i) {
                pstmt.setString(i+1, selected_users.getItem(i));
            }
            pstmt.executeUpdate();
            cstmt = con.prepareCall("{ call perform_match(?) }");
            if (jRadioButton1.isSelected()) {
                cstmt.setInt(1, 1);
            }
            else {
                cstmt.setInt(1, 0);
            }
            cstmt.execute();
            pstmt = con.prepareStatement("drop temporary table users_to_match");
            pstmt.executeUpdate();
            Thread.sleep(5000);
            rs = stmt.executeQuery("select u1.name as name1, m.source1, m.source2, u2.name as name2,m.match_count,m.all_count,m.id,m.match_count*100/m.all_count as percent from matched m join users u1 on m.id in (select * from temp_matches) and u1.user_id=(select user from programme_codes where id = m.source1) join users u2 on u2.user_id=(select user from programme_codes where id = m.source2) order by percent");
            while (rs.next()) {
                String to_add = rs.getString("id");
                to_add = StringAllign(to_add,5);
                to_add+=rs.getString("name1")+";"+rs.getString("source1");
                to_add = StringAllign(to_add,26);
                to_add+="- ";
                to_add+=rs.getString("name2")+";"+rs.getString("source2");
                to_add = StringAllign(to_add,49);
                to_add+=rs.getString("match_count")+"/"+rs.getString("all_count");
                to_add = StringAllign(to_add,55);
                to_add+=rs.getString("percent");
                match_list.add(to_add);
            }
        } catch (InterruptedException | SQLException ex) {
            Logger.getLogger(Form.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }//GEN-LAST:event_matching_buttonActionPerformed

    private void button1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button1ActionPerformed
        try {
            String p = match_list.getSelectedItem();
            p = p.substring(0,p.indexOf(" "));
            int match = Integer.parseInt(p);
            rs = stmt.executeQuery("select f1.position as p1,f2.position as p2,f1.hash_value f1.hash_value from matches m join fingerprints f1 on m.the_match="+p+" and f1.id=m.fingerprint1 join fingerprints f2 on f2.id=m.fingerprint2");
            while (rs.next()) {
                String to_add = rs.getString("p1");
                to_add = StringAllign(to_add,10);
                to_add+=Integer.toHexString(rs.getInt("hash_value"));
                to_add = StringAllign(to_add,30);
                to_add+=rs.getString("p2");
                fingerprints.add(to_add);
            }
            rs = stmt.executeQuery("select file from programme_codes where id = (select source1 from matched where id="+p+")");
            rs.next();
            String file = rs.getString("file");
            while(file.indexOf("\n") != -1) {
                source1.add(file.substring(0,file.indexOf("\n")));
                file = file.substring(file.indexOf("\n")+1);
            }
            source1.add(file);
            rs = stmt.executeQuery("select file from programme_codes where id = (select source2 from matched where id="+p+")");
            rs.next();
            file = rs.getString("file");
            while(file.indexOf("\n") != -1) {
                source2.add(file.substring(0,file.indexOf("\n")));
                file = file.substring(file.indexOf("\n"));
            }
            source2.add(file);
            
        } catch (SQLException ex) {
            Logger.getLogger(Form.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }//GEN-LAST:event_button1ActionPerformed

    private void button2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button2ActionPerformed
        try {
            String item = fingerprints.getSelectedItem();
            String position1 = item.substring(0, item.indexOf(" "));
            String p = match_list.getSelectedItem();
            p = p.substring(0,p.indexOf(" "));
            rs = stmt.executeQuery("select max(line_number) as line from code_new_lines where program_id=(select source1 from matched where id="+p+") and position>"+position1);
            rs.next();
            source1.select(rs.getInt("line"));
            item = item.substring(item.indexOf(" ")).trim();
            item = item.substring(item.indexOf(" ")).trim();
            rs = stmt.executeQuery("select max(line_number) as line from code_new_lines where program_id=(select source2 from matched where id="+p+") and position>"+item);
            rs.next();
            source2.select(rs.getInt("line"));
        } catch (SQLException ex) {
            Logger.getLogger(Form.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_button2ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Form().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox Programs;
    private javax.swing.JButton add_all;
    private javax.swing.JButton add_user;
    private java.awt.Button button1;
    private java.awt.Button button2;
    private java.awt.List fingerprints;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JRadioButton jRadioButton1;
    private javax.swing.JRadioButton jRadioButton2;
    private javax.swing.JTabbedPane jTabbedPane1;
    private java.awt.List match_list;
    private javax.swing.JButton matching_button;
    private java.awt.List selected_users;
    private java.awt.List source1;
    private java.awt.List source2;
    private javax.swing.JButton unadd_all;
    private javax.swing.JButton unadd_user;
    private javax.swing.JComboBox usergroups;
    private java.awt.List users_list;
    // End of variables declaration//GEN-END:variables
}
