using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using NeanderSharp;

namespace NeanderSharp
{
    public partial class NeanderForm : Form
    {
        NeanderSharp.Neander neander;
        ProgramForm programa;
        public NeanderForm()
        {
            InitializeComponent();
        }

        private void NeanderForm_Load(object sender, EventArgs e)
        {
            negativeCheckbox.Enabled = false;
            zeroCheckbox.Enabled = false;
            neander = new NeanderSharp.Neander();
            neander.PropertyChanged += new PropertyChangedEventHandler(neander_PropertyChanged);
            programa = new ProgramForm();
            programa.DataSource = new MemEntryBindingList(neander.Memory);
            programa.Show();
        }

        void neander_PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            switch (e.PropertyName)
            {
                case "AC":
                    acTxt.Text = neander.AC.ToString();
                    break;
                case "PC":
                    pcTxt.Text = neander.PC.ToString();
                    break;
            }

        }

        private void salvarToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void abrirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DialogResult resultAbrir = openFileDialog1.ShowDialog();
            if (resultAbrir == DialogResult.OK)
            {
                MemReader r = new MemReader(openFileDialog1.FileName);
                r.ReadHeader();
                
                for (int i = 0; i <= 255; i++)
                {
                    neander.Memory[i] = r.ReadByte();
                }
            }
            programa.UpdateDataGridView();
        }

        private void rodarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //TODO: put it in a thread
            neander.Run();
            for (int i = 0; i < 256; i++)
            {
                Console.WriteLine("[{0}] - {1}", i, neander.Memory[i]);
            }
        }

        private void passoAPassoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                neander.Step();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
