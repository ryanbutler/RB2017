<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.account._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
<asp:Repeater ID="rpArticlesView" runat="server">
<ItemTemplate>
<p><asp:HyperLink ID="hlLink" runat="server" NavigateUrl='<%#Eval("Guid", "view-detail.aspx?guid={0}") %>' Text='<%#Eval("Article_Name") %>' /></p>
</ItemTemplate>
</asp:Repeater>        
</form>
</body>
</html>
