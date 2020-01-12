<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="LibraryWebApp.AddBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Book Addition - My Library</title>
    <style>
        .fixed-width{
            display: inline-block;
            width: 200px;
            padding-top: 5px;
            padding-bottom: 5px;
        }
        header{
            background-color: black;
            color: white;
            overflow: auto;
            padding: 15px 30px;
        }
        #logo{
            float: left;
            font-weight: bold;
        }
        nav{
            float: right;
            font-family: Arial, sans-serif;
            font-size: 0.8em;
        }
        nav a{
            color: white;
            text-decoration: none;
            display: inline-block;

        }
        nav a:not(:last-of-type)::after{
            content: ' | ';
        }
        nav a:hover{
            color: yellow;
        }
        main{
            clear: both;
            padding-top: 20px;
            width: 500px;
            margin: auto;
        }
        
    </style>
</head>
<body>
     <header>
        <div id="logo">
            My Library
        </div>
        <nav>
            <a href="AddStudent.aspx">New Student</a>
            <a href="AddBook.aspx">New Book</a>
            <a href="BorrowBook.aspx">Borrow</a>
            <a href="ReturnBook.aspx">Return</a>
        </nav>
    </header>
    <main>
        <h2>New Book Addition</h2>
        <form id="form1" runat="server">
            <div>
                <span class="fixed-width">Book Title:</span>
                <asp:TextBox ID="BookTitle" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="BookTitle" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <span class="fixed-width">Page Count:</span>
                <asp:TextBox ID="BookPageCount" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="BookPageCount" ErrorMessage="Wrong Format" ForeColor="Red" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                <br />
                <span class="fixed-width">Price:</span>
                <asp:TextBox ID="BookPrice" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="BookPrice" ErrorMessage="Wrong Format" ForeColor="Red" ValidationExpression="(\d)+\.(\d){2}"></asp:RegularExpressionValidator>
                <br />
                <span class="fixed-width">Author First Name:</span>
                <asp:TextBox ID="BookAuthorFirstName" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Author Last Name:</span>
                <asp:TextBox ID="BookAuthorLastName" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Type:</span>
                <asp:TextBox ID="BookTypeName" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Submit:</span>
                <asp:Button ID="BookSubmitBtn" runat="server" Text="Submit" OnClick="BookSubmitBtn_Click" />
                <br />
                <asp:Label ID="UserMessage" runat="server"></asp:Label>
            </div>
        </form>
    </main>
</body>
</html>
