<%@ Page Title="Creating a Human Resources Application with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_human_resources_application_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Human Resources Application with ASP.NET (ASPX) and MS SQL Server</h2>
<p>Most companies post their job openings on an internal intranet, as well as on outside job sites such as CareerBuilder or Indeed. However, the need for a company to post their jobs to their internal intranet promptly and efficiently presents a significant challenge. How do you allow non-technical personnel with no HTML skills to post new jobs to the intranet? How do you distinguish between active listings (that is, for jobs with an immediate need) and those that will not be active for another few weeks but need to be entered by the human resources (HR) department?</p>
<p>There are a few options, including migrating the entire company's website into a content management system. This way, non-technical personnel can create new job listings without the hassle of learning new technologies. </p>
<p>In this article, I'll explain how you could create a simple human resources application with ASP.NET:</p>
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
<li>Give your database a name of HumanResources and click OK.</li>
</ul>
<h3>Create the Main Table</h3>
<p>To create our tables, follow these steps:</p>
<ol>
<li>Click the plus sign (+) next to your database as shown below:</li>
</ol>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig2.jpg" width="198" height="84" alt="Expand Table" /></p>
<p>Let's create our table, HumanResources, first. We need the following columns as outlined below:</p>
<ol>
<li>ID:
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>Guid:
<ul>
<li>Data type: uniqueidentifier</li>
<li>Not null</li>
</ul>
</li>
<li>PostingDate:
<ul>
<li>Data type: datetime</li>
<li>Not null</li>
</ul>
</li>
<li>JobTitle:
<ul>
<li>Data type: varchar(100)</li>
<li>Not null</li>
</ul>
</li>
<li>JobIDNumber:
<ul>
<li>Data type: varchar(50)</li>
<li>Not null</li>
</ul>
</li>
<li>RequiredQual:
<ul>
<li>Data type: varchar(100)</li>
<li>Not null</li>
</ul>
</li>
<li>PreferredQual:
<ul>
<li>Data type: varchar(100)</li>
<li>Not null</li>
</ul>
</li>
<li>Responsibilities:
<ul>
<li>Data type: varchar(500)</li>
<li>Not null</li>
</ul>
</li>
<li>StartDate:
<ul>
<li>Data type: datetime</li>
<li>Not null</li>
</ul>
</li>
<li>Salary:
<ul>
<li>Data type: varchar(50)</li>
<li>Not null</li>
</ul>
</li>
<li>ApplyInfo:
<ul>
<li>Data type: varchar(50)</li>
<li>Not null</li>
</ul>
</li>
<li>Active:
<ul>
<li>Data type: bit</li>
<li>Not null</li>
</ul>
</li>
</ol>
<p>Before continuing, make sure to set the primary key by right clicking the column (ID) and choosing Set Primary Key as shown below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig4.gif" width="210" height="51" alt="Set Primary Key" /></p>
<p>While we're at it, let's set the seed on this column as well by setting Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig5.gif" width="616" height="65" alt="Set Is Identity" /></p>
<p>Next, left click the GUID (global unique identifier) column and in the properties window, set default value or binding to (newid()).</p>
<h3>Populating Human Resources Table</h3>
<p>Let's populate the table with some data by following these steps:</p>
<ol>
<li>Right click on HumanResources, and select Open</li>
<li>Enter the following data:</li>
<li>Record 1:
<ul>
<li>Job Title: Software Engineer</li>
<li>Required Qualifications: 4 years in commericial development</li>
</ul>
</li>
<li>Record 2:
<ul>
<li>Job Title: Business Analyst</li>
<li>Required Qualifications: 3 years in commericial development</li>
</ul>
</li>
</ol>
<p>Enter a few more records with different information. After each record, make sure you press the execute button so you get a new GUID as shown in the image below:</p>
<p class="alignCenter"><img src="images/EmployeeDirectoryASP.NET_Fig6.jpg" width="126" height="72" alt="Execute SQL" /></p>
<h3>Create the HR Application with Visual Studio</h3>
<p>Open Visual Studio (Start: Programs: Microsoft Visual Studio) and from the main menu, follow these steps:</p>
<ol>
<li>File: New: Project</li>
<li>In the New Projects window, left click Web on the left side and left click ASP.NET Web Application on the right side.</li>
<li>In the name text field, type HumanResources.</li>
<li>In the location text field, choose a directory and click OK.</li>
</ol>
<h3>Modify the web.config File</h3>
<p>From the solution project, you need to modify your configuration file for your database connection. Double click web.config to open the file, and then add the following right after &lt;appSettings/&gt;:</p>
<pre><code>
&lt;connectionstrings name="[your_connection_key_name]" connectionstring="Data Source=(local);Initial Catalog=HumanResources;Integrated Security=SSPI;"/&gt;
</code></pre>
<p>As you can see from the code above, we added a connection string with a key name, followed by your connection details. Modify this with your own settings. When you're finished, save the file.</p>
<h3>Create default.aspx to view existing jobs</h3>
<p>In order to view all jobs currently in the system, we need to create a default.aspx file. Follow these steps:</p>
<ol>
<li>Right click on the solution</li>
<li>Choose Add : New Item</li>
<li>In the Add New Item Window, choose Web from the left pane</li>
<li>Choose Web Form with Master page from the right pane</li>
<li>In the name text field, type default.aspx and click Add</li>
</ol>
<h3>Add functonality to default.aspx</h3>
<p>Our default.aspx allows us to do the following:</p>
<ol>
<li>Add a new job to the system</li>
<li>View active jobs in the system</li>
<li>View inactive jobs in the system</li>
</ol>
<p>Open default.aspx and add the following code:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;
&lt;head runat="server"&gt;
&lt;title&gt;Human Resources &#8212; Administrative &#8212; Home&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "../style.css";
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="form1" runat="server"&gt;
&lt;table id="mainTbl" cellspacing="0"&gt;
&lt;tr&gt;
&lt;td id="header" colspan="2"&gt;Fake Company&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td id="left"&gt;
&lt;ul id="navigation"&gt;
&lt;li&gt;&lt;a href="addjob.aspx"&gt;Add Job&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;About Us&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;Contact&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;Maps&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/td&gt;
&lt;td id="content"&gt;
&lt;h2&gt;Active jobs (are visible from home page)&lt;/h2&gt;
&lt;asp:Repeater ID="rpAdminActiveJobs" runat="server"&gt;
&lt;ItemTemplate&gt;
&lt;ul&gt;
&lt;li&gt;&lt;%#Eval("JobTitle")%&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/ItemTemplate&gt;
&lt;/asp:Repeater&gt;
&lt;h2&gt;Inactive jobs (are not visible from home page)&lt;/h2&gt;
&lt;asp:Repeater ID="rpAdminInactiveJobs" runat="server"&gt;
&lt;ItemTemplate&gt;
&lt;ul&gt;
&lt;li&gt;&lt;%#Eval("JobTitle")%&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/ItemTemplate&gt;
&lt;/asp:Repeater&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</code>
</pre>
<p>As you can see from the code above, we have a basic template that allows our behavior that we described before.</p>
<h3>Add Stylesheet</h3>
<p>As you might have seen, we have a style sheet imported in our template. Follow these steps to create a style sheet:</p>
<ol>
<li>From the Solution explorer, right click  and choose Add : New Item</li>
<li>In the Add New Item Window, choose Web from the left pane</li>
<li>From the right pane, choose Style Sheet</li>
<li>In the name text field, type style.css and click Add</li>
</ol>
<h3>Create a Human Resources Class</h3>
<p>For us to be able to add a new job listing to your system, you need to write an insert functionality either within addjob.aspx or its code-behind file. Generally, the more you can abstract functionality out of designer files into classes that turn into objects, the less your code is coupled and the easier it will be to modify for enhancements. As a result, you'll code this functionality in a class.
</p>
<p>Follow these steps to create your class:</p>
<ol>
<li>From the solution explorer, right click the solution and choose Add:Class.</li>
<li>In class window name field, type HumanResources.cs and click OK.</li>
</ol>
<p>Double click HumanResources.cs from the solution explorer and add the following namespaces:</p>
<pre><code>
using System.Data;
 using System.Configuration;
 using System.Data.SqlClient;
 namespace HumanResources
 {
   public class HumanResources
   {
  
   }
  
 }
</code></pre>
<p>As you can see, you added three. The first allows us to work with stored procedures in ADO.NET; the second allows us to reference a connection key from your configuration file; and the last allows us to connect to SQL Server. Next, let's add your declarations, as shown below:</p>
<pre>
<code>
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
namespace HumanResources
{
    public class HumanResources
    {
        #region Declarations
        public DateTime postingDate { get; set; }
        public string jobTitle { get; set; }
        public string requiredQual { get; set; }
        public string preferredQual { get; set; }
        public string responsibilities { get; set; }
        public DateTime startDate { get; set; }
        public string salary { get; set; }
        public string applyInfo { get; set; }
        public bool active { get; set; }
        public Guid guid { get; set; }
        #endregion
    }
}
</code>
</pre>
<p>As you can see, you create a region named declarations, and inside you create public variables (with appropriate data types for each column from your database table) with getters and setters. Next, let's add your add job method, which will insert new jobs in your system as shown below:</p>
<pre><code>
public void AddJob()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["[your_key_name"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spHumanResourcesAddJob", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter parameterPostingDate = new SqlParameter("@PostingDate", SqlDbType.DateTime);
            SqlParameter parameterJobTitle = new SqlParameter("@JobTitle", SqlDbType.VarChar, 100);
            SqlParameter parameterReqQual = new SqlParameter("@RequiredQual", SqlDbType.VarChar, 100);
            SqlParameter parameterPrefQual = new SqlParameter("@PreferredQual", SqlDbType.VarChar, 50);
            SqlParameter parameterResponsibilities = new SqlParameter("@Responsibilities", SqlDbType.VarChar, 500);
            SqlParameter parameterStartDate = new SqlParameter("@StartDate", SqlDbType.DateTime);
            SqlParameter parameterSalary = new SqlParameter("@Salary", SqlDbType.VarChar, 50);
            SqlParameter parameterApplyInfo = new SqlParameter("@ApplyInfo", SqlDbType.VarChar, 500);
            SqlParameter parameterActive = new SqlParameter("@Active", SqlDbType.Bit);
            parameterPostingDate.Value = postingDate;
            parameterJobTitle.Value = jobTitle;
            parameterReqQual.Value = requiredQual;
            parameterPrefQual.Value = preferredQual;
            parameterResponsibilities.Value = responsibilities;
            parameterStartDate.Value = startDate;
            parameterSalary.Value = salary;
            parameterApplyInfo.Value = applyInfo;
            parameterActive.Value = active;
            cmd.Parameters.Add(parameterPostingDate);
            cmd.Parameters.Add(parameterJobTitle);
            cmd.Parameters.Add(parameterReqQual);
            cmd.Parameters.Add(parameterPrefQual);
            cmd.Parameters.Add(parameterResponsibilities);
            cmd.Parameters.Add(parameterStartDate);
            cmd.Parameters.Add(parameterSalary);
            cmd.Parameters.Add(parameterApplyInfo);
            cmd.Parameters.Add(parameterActive);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                cmd.Dispose();
                conn.Close();
            }
        }
</code></pre>
<p>As you can see from the code above, you created a method named AddJob and did the following:</p>
<ol>
<li>Created a connection object and passed in your configuration key</li>
<li>Created a command object and passed in your stored procedure and connection object</li>
<li>Created a SQL parameter for each column from your database table and its data type</li>
<li>Set the parameter's value to its appropriate variable value</li>
<li>Added the parameter to your command object</li>
</ol>
<p>If for any reason you can't open a connection to the database or execute the query, you wrap this inside a try/catch block, which handles exceptions, and do the following:</p>
<ol>
<li>Call the open method of your connection object</li>
<li>Call the execute non query method of your command object</li>
<li>If an exception occurs, catch it and throw the exception to the screen</li>
</ol>
<p>Lastly, you call the dispose method of your command object and the close method of your connection object to clear resources.</p>
<p>We'll continue next by adding the ability to call a new job <a href="default2.aspx">next</a>.</p>
</asp:Content>