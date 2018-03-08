<%@ Page Title="Building and Deploying a ASP.NET (ASPX) website to production" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.produce_a_website_build_and_deploy._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<p>As you can see these are the folders in a given solution. As a reader you may be wondering why not publish all these to the server for production?</p>
<p>Simple answer - the server for production is expecting compiled assemblies (binary code 0’s & 1’s) and our dev folder doesn’t contain compiled assemblies except for those found in packages. When we write code in our business object (BO), code-behind, or write stored procedures for our data access (DA) and build our solution the compiled assembly is referenced in the bin folder.</p>
<p>So how are we to know which files a published server needs to correctly display our website? Visual Studio publishing capabilities has the <a href="default2.aspx">answer</a>.</p>
</asp:Content>