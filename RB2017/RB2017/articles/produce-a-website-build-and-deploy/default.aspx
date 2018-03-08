<%@ Page Title="Building and Deploying a ASP.NET (ASPX) website to production" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.produce_a_website_build_and_deploy._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Building and Deploying a ASP.NET (ASPX) website to production</h2>
<p>When you create a solution in Visual Studio and manage your project in development, the time will come to make it work in production.</p>
<h3>Solution Explorer</h3>
<p>If we take a look at the solution explorer, we see the following:</p>
<p class="alignCenter"><img src="images/solution_explorer.png" alt="Expand Solution Folder" width="350" height="460" /></p>
<p>As you can see there are the folders and files in a given solution. As a reader you may be wondering why not publish all these to the server for production?</p>
<p>Simple answer - the server for production is expecting compiled assemblies in released or optimized mode. Our solution folder contains compiled assemblies in debug mode. </p>
<p>Furthermore, when we write code in our business object (BO), code-behind, or write stored procedures for our data access (DA) and build our solution the compiled assemblies are referenced in the bin folder.</p>
<p>So how are we to know which files a published server needs to correctly display our website? Visual Studio publishing capabilities has the answer.</p>
<h3>Changing compiled assemblies from debug to release</h3>
<p>With Visual Studio opened, we toggle our assemblies from debug or release mode from the following menu option:</p>
<p class="alignCenter"><img src="images/debug-release-toolbar.png" width="264" height="63" alt="Debug - Release Toolbar" /></p>
<p>When working within Visual Studio, we want to work with debug. When going into production, we switch to release, build the solution, and publish.</p>
<h3>Publishing the solution</h3>
<p>In order to publish our solution, follow these steps:</p>
<ol>
<li>From the solution explorer, right click on the solution and choose Publish.</li>
<li>In the publish window, for target location, click Settings</li>
<li>For publish method, choose File System</li>
<li>For target location, it will pre-select the root location of your solution. At the end, append on a folder named Release.</li>
<li>Click next, and for Configuration, choose Release</li>
<li>Click Save</li>
</ol>
<p>While in the publish window, click Publish. At the bottom of Visual Studio's output window, you'll see the activity occuring during the publication of your website.</p>
<h3>Summary</h3>
<p>In this article, you learned about two different types of modes regarding our assembiles, debug and release. You also learned how to switch the configuration when needed. Lastly, you learned how to publish
your website into a separate Release folder so now you can have a development and release version.</p>
<p>If you have questions, please <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>