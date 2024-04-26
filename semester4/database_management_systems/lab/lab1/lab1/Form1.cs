using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection.Emit;
using System.Windows.Forms;

namespace lab1
{
    public partial class Form1 : Form
    {
        private SqlConnection dbConnection;
        private SqlDataAdapter dbCategories, dbEmployee;
        private DataSet tableData;
        private DataRelation relCatEmp;
        BindingSource bsCategories, bsEmployee;

        public Form1()
        {
            InitializeComponent();
        }

        private void ReloadEmployeeTableView()
        {
            if (tableData.Tables["Employee"] != null)
            {
                tableData.Tables["Employee"].Clear();
            }
            dbEmployee.Fill(tableData, "Employee");
            viewEmployee.DataSource = bsEmployee;
        }

        private void cleanTextBox()
        {
            textEmpID.Clear();
            textCatID.Clear();
            textEmpName.Clear();
            textCatName.Clear();
            textEmpSalary.Clear();
            textEmpWork.Clear();
            textEmpJob.Clear();
            textEmpExperience.Clear();
        }

        private void viewCategories_SelectionChanged(object sender, EventArgs e)
        {
            cleanTextBox();

            if (viewCategories.SelectedRows.Count != 0)
            {
                DataGridViewRow selectedRow = viewCategories.SelectedRows[0];
                dbEmployee.SelectCommand = new SqlCommand("SELECT * FROM Employee WHERE catID = " + selectedRow.Cells[0].Value, dbConnection);
                ReloadEmployeeTableView();
            }
        }

        private void viewEmployee_SelectionChanged(object sender, EventArgs e)
        {
            if (viewEmployee.SelectedRows.Count != 0)
            {
                DataGridViewRow selectedRowEmp = viewEmployee.SelectedRows[0];
                DataGridViewRow selectedRowCat = viewCategories.SelectedRows[0];
                textEmpID.Text = selectedRowEmp.Cells[0].Value.ToString();
                textCatID.Text = selectedRowCat.Cells[0].Value.ToString();
                textEmpName.Text = selectedRowEmp.Cells[2].Value.ToString();
                textCatName.Text = selectedRowCat.Cells[1].Value.ToString();
                textEmpSalary.Text = selectedRowEmp.Cells[3].Value.ToString();
                textEmpWork.Text = selectedRowEmp.Cells[4].Value.ToString();
                textEmpJob.Text = selectedRowEmp.Cells[5].Value.ToString();
                textEmpExperience.Text = selectedRowEmp.Cells[6].Value.ToString();
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dbConnection = new SqlConnection(@"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=AppleStore;Integrated Security=True;");
            dbConnection.Open();

            dbCategories = new SqlDataAdapter("SELECT * FROM Categories", dbConnection);
            tableData = new DataSet();
            dbCategories.Fill(tableData, "Categories");
            viewCategories.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            dbEmployee = new SqlDataAdapter("SELECT * FROM Employee", dbConnection);
            dbEmployee.Fill(tableData, "Employee");
            viewEmployee.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            DataColumn managerCatID = tableData.Tables["Categories"].Columns["catID"];
            DataColumn managerEmpID = tableData.Tables["Employee"].Columns["catID"];
            relCatEmp = new DataRelation("FK_CATEGORIES_EMPLOYEE", managerCatID, managerEmpID);
            tableData.Relations.Add(relCatEmp);

            bsCategories = new BindingSource();
            bsCategories.DataSource = tableData;
            bsCategories.DataMember = "Categories";

            bsEmployee = new BindingSource();
            bsEmployee.DataSource = bsCategories;
            bsEmployee.DataMember = "FK_CATEGORIES_EMPLOYEE";
            viewCategories.DataSource = bsCategories;
        }

        private void clearButton_Click(object sender, EventArgs e)
        {
            cleanTextBox();
        }

        private void addButton_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("INSERT INTO Employee VALUES (@empID, @catID, @empName, @empSalary, @empWork, @empJob, @empExperience)", dbConnection);
            if (textEmpID.Text.Length != 0)
            {
                try
                {
                    int emp_id = Int32.Parse(textEmpID.Text);
                    if (textCatID.Text.Length != 0)
                    {
                        int cat_id = Int32.Parse(textCatID.Text);
                        int salary, work, experience;
                        if (textEmpSalary.Text.Length != 0 || textEmpWork.Text.Length != 0 ||
                            textEmpExperience.Text.Length != 0)
                        {
                            salary = Int32.Parse(textEmpSalary.Text);
                            work = Int32.Parse(textEmpWork.Text);
                            experience = Int32.Parse(textEmpExperience.Text);
                        }
                        else
                        {
                            salary = 0;
                            work = 0;
                            experience = 0;
                        }
                        command.Parameters.Add("@empID", SqlDbType.Int);
                        command.Parameters["@empID"].Value = emp_id;
                        command.Parameters.Add("@catID", SqlDbType.Int);
                        command.Parameters["@catID"].Value = cat_id;
                        command.Parameters.Add("@empName", SqlDbType.VarChar, 100);
                        command.Parameters["@empName"].Value = textEmpName.Text;
                        command.Parameters.Add("@empSalary", SqlDbType.Int);
                        command.Parameters["@empSalary"].Value = salary;
                        command.Parameters.Add("@empWork", SqlDbType.Int);
                        command.Parameters["@empWork"].Value = work;
                        command.Parameters.Add("@empJob", SqlDbType.VarChar, 100);
                        command.Parameters["@empJob"].Value = textEmpJob.Text;
                        command.Parameters.Add("@empExperience", SqlDbType.Int);
                        command.Parameters["@empExperience"].Value = experience;
                        try
                        {
                            dbEmployee.InsertCommand = command;
                            dbEmployee.InsertCommand.ExecuteNonQuery();
                            ReloadEmployeeTableView();
                        }
                        catch (SqlException sqlException)
                        {
                            if (sqlException.Number == 2627)
                                MessageBox.Show("The employer id must be unique!");
                            else if (sqlException.Number == 547)
                                MessageBox.Show("There's no category with the given id!");
                            else
                                MessageBox.Show(sqlException.Message);
                        }
                    }
                    else
                        MessageBox.Show("Please provide a category id!");
                }
                catch (FormatException ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
                MessageBox.Show("Please provide a employer id!");
        }

        private void removeButton_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("DELETE FROM Employee WHERE empID = @empID", dbConnection);
            if (textEmpID.Text.Length != 0)
            {
                int emp_id = Int32.Parse(textEmpID.Text);
                command.Parameters.Add("@empID", SqlDbType.Int);
                command.Parameters["@empID"].Value = emp_id;
                try
                {
                    dbEmployee.DeleteCommand = command;
                    int numberOfDeletedEmployee = dbEmployee.DeleteCommand.ExecuteNonQuery();
                    if (numberOfDeletedEmployee == 0)
                    {
                        MessageBox.Show("There is no employer with the given id!");
                    }
                    else
                    {
                        ReloadEmployeeTableView();
                    }
                }
                catch (SqlException sqlException)
                {
                    MessageBox.Show(sqlException.ToString());
                }
            }
            else
                MessageBox.Show("Please provide a employer id!");
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("UPDATE Employee SET catID = @catID, empName = @empName, empSalary = @empSalary, empWork = @empWork, empJob = @empJob, empExperience = @empExperience WHERE empID = @empID", dbConnection);

            int emp_id = Int32.Parse(textEmpID.Text);
            int cat_id = Int32.Parse(textCatID.Text);
            int salary = Int32.Parse(textEmpSalary.Text);
            int work = Int32.Parse(textEmpWork.Text);
            int experience = Int32.Parse(textEmpExperience.Text);

            command.Parameters.Add("@empID", SqlDbType.Int);
            command.Parameters["@empID"].Value = emp_id;
            command.Parameters.Add("@catID", SqlDbType.Int);
            command.Parameters["@catID"].Value = cat_id;
            command.Parameters.Add("@empName", SqlDbType.VarChar, 100);
            command.Parameters["@empName"].Value = textEmpName.Text;
            command.Parameters.Add("@empSalary", SqlDbType.Int);
            command.Parameters["@empSalary"].Value = salary;
            command.Parameters.Add("@empWork", SqlDbType.Int);
            command.Parameters["@empWork"].Value = work;
            command.Parameters.Add("@empJob", SqlDbType.VarChar, 100);
            command.Parameters["@empJob"].Value = textEmpJob.Text;
            command.Parameters.Add("@empExperience", SqlDbType.Int);
            command.Parameters["@empExperience"].Value = experience;

            try
            {
                dbEmployee.UpdateCommand = command;
                int numberOfUpdatedEmployee = dbEmployee.UpdateCommand.ExecuteNonQuery();
                if (numberOfUpdatedEmployee == 0)
                {
                    MessageBox.Show("There is no employer with the given id!");

                }
                else
                {
                    ReloadEmployeeTableView();
                }
            }
            catch (SqlException sqlException)
            {
                if (sqlException.Number == 2627)
                    MessageBox.Show("The employer id must be unique!");
                else if (sqlException.Number == 547)
                    MessageBox.Show("There's no category with the given id!");
                else
                    MessageBox.Show(sqlException.Message);
            }
        }

        private void allEmployeeButton_Click(object sender, EventArgs e)
        {
            ReloadEmployeeTableView();
            Form2 form2 = new Form2();
            form2.Show();
        }

        private void dataGridViewUpdate()
        {
            viewCategories.ClearSelection();
            viewCategories.Rows[bsCategories.Position].Selected = true;
        }
        private void firstButton_Click(object sender, EventArgs e)
        {
            bsCategories.MoveFirst();
            dataGridViewUpdate();
        }

        private void previousButton_Click(object sender, EventArgs e)
        {
            bsCategories.MovePrevious();
            dataGridViewUpdate();
        }

        private void nextButton_Click(object sender, EventArgs e)
        {
            bsCategories.MoveNext();
            dataGridViewUpdate();
        }

        private void lastButton_Click(object sender, EventArgs e)
        {
            bsCategories.MoveLast();
            dataGridViewUpdate();
        }

        private void dataGridViewUpdateEmp()
        {
            viewEmployee.ClearSelection();
            viewEmployee.Rows[bsEmployee.Position].Selected = true;
        }

        private void buttonP_Click(object sender, EventArgs e)
        {
            bsEmployee.MovePrevious();
            dataGridViewUpdateEmp();
        }

        private void buttonN_Click(object sender, EventArgs e)
        {
            bsEmployee.MoveNext();
            dataGridViewUpdateEmp();
        }
    }
}
