<%@ Page Title="Creating a Application for admission and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_registration_and_confirmation_system_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h3>Relational Databases</h3>
<p>When learning about databases, one of the toughest concepts to understand is relationships in data. In relational databases you shouldn't duplicate data, and you especially shouldn't leave your database vulnerable to scalability or maintenance issues. We get around this by relating our data to other tables. This way, we don't duplicate data and our database remains scalable, which usually alleviates the maintenance pain point.</p>
<p>For example, think of a family tree hierarchy. Let's start with the parents:</p>
<p class="alignCenter"><img src="images/Parents.gif" width="200" height="100" alt="Parents"></p>
<p>The parents have children:</p>
<p class="alignCenter"><img src="images/Parents_Children.gif" width="200" height="200" alt="Parents with Children"></p>
<p>As you can see, the children are related to each other as brother and sister, and they are also related to each parent. So in our example, mom and dad (parents) is our parent table, while the children are our children table(s). As a result, we know these tables are related through DNA. Applying this concept to our help desk example, we can think of the help desk table as being our parent table and our additional tables as our child tables. The only difference is they are related through a primary  foreign key.</p>
<p>By creating four additional tables we can store a reference or relationship of these records in our help desk table. By doing this, we gain the following benefits:</p>
<ol>
<li>Duplicate data is eliminated because help desk will hold a unique key reference (foreign key) to each status, department, severity and employee that comes from each parent table.</li>
<li>Scalability is enabled and maintenance is reduced. If an employee or department changes, you change the details in the employee or department tables (children), and the unique reference in help desk (parent) automatically reflects that change.</li>
<li>You enforce referential integrity of the records, ensuring that a deletion from department or employee doesn't adversely affect any records in help desk.</li>
</ol>
<p>Figure 1 offers an illustration to help visualize the relationships in the data.</p>
<p class="alignCenter"><img src="images/relationships.png" width="723" height="461" alt="Relationships in data"/></p>
<h3>Create a Database Diagram</h3>
<p>In order to enforce referential integrity on our database, let's create a database diagram by following these steps:</p>
<ol>
<li>Right click Database diagrams and select New Database Diagram as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/NewDatabaseDiagram.jpg" width="315" height="118" alt="New Database Diagram"></p>
<ol>
<li>In the Add table window, select appliicant and high school and click Add as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/add_table.png" width="469" height="368" alt="Add Tables"/></p>
<p>Place the applicant table in the middle with high school in the top right and year intend to enroll in the top left as shown in the previous section.</p>
<p>Next, proceed with these steps:</p>
<ol>
<li>Left click the ID column in high school and drag it to the high school ID column in applicant. In the window that pops up, make sure your settings are as shown in Figure 2 and then click OK. </li>
</ol>
<p class="alignCenter"><img src="images/foreign_key.png" width="529" height="399" alt="Foreign key constraint"/></p>
<h3>Populating high school table</h3>
<p>Let's proceed to populate the tables with some data by following these steps:</p>
<ol>
<li>Right click on high school, and select Open.</li>
<li>Enter the following data: 
<ul>
<li>Hillcrest</li>
<li>Kickapoo</li>
<li>Central</li>
</ul>
</li>
<li>Right click on year intend to enroll, and select Open.</li>
<li>Enter the following data:
<ul>
<li>2018</li>
<li>2019</li>
<li>2020</li>
</ul>
</li>
</ol>
<p>Minimize SQL Server Management Studio; we're done with it for the time being.</p>
<h3>Open Visual Studio and Create the Project</h3>
<p>Open Visual Studio from the desktop: Start>Programs>Microsoft Visual Studio. From the main menu, create a new project by following these steps:</p>
<ol>
<li>File:New:Project</li>
<li>In the New Project window, under the Visual C# tree, choose Web and then ASP.NET Web Application.</li>
<li>In the name text box, name our project ApplicantAdmission.</li>
<li>Leave Create a directory for solution checked.</li>
<li>Click OK.</li>
<li>In the dialog that follows, choose Web Forms, and click Ok</li>
</ol>
<h3>Open web.config</h3>
<p>From the solution explorer, double click web.config and look for &lt;configuration&gt;. Inside this tag, add the following markup:</p>
<pre><code>
&lt;connectionStrings&gt;
&lt;add name="aa" connectionString="Data Source=--replace with local db or remote host--;Initial Catalog=ApplicantAdmission;Integrated Security=SSPI;"/&gt;
&lt;/connectionStrings&gt;
</code></pre>
<p>Simply replace the data source with either your local database server name or your remote host. When you are done, save your file.</p>
<h3>Working with apply.aspx</h3>
<p>In order for us to collect the information needed, we'll create a new file named apply.aspx. Follow these steps:</p>
<ol>
<li>From the solution explorer, right click and choose Add : New Item</li>
<li>In the New Item Window, from the left pane, choose Web</li>
<li>From the right pane, choose Web Form</li>
<li>Click Add</li>
</ol>
<p>Add the following for initial markup:</p>
<pre><code>
&lt;form id="form1" name="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="phApplication" runat="server" Visible="true"&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phSuccess" runat="server" Visible="false"&gt;
&lt;div id="success"&gt;
&lt;p&gt;Thank you for your application!&lt;/p&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, you create three placeholder controls: </p>
<ol>
<li>Your initial placeholder, which contains your applicant information contents</li>
<li>The second placeholder, which contains a success message</li>
</ol>
<p>We'll continue by creating the style sheet and markup for the form <a href="default3.aspx">next</a>.</p>
</asp:Content>