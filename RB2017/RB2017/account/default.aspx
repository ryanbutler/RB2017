<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.admin._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Submitted Articles</h2>
<form runat="server">
<asp:Repeater ID="rpSubmittedArticles" runat="server">
<ItemTemplate>
<p><a href="view-article.aspx?guid=<%#Eval("Guid") %>"><%#Eval("Article_Name") %></a></p>
</ItemTemplate>
</asp:Repeater>
</form>
</asp:Content>