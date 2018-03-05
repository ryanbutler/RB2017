<%@ Page Title="Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.articles.creating_a_searchable_online_employee_directory_asp_net_ms_sql_server.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create viewdetail.aspx</h3>
<p>When our visitors view this page, they will see additional details of the employee in a read-only format. Let's create this file by following these steps:</p>
<ol>
<li>From the solution explorer, right click on your solution and choose Add:New Item.</li>
<li>In the Add New Item window, select ASP.NET Web Form.</li>
<li>In the name text field, type "viewdetail.aspx" and left click Add.</li>
</ol>
<p>Double click viewdetail.aspx from the solution explorer and remove everything inside the opening and closing &lt;form&gt; tags. Next, add the following markup inside the opening and closing &lt;form&gt; tags as shown below:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="phViewDetail" runat="server" Visible="true"&gt;
&lt;dl&gt;
&lt;dt&gt;First name:&lt;/dt&gt;
&lt;dd&gt;&lt;asp:Label ID="lblFName" runat="server" /&gt;&lt;/dd&gt;
&lt;dt&gt;Last name:&lt;/dt&gt;
&lt;dd&gt;&lt;asp:Label ID="lblLName" runat="server" /&gt;&lt;/dd&gt;
&lt;dt&gt;Email:&lt;/dt&gt;
&lt;dd&gt;&lt;asp:Label ID="lblEmail" runat="server" /&gt;&lt;/dd&gt;
&lt;dt&gt;&lt;/dt&gt;
&lt;dd&gt;&lt;a href="Default.aspx"&gt;Back to employee directory&lt;/a&gt;&lt;/dd&gt;
&lt;/dl&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phNoViewDetail" runat="server" Visible="false"&gt;
&lt;p&gt;No employee selected.&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, we create a placeholder control, set its visibility to true, and nested inside, we use a fieldset and definition lists. Fieldsets, along with definition lists, are another way of making form layouts accessible, much like labels. In a definition list, the &lt;dt&gt; tag is your label and the &lt;dd&gt; tag is where you place your form(s) element(s). We use label controls and we'll set their text property in the code behind to the approach value. Lastly, we use another placeholder control, set its visibility to false, and put a simple error message inside. If for any reason our query string isn't there, we'll display this.</p>
<h3>Create Our Style Sheet</h3>
<p>Let's create our style sheet so we can control the positioning of our definition lists:</p>
<ol>
<li>From the solution explorer, right click on the solution and choose Add:New Item.</li>
<li>In the add new item window, choose style sheet.</li>
<li>In the name text field, type "style" and then left click Add.</li>
</ol>
<p>In our style sheet, add the following rules as shown below:</p>
<pre><code>
body
{
}
dl{
      width:400px;
      margin:0 auto;
}
dl dt{
      float:left;
      width:80px;
}
dl dt dd{
      float:left;
      width:80px;
}
</code></pre>
<p>As you can see from the code above, we set the dl tag to a width of 400 and center it with a margin of auto. Then we float both the dt and dd left, giving them an appropriate width. Save your file. In viewdetail.aspx, add the reference to our style sheet as shown below:</p>
<pre><code>
&lt;head&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
&lt;/head&gt;
</code></pre>
<p>As you can see from the code above, we create a reference to the style sheet. Save your file.</p>
<h3>Creating View Detail Method in employeedirectory.cs</h3>
<p>We know from our main page (default.aspx), viewdetail.aspx needs to accept a parameter, specifically, a GUID from the query string. What we'll do is create a method in our class file that will take one parameter, a GUID, and return that to our code behind file and then display additional detail about our employee. Let's add the code for that as shown below:</p>
<pre><code>
public void GetEmployeesViewGuid(Guid guid)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spEmployeeDirectoryViewGuid", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter parameterGuid = new SqlParameter("@Guid", SqlDbType. UniqueIdentifier, 37);
            parameterGuid.Value = guid;
            cmd.Parameters.Add(parameterGuid);
            try
            {
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if(rdr.Read())
                {
                    lname = rdr["LName"].ToString();
                    fname = rdr["FName"].ToString();
                    email = rdr["Email"].ToString();
                    officeloc = rdr["OfficeLoc"].ToString();
                    phonenum = rdr["PhoneNum"].ToString();
                    jobtitle = rdr["JobTitle"].ToString();
                }
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
</code></pre>
<p>In the code above, we do the following:</p>
<ol>
<li>Create a method GetEmployeesViewGuid and pass in our GUID.</li>
<li>Create a connection object and pass in our key from our configuration file.</li>
<li>Create a command object and pass in our stored procedure (created next) and our connection object.</li>
<li>Set our command object to accept a stored procedure.</li>
<li>Create a SQL parameter and pass in our GUID as a parameter.</li>
<li>Set our parameter to the value of our GUID variable.</li>
</ol>
<p>If for any reason we can't open the connection or read from our data reader object, we wrap that inside a try/catch block and do the following:</p>
<ol>
<li>Call the open method of our connection object.</li>
<li>Set our data reader object to the execute reader method of our command object.</li>
<li>If the data reader can read, we do the following:
<ul>
<li>Set each of our class-level variables to the appropriate data reader value</li>
</ul>
</li>
<li>Catch and throw an exception if necessary.</li>
<li>Call the dispose method of the command object and the close method of our connection object</li>
</ol>
<p>Save your file.</p>
<h3>Create Stored Procedure View Detail</h3>
<p>As before, we need to create another stored procedure. From the object explorer, follow these steps to create the procedure for viewing an employee's specific information:</p>
<ol>
<li>Expand the plus sign (+) next to our database, mwd.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code with the following as shown below:</p>
<pre><code>
use mwd
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      &lt;Author,,Name&gt;
-- Create date: &lt;Create Date,,&gt;
-- Description:   &lt;Description,,&gt;
-- =============================================
CREATE PROCEDURE spEmployeeDirectoryViewGuid 
   -- Add the parameters for the stored procedure here
   @Guid uniqueidentifier
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   SELECT FName, LName, Guid, Email, OfficeLoc, JobTitle, PhoneNum
   FROM EmployeeDirectory
   WHERE Guid=@Guid
END
GO
</code></pre>
<p>As you can see from the SQL query above, we create a parameter, GUID, set its size to 37, select from our table the columns we want and then append on a WHERE clause for our GUID parameter. Before running the stored procedure on the database, follow these steps from the main menu to save the stored procedure:</p>
<ol>
<li>From the main menu, choose File:Save As.</li>
<li>In the Save As dialog, type "spEmployeeDirectoryViewGuid" and then left click OK.</li>
</ol>
<p>When finished, run the stored procedure by clicking execute right below the main menu. If run succesfully, SQL Server will report "Commands executed successfully." Minimize SQL Server Management Studio for the time being.</p>
<h3>Open viewdetail.aspx.cs</h3>
<p>From the solution explorer, follow these steps:</p>
<ol>
<li>Left click the plus sign (+) next to default.aspx.</li>
<li>Double click default.aspx.cs. Inside your partial class, add the following code as shown below:</li>
</ol>
<pre><code>
namespace EmployeeDirectory
{
    public partial class viewdetail : System.Web.UI.Page
    {
        #region Declarations
        EmployeeDirectory ed = new EmployeeDirectory();
        #endregion
   }
}
</code></pre>
<p>As you can see from the code above, we create a new instance of our employee directory class.</p>
<p>In our page load event, let's add the following code as shown below:</p>
<pre><code>
namespace EmployeeDirectory
{
    public partial class viewdetail : System.Web.UI.Page
    {
        #region Declarations
        EmployeeDirectory ed = new EmployeeDirectory();
        #endregion
        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid myguid = Guid.Empty;
            myguid =new Guid(Request.QueryString["guid"]);
            if (myguid != null)
            {
                GetData(myguid);
            }
            else
            {
                phNoViewDetail.Visible = true;
                phViewDetail.Visible = false;
            }
        }
}
}
</code></pre>
<p>As you can see from the code above, we do the following inside our page load event:</p>
<ol>
<li>Create a variable with a data type of GUID and set it to empty.</li>
<li>Set our GUID variable to accept a new GUID, and pass in our query string.</li>
<li>Check our GUID variable to see if it's null.
<ul>
<li>If it is not, call GetData and pass in our variable.</li>
<li>If it is, show our error message.</li>
</ul>
</li>
</ol>
<p>You may wonder why we had to set the GUID variable to empty. The reason is simple: if for any reason we don't get a query string passed in, we need a default value (empty string) in our variable. Otherwise, our application will throw an exception because we're accessing a null object.</p>
<p>Let's create our GetData method as shown below:</p>
<pre><code>
protected void GetData(Guid myguid)
        {
            phViewDetail.Visible = true;
            ed.GetEmployeesViewGuid(myguid);
            lblFName.Text = ed.fname.ToString();
            lblLName.Text = ed.lname.ToString();
            lblEmail.Text = ed.email.ToString();
        }
</code></pre>
<p>As you can see from the code above, we pass in our variable as a GUID data type, and then we do the following:</p>
<ol>
<li>Set our initial placeholder's visibility to true.</li>
<li>Call our method, GetEmployeesViewguid, and pass in our variable.</li>
<li>After our method runs, if the reader can read data, we set each of our label controls to their appropriate values from our object.</li>
</ol>
<p>Save your file. Run the project by pressing F5, and type "D" or "Doe" in the search field, which returns Doe. Click on the hyperlink and you should be able to view additional details regarding our employee.</p>
<h3>Summary</h3>
<p>In this article, you learned how to create an employee search directory using ASP.NET. Additionally, you learned the following:</p>
<ol>
<li>SQL
<ul>
<li>Create a database</li>
<li>Create a table</li>
<li>Create and understand stored procedures</li>
</ul>
</li>
<li>Visual Studio
<ul>
<li>Create a project</li>
<li>Create two web forms
<ul>
<li>One that searches for an employee</li>
<li>One that views additional detail about an employee</li>
</ul>
</li>
</ul>
</li>
<li>Definition lists and how to style them appropriately</li>
<li>Create a class that had:
<ul>
<li>A generic list object</li>
<li>A method that accepted a GUID as a parameter</li>
</ul>
</li>
</ol>
<p>Take the knowledge gained in this article and build or enhance our search application to meet any need or requirement you may have.</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>