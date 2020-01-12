using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryWebApp
{
    public partial class ReturnBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ReturnBtn_Click(object sender, EventArgs e)
        {
            BusinessLayer.Student returningStudent = new BusinessLayer.Student();
            returningStudent.stId = Convert.ToInt32(this.StudentDropDown.Text);

            BusinessLayer.Book returnedBook = new BusinessLayer.Book();
            if (this.StudentBookDropDown.Text == "")
            {
                UserMessage.Text = "Please select a Book to return";
                return;
            }
            returnedBook.bkId = Convert.ToInt32(this.StudentBookDropDown.Text);

            string result = DataAccessLayer.Tools.ReturnBook(returningStudent, returnedBook);

            if (result.Equals("1"))
            {
                UserMessage.Text = "Database Error.";
            }
            else if (result.Equals("0"))
            {
                UserMessage.Text = "Book Successfully Returned, Thank You.";
                this.StudentBookDropDown.Items.Remove(this.StudentBookDropDown.SelectedItem);
                // this.StudentDropDown.ClearSelection();
            }

        }

        protected void StudentDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.StudentBookDropDown.Items.Clear();
            this.UserMessage.Text = "";
        }

        protected void GetBookBtn_Click(object sender, EventArgs e)
        {
            BusinessLayer.Student returningStudent = new BusinessLayer.Student();
            returningStudent.stId = Convert.ToInt32(this.StudentDropDown.Text);

            DataSet ds = DataAccessLayer.Tools.GetStudentBooks(returningStudent);
            DataTable dt = ds.Tables[0];
            this.StudentBookDropDown.DataSource = dt;
            this.StudentBookDropDown.DataTextField = dt.Columns[1].ToString();
            this.StudentBookDropDown.DataValueField = dt.Columns[0].ToString();
            this.StudentBookDropDown.DataBind();
        }

        protected void StudentBookDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.UserMessage.Text = "";
        }
    }
}