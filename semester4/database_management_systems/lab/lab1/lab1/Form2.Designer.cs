using System.Drawing;
using System.Windows.Forms;

namespace lab1
{
    partial class Form2
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

        #region #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            labelAllEmployee = new Label();
            viewEmployee = new DataGridView();
            ((System.ComponentModel.ISupportInitialize)viewEmployee).BeginInit();
            SuspendLayout();
            // 
            // labelAllEmployee
            // 
            labelAllEmployee.AutoSize = true;
            labelAllEmployee.Font = new Font("Georgia", 12F, FontStyle.Bold, GraphicsUnit.Point);
            labelAllEmployee.Location = new Point(478, 9);
            labelAllEmployee.Name = "labelAllEmployee";
            labelAllEmployee.Size = new Size(144, 24);
            labelAllEmployee.TabIndex = 0;
            labelAllEmployee.Text = "All Employee";
            // 
            // viewEmployee
            // 
            viewEmployee.BackgroundColor = Color.Snow;
            viewEmployee.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            viewEmployee.Location = new Point(44, 48);
            viewEmployee.Name = "viewEmployee";
            viewEmployee.RowHeadersWidth = 51;
            viewEmployee.RowTemplate.Height = 29;
            viewEmployee.Size = new Size(1024, 589);
            viewEmployee.TabIndex = 1;
            // 
            // Form2
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1103, 649);
            Controls.Add(viewEmployee);
            Controls.Add(labelAllEmployee);
            Name = "Form2";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Form2";
            Load += Form2_Load;
            ((System.ComponentModel.ISupportInitialize)viewEmployee).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label labelAllEmployee;
        private DataGridView viewEmployee;
    }
}