/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package fri.cbw.MyTestParamEvalTool1;

import fri.cbw.CBWutil.CBWUtil;
import fri.cbw.CBWutil.InboundConnectionException;
import fri.cbw.GenericTool.AbstractGenericTool;
import fri.cbw.GenericTool.AbstractModelTool;
import fri.cbw.GenericTool.AbstractParamEvalTool;
import fri.cbw.GenericTool.AbstractSpecies;
import fri.cbw.GenericTool.ToolTopComponent;
import java.awt.Component;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.swing.JLabel;
import javax.swing.JTextField;
import org.openide.DialogDisplayer;
import org.openide.NotifyDescriptor;
import org.openide.awt.ActionID;
import org.openide.util.NbBundle.Messages;
import org.openide.windows.TopComponent;

/**
 * Top component which displays something.
 */

@TopComponent.Description(
    preferredID = "MyTestParamEvalToolTopComponent",
//iconBase="SET/PATH/TO/ICON/HERE", 
persistenceType = TopComponent.PERSISTENCE_NEVER)
@TopComponent.Registration(mode = "editor", openAtStartup = false)
@ActionID(category = "Window", id = "fri.cbw.MyTestParamEvalTool1.MyTestParamEvalToolTopComponent")
//@ActionReference(path = "Menu/Window" /*, position = 333 */)
@Messages({
    "CTL_MyTestParamEvalToolAction=MyTestParamEvalTool",
    "CTL_MyTestParamEvalToolTopComponent=MyTestParamEvalTool Window",
    "HINT_MyTestParamEvalToolTopComponent=This is a MyTestParamEvalTool window"
})
public final class MyTestParamEvalToolTopComponent extends ToolTopComponent {

    public MyTestParamEvalToolTopComponent(AbstractGenericTool genericTool) {
        super(genericTool);
        initComponents();
        setName(Bundle.CTL_MyTestParamEvalToolTopComponent());
        setToolTipText(Bundle.HINT_MyTestParamEvalToolTopComponent());
        
        createFields(((AbstractParamEvalTool)getGenericTool()).getSpecies());
        
    }
    
    /**
     * This method is called from within the constructor to initialize the form. WARNING: Do NOT
     * modify this code. The content of this method is always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jPanel1 = new javax.swing.JPanel();
        jButton1 = new javax.swing.JButton();
        btnSave = new javax.swing.JButton();

        jScrollPane1.setBorder(null);
        jScrollPane1.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
        jScrollPane1.setMaximumSize(new java.awt.Dimension(100, 100));

        jPanel1.setMaximumSize(new java.awt.Dimension(100, 100));
        jPanel1.setLayout(new java.awt.GridLayout(10, 2, 20, 20));
        jScrollPane1.setViewportView(jPanel1);

        org.openide.awt.Mnemonics.setLocalizedText(jButton1, org.openide.util.NbBundle.getMessage(MyTestParamEvalToolTopComponent.class, "MyTestParamEvalToolTopComponent.jButton1.text")); // NOI18N
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        org.openide.awt.Mnemonics.setLocalizedText(btnSave, org.openide.util.NbBundle.getMessage(MyTestParamEvalToolTopComponent.class, "MyTestParamEvalToolTopComponent.btnSave.text")); // NOI18N
        btnSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSaveActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(21, 21, 21)
                .addComponent(jButton1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnSave)
                .addContainerGap(245, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton1)
                    .addComponent(btnSave))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 244, Short.MAX_VALUE)
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        ((AbstractParamEvalTool)getGenericTool()).setSpecies(null);
        
        LinkedHashMap<AbstractSpecies, Double> species = null; 
        
        try{
            AbstractModelTool amt = (AbstractModelTool) getGenericTool().getFirstInboundModul();
            species = amt.getSpecies();
        }catch(InboundConnectionException e){
            DialogDisplayer.getDefault().notify(new NotifyDescriptor.Message("Predhodni modul ne obstaja"));
            return;
        }
        createFields(species);
    }//GEN-LAST:event_jButton1ActionPerformed

    private void btnSaveActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSaveActionPerformed
        
        for(Component c : jPanel1.getComponents()){
            if(c instanceof JLabel){
                JTextField field = (JTextField) ((JLabel)c).getLabelFor();
                Double val = CBWUtil.getDoubleZero(field.getText());
                
                AbstractParamEvalTool pt = (AbstractParamEvalTool)getGenericTool();
                pt.addSpecies(((JLabel)c).getText(), val);
                
            }
        }
    }//GEN-LAST:event_btnSaveActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnSave;
    private javax.swing.JButton jButton1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables
    @Override
    public void componentOpened() {
        // TODO add custom code on component opening
    }

    @Override
    public void componentClosed() {
        // TODO add custom code on component closing
    }

    void writeProperties(java.util.Properties p) {
        // better to version settings since initial version as advocated at
        // http://wiki.apidesign.org/wiki/PropertyFiles
        p.setProperty("version", "1.0");
        // TODO store your settings
    }

    void readProperties(java.util.Properties p) {
        String version = p.getProperty("version");
        // TODO read your settings according to their version
    }

    @Override
    public void doSave() {
        
    }

    private void createFields(LinkedHashMap<AbstractSpecies, Double> species) {
        if(species == null)
            return;
        
        jPanel1.setLayout(null);
        jPanel1.removeAll();
        
        int i = 0;
        for (Map.Entry<AbstractSpecies, Double> entry : species.entrySet()) {
            JLabel label = new JLabel(entry.getKey().getName(), JLabel.RIGHT);
            label.setSize(100, 20);
            label.setBounds(10, 30* ++i, 100, 20);
            jPanel1.add(label);
            
            JTextField textField = new JTextField(10);
            textField.setSize(100, 10);
            label.setLabelFor(textField);
            textField.setBounds(110, 30* i, 200, 20);
            textField.setText(entry.getValue().toString());
            jPanel1.add(textField);
            
        }
        
        //revalidate and repaint
        this.revalidate();
        this.repaint();
    }

}
