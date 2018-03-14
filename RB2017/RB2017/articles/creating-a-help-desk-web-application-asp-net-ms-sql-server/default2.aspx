<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Relational Databases</h3>
<p>When learning about databases, one of the toughest concepts to understand is relationships in data. In relational databases you shouldn't duplicate data, and you especially shouldn't leave your database vulnerable to scalability or maintenance issues. We get around this by relating our data to other tables. This way, we don't duplicate data and our database remains scalable, which usually alleviates the maintenance pain point.</p>
<p>For example, think of a family tree hierarchy. Let's start with the parents:</p>
<p class="alignCenter"><img src="images/Parents.gif" width="200" height="100" alt="Parents" /></p>
<p>The parents have children:</p>
<p class="alignCenter"><img src="images/Parents_Children.gif" width="200" height="200" alt="Parents with Children" /></p>
<p>As you can see, the children are related to each other as brother and sister, and they are also related to each parent. So in our example, mom and dad (parents) is our parent table, while the children are our children table(s). As a result, we know these tables are related through DNA. Applying this concept to our help desk example, we can think of the help desk table as being our parent table and our additional tables as our child tables. The only difference is they are related through a primary  foreign key.</p>
<p>By creating four additional tables we can store a reference or relationship of these records in our help desk table. By doing this, we gain the following benefits:</p>
<ol>
<li>Duplicate data is eliminated because help desk will hold a unique key reference (foreign key) to each status, department, severity and employee that comes from each parent table.</li>
<li>Scalability is enabled and maintenance is reduced. If an employee or department changes, you change the details in the employee or department tables (children), and the unique reference in help desk (parent) automatically reflects that change.</li>
<li>You enforce referential integrity of the records, ensuring that a deletion from department or employee doesn't adversely affect any records in help desk.</li>
</ol>
<p>Figure 1 offers an illustration to help visualize the relationships in the data.</p>
<p class="alignCenter"><img src="images/diagram.png" width="672" height="270" alt="Help Desk Relationships" /></p>
<h3>Create a Database Diagram</h3>
<p>In order to enforce referential integrity on our database, let's create a database diagram by following these steps:</p>
<ol>
<li>Right click Database diagrams and select New Database Diagram as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/NewDatabaseDiagram.jpg" width="315" height="118" alt="New Database Diagram" /></p>
<ol>
<li>In the Add table window, select severity, department, employee and status, and click Add as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/add_tables.png" width="464" height="365" alt="Add Table Window" /></p>
<p>Place the help desk table in the middle with status in the top left, department in the bottom left, severity in the top right, and employee in the bottom right as shown in the previous section.</p>
<p>Next, proceed with these steps:</p>
<ol>
<li>Left click the ID column in status and drag it to the status ID column in help desk. In the window that pops up, make sure your settings are as shown in Figure 2 and then click OK. </li>
</ol>
<p class="alignCenter"><img src="images/relationships.png" width="528" height="399" alt="Status ID Column" /></p>
<ol>
<li>Repeat this process for department, severity and employee, choosing appropriate column names.</li>
<li>In the database diagram window, press Ctrl + S and give your diagram a name, such as help desk.</li>
</ol>
<h3>Populating Severity, Employee, Department and Status Tables</h3>
<p>Let's proceed to populate the tables with some data by following these steps:</p>
<ol>
<li>Right click on severity, and select Open.</li>
<li>Enter the following data: 
<ul>
<li>Low</li>
<li>Medium</li>
<li>High</li>
</ul>
</li>
<li>Right click on department and select Open.</li>
<li>Enter the following data: 
<ul>
<li>Information Services</li>
<li>Networking</li>
<li>Human Resources</li>
</ul>
</li>
<li>Right click on status and select Open.</li>
<li>Enter the following data: 
<ul>
<li>New</li>
<li>Open</li>
<li>Resolved</li>
</ul>
</li>
</ol>
<p>Minimize SQL Server Management Studio; we're done with it for the time being.</p>
<h3>Open Visual Studio and Create the Project</h3>
<p>Open Visual Studio from the desktop: Start>Programs>Microsoft Visual Studio. From the main menu, create a new project by following these steps:</p>
<ol>
<li>File:New:Project</li>
<li>In the New Project window, under the Visual C# tree, choose Web and then ASP.NET Web Application.</li>
<li>In the name text box, name our project HelpDesk.</li>
<li>Leave Create a directory for solution checked.</li>
<li>Click OK.</li>
<li>In the dialog that follows, choose Web Forms, and click Ok</li>
</ol>
<h3>Open web.config</h3>
<p>From the solution explorer, double click web.config and look for &lt;configuration&gt;. Inside this tag, add the following markup:</p>
<pre><code>
&lt;connectionStrings&gt;
&lt;add name="hd" connectionString="Data Source=--replace with local db or remote host--;Initial Catalog=HelpDesk;Integrated Security=SSPI;"/&gt;
&lt;/connectionStrings&gt;
</code></pre>
<p>Simply replace the data source with either your local database server name or your remote host. When you are done, save your file.</p>
<h3>Working with default.aspx</h3>
<p>From the solution explorer, delete the existing default.aspx file. Next, follow these steps to create a new
default page: </p>
<ol>
<li>Right click the solution</li>
<li>Choose Add New Item</li>
<li>In the Add New Item window, from the left pane, choose Web, then Web Forms</li>
<li>From the right pane, choose Web Form</li>
<li>In the name text field, type default.aspx</li>
<li>Click Add</li>
</ol>
<p>Modify the existing markup inside &lt;form runat="server"&gt; with the following:</p>
<pre><code>
&lt;body&gt;
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="phForm" runat="server" Visible="true"&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phSuccess" runat="server" Visible="false"&gt;
&lt;p&gt;Ticket submitted successfully.&lt;/p&gt;
&lt;p&gt;&lt;a href="Default.aspx"&gt;Submit another ticket&lt;/a&gt;&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
&lt;/body&gt;
</code></pre>
<p>As you can see from the code above, we nested two placeholder controls inside our form tag. A placeholder control is identical to any other ASP.NET control in that it's run on the server side. The only difference is whether it will show or hide the content inside. The control is made up of the following:</p>
<ol>
<li>ID
<ul>
<li>This element gives our placeholder a unique name.</li>
</ul>
</li>
<li>Runat
<ul>
<li>The control will be run by the Web server first and the resulting HTML output then will be sent to the browser.</li>
</ul>
</li>
<li>Visible
<ol>
<li>This element sets the visibility of our control to true, meaning it will show initially.</li>
</ol>
</li>
</ol>
<p>The second placeholder control simply is a success message. I'll show how this works a little later.</p>
<p>We'll continue with creating our style sheet and our additional HTML markup <a href="default3.aspx">next</a>.</p>
</asp:Content>