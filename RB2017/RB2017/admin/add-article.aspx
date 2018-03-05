<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="add-article.aspx.cs" Inherits="RB2017.admin.add_article" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Add Article</h2>
<form runat="server">
<asp:PlaceHolder ID="formPH" runat="server" Visible="true">
<asp:TextBox ID="article_Name_TB" runat="server" />
<asp:Button ID="btnInsertArticleName" runat="server" Text="Submit Article" OnClick="btnInsertArticleName_Click"/>
</asp:PlaceHolder>
</form>
</asp:Content>