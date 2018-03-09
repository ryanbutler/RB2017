<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add-article.aspx.cs" Inherits="RB2017.account.add_article" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
</head>
<body>
<form id="form1" runat="server">
<h3>Add Article</h3>       
<asp:TextBox ID="articleNameTB" runat="server" Columns="25" />
<asp:Button ID="submitBtn" runat="server" OnClick="Add_Article" Text="Add Article" />
<input type="reset" value="reset" />
</form>
</body>
</html>
