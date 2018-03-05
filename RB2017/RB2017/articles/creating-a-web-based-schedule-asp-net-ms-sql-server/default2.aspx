<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create Child Tables</h3>
<p>We'll explain why we need four additional tables shortly, but let's go ahead and create the section name, room, location and instructors table using the same steps as outlined above, just change column names as outlined below:</p>
<h3>SectionName</h3>
<ol>
<li>ID
<ul>
<li>Primary Key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>SectionName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>Synonym
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Room</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>Room
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Location</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>Location
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<h3>Instructor</h3>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>InstFName
<ul>
<li>Data type: varchar(50) </li>
<li>Null</li>
</ul>
</li>
<li>InstLName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<p>Make sure you set the primary key and seed on the ID columns for these tables as well.</p>
<h3>Relational Databases</h3>
<p>When learning about databases, one of the toughest concepts to understand is the idea behind relationships in data. In relational databases you don't want to duplicate data, and you especially don't want to leave your database vulnerable to scalability or maintenance issues. We get around this through relating our data to other tables. This way, you don't duplicate data and your database remains scalable and the maintenance pain point is usually reduced.</p>
<p>For example, think of a family hierarchy tree. Let's start with the parents:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig6.gif" width="200" height="100" alt="Parents" /></p>
<p>The parents have children:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig7.gif" width="200" height="200" alt="Parents and children relationship" /></p>
<p>As you can see, the children are related to each other as brother and sister, and they are also related to each parent. So in our example, mom and dad (parents) is our parent table, while the children are our children table(s). As a result, we know these tables are related through DNA. Using our example above, we can think of the help desk table as being our parent table, while our additional tables can be thought of as our child tables. The only difference is they are related through a primary -- foreign key.</p>
<p>By creating four additional tables we can store a reference or relationship of these records in our help desk table. By doing this, we eliminate the following:</p>
<ol>
<li>Duplicate data, since class schedule will hold a unique key reference (foreign key) to each section name, room, location and instructor that comes from each parent table.</li>
<li>Scalable and maintenance has been reduced. If a room or instructor changes, you change the details in the room or instructor tables (children), and the unique reference in class schedule (parent), automatically reflects that change.</li>
<li>You enforce referential integrity of the records, ensuring that a delete from room or instructor doesn't adversely affect any records in class schedule.</li>
</ol>
<p>Let's use an illustration to help visualize the relationships in the data:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig8.jpg" width="624" height="373" alt="Class schedule diagram" /></p>
<h3>Create a Database Diagram</h3>
<p>In order to help enforce referential integrity on our database, let's create a database diagram by following these steps:</p>
<ol>
<li>Right click Database diagrams and select New Database Diagram as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig9.jpg" width="315" height="118" alt="New Database Diagram"/></p>
<ol>
<li>In the Add table window, select class schedule, instructor, location, room, section name and then click add as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig10.jpg" width="398" height="320" alt="Add Table Relationships" /></p>
<p>Place the class schedule table in the middle, with section name, room and instructor on the left, location on the right, as shown before the section Create a database diagram.</p>
<p>From this point, follow these steps:</p>
<ol>
<li>Left click the ID column in section name and drag to the section name id column in class schedule. In the window that prompts, make sure your settings are as shown below and then click OK:</li>
</ol>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig11.jpg" width="456" height="320" alt="Tables and Columns" /></p>
<ol>
<li>Repeat this process for instructor, location, and room choosing appropriate column names where appropriate.</li>
<li>In the database diagram window, press Ctrl + S and give your diagram a name, such as class schedule.</li>
</ol>
<p>We'll continue by populating the tables <a href="default3.aspx">next</a>.</p>
</asp:Content>