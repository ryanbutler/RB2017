<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<p>Suppose you work for a small to midsize company that employs 50-100 workers. The Help Desk -- a subsidiary of the Information Services Division -- is in charge of trouble tickets regarding general PC issues such as email, viruses, network issues, etc. Initially, the Help Desk team stored this information in Excel spreadsheets, but as the company has grown, managing these spreadsheets has become tedious and time consuming.</p>
<p>The Help Desk has asked you to devise a more efficient solution that could be developed internally, saving the company money. As you start to think about it, the following requirements are apparent: fields for the submitter's first and last name, as well as their email address. You'll also need combo boxes for indicating ticket severity (low, medium, high), department, status (new, open, resolved), employee working on the issue, as well as an area for comments. Of all the solutions available, creating an internal help desk Web application with ASP.NET is relatively simple.</p>
<p>In the following article, we'll see how to implement these features in an ASP.NET help desk Web application using a database-driven approach, while keeping maintenance and scalability in mind. If you would like to learn how to implement a Web application like this, please follow along. You'll need Visual Studio, MS SQL Server</p>
<h3>Create the Database</h3>
<ol>
<li>Start: Programs: SQL Server</li>
<li>Connect to your local database server.</li>
<li>When connected, create your database by following these steps: 
<ul>
<li>Right click on Databases and select New Database as shown below: </li>
</ul>
</li>
</ol>
<p class="alignCenter"><img src="images/SelectNewDatabase.jpg" width="338" height="68" alt="Select New Database" /></p>
<ul>
<li>Name your database mwd and click OK.</li>
</ul>
<h3>Create the Main Table</h3>
<p>To create your tables, follow these steps:</p>
<ol>
<li>Click the plus (+) sign next to your database as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/ClickPlusSign.jpg" width="198" height="84" alt="Expand database table" /></p>
<ol>
<li>Right click on Tables, and select New Table as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/SelectNewTable.jpg" width="262" height="136" alt="Select New Table" /></p>
<p>Let's create the main table helpdesk first. We need the following columns as outlined below:</p>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>FName
<ul>
<li>Data type: varchar(50) </li>
<li>Null</li>
</ul>
</li>
<li>LName
<ul>
<li>Data type: varchar(50) </li>
<li>Null</li>
</ul>
</li>
<li>Email
<ul>
<li>Data type: varchar(50) </li>
<li>Null</li>
</ul>
</li>
<li>SeverityID
<ul>
<li>Data type: int</li>
<li>Null</li>
</ul>
</li>
<li>StatusID
<ul>
<li>Data type: int</li>
<li>Not Null</li>
</ul>
</li>
<li>DepartmentID
<ul>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>EmployeeID
<ul>
<li>Data type: int</li>
<li>Null</li>
</ul>
</li>
<li>Comments
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<p>Before continuing, make sure to set the primary key by right clicking the column and choosing Set Primary Key as shown below:</p>
<p class="alignCenter"><img src="images/SetPrimaryKey.gif" width="210" height="51" alt="Set Primary Key" /></p>
<p>While we're at it, let's set the seed on this column as well by setting the Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/IDSpec2Yes.gif" width="616" height="65" alt="Identity Seed" /></p>
<p>I'll explain why we need four additional tables shortly, but let's proceed to create the severity, status, department and employee table using the same steps as previously outlined. Just change the table column names as outlined below:</p>
<h3>Severity</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>Severity
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Status</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type:int</li>
<li>Not null</li>
</ul>
</li>
<li>Status
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Department</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type:int</li>
<li>Not null</li>
</ul>
</li>
<li>Department
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Employee</h3>
<ol>
<li>ID
<ul>
<li>Primary key
<ul>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>FName
<ul>
<li>Data type: varchar(50)</li>
<li>Not null</li>
</ul>
</li>
</ul>
</li>
<li>LName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<p>Make sure you set the primary key and seed on the ID columns for these tables as well.</p>
<p>We'll continue by explaining relational databases <a href="default2.aspx">next</a>.</p>
</asp:Content>