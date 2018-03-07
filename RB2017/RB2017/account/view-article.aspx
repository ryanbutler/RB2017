<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="view-article.aspx.cs" Inherits="RB2017.admin.view_article" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>View Article</h2>
<form runat="server">
<asp:Repeater ID="rpViewArticle" runat="server">
<ItemTemplate>
<p><%#Eval("Article_Name") %></p>
</ItemTemplate>
</asp:Repeater>
</form>
<p><a href="default.aspx">Back to articles listing.</a></p>
</asp:Content>