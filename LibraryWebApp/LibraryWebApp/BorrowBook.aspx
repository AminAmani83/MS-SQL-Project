<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowBook.aspx.cs" Inherits="LibraryWebApp.BorrowBook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Borrow a Book - My Library</title>
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
        <h2>Borrow a Book</h2>
        <form id="form1" runat="server">
            <div>
                Student:<br />
                <asp:DropDownList ID="StudentDropDown" runat="server" DataSourceID="StudentDB" DataTextField="name" DataValueField="studentId" OnSelectedIndexChanged="StudentDropDown_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <asp:SqlDataSource ID="StudentDB" runat="server" ConnectionString="<%$ ConnectionStrings:libraryConnectionString %>" SelectCommand="SP_getAllStudents" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <br />
                <br />
                Book:<br />
                <asp:DropDownList ID="BookDropDown" runat="server" DataSourceID="BookDB" DataTextField="BookInfo" DataValueField="BookId" OnSelectedIndexChanged="BookDropDown_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <asp:SqlDataSource ID="BookDB" runat="server" ConnectionString="<%$ ConnectionStrings:libraryConnectionString %>" SelectCommand="SP_getAllBooks" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <br />
                <br />
                <asp:Button ID="BorrowBtn" runat="server" Text="Borrow" OnClick="BorrowBtn_Click" />
                <br />
                <br />
                <asp:Label ID="UserMessage" runat="server"></asp:Label>
            </div>
        </form>
    </main>
</body>
</html>
