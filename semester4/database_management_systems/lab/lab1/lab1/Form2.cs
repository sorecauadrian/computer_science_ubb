using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab1
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            SqlConnection cs = new SqlConnection(@"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=AppleStore;Integrated Security=True;");
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            BindingSource bs = new BindingSource();

            da.SelectCommand = new SqlCommand("SELECT * FROM Employee", cs);
            ds.Clear(); 
            da.Fill(ds);
            viewEmployee.DataSource = ds.Tables[0];
            bs.DataSource = ds.Tables[0];
        }
    }
}
