package gui;

import gui.toolbarItems.ConfigureServersItem;
import javax.swing.JToolBar;
import gui.toolbarItems.LoginItem;
import gui.toolbarItems.CompareDocumentsItem;

public class Toolbar extends JToolBar {

  private CompareDocumentsItem compareDocumentsItem;

  private ConfigureServersItem configureServersItem;

  private LoginItem loginItem;
  
  Toolbar(TabsPane tabs) {
      loginItem = new LoginItem(tabs);
      add(loginItem);
  }

}