using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Configuration;

namespace Lab2
{
    public partial class Form1 : Form
    {
        private SqlConnection dbConnection;         // Connection to the database
        private SqlDataAdapter daParent, daChild;   // Data adapters for parent and child tables
        private DataSet tableData;                  // DataSet to store table data
        private DataRelation drParentChild;         // Data relation between parent and child tables
        private BindingSource bsParent, bsChild;    // Binding sources for parent and child tables

        public Form1()
        {
            InitializeComponent();
        }

        private string getParentTableName()
        {
            // Retrieve the parent table name from the configuration file
            return ConfigurationManager.AppSettings["ParentTableName"].ToString();
        }

        private string getChildTableName()
        {
            // Retrieve the child table name from the configuration file
            return ConfigurationManager.AppSettings["ChildTableName"].ToString();
        }

        private string getParentSelectQuery()
        {
            // Retrieve the select query for the parent table from the configuration file
            return ConfigurationManager.AppSettings["ParentSelectQuery"].ToString();
        }

        private string getChildSelectQuery()
        {
            // Retrieve the select query for the child table from the configuration file
            return ConfigurationManager.AppSettings["ChildSelectQuery"].ToString();
        }

        private string getParentReferencedKey()
        {
            // Retrieve the referenced key in the parent table from the configuration file
            return ConfigurationManager.AppSettings["ParentReferencedKey"].ToString();
        }

        private string getChildForeignKey()
        {
            // Retrieve the foreign key in the child table from the configuration file
            return ConfigurationManager.AppSettings["ChildForeignKey"].ToString();
        }

        private string getParentSelectionQuery()
        {
            // Retrieve the selection query for the parent table from the configuration file
            return ConfigurationManager.AppSettings["ParentSelectionQuery"].ToString();
        }

        private void parentTableView_SelectionChanged(object sender, EventArgs e)
        {
            if (parentTableView.SelectedRows.Count != 0)
            {
                // Retrieve the selected parent row
                DataGridViewRow selectedRow = parentTableView.SelectedRows[0];

                // Construct the selection query for child records based on the selected parent row
                string selectCommandString = String.Format(getParentSelectionQuery(), selectedRow.Cells[0].Value);

                // Set the select command of the child data adapter to fetch the relevant child records
                daChild.SelectCommand = new SqlCommand(selectCommandString, dbConnection);

                // Reload the child table view with the updated child records
                ReloadChildTableView();
            }
        }

        private void childTableView_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            if (e.Exception is InvalidConstraintException)
                MessageBox.Show("The parent id you provided does not exist!");
            else if (e.Exception is FormatException)
                MessageBox.Show(e.Exception.Message);
            else
                try
                {
                    throw e.Exception;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            SqlCommandBuilder builder = new SqlCommandBuilder(daChild);
            daChild.UpdateCommand = builder.GetUpdateCommand();
            daChild.InsertCommand = builder.GetInsertCommand();
            daChild.DeleteCommand = builder.GetDeleteCommand();

            try
            {
                daChild.Update(tableData, getChildTableName());
            }
            catch (SqlException sqlException)
            {
                if (sqlException.Number == 2627)
                    MessageBox.Show("There is column data that should be unique in the table!");
                else if (sqlException.Number == 547)
                    MessageBox.Show("There's no parent with the given id!");
                else
                    MessageBox.Show(sqlException.Message);
            }

            ReloadChildTableView();
        }

        private void ReloadChildTableView()
        {
            if (tableData.Tables[getChildTableName()] != null)
            {
                tableData.Tables[getChildTableName()].Clear();
            }

            // Fill the child table data using the child data adapter
            daChild.Fill(tableData, getChildTableName());

            // Set the data source of the child table view to the child binding source
            childTableView.DataSource = bsChild;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // Establish a connection to the database using the connection string
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string database = ConfigurationManager.AppSettings["Database"];

            dbConnection = new SqlConnection(String.Format(connectionString, database));
            dbConnection.Open();

            // Initialize the DataSet
            tableData = new DataSet();

            // Create a data adapter for the parent table and fill the parent table data in the DataSet
            daParent = new SqlDataAdapter(getParentSelectQuery(), dbConnection);
            daParent.Fill(tableData, getParentTableName());
            parentTableView.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            // Create a data adapter for the child table and fill the child table data in the DataSet
            daChild = new SqlDataAdapter(getChildSelectQuery(), dbConnection);
            daChild.Fill(tableData, getChildTableName());
            childTableView.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            // Define the relationship between the parent and child tables
            DataColumn referenceId = tableData.Tables[getParentTableName()].Columns[getParentReferencedKey()];
            DataColumn foreignId = tableData.Tables[getChildTableName()].Columns[getChildForeignKey()];
            drParentChild = new DataRelation("FK_Parent_Child", referenceId, foreignId);
            tableData.Relations.Add(drParentChild);

            // Set up the binding sources for the parent and child tables
            bsParent = new BindingSource();
            bsParent.DataSource = tableData;
            bsParent.DataMember = getParentTableName();

            bsChild = new BindingSource();
            bsChild.DataSource = bsParent;
            bsChild.DataMember = "FK_Parent_Child";

            // Set the data source of the parent table view to the parent binding source
            parentTableView.DataSource = bsParent;
        }
    }
}