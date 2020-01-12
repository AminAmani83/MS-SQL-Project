<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnBook.aspx.cs" Inherits="LibraryWebApp.ReturnBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Return a Book - My Library</title>
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
            width: 300px;
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
        <h2>Return a Book</h2>
        <form id="form1" runat="server">
            <div>
                Student:<br />
                <asp:DropDownList ID="StudentDropDown" runat="server" DataSourceID="StudentDB" DataTextField="name" DataValueField="studentId" OnSelectedIndexChanged="StudentDropDown_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <asp:SqlDataSource ID="StudentDB" runat="server" ConnectionString="<%$ ConnectionStrings:libraryConnectionString %>" SelectCommand="SP_getAllStudents" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <br />
                <br />
                <asp:Button ID="GetBookBtn" runat="server" OnClick="GetBookBtn_Click" Text="Get Book List" />
                <br />
                <br />
                Book:<br />
                <asp:DropDownList ID="StudentBookDropDown" runat="server" OnSelectedIndexChanged="StudentBookDropDown_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="StudentBookDropDown" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator> -->
                <br />
                <br />
                <asp:Button ID="ReturnBtn" runat="server" OnClick="ReturnBtn_Click" Text="Return" />
                <br />
                <br />
                <asp:Label ID="UserMessage" runat="server"></asp:Label>
            </div>
        </form>
    </main>
</body>
</html>
