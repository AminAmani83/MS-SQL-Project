<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddStudent.aspx.cs" Inherits="LibraryWebApp.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Registration - My Library</title>
    <style>
        .fixed-width{
            display: inline-block;
            width: 100px;
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
        <h2>New Student Registration</h2>
        <form id="form1" runat="server">
                <span class="fixed-width">Student ID:</span>
                <!-- <input type="number" id="studentId2" runat="server" /> -->
                <asp:TextBox ID="studentId" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field" ForeColor="Red" ControlToValidate="studentId"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="studentId" ErrorMessage="Wrong Format" ForeColor="Red" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                <br />
                <span class="fixed-width">First Name:</span>
                <asp:TextBox ID="studentFirstName" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Last Name:</span>
                <asp:TextBox ID="studentLastName" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Birth Date:</span>
                <input type="date" id="studentBirthDate2" runat="server" />
                <!-- <asp:TextBox ID="studentBirthDate" runat="server"></asp:TextBox> -->
                <br />
                <span class="fixed-width">Gender:</span>
                <asp:DropDownList ID="studentGender" runat="server">
                    <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                    <asp:ListItem Value="F">Female</asp:ListItem>
                </asp:DropDownList>
                <br />
                <span class="fixed-width">Class: </span>
                <asp:TextBox ID="studentClass" runat="server"></asp:TextBox>
                <br />
                <span class="fixed-width">Submit: </span>
                <asp:Button ID="studentSubmitBtn" runat="server" Text="Submit" OnClick="studentSubmitBtn_Click" />
                <br />
                <asp:Label ID="UserMessage" runat="server"></asp:Label>
        </form>
    </main>
</body>
</html>
