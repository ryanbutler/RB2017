<%@ Page Title="Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_searchable_online_employee_directory_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Implement Search Functionality</h3>
<p>Our search functionality works as follows: a visitor will type a last name or a letter of a last name in our search field. They click submit, we pass in the value they enter, issue a query against it, and if we find a match or matches, we'll display the employee last and first name as a hyperlink. If no matches are found, we display our placeholder that has the no records exist message. We could put all this logic in our code-behind file, but that's not recommended. Instead, let's create a class file to handle the data access.</p>
<h3>Create our class file</h3>
<p>From the solution explorer, follow these steps:</p>
<ol>
<li>Right click the solution directory and choose Add:New Item.</li>
<li>From the left pane, select code.</li>
<li>From the right pane, select class.</li>
<li>In the name text field, type EmployeeDirectory.cs and left click add.</li>
</ol>
<p>With EmployeeDirectory.cs opened, it will an empty class as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace EmployeeDirectory
{
    public class EmployeeDirectory
    {
    }
}
</code></pre>
<p>In order to work with our SQL database, we need to import the following libraries:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace EmployeeDirectory
{
    public class EmployeeDirectory
    {
    }
}
</code></pre>
<p>As you can see from the code above, we added three below System.Web. They are as follows:</p>
<ol>
<li>System.Data: allows us to work with stored procedures in ADO.NET</li>
<li>System.Configuration: allows us to reference a connection key from our configuration file</li>
<li>System.Data.SqlClient: allows us to connect to SQL Server</li>
</ol>
<h3>Creating Our Declarations</h3>
<p>Let's first add class-level variables so that we can get or set our data. Add the following code:</p>
<pre><code>
namespace EmployeeDirectory
{
    public class EmployeeDirectory
    {
        #region Declarations
        public string name { get; set; }
        public string lname { get; set; }
        public string fname { get; set; }
        public Guid guid { get; set; }
        public string email { get; set; }
        public string officeloc { get; set; }
        public string phonenum { get; set; }
        public string jobtitle { get; set; }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we added a region that holds our class-level variables. These variables match our columns from the database table.</p>
<h3>Creating Our Method</h3>
<p>We know that our method in this class needs to accept an argument, which is a string from our search box. We also know this search could bring back one or multiple matches. As a result, our method needs to create and store a generic list object and then return that to our code-behind file. Let's add the following code:</p>
<pre><code>
        #region Methods
        public List&lt;EmployeeDirectory&gt;GetEmployeesView(string lastname)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ed"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spEmployeeDirectoryViewDetail", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter parameterLName = new SqlParameter("@LName", SqlDbType.VarChar,50);
            parameterLName.Value = lastname;
            cmd.Parameters.Add(parameterLName);
            List&lt;EmployeeDirectory&gt; employees = new List&lt;EmployeeDirectory&gt;();
            try
            {
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    EmployeeDirectory ed = new EmployeeDirectory();
                    ed.name = rdr["Name"].ToString();
                    ed.guid = new Guid(rdr["Guid"].ToString());
                    employees.Add(ed);
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
            return employees;            
            
        }
            #endregion
</code></pre>
<p>As you can see from the code above we do the following:</p>
<ol>
<li>Create a generic list method named GetEmployeesView and pass in the value from our search text box.</li>
<li>Create a connection object and pass in our key from our configuration file.</li>
<li>Create a command object and pass in our stored procedure along with our connection object.</li>
<li>Set our command object to accept stored procedures.</li>
<li>Create a SQL parameter, pass in our parameter from our stored procedure and the parameter's data type.</li>
<li>Add our parameter to the command object.</li>
<li>Create a generic list object named employees.</li>
</ol>
<p>If we can't connect to our database or read through the results from our query, we wrap the following in a try/catch block, which handles exceptions:</p>
<ol>
<li>Call the open method of our connection object.</li>
<li>Create a data reader object, and set the command object's execute reader method to it.
<ul>
<li>Inside our while loop:
<ol>
<li>Create a new employee object.</li>
<li>Assign each of our class-level variables to the value coming from our data reader object.</li>
<li>Add each new object to our generic list object.</li>
</ol>
</li>
</ul>
</li>
<li>Catch the exception and throw an exception if needed.</li>
<li>Call the dispose method on our command object and the close method on our connection object.</li>
<li>Return our list object.</li>
</ol>
<p>In default.aspx.cs, add the following as shown below:</p>
<pre><code>
namespace EmployeeDirectory
{
    public partial class _Default : System.Web.UI.Page
    {
        #region Declarations
        EmployeeDirectory ed = new EmployeeDirectory();
        #endregion
}
}
</code></pre>
<p>As you can see from the code above, we create a new instance of the employee directory class.</p>
<p>Within the search method created earlier, add the following code as shown below:</p>
<pre><code>
namespace EmployeeDirectory
{
    public partial class _Default : System.Web.UI.Page
    {
        #region Declarations
        EmployeeDirectory ed = new EmployeeDirectory();
        #endregion
        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void btnSearch_Click(object s, EventArgs e)
        {
            List&lt;EmployeeDirectory&gt; employees = ed.GetEmployeesView(txtName.Text);
            TogglePHVisibility();
            rpEmployeeSearchView.DataSource = employees;
            rpEmployeeSearchView.DataBind();
        }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we create a generic list object named employees and set it to our object, ed. From our object, we call GetEmployeesView, passing in our search field. We call TogglePHVisibility, which shows our repeater control and hides the other placeholder control. When our list object gets filled with one or multiple objects, we set the data source of our repeater control to our list object and call the data bind method to associate the data to the control.</p>
<p>Let's write the TogglePHVisibility method as shown below:</p>
<pre><code>
namespace EmployeeDirectory
{
    public partial class _Default : System.Web.UI.Page
    {
        #region Declarations
        EmployeeDirectory ed = new EmployeeDirectory();
        #endregion
        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void btnSearch_Click(object s, EventArgs e)
        {
            List&lt;EmployeeDirectory&gt; employees = ed.GetEmployeesView(txtName.Text);
            TogglePHVisibility();
            rpEmployeeSearchView.DataSource = employees;
            rpEmployeeSearchView.DataBind();
        }
        protected void TogglePHVisibility()
        {
            phEmployeeSearch.Visible = true;
            phNoEmployeeFound.Visible = false;
        }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we toggle the placeholders appropriately. Save both files and restore SQL Server Management Studio.</p>
<h3>A Word About Stored Procedures</h3>
<p>Think of stored procedures in databases as blocks of SQL code that have been executed against the database. This is great for multiple reasons, including:</p>
<ol>
<li>Because the SQL code is executed against the database, it's already indexed on the database and knows the tables it needs, which means performance is enhanced.</li>
<li>Because we're calling the function in our application, we aren't executing a SQL query from our application, which is faster than embedding SQL.</li>
<li>If a change is needed to the query, you change it in the saved SQL file rather than in our business layer.</li>
</ol>
<p>We'll continue by creating the stored procedure for the employee directory <a href="default3.aspx">next</a>.</p>
</asp:Content>