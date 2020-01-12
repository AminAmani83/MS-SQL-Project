using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryWebApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void studentSubmitBtn_Click(object sender, EventArgs e)
        {
            BusinessLayer.Student newStudent = new BusinessLayer.Student();
            newStudent.stId = Convert.ToInt32(this.studentId.Text);
            // newStudent.stId = Convert.ToInt32(this.studentId2.Value);
            newStudent.stFirstName = this.studentFirstName.Text;
            newStudent.stLastName = this.studentLastName.Text;
            // newStudent.stBirthDate = this.studentBirthDate.Text;
            if (!String.IsNullOrEmpty(this.studentBirthDate2.Value))
                newStudent.stBirthDate = this.studentBirthDate2.Value;
            newStudent.stGender = this.studentGender.Text;
            newStudent.stClass = this.studentClass.Text;

            string result = DataAccessLayer.Tools.InsertStudent(newStudent);

            if (result.Equals("1"))
            {
                UserMessage.Text = "Database Error.";
            }
            else if (result.Equals("0"))
            {
                UserMessage.Text = "Registration Successful, Thank You.";
                cleanupForm();
            }
            
        }

        protected void cleanupForm()
        {
            this.studentId.Text = "";
            this.studentFirstName.Text = "";
            this.studentLastName.Text = "";
            this.studentBirthDate2.Value = "";
            this.studentClass.Text = "";
        }

    }
}