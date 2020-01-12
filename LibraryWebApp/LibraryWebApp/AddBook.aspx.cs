using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryWebApp
{
    public partial class AddBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BookSubmitBtn_Click(object sender, EventArgs e)
        {
            BusinessLayer.Book newBook = new BusinessLayer.Book();
            newBook.bkTitle = this.BookTitle.Text;
            if (!String.IsNullOrEmpty(this.BookPageCount.Text))
                newBook.bkPageCount = Convert.ToInt32(this.BookPageCount.Text);
            if (!String.IsNullOrEmpty(this.BookPrice.Text))
                newBook.bkPrice = Convert.ToDouble(this.BookPrice.Text);
            newBook.bkAuthorFirstName = this.BookAuthorFirstName.Text;
            newBook.bkAuthorLasstName = this.BookAuthorLastName.Text;
            newBook.bkTypeName = this.BookTypeName.Text;

            string result = DataAccessLayer.Tools.InsertBook(newBook);

            if (result.Equals("1"))
            {
                UserMessage.Text = "Database Error.";
            }
            else if (result.Equals("0"))
            {
                UserMessage.Text = "Book Addition Successful, Thank You.";
                cleanupForm();
            }
        }

        protected void cleanupForm()
        {
            this.BookTitle.Text = "";
            this.BookPageCount.Text = "";
            this.BookPrice.Text = "";
            this.BookAuthorFirstName.Text = "";
            this.BookAuthorLastName.Text = "";
            this.BookTypeName.Text = "";
        }

    }
}