using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryWebApp
{
    public partial class BorrowBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BorrowBtn_Click(object sender, EventArgs e)
        {
            BusinessLayer.Student borrowingStudent = new BusinessLayer.Student();
            borrowingStudent.stId = Convert.ToInt32(this.StudentDropDown.Text);

            BusinessLayer.Book requestedBook = new BusinessLayer.Book();
            requestedBook.bkId = Convert.ToInt32(this.BookDropDown.Text);

            string result = DataAccessLayer.Tools.BorrowBook(borrowingStudent, requestedBook);

            if (result.Equals("1"))
            {
                UserMessage.Text = "Database Error.";
            }
            else if (result.Equals("0"))
            {
                UserMessage.Text = "Book Successfully Borrowed, Thank You.";
            }
            else if (result.Equals("MaxBooksLimitReached"))
            {
                UserMessage.Text = "This student has already borrowed 3 books.";
            }
            else if (result.Equals("BookNotAvailable"))
            {
                UserMessage.Text = "This book is not available at the moment.";
            }
        }

        protected void StudentDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.UserMessage.Text = "";
        }

        protected void BookDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.UserMessage.Text = "";
        }
    }
}