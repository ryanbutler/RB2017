<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default6.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Creating the Help Desk Class</h3>
<p>Now that we have our data coming in, we need to be able to record a help desk ticket submission. We need to create an event handler in a class to handle it. Let's first create a help desk class by doing the following:
</p>
<ol>
<li>Right click the project solution.</li>
<li>Choose Add:New Item.</li>
<li>In the Add New Item window, select Class.cs.</li>
<li>In the name text field, type "HelpDesk" and then click Add.</li>
</ol>
<p>Double click HelpDesk.cs from the Solution Explorer, which will show the empty class as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace HelpDesk
{
    public class HelpDesk
    {
    }
}
</code></pre>
<p>We need to import three libraries as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace HelpDesk
{
    public class HelpDesk
    {
    }
}
</code></pre>
<p>The first library (System.Data) allows us to work with stored procedures in ADO.NET, the second (System.Configuration) allows us to reference a connection key from our configuration file and the last (System.Data.SqlClient) one allows us to connect to SQL Server.
</p>
<h3>Creating Our Declarations</h3>
<p>Let's first add our class-level variables so that we can get or set our data. Add the following code:</p>
<pre><code>
namespace HelpDesk
{
    public class HelpDesk
    {
        #region Declarations
        public string fname { get; set; }
        public string lname { get; set; }
        public string email { get; set; }
        public int status { get; set; }
        public string comments { get; set; }
        public int severity { get; set; }
        public int department { get; set; }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we added a region that holds our class-level variables. These variables match our columns from the database table.</p>
<h3>Creating Our Method</h3>
<p>In order to insert our help desk ticket, we need one method that will accept our parameters and insert the record. We do this by adding the following code:</p>
<pre><code>
#region Methods
        public void Save()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spInsertHelpDeskTicket", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter parameterFName = new SqlParameter("@FName", SqlDbType.VarChar, 50);
            parameterFName.Value = fname;
            cmd.Parameters.Add(parameterFName);
            SqlParameter parameterLName = new SqlParameter("@LName", SqlDbType.VarChar, 50);
            parameterLName.Value = lname;
            cmd.Parameters.Add(parameterLName);
            SqlParameter parameterEmail = new SqlParameter("@Email", SqlDbType.VarChar, 50);
            parameterEmail.Value = email;
            cmd.Parameters.Add(parameterEmail);
            SqlParameter parameterSeverity = new SqlParameter("@SeverityID", SqlDbType.Int);
            parameterSeverity.Value = severity;
            cmd.Parameters.Add(parameterSeverity);
            SqlParameter parameterStatus = new SqlParameter("@StatusID", SqlDbType.Int);
            parameterStatus.Value = status;
            cmd.Parameters.Add(parameterStatus);
            SqlParameter parameterDepartment = new SqlParameter("@DepartmentID", SqlDbType.Int);
            parameterDepartment.Value = department;
            cmd.Parameters.Add(parameterDepartment);
            SqlParameter parameterComments = new SqlParameter("@Comments", SqlDbType.VarChar, 250);
            parameterComments.Value = comments;
            cmd.Parameters.Add(parameterComments);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message.ToString());
            }
            finally
            {
                cmd.Dispose();
                conn.Close();
            }
        }
        #endregion
</code></pre>
<p>As you can see from the code above, we did the following:</p>
<ol>
<li>Created a connection object and passed in our configuration key</li>
<li>Created a command object and passed in our stored procedure</li>
<li>Set our command object to use a stored procedure</li>
<li>Created a SQL parameter for each class-level variable:
<ul>
<li>Specified the data type for each
</li>
</ul>
</li>
<li>Added each SQL parameter to our command object</li>
</ol>
<p>If for any reason we can't open or execute our query, we wrap it inside a try/catch block and then open the connection to our database and execute the stored procedure. After the stored procedure is executed, we dispose of the command object and close our connection.
</p>
<h3>Create the Help Desk Object</h3>
<p>From the Solution Explorer, double click default.aspx.cs and type the following method:</p>
<pre><code>
namespace HelpDesk
{
 public partial class _default : System.Web.UI.Page
 {
     #region Declarations
     HelpDesk hd = new HelpDesk();
     #endregion
     protected void Page_Load(object sender, EventArgs e)
  {
  }
  protected void btnSubmit_Click(object sender, EventArgs e)
  {
  }
 }
}
</code></pre>
<p>As you can see from the code above, we simply create a reference to the help desk object.</p>
<h3>Creating the Submit Method</h3>
<p>Now that we have the reference to our help desk object, let's add the following method:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
        {
            hd.fname = fnameTB.Text;
            hd.lname = lnameTB.Text;
            hd.email = emailTB.Text;
            hd.severity = Convert.ToInt32(ddlSeverity.SelectedValue);
            hd.status = Convert.ToInt32(ddlStatus.SelectedValue);
            hd.department = Convert.ToInt32(ddlDept.SelectedValue);
            hd.comments = commentsTB.Text;
            hd.Save();
            phForm.Visible = false;
            phSuccess.Visible = true;
        }
</code></pre>
<p>As you can see from the code above, we set each of our help desk object properties to the appropriate values of our controls from our default.aspx page. Once we have that information, we call the save method, and then we toggle the visibility of our controls.</p>
<h3>Test Drive the Application</h3>
<p>From Visual Studio, click the green arrow button (F5) to run the project. Type data into the text fields, pick optons from the dropdown lists, and press submit. If everything works correctly, you should have a new record in the help desk table.</p>
<h3>Summary</h3>
<p>In this article you learned how to build a relatively simple help desk application in ASP.NET and along the way learned how to do the following:</p>
<ol>
<li>Create a database:
<ul>
<li>Create corresponding tables</li>
<li>Create and understand stored procedures</li>
<li>Understand relationships with data</li>
<li>Create a database diagram to enforce referential integrity</li>
</ul>
</li>
<li>Create a Visual Studio project:
<ul>
<li>Create a Web form with basic controls</li>
<li>Create JavaScript reset functionality</li>
<li>Create corresponding C# classes and understand the basics of generics</li>
<li>Create server- or client-side event handlers and understand the differences between the two</li>
</ul>
</li>
</ol>
<p>Take the knowledge you gained from this article and expand your help desk application to meet any requirement you may need.
</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>