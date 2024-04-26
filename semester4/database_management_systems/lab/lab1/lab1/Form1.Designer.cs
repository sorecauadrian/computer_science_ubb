using System.Drawing;
using System.Windows.Forms;

namespace lab1
{
    partial class Form1
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
            viewCategories = new DataGridView();
            viewEmployee = new DataGridView();
            labelCategories = new Label();
            labelEmployee = new Label();
            labelEmpID = new Label();
            labelCatID = new Label();
            labelEmpName = new Label();
            labelCatName = new Label();
            labelEmpSalary = new Label();
            labelEmpWork = new Label();
            labelEmpJob = new Label();
            labelEmpExperience = new Label();
            textEmpID = new TextBox();
            textCatID = new TextBox();
            textEmpName = new TextBox();
            textCatName = new TextBox();
            textEmpSalary = new TextBox();
            textEmpWork = new TextBox();
            textEmpJob = new TextBox();
            textEmpExperience = new TextBox();
            addButton = new Button();
            removeButton = new Button();
            updateButton = new Button();
            clearButton = new Button();
            allEmployeeButton = new Button();
            tableLayoutPanel1 = new TableLayoutPanel();
            tableLayoutPanel2 = new TableLayoutPanel();
            firstButton = new Button();
            previousButton = new Button();
            nextButton = new Button();
            buttonP = new Button();
            buttonN = new Button();
            lastButton = new Button();
            tableLayoutPanel3 = new TableLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)viewCategories).BeginInit();
            ((System.ComponentModel.ISupportInitialize)viewEmployee).BeginInit();
            tableLayoutPanel1.SuspendLayout();
            tableLayoutPanel2.SuspendLayout();
            tableLayoutPanel3.SuspendLayout();
            SuspendLayout();
            // 
            // viewCategories
            // 
            viewCategories.AllowUserToAddRows = false;
            viewCategories.AllowUserToDeleteRows = false;
            viewCategories.BackgroundColor = Color.Snow;
            viewCategories.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            viewCategories.Dock = DockStyle.Fill;
            viewCategories.Location = new Point(636, 25);
            viewCategories.Margin = new Padding(3, 2, 3, 2);
            viewCategories.Name = "viewCategories";
            viewCategories.ReadOnly = true;
            viewCategories.RowHeadersWidth = 51;
            viewCategories.RowTemplate.Height = 24;
            viewCategories.Size = new Size(592, 369);
            viewCategories.TabIndex = 0;
            viewCategories.SelectionChanged += viewCategories_SelectionChanged;
            // 
            // viewEmployee
            // 
            viewEmployee.AllowUserToAddRows = false;
            viewEmployee.AllowUserToDeleteRows = false;
            viewEmployee.BackgroundColor = Color.Snow;
            viewEmployee.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            viewEmployee.Dock = DockStyle.Fill;
            viewEmployee.Location = new Point(3, 25);
            viewEmployee.Margin = new Padding(3, 2, 3, 2);
            viewEmployee.Name = "viewEmployee";
            viewEmployee.RowHeadersWidth = 51;
            viewEmployee.RowTemplate.Height = 24;
            viewEmployee.Size = new Size(627, 369);
            viewEmployee.TabIndex = 1;
            viewEmployee.SelectionChanged += viewEmployee_SelectionChanged;
            // 
            // labelCategories
            // 
            labelCategories.AutoSize = true;
            labelCategories.Dock = DockStyle.Fill;
            labelCategories.Font = new Font("Trebuchet MS", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            labelCategories.ForeColor = Color.Purple;
            labelCategories.Location = new Point(636, 0);
            labelCategories.Name = "labelCategories";
            labelCategories.Size = new Size(592, 23);
            labelCategories.TabIndex = 2;
            labelCategories.Text = "Categories";
            labelCategories.TextAlign = ContentAlignment.TopCenter;
            // 
            // labelEmployee
            // 
            labelEmployee.AutoSize = true;
            labelEmployee.Dock = DockStyle.Fill;
            labelEmployee.Font = new Font("Trebuchet MS", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            labelEmployee.ForeColor = Color.Purple;
            labelEmployee.Location = new Point(3, 0);
            labelEmployee.Name = "labelEmployee";
            labelEmployee.Size = new Size(627, 23);
            labelEmployee.TabIndex = 3;
            labelEmployee.Text = "Employee Of a Category";
            labelEmployee.TextAlign = ContentAlignment.TopCenter;
            // 
            // labelEmpID
            // 
            labelEmpID.AutoSize = true;
            labelEmpID.Dock = DockStyle.Fill;
            labelEmpID.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpID.Location = new Point(5, 2);
            labelEmpID.Name = "labelEmpID";
            labelEmpID.Size = new Size(109, 31);
            labelEmpID.TabIndex = 4;
            labelEmpID.Text = "Employer ID";
            // 
            // labelCatID
            // 
            labelCatID.AutoSize = true;
            labelCatID.Dock = DockStyle.Fill;
            labelCatID.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelCatID.Location = new Point(354, 2);
            labelCatID.Name = "labelCatID";
            labelCatID.Size = new Size(107, 31);
            labelCatID.TabIndex = 5;
            labelCatID.Text = "Category ID";
            // 
            // labelEmpName
            // 
            labelEmpName.AutoSize = true;
            labelEmpName.Dock = DockStyle.Left;
            labelEmpName.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpName.Location = new Point(5, 35);
            labelEmpName.Name = "labelEmpName";
            labelEmpName.Size = new Size(60, 31);
            labelEmpName.TabIndex = 6;
            labelEmpName.Text = "Name";
            // 
            // labelCatName
            // 
            labelCatName.AutoSize = true;
            labelCatName.Dock = DockStyle.Fill;
            labelCatName.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelCatName.Location = new Point(354, 35);
            labelCatName.Name = "labelCatName";
            labelCatName.Size = new Size(107, 31);
            labelCatName.TabIndex = 7;
            labelCatName.Text = "Name";
            // 
            // labelEmpSalary
            // 
            labelEmpSalary.AutoSize = true;
            labelEmpSalary.Dock = DockStyle.Left;
            labelEmpSalary.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpSalary.Location = new Point(5, 68);
            labelEmpSalary.Name = "labelEmpSalary";
            labelEmpSalary.Size = new Size(59, 31);
            labelEmpSalary.TabIndex = 8;
            labelEmpSalary.Text = "Salary";
            // 
            // labelEmpWork
            // 
            labelEmpWork.AutoSize = true;
            labelEmpWork.Dock = DockStyle.Fill;
            labelEmpWork.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpWork.Location = new Point(5, 101);
            labelEmpWork.Name = "labelEmpWork";
            labelEmpWork.Size = new Size(109, 31);
            labelEmpWork.TabIndex = 9;
            labelEmpWork.Text = "Work";
            // 
            // labelEmpJob
            // 
            labelEmpJob.AutoSize = true;
            labelEmpJob.Dock = DockStyle.Left;
            labelEmpJob.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpJob.Location = new Point(5, 134);
            labelEmpJob.Name = "labelEmpJob";
            labelEmpJob.Size = new Size(38, 31);
            labelEmpJob.TabIndex = 10;
            labelEmpJob.Text = "Job";
            // 
            // labelEmpExperience
            // 
            labelEmpExperience.AutoSize = true;
            labelEmpExperience.Dock = DockStyle.Left;
            labelEmpExperience.Font = new Font("Microsoft YaHei Light", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            labelEmpExperience.Location = new Point(5, 167);
            labelEmpExperience.Name = "labelEmpExperience";
            labelEmpExperience.Size = new Size(98, 31);
            labelEmpExperience.TabIndex = 11;
            labelEmpExperience.Text = "Experience";
            // 
            // textEmpID
            // 
            textEmpID.Dock = DockStyle.Left;
            textEmpID.Location = new Point(122, 4);
            textEmpID.Margin = new Padding(3, 2, 3, 2);
            textEmpID.Name = "textEmpID";
            textEmpID.Size = new Size(224, 27);
            textEmpID.TabIndex = 12;
            // 
            // textCatID
            // 
            textCatID.Dock = DockStyle.Left;
            textCatID.Location = new Point(469, 4);
            textCatID.Margin = new Padding(3, 2, 3, 2);
            textCatID.Name = "textCatID";
            textCatID.Size = new Size(143, 27);
            textCatID.TabIndex = 13;
            // 
            // textEmpName
            // 
            textEmpName.Dock = DockStyle.Left;
            textEmpName.Location = new Point(122, 37);
            textEmpName.Margin = new Padding(3, 2, 3, 2);
            textEmpName.Name = "textEmpName";
            textEmpName.Size = new Size(224, 27);
            textEmpName.TabIndex = 14;
            // 
            // textCatName
            // 
            textCatName.Dock = DockStyle.Left;
            textCatName.Location = new Point(469, 37);
            textCatName.Margin = new Padding(3, 2, 3, 2);
            textCatName.Name = "textCatName";
            textCatName.ReadOnly = true;
            textCatName.Size = new Size(143, 27);
            textCatName.TabIndex = 15;
            // 
            // textEmpSalary
            // 
            textEmpSalary.Dock = DockStyle.Left;
            textEmpSalary.Location = new Point(122, 70);
            textEmpSalary.Margin = new Padding(3, 2, 3, 2);
            textEmpSalary.Name = "textEmpSalary";
            textEmpSalary.Size = new Size(224, 27);
            textEmpSalary.TabIndex = 16;
            // 
            // textEmpWork
            // 
            textEmpWork.Dock = DockStyle.Left;
            textEmpWork.Location = new Point(122, 103);
            textEmpWork.Margin = new Padding(3, 2, 3, 2);
            textEmpWork.Name = "textEmpWork";
            textEmpWork.Size = new Size(224, 27);
            textEmpWork.TabIndex = 17;
            // 
            // textEmpJob
            // 
            textEmpJob.Dock = DockStyle.Left;
            textEmpJob.Location = new Point(122, 136);
            textEmpJob.Margin = new Padding(3, 2, 3, 2);
            textEmpJob.Name = "textEmpJob";
            textEmpJob.Size = new Size(224, 27);
            textEmpJob.TabIndex = 18;
            // 
            // textEmpExperience
            // 
            textEmpExperience.Dock = DockStyle.Left;
            textEmpExperience.Location = new Point(122, 169);
            textEmpExperience.Margin = new Padding(3, 2, 3, 2);
            textEmpExperience.Name = "textEmpExperience";
            textEmpExperience.Size = new Size(224, 27);
            textEmpExperience.TabIndex = 19;
            // 
            // addButton
            // 
            addButton.BackColor = Color.RosyBrown;
            addButton.Dock = DockStyle.Fill;
            addButton.FlatAppearance.BorderColor = Color.DarkViolet;
            addButton.Font = new Font("Microsoft YaHei UI", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            addButton.ForeColor = SystemColors.ActiveCaptionText;
            addButton.Location = new Point(3, 2);
            addButton.Margin = new Padding(3, 2, 3, 2);
            addButton.Name = "addButton";
            addButton.Size = new Size(586, 68);
            addButton.TabIndex = 20;
            addButton.Text = "Add Employer";
            addButton.UseVisualStyleBackColor = false;
            addButton.Click += addButton_Click;
            // 
            // removeButton
            // 
            removeButton.BackColor = Color.RosyBrown;
            removeButton.Dock = DockStyle.Fill;
            removeButton.Font = new Font("Microsoft YaHei UI", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            removeButton.Location = new Point(3, 74);
            removeButton.Margin = new Padding(3, 2, 3, 2);
            removeButton.Name = "removeButton";
            removeButton.Size = new Size(586, 68);
            removeButton.TabIndex = 21;
            removeButton.Text = "Remove Employer";
            removeButton.UseVisualStyleBackColor = false;
            removeButton.Click += removeButton_Click;
            // 
            // updateButton
            // 
            updateButton.BackColor = Color.RosyBrown;
            updateButton.Dock = DockStyle.Fill;
            updateButton.Font = new Font("Microsoft YaHei UI", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            updateButton.Location = new Point(3, 146);
            updateButton.Margin = new Padding(3, 2, 3, 2);
            updateButton.Name = "updateButton";
            updateButton.Size = new Size(586, 68);
            updateButton.TabIndex = 22;
            updateButton.Text = "Update Employer";
            updateButton.UseVisualStyleBackColor = false;
            updateButton.Click += updateButton_Click;
            // 
            // clearButton
            // 
            clearButton.BackColor = Color.RosyBrown;
            clearButton.Dock = DockStyle.Fill;
            clearButton.Font = new Font("Microsoft YaHei UI", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            clearButton.Location = new Point(3, 218);
            clearButton.Margin = new Padding(3, 2, 3, 2);
            clearButton.Name = "clearButton";
            clearButton.Size = new Size(586, 74);
            clearButton.TabIndex = 23;
            clearButton.Text = "Clear All";
            clearButton.UseVisualStyleBackColor = false;
            clearButton.Click += clearButton_Click;
            // 
            // allEmployeeButton
            // 
            allEmployeeButton.BackColor = Color.RosyBrown;
            allEmployeeButton.Dock = DockStyle.Top;
            allEmployeeButton.Font = new Font("Microsoft YaHei UI", 10.8F, FontStyle.Regular, GraphicsUnit.Point);
            allEmployeeButton.Location = new Point(3, 296);
            allEmployeeButton.Margin = new Padding(3, 2, 3, 2);
            allEmployeeButton.Name = "allEmployeeButton";
            allEmployeeButton.Size = new Size(586, 72);
            allEmployeeButton.TabIndex = 24;
            allEmployeeButton.Text = "All Employee";
            allEmployeeButton.UseVisualStyleBackColor = false;
            allEmployeeButton.Click += allEmployeeButton_Click;
            // 
            // tableLayoutPanel1
            // 
            tableLayoutPanel1.ColumnCount = 2;
            tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 51.421608F));
            tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 48.578392F));
            tableLayoutPanel1.Controls.Add(labelEmployee, 0, 0);
            tableLayoutPanel1.Controls.Add(viewEmployee, 0, 1);
            tableLayoutPanel1.Controls.Add(labelCategories, 1, 0);
            tableLayoutPanel1.Controls.Add(viewCategories, 1, 1);
            tableLayoutPanel1.Controls.Add(tableLayoutPanel2, 0, 2);
            tableLayoutPanel1.Controls.Add(tableLayoutPanel3, 1, 2);
            tableLayoutPanel1.Location = new Point(0, 0);
            tableLayoutPanel1.Margin = new Padding(3, 2, 3, 2);
            tableLayoutPanel1.Name = "tableLayoutPanel1";
            tableLayoutPanel1.RowCount = 3;
            tableLayoutPanel1.RowStyles.Add(new RowStyle());
            tableLayoutPanel1.RowStyles.Add(new RowStyle());
            tableLayoutPanel1.RowStyles.Add(new RowStyle());
            tableLayoutPanel1.Size = new Size(1231, 778);
            tableLayoutPanel1.TabIndex = 25;
            // 
            // tableLayoutPanel2
            // 
            tableLayoutPanel2.CellBorderStyle = TableLayoutPanelCellBorderStyle.Inset;
            tableLayoutPanel2.ColumnCount = 4;
            tableLayoutPanel2.ColumnStyles.Add(new ColumnStyle());
            tableLayoutPanel2.ColumnStyles.Add(new ColumnStyle());
            tableLayoutPanel2.ColumnStyles.Add(new ColumnStyle());
            tableLayoutPanel2.ColumnStyles.Add(new ColumnStyle());
            tableLayoutPanel2.Controls.Add(labelCatID, 2, 0);
            tableLayoutPanel2.Controls.Add(textCatID, 3, 0);
            tableLayoutPanel2.Controls.Add(labelCatName, 2, 1);
            tableLayoutPanel2.Controls.Add(textCatName, 3, 1);
            tableLayoutPanel2.Controls.Add(labelEmpID, 0, 0);
            tableLayoutPanel2.Controls.Add(textEmpID, 1, 0);
            tableLayoutPanel2.Controls.Add(labelEmpName, 0, 1);
            tableLayoutPanel2.Controls.Add(textEmpName, 1, 1);
            tableLayoutPanel2.Controls.Add(labelEmpSalary, 0, 2);
            tableLayoutPanel2.Controls.Add(textEmpSalary, 1, 2);
            tableLayoutPanel2.Controls.Add(labelEmpWork, 0, 3);
            tableLayoutPanel2.Controls.Add(textEmpWork, 1, 3);
            tableLayoutPanel2.Controls.Add(labelEmpJob, 0, 4);
            tableLayoutPanel2.Controls.Add(textEmpJob, 1, 4);
            tableLayoutPanel2.Controls.Add(labelEmpExperience, 0, 5);
            tableLayoutPanel2.Controls.Add(textEmpExperience, 1, 5);
            tableLayoutPanel2.Controls.Add(firstButton, 0, 7);
            tableLayoutPanel2.Controls.Add(previousButton, 1, 7);
            tableLayoutPanel2.Controls.Add(nextButton, 2, 7);
            tableLayoutPanel2.Controls.Add(buttonP, 0, 6);
            tableLayoutPanel2.Controls.Add(buttonN, 1, 6);
            tableLayoutPanel2.Controls.Add(lastButton, 3, 7);
            tableLayoutPanel2.Dock = DockStyle.Fill;
            tableLayoutPanel2.Location = new Point(3, 398);
            tableLayoutPanel2.Margin = new Padding(3, 2, 3, 2);
            tableLayoutPanel2.Name = "tableLayoutPanel2";
            tableLayoutPanel2.RowCount = 8;
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.RowStyles.Add(new RowStyle());
            tableLayoutPanel2.Size = new Size(627, 378);
            tableLayoutPanel2.TabIndex = 26;
            // 
            // firstButton
            // 
            firstButton.Dock = DockStyle.Bottom;
            firstButton.FlatAppearance.BorderColor = Color.DarkRed;
            firstButton.FlatAppearance.BorderSize = 2;
            firstButton.FlatAppearance.CheckedBackColor = Color.FromArgb(255, 192, 255);
            firstButton.FlatStyle = FlatStyle.System;
            firstButton.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            firstButton.ForeColor = Color.DarkSlateBlue;
            firstButton.Location = new Point(5, 319);
            firstButton.Name = "firstButton";
            firstButton.Size = new Size(109, 54);
            firstButton.TabIndex = 27;
            firstButton.Text = "First";
            firstButton.UseVisualStyleBackColor = true;
            firstButton.Click += firstButton_Click;
            // 
            // previousButton
            // 
            previousButton.Dock = DockStyle.Bottom;
            previousButton.FlatAppearance.BorderColor = Color.DarkRed;
            previousButton.FlatAppearance.BorderSize = 2;
            previousButton.FlatAppearance.CheckedBackColor = Color.FromArgb(255, 192, 255);
            previousButton.FlatStyle = FlatStyle.System;
            previousButton.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            previousButton.ForeColor = Color.DarkSlateBlue;
            previousButton.Location = new Point(122, 319);
            previousButton.Name = "previousButton";
            previousButton.Size = new Size(224, 54);
            previousButton.TabIndex = 28;
            previousButton.Text = "Previous";
            previousButton.UseVisualStyleBackColor = true;
            previousButton.Click += previousButton_Click;
            // 
            // nextButton
            // 
            nextButton.Dock = DockStyle.Bottom;
            nextButton.FlatAppearance.BorderColor = Color.DarkRed;
            nextButton.FlatAppearance.BorderSize = 2;
            nextButton.FlatAppearance.CheckedBackColor = Color.FromArgb(255, 192, 255);
            nextButton.FlatStyle = FlatStyle.System;
            nextButton.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            nextButton.ForeColor = Color.DarkSlateBlue;
            nextButton.Location = new Point(354, 319);
            nextButton.Name = "nextButton";
            nextButton.Size = new Size(107, 54);
            nextButton.TabIndex = 29;
            nextButton.Text = "Next";
            nextButton.UseVisualStyleBackColor = true;
            nextButton.Click += nextButton_Click;
            // 
            // buttonP
            // 
            buttonP.Dock = DockStyle.Left;
            buttonP.Location = new Point(5, 203);
            buttonP.Name = "buttonP";
            buttonP.Size = new Size(94, 29);
            buttonP.TabIndex = 30;
            buttonP.Text = "△";
            buttonP.UseVisualStyleBackColor = true;
            buttonP.Click += buttonP_Click;
            // 
            // buttonN
            // 
            buttonN.Dock = DockStyle.Left;
            buttonN.Location = new Point(122, 203);
            buttonN.Name = "buttonN";
            buttonN.Size = new Size(94, 29);
            buttonN.TabIndex = 31;
            buttonN.Text = "▽";
            buttonN.UseVisualStyleBackColor = true;
            buttonN.Click += buttonN_Click;
            // 
            // lastButton
            // 
            lastButton.Dock = DockStyle.Bottom;
            lastButton.FlatAppearance.BorderColor = Color.DarkRed;
            lastButton.FlatAppearance.BorderSize = 2;
            lastButton.FlatAppearance.CheckedBackColor = Color.FromArgb(255, 192, 255);
            lastButton.FlatStyle = FlatStyle.System;
            lastButton.Font = new Font("Segoe UI Semibold", 10.8F, FontStyle.Bold, GraphicsUnit.Point);
            lastButton.ForeColor = Color.DarkSlateBlue;
            lastButton.Location = new Point(469, 319);
            lastButton.Name = "lastButton";
            lastButton.Size = new Size(153, 54);
            lastButton.TabIndex = 32;
            lastButton.Text = "Last";
            lastButton.UseVisualStyleBackColor = true;
            lastButton.Click += lastButton_Click;
            // 
            // tableLayoutPanel3
            // 
            tableLayoutPanel3.ColumnCount = 1;
            tableLayoutPanel3.ColumnStyles.Add(new ColumnStyle());
            tableLayoutPanel3.Controls.Add(addButton, 0, 0);
            tableLayoutPanel3.Controls.Add(removeButton, 0, 1);
            tableLayoutPanel3.Controls.Add(updateButton, 0, 2);
            tableLayoutPanel3.Controls.Add(clearButton, 0, 3);
            tableLayoutPanel3.Controls.Add(allEmployeeButton, 0, 4);
            tableLayoutPanel3.Dock = DockStyle.Fill;
            tableLayoutPanel3.Location = new Point(636, 398);
            tableLayoutPanel3.Margin = new Padding(3, 2, 3, 2);
            tableLayoutPanel3.Name = "tableLayoutPanel3";
            tableLayoutPanel3.RowCount = 5;
            tableLayoutPanel3.RowStyles.Add(new RowStyle());
            tableLayoutPanel3.RowStyles.Add(new RowStyle());
            tableLayoutPanel3.RowStyles.Add(new RowStyle());
            tableLayoutPanel3.RowStyles.Add(new RowStyle());
            tableLayoutPanel3.RowStyles.Add(new RowStyle());
            tableLayoutPanel3.Size = new Size(592, 378);
            tableLayoutPanel3.TabIndex = 33;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.MistyRose;
            ClientSize = new Size(1251, 835);
            Controls.Add(tableLayoutPanel1);
            Margin = new Padding(3, 2, 3, 2);
            Name = "Form1";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Form1";
            Load += Form1_Load;
            ((System.ComponentModel.ISupportInitialize)viewCategories).EndInit();
            ((System.ComponentModel.ISupportInitialize)viewEmployee).EndInit();
            tableLayoutPanel1.ResumeLayout(false);
            tableLayoutPanel1.PerformLayout();
            tableLayoutPanel2.ResumeLayout(false);
            tableLayoutPanel2.PerformLayout();
            tableLayoutPanel3.ResumeLayout(false);
            ResumeLayout(false);
        }

        #endregion

        private DataGridView viewCategories;
        private DataGridView viewEmployee;
        private Label labelCategories;
        private Label labelEmployee;
        private Label labelCatID;
        private Label labelEmpID;
        private Label labelCatName;
        private Label labelEmpName;
        private Label labelEmpSalary;
        private Label labelEmpWork;
        private Label labelEmpJob;
        private Label labelEmpExperience;
        private TextBox textEmpID;
        private TextBox textCatID;
        private TextBox textCatName;
        private TextBox textEmpName;
        private TextBox textEmpSalary;
        private TextBox textEmpWork;
        private TextBox textEmpJob;
        private TextBox textEmpExperience;
        private Button addButton;
        private Button removeButton;
        private Button updateButton;
        private Button clearButton;
        private Button allEmployeeButton;
        private TableLayoutPanel tableLayoutPanel1;
        private TableLayoutPanel tableLayoutPanel2;
        private TableLayoutPanel tableLayoutPanel3;
        private Button firstButton;
        private Button previousButton;
        private Button nextButton;
        private Button lastButton;
        private Button buttonP;
        private Button buttonN;
    }
}