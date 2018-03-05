<%@ Page Title="Creating an Audit Record Application with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_audit_record_application_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating an Audit Record Application with ASP.NET (ASPX) and MS SQL Server</h2>
<p>Often times in development, you need the ability to store audit transactions within an application. Reasons for this are varied and include: health care related applications use it to determine who viewed patient data, which help the product meet government regulations. When businesses use applications that have multiple users updating, recording or deleting sensitive information generally want auditing procedures in place to prevent fraud or inaccurate information from entering the system. Bank applications use it to audit balances recorded by accountants. Obviously, having the ability to keep audits of these transactions becomes very helpful over the course of time.</p>
<p>In the following article, we'll learn how to implement audit recording through an ASP.NET application. Specifically, we'll learn: how to effectively record the audit from a table in SQL, how to record the date and time, as well as the user who audited the information. If you would like to learn how to create and implement an application such as this, please do follow along.</p>
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
<li>Give your database a name of AuditRecord and click OK.</li>
</ul>
<h3>Create the Main Table</h3>
<p>To create our tables, follow these steps:</p>
<ol>
<li>Click the plus sign (+) next to your database as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig2.jpg" width="198" height="84" alt="Expand Database"/></p>

<p>Let's create our table, employeedirectory, first. We need the following columns as outlined below:</p>
<ol>
<li>ID:
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>FName:
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>LName:
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>Email:
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>GUID:
<ul>
<li>Data type: uniqueidentifier</li>
<li>Not null</li>
</ul>
</li>
<li>JobTitle:
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>OfficeLoc:
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
<h3>Create the Record History Application with Visual Studio</h3>
<p>Open Visual Studio (Start:Programs:Microsoft Visual Studio) and from the main menu, follow these steps:</p>
<ol>
<li>File:New:Project</li>
<li>In the New Projectswindow, left click Web on the left side and left click ASP.NET Web Application on the right side.</li>
<li>In the name text field, type RecordHistory.</li>
<li>In the location text field, choose a directory and click OK.</li>
</ol>
<h3>Modify the web.config File</h3>
<p>From the solution project, you need to modify your configuration file for your database connection. Double click web.config to open the file, and then add the following right after &lt;appSettings/&gt;: </p>
<pre><code>
&lt;connectionStrings&gt; 
&lt;add name="mwd" connectionString="Data Source=A12B3TM1;Initial Catalog=mwd_RecordHistory;Integrated Security=SSPI;"/&gt;
 &lt;/connectionStrings&gt;
</code></pre>
<p>As you can see from the code above, you added a connection string with a key named mwd, followed by your connection details. Modify this with your own settings. When you're finished, save the file.</p>
<h3>Create a Classes and Style Folder</h3>
<p>From the solution, let's create our classes' folder as an example:</p>
<ol>
<li>Right click on the solution and select Add→New Folder.</li>
<li>Type classes and press enter.</li>
</ol>
<p>From the classes' folder, create two additional files by following these steps:</p>
<ol>
<li>Right click on the folder, and select Add:New Item.</li>
<li>In Add New Item window, select Class file from the right side.</li>
<li>In the name text field, type RecordHistoryData and click OK.</li>
</ol>
<p>Repeat this process, but when you reach the last step, type RecordHistoryDataActions in the name text field. You will now have two classes, RecordHistoryData and RecordHistoryDataActions.</p>
<p>Before finishing, create a folder for style. For your style sheet, follow these steps:</p>
<ol>
<li>From the solution, right click and select Add:New Item.</li>
<li>In the New Item window, select stylesheet from the right side.</li>
</ol>
<p>In the name text field, type style.css and click OK.</p>
<p>Double click your style.css from the solution explorer and add the code from the style.css file in the project downloads. As you can see from the code archive, you added the following: a container for your form, and basic positioning for your labels. Save your style sheet before moving forward.</p>
<h3>Create Default.aspx and Recordaudit.aspx</h3>
<p>Our default page, serves as our home page, which lists all employees that are available. From looking at the project downloads, you will notice the following:</p>
<ol>
<li>An ASPX page with a reference to a style sheet</li>
<li>A layout container that contains a repeater control, which holds a hyperlink server control</li>
</ol>
<p>It should be noted, the important to the link is the NavigateUrl attribute. We first pass in our column from our database table, GUID (also our class level variable), followed by a link to our recordaudit.aspx page, and append on a query string of guid, followed by a bracket that serve to parse through each GUID available from our database table.</p>
<p>This file works with RecordHistoryData.cs to display employee names, which we'll cover next.</p>
<p>Save your file(s).</p>
<h3>Displaying Employee Names</h3>
<p>To display employee names from our home page, we need to write a data handling method that will query our database for records in our parent table, RecordHistory. We can either do this in the code-behind file for our home page, or, we can do this from our class file, RecordHistoryData.cs. Generally, the latter option is preferred, since you are abstracting code that would otherwise be tightly coupled to the home page. From the solution explorer, do the following:</p>
<ol>
<li>Left click the plus (+) sign next to classes.</li>
<li>Double click RecordHistoryData.cs.</li>
</ol>
<p>With the file open, add the following namespaces:</p>
<pre><code>
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace RecordHistory.classes
{
    public class RecordHistoryData
    {
}
</code></pre>
<p>As you can see, you added three. The first allows us to work with stored procedures in ADO.NET; the second allows us to reference a connection key from your configuration file; and the last allows us to connect to SQL Server. Next, let's add your declarations, which you can get from the project downloads file.</p>
<p>As you can see from the code archive, you create a region named declarations, and inside you create public variables (with appropriate data types for each column from your database table) with getters and setters. Next, let's add our method that will list all employees on our homepage, which can be found from the project downloads file.</p>
<p>As you can see from the code archive, you created a static method named GetEmployees and did the following:</p>
<ol>
<li>Created a connection object and passed in your configuration key</li>
<li>Created a command object and passed in your stored procedure and connection object</li>
<li>Created a generic list object, typed as our class</li>
</ol>
<p>If for any reason you can't open a connection to the database or execute the query, you wrap this inside a try/catch block, which handles exceptions, and do the following:</p>
<ol>
<li>Call the open method of your connection object.</li>
<li>Create a data reader object, and set it to the command object's execute reader method.</li>
<li>Because we want all employees listed, we iterate through our reader object using a while loop and do the following: 
<ul>
<li>Create a new instance of our RecordHistoryData object.</li>
<li>Set each of our variables used to display our employee names from our reader object.</li>
<li>Add our record history object to our list object each time through the iteration.</li>
</ul>
</li>
<li>If an exception occurs, catch it and throw the exception to the screen.</li>
</ol>
<p>Lastly, you call the dispose method of your command object and the close method of your connection object to clear resources.</p>
<p>Save your file(s).</p>
<h3>Open Default.aspx.cs</h3>
<p>Since you have written the functionality needed to display employees, let's add the ability to call it. From the solution explorer, left click the plus (+) sign next to default.aspx and double click default.aspx.cs. Next, add the region named declarations and methods from the project downloads file.</p>
<p>As you can see from the code archive, you do the following:</p>
<ol>
<li>Add a namespace for our class, which is RecordHistory.classes.</li>
<li>Create a region named declarations.</li>
<li>In the page load event, we create a generic list object typed as our class, and then call the appropriate method.</li>
<li>We then set the data source property of our repeater control to our list object and then data bind to our control to display the names.</li>
</ol>
<p>Save your file(s) and run the project. Your home page should show two employees.</p>
<h3>Exploring Recordaudit.aspx</h3>
<p>Let's take a moment and look over this page, since this is where our auditing occurs. From the solution, do the following:</p>
<ul>
<li>Double click recordaudit.aspx.</li>
</ul>
<p>Inside this file, you will notice the following:</p>
<ol>
<li>A reference to our style sheet, which controls the layout of our form.</li>
<li>Three placeholder controls, which do the following: 
<ul>
<li>First placeholder shows our initial form, which contains fields to edit existing employee information.</li>
<li>Second placeholder shows our success message, which will be visible after a successful update, or in our case, audit.</li>
<li>Third placeholder shows a failure message, which will be visible if our query string is empty.</li>
</ul>
</li>
<li>One server-side button control, which does the following: 
<ul>
<li>Server-side event, which handles update (audit) functionality</li>
</ul>
</li>
</ol>
<p>We'll continue with writing the view employee functionality <a href="default2.aspx">next</a>.</p>
</asp:Content>