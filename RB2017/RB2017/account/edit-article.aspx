<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit-article.aspx.cs" Inherits="RB2017.account.edit_article" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
</head>
<body>
<form id="form1" runat="server">
<asp:TextBox ID="articleNameTB" runat="server" Text='<%#Bind("Article_Name") %>' Columns="45"/>
<asp:Button ID="btnEditArticle" runat="server" Text="Update Article" OnClick="Update_Article"/>
<a href="default.aspx">Back to Articles</a>
</form>
</body>
</html>
