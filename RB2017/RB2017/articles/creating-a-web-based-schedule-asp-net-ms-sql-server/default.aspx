<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<p>Community colleges and universities across the country and around the world are increasingly using their website as way to reach their students. As more students enroll, the demand for more dynamic applications including application for admission, contact forms, and registration for events becomes important. Another aspect for these websites that has become popular is the ability to show a Web-based schedule of classes. Within this schedule, they normally provide complete information about each class, including whether the class is full, or maybe whether it has a lab component.
</p>
<p>You as the developer/programmer for the college or university have been tasked with creating a dynamic Web-based schedule that does the following: show all class information in a table, if a specific class has no remaining seats left, highlight the entire row in red, and if a specific class has a lab component, highlight the entire row in gold.
</p>
<p>As one can imagine, developing a Web-based application such as this one with ASP.NET and SQL Server is relatively simple. If you would like to learn how to build an application like this, please follow along. You'll need Visual Studio and SQL Server.
</p>
<h3>Create the Database</h3>
<p>From the desktop, follow these steps to open SQL Server:</p>
<ol>
<li>Start: Programs: SQL Server: SQL Server Management Studio</li>
<li>Connect to your local database server.</li>
<li>Create your database by following these steps:
<ul>
<li>Right click on databases and select New database as shown below:</li>
</ul>
</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig1.jpg" width="338" height="68" alt="New Database" /></p>
<ol>
<li>Give your database a name of mwd and click OK</li>
</ol>
<h3>Create the Main Table</h3>
<ol>
<li>To create our tables, follow these steps:</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig2.jpg" width="198" height="84" alt="Expand Database" /></p>
<ol>
<li>Right click on Tables and select New Table as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig3.jpg" width="262" height="136" alt="New Table" /></p>
<p>Let's create the main table classschedule first. We need the following columns as outlined below:</p>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>SectionNameId
<ul>
<li>Foreign key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>SynonymID
<ul>
<li>Data type: int</li>
<li>Null</li>
</ul>
</li>
<li>CreditHrs
<ul>
<li>Data type:int</li>
<li>Null</li>
</ul>
</li>
<li>Title
<ul>
<li>Data type: varchar(50) </li>
<li>Null</li>
</ul>
</li>
<li>TotalSeats
<ul>
<li>Data type: int</li>
<li>Null</li>
</ul>
</li>
<li>RemainingSeats
<ul>
<li>Data type: int</li>
<li>Null</li>
</ul>
</li>
<li>MeetInformation
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>RoomNumberID
<ul>
<li>Foreign key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>Days
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>StartTime
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>EndTime
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>InstructorID
<ul>
<li>Foreign key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>LocationID
<ul>
<li>Foreign key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
</ol>
<p>Before continuing, make sure to set the primary key by right clicking the column (ID) and choosing primary key as shown below:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig4.gif" width="210" height="51" alt="Set Primary Key" /></p>
<p>While we're at it, let's set the seed on this column as well by setting Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig5.gif" width="616" height="65" alt="Set Is Identity Seed" /></p>
<p>We'll continue by creating our child tables <a href="default2.aspx">next</a>.</p>
</asp:Content>