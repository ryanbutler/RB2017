<%@ Page Title="Building and Deploying a ASP.NET (ASPX) website to production" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.produce_a_website_build_and_deploy._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Building and Deploying a ASP.NET (ASPX) website to production</h2>
<p>Developing and troubleshooting an ASP.NET  website can be fun and exciting. You’re generally learning new concepts, discovering and resolving issues, and driving your objectives to a successful website. When it comes time to deploy the website to a production server, often times the fun and excitement becomes a frustrating, time consuming and tedious exercise.</p>
<p>Reason for this are many including: (1) The development machine has all the necessary files needed to make the website work, however, isolating these files and publishing to a server can be trying the first few times, (2) Finding the right host for your website - if you’re working solely with Microsoft .NET, a Windows host that supports the current version is a requirement.</p>
<p>Fortunately, Microsoft Visual Studio comes with native publishing methods to make isolating development to production relatively easy. </p>
<p>In the following article, we’ll see how to isolate a development to production environment, and how to deploy only the necessary files for production.</p>
<h3>Creating development and release environment</h3>
<p>There are multiple avenues to creating a development & production environment, too many to include in this article. Instead, we’ll discuss a couple popular avenues prevalent today, and then from there, you’ll decide which option to take.</p>
<h3>Option 1</h3>
<p>From this path you create the following hierarchy:</p>
<ol>
<li>
C:\Project Name
<ol type="a">
<li>C:\Project Name\trunk</li>
<li>
C:\Project Name\branches
<ol type="i">
<li>C:\Project Name\branches\v1.0</li>
<li>C:\Project Name\branches\v2.0</li>
</ol>
</li>
<li>C:\Project Name\Release\v1.0</li>
<li>C:\Project Name\Release\v2.0</li>
</ol>
</li>
</ol>
<p>In this approach you have: (a) trunk, which is considered the main line, in other words, the golden branch for development, (b) branches, which is considered a specific version of the code base by development version. This could be useful if there’s a specific bug related to either version 1 or 2 that needs to be addressed and (c) & (d) are release versions of the product that have been certified a public stable version.</p>
<p>If you’re working in a large team or have many different versions of the same product this can be the desired approach.</p>
<h3>Option 2</h3>
<p>From this path you create the following hierarchy:</p>
<ol>
<li>
C:\Project Name
<ol type="a">
<li>C:\Project Name\Dev</li>
<li>C:\Project Name\Release</li>
</ol>
</li>
</ol>
<p>In this approach you have: (a) Dev, which is considered the main line, in other words, the golden branch for development, (b) Release, which is the released version of the product that have been certified a public stable version. Sometimes in this approach release is extended to include another folder named branch, which is used to store a certified public stable version product:</p>
<ol>
<li>
C:\Project Name
<ol type="a">
<li>C:\Project Name\Dev</li>
<li>
C:\Project Name\Release
<ol type="i">
<li>C:\Project Name\Release\v1.0</li>
</ol>
</li>
</ol>
</li>
</ol>
<p>Typically, (1.i) would be used if you have many different versions of the same product. </p>
<p>From personal experience I tend to favor option 2. It seems to be less complicated of a branching strategy and allows development to be centralized to one location, rather than working from multiple branches and having to merge code if needed between branches. Typically the more complex the branching strategy the harder merges become and keeping code working in those specific configurations.</p>
<p>Regardless of which option is selected including this pathing structure in a version control system such as Team Foundation Server (TFS), Subversion, CodePlex, GitHub, etc. is essential to keeping development and release environments isolated.</p>
<h3>Option 2 development environment</h3>
<p>Working with option 2 in a development environment our folder hierarchy looks like:</p>
<p class="alignCenter"><img src="images/root_solution.jpg" alt="Root Solution" width="165" height="67" /></p>
<p>When we expand Dev we see:</p>
<p class="alignCenter"><img src="images/expand_dev.jpg" alt="Expand Development Folder" width="199" height="104" /></p>
<p>As you can see we have two root folders inside Dev: (1) packages which include all pre-packaged assemblies (DLL) that Visual Studio creates for each new project and (2) the name of our solution. Expanding the name of our solution we see:</p>
<p class="alignCenter"><img src="images/expand_rb2017.jpg" alt="Expand Solution Folder" width="1152" height="648" /></p>
<p>As you can see these are the folders in a given solution. As a reader you may be wondering why not publish all these to the server for production?</p>
<p>Simple answer - the server for production is expecting compiled assemblies (binary code 0’s & 1’s) and our dev folder doesn’t contain compiled assemblies except for those found in packages. When we write code in our business object (BO), code-behind, or write stored procedures for our data access (DA) and build our solution the compiled assembly is referenced in the bin folder.</p>
<p>So how are we to know which files a published server needs to correctly display our website? Visual Studio publishing capabilities has the <a href="default2.aspx">answer</a>.</p>
</asp:Content>