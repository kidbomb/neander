using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace NeanderSharp
{
    public partial class ProgramForm : Form
    {
        public ProgramForm()
        {
            InitializeComponent();
        }

        private void ProgramForm_Load(object sender, EventArgs e)
        {
            
        }

        public BindingList<MemEntry> DataSource
        {
            set { dataGridView1.DataSource = value; }
        }

        private void dataGridView1_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {

        }

        public void UpdateDataGridView()
        {
            dataGridView1.Invalidate();
        }
    }
}
