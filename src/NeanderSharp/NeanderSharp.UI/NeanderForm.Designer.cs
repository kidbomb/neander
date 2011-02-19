namespace NeanderSharp
{
    partial class NeanderForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.negativeCheckbox = new System.Windows.Forms.CheckBox();
            this.zeroCheckbox = new System.Windows.Forms.CheckBox();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.arquivoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.abrirToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.salvarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.executarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.rodarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.passoAPassoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.acTxt = new System.Windows.Forms.TextBox();
            this.pcTxt = new System.Windows.Forms.TextBox();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.acTxt);
            this.groupBox1.Location = new System.Drawing.Point(13, 27);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(72, 49);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "AC:";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.pcTxt);
            this.groupBox2.Location = new System.Drawing.Point(91, 27);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(81, 49);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "PC:";
            // 
            // negativeCheckbox
            // 
            this.negativeCheckbox.AutoSize = true;
            this.negativeCheckbox.Location = new System.Drawing.Point(29, 96);
            this.negativeCheckbox.Name = "negativeCheckbox";
            this.negativeCheckbox.Size = new System.Drawing.Size(34, 17);
            this.negativeCheckbox.TabIndex = 2;
            this.negativeCheckbox.Text = "N";
            this.negativeCheckbox.UseVisualStyleBackColor = true;
            // 
            // zeroCheckbox
            // 
            this.zeroCheckbox.AutoSize = true;
            this.zeroCheckbox.Location = new System.Drawing.Point(113, 96);
            this.zeroCheckbox.Name = "zeroCheckbox";
            this.zeroCheckbox.Size = new System.Drawing.Size(33, 17);
            this.zeroCheckbox.TabIndex = 3;
            this.zeroCheckbox.Text = "Z";
            this.zeroCheckbox.UseVisualStyleBackColor = true;
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.arquivoToolStripMenuItem,
            this.executarToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(264, 24);
            this.menuStrip1.TabIndex = 4;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // arquivoToolStripMenuItem
            // 
            this.arquivoToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.abrirToolStripMenuItem,
            this.salvarToolStripMenuItem});
            this.arquivoToolStripMenuItem.Name = "arquivoToolStripMenuItem";
            this.arquivoToolStripMenuItem.Size = new System.Drawing.Size(61, 20);
            this.arquivoToolStripMenuItem.Text = "Arquivo";
            // 
            // abrirToolStripMenuItem
            // 
            this.abrirToolStripMenuItem.Name = "abrirToolStripMenuItem";
            this.abrirToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
            this.abrirToolStripMenuItem.Size = new System.Drawing.Size(154, 22);
            this.abrirToolStripMenuItem.Text = "Abrir...";
            this.abrirToolStripMenuItem.Click += new System.EventHandler(this.abrirToolStripMenuItem_Click);
            // 
            // salvarToolStripMenuItem
            // 
            this.salvarToolStripMenuItem.Name = "salvarToolStripMenuItem";
            this.salvarToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.S)));
            this.salvarToolStripMenuItem.Size = new System.Drawing.Size(154, 22);
            this.salvarToolStripMenuItem.Text = "Salvar...";
            this.salvarToolStripMenuItem.Click += new System.EventHandler(this.salvarToolStripMenuItem_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // executarToolStripMenuItem
            // 
            this.executarToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.rodarToolStripMenuItem,
            this.passoAPassoToolStripMenuItem});
            this.executarToolStripMenuItem.Name = "executarToolStripMenuItem";
            this.executarToolStripMenuItem.Size = new System.Drawing.Size(63, 20);
            this.executarToolStripMenuItem.Text = "Executar";
            // 
            // rodarToolStripMenuItem
            // 
            this.rodarToolStripMenuItem.Name = "rodarToolStripMenuItem";
            this.rodarToolStripMenuItem.ShortcutKeys = System.Windows.Forms.Keys.F9;
            this.rodarToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.rodarToolStripMenuItem.Text = "Rodar";
            this.rodarToolStripMenuItem.Click += new System.EventHandler(this.rodarToolStripMenuItem_Click);
            // 
            // passoAPassoToolStripMenuItem
            // 
            this.passoAPassoToolStripMenuItem.Name = "passoAPassoToolStripMenuItem";
            this.passoAPassoToolStripMenuItem.ShortcutKeys = System.Windows.Forms.Keys.F8;
            this.passoAPassoToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.passoAPassoToolStripMenuItem.Text = "Passo";
            this.passoAPassoToolStripMenuItem.Click += new System.EventHandler(this.passoAPassoToolStripMenuItem_Click);
            // 
            // acTxt
            // 
            this.acTxt.Enabled = false;
            this.acTxt.Location = new System.Drawing.Point(6, 23);
            this.acTxt.Name = "acTxt";
            this.acTxt.Size = new System.Drawing.Size(60, 20);
            this.acTxt.TabIndex = 0;
            // 
            // pcTxt
            // 
            this.pcTxt.Enabled = false;
            this.pcTxt.Location = new System.Drawing.Point(1, 23);
            this.pcTxt.Name = "pcTxt";
            this.pcTxt.Size = new System.Drawing.Size(74, 20);
            this.pcTxt.TabIndex = 0;
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 135);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(264, 22);
            this.statusStrip1.TabIndex = 5;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            // 
            // NeanderForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(264, 157);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.zeroCheckbox);
            this.Controls.Add(this.negativeCheckbox);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "NeanderForm";
            this.Text = "Neander";
            this.Load += new System.EventHandler(this.NeanderForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckBox negativeCheckbox;
        private System.Windows.Forms.CheckBox zeroCheckbox;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem arquivoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem abrirToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem salvarToolStripMenuItem;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.ToolStripMenuItem executarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem rodarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem passoAPassoToolStripMenuItem;
        private System.Windows.Forms.TextBox acTxt;
        private System.Windows.Forms.TextBox pcTxt;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
    }
}

