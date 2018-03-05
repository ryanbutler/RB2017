<%@ Page Title="Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_searchable_online_employee_directory_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server</h2>
<p>When working for a large company, it's hard to know everyone's name, job title, room location and contact information such as phone number or email address. Most companies rely on a spreadsheet of employee names that becomes outdated as soon as the sheet is printed. Most solutions to this problem rely on a Web-based approach. One solution could be posting a PDF file or Excel file to an internal intranet, but the same maintenance pain point exist: every time a change is needed, you have to re-upload the document.</p>
<p>A solution that is more flexible and robust to changes is a Web page that's capable of searching a database of employee names. When an employee is found, his or her name is displayed in a hyperlink that provides further information when clicked. As a developer, if you're familiar with ASP.NET and database-driven pages, this solution is quite simple to implement.</p>
<p>In this article I'll explain how to create a database, create one page that will search for any employee with the specified name or letter, and create another page that will display additional details regarding that employee. To follow along with this article, you'll need Visual Studio, as well as SQL Server.</p>
<h3>Create the Database</h3>
<p>From the desktop, follow these steps to open SQL Server:</p>
<ol>
<li>Start:Programs:SQL Server:SQL Server Management Studio.</li>
<li>Connect to your local database server.</li>
<li>Create your database by following these steps:
<ul>
<li>Right click on databases and select New database as shown below:</li>
</ul>
</li>
</ol>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig1.jpg" width="338" height="68" alt="New Database" /></p>
<ul>
<li>Give your database a name of emp_dir and click OK.</li>
</ul>
<h3>Create the Main Table</h3>
<p>To create our tables, follow these steps:</p>
<ol>
<li>Click the plus sign (+) next to your database as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig2.jpg" width="198" height="84" alt="New Table" /></p>
<p>Let's create our table, employeedirectory, first. We need the following columns as outlined below:</p>
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
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>LName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>Email
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>GUID
<ul>
<li>Data type: uniqueidentifier</li>
<li>Not null</li>
</ul>
</li>
<li>JobTitle
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>OfficeLoc
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
</ol>
<p>Before continuing, make sure to set the primary key by right clicking the column (ID) and choosing Set Primary Key as shown below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig4.gif" width="210" height="51" alt="Set Primary Key" /></p>
<p>While we're at it, let's set the seed on this column as well by setting Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig5.gif" width="616" height="65" alt="Set Is Identity" /></p>
<p>Next, left click the GUID (global unique identifier) column and in the properties window, set default value or binding to (newid()).</p>
<h3>Populating Employee Table</h3>
<p>Let's populate the table with some data by following these steps:</p>
<ol>
<li>Right click on employeedirectory, and select Open</li>
<li>Enter the following data:</li>
<li>Record 1
<ul>
<li>FName : Jake</li>
<li>LName : Doe</li>
<li>Email: doej@domain.com</li>
<li>GUID : leave empty</li>
<li>JobTitle: Director</li>
<li>Office Loc : 110</li>
<li>PhoneNum : 2324</li>
</ul>
</li>
</ol>
<p>Enter a few more records with different information. After each record, make sure you press the execute button so you get a new GUID as shown in the image below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig6.jpg" width="126" height="72" alt="Execute SQL" /></p>
<p>Minimize SQL Server Management Studio; we're done with it for the time being.</p>
<h3>Open Visual Studio and Create the Project</h3>
<p>Let's open Visual Studio from the desktop: Start:Programs:Microsoft Visual Studio. From the main menu, create a new project by following these steps:</p>
<ol>
<li>File:New:Project</li>
<li>In the New Project window, under the Visual C# tree, choose Web and then ASP.NET Web Application.</li>
<li>In the name text box, name our project EmployeeDirectory.</li>
<li>Leave Create a directory for solution checked.</li>
<li>Click OK.</li>
</ol>
<p>Once the project is created, you'll have one ASPX file and a web.config.</p>
<h3>Open web.config and default.aspx</h3>
<p>From the solution explorer, double click web.config and look for &lt;connectionStrings&gt;. Replace the default markup with the following:</p>
<pre><code>
&lt;connectionStrings&gt;
&lt;add name="mwd" connectionString="Data Source=P425\SQLExpress;Initial Catalog=mwd;Integrated Security=SSPI;"/&gt;
&lt;/connectionStrings&gt;
</code></pre>
<p>Simply replace the value inside the double quotes for connection string with your settings. When you are done, save your file.</p>
<p>From the solution explorer, double click default.aspx and remove everything between the opening and closing &lt;form&gt; tags. Replace it with the following markup:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;h2&gt;Employee Search&lt;/h2&gt;
&lt;p&gt;Search an employee by typing a last name.&lt;/p&gt;
&lt;asp:TextBox ID="txtName" runat="server"/&gt;
&lt;asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" /&gt;
&lt;asp:PlaceHolder ID="phEmployeeSearch" runat="server" Visible="false"&gt;   
&lt;asp:Repeater ID="rpEmployeeSearchView" runat="server"&gt;
&lt;ItemTemplate&gt;
    &lt;p&gt;&lt;asp:HyperLink ID="hlLink" runat="server" NavigateUrl='&lt;%#Eval("guid", "viewdetail.aspx?guid={0}")%&gt;' Text='&lt;%#Eval("Name")%&gt;' /&gt;&lt;/p&gt;
&lt;/ItemTemplate&gt;
&lt;/asp:Repeater&gt;&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phNoEmployeeFound" runat="server" Visible="false"&gt;
&lt;p&gt;No Employee exists.&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, we have the following:</p>
<ol>
<li>Heading three to identify the page</li>
<li>Server-side text box</li>
<li>Button control</li>
</ol>
<p>Each control has an ID property value to uniquely identify it. Each one has a runat property value that tells us the control is run by the server first and then HTML output is sent to the browser. On the button, we have an OnClick attribute with a value of btnSearch_Click. OnClick is a server-side event, which means we must have a corresponding event in our code-behind file.</p>
<p>Before doing that, you will also see a placeholder control (with its visibility set to false) with a repeater control inside. Inside the repeater control, we use a hyperlink control. In that control, we use the NavigateUrl property -- passing in the Web page that will view additional employee detail -- and use the Text property and pass in Name, which is coming from our stored procedure query (more on this query shortly).</p>
<p>When a user searches for employees, we'll toggle this to true if an employee is found. If no employee is found, we'll toggle our second placeholder, which tells the visitor there's no employee found.</p>
<p>Let's add the method we need for our button control. From the solution explorer, left click the plus sign (+) next to default.aspx, double click default.aspx.cs and add the following code:</p>
<pre><code>
protected void btnSearch_Click(object s, EventArgs e)
{
}
</code></pre>
<p>Save your file.</p>
<h3>Run the Project</h3>
<p>When we initially run the project, you'll see this window:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig7.jpg" width="494" height="234" alt="Debugging Not Enabled" />
<p>Click OK. Because we have no functionality yet, you should just see the initial screen. When finished, return to Visual Studio and press the stop button.</p>
<p>We'll continue by implementing the search functionality <a href="default2.aspx">next</a>.</p>
</asp:Content>