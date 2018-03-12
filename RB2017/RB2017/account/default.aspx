<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.account._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
<p><a href="add-article.aspx">Add Article</a></p>
<asp:Repeater ID="rpArticlesView" runat="server">
<ItemTemplate>
<p><asp:HyperLink ID="hlLink" runat="server" NavigateUrl='<%#Eval("Guid", "edit-article.aspx?guid={0}") %>' Text='<%#Eval("Article_Name") %>' /></p>
</ItemTemplate>
</asp:Repeater>        
</form>
</body>
</html>
