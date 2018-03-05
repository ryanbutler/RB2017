<%@ Page Title="Building and Deploying a ASP.NET (ASPX) website to production" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.produce_a_website_build_and_deploy.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Building and Deploying a ASP.NET (ASPX) website to production</h2>
<h3>Creating a release profile</h3>
<p>Once we have compiled our solution the next step is to create a release profile for use in publishing our application. Follow these steps:</p>
<ol>
<li>Right click the solution in Solution Explorer and choose Properties:</li>
</ol>
<p class="alignCenter"><a href="images/solution_properties.jpg" data-lightbox="Solution Properties"><img src="thumbs/solution_properties.jpg" alt="Solution Properties" width="300" height="371" /></a></p>
<ol start="2">
<li>In the solution tab which opens, with Application selected, choose our target framework, in our case, .NET Framework 4:</li>
</ol>
<p class="alignCenter"><a href="images/tab_application.jpg" data-lightbox="Tab Application"><img src="thumbs/tab_application.jpg" alt="Tab Application" width="300" height="72" /></a></p>
<ol start="3">
<li>Select Build:</li>
</ol>
<p class="alignCenter"><img src="images/build.jpg" alt="Build" width="311" height="84" /></p>
<ol start="4">
<li>For configuration drop down choose Release:</li>
</ol>
<p class="alignCenter"><a href="images/build_configuration.jpg" data-lightbox="Build Configuration"><img src="thumbs/build_configuration.jpg" alt="Build Configuration" width="300" height="65" /></a></p>
<ol start="5">
<li>Under general, tick the check box Optimize code:</li>
</ol>
<p class="alignCenter"><a href="images/build_general_optimize_code.jpg" data-lightbox="Build General Optimize Code"><img src="thumbs/build_general_optimize_code.jpg" alt="Build General Optimize Code" width="300" height="193" /></a></p>
<ol start="6">
<li>Under output, ensure Output Path references the correct path for production files, in our case C:\Solution\Release:</li>
</ol>
<p class="alignCenter"><a href="images/build_output_output_path.jpg" data-lightbox="Build General Optimize Code"><img src="thumbs/build_output_output_path.jpg" alt="Build Output Path" width="300" height="36" /></a></p>
<p>Save our profile and close the tab.</p>
<p>We'll finish by publishing our <a href="default3.aspx">website</a>.</p>
</asp:Content>