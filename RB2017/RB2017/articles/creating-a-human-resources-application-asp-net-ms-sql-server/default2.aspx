<%@ Page Title="Creating a Human Resources Application with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_human_resources_application_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Human Resources Application with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Calling Add Job Method</h3>
<p>Since you have written the add job functionality, let's add the ability to call it. From the solution explorer, follow these steps:</p>
<ol>
<li>Right click the solution and select Add : New Item</li>
<li>In the Add New Item window, choose Web</li>
<li>In the right pane, choose Web Form with Master Page</li>
<li>In the name text field, type addjob.aspx and click Add</li>
</ol>
<h3>Adding markup to addjob.aspx</h3>
<p>When viewing addjob.aspx we need a basic form to capture the information and then submit the information to our database table. Let's add the following code:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;
&lt;head runat="server"&gt;
&lt;title&gt;Human Resources : Add Job&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "../style.css";
&lt;/style&gt;
&lt;script type="text/javascript" src="../clear.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;a href="default.aspx"&gt;Back to job listings&lt;/a&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;form id="formLayout" runat="server"&gt;
&lt;h3&gt;Add Job&lt;/h3&gt;
&lt;p&gt;Please use the fields below to add a job to our human resources system.&lt;/p&gt;
&lt;fieldset&gt;
&lt;legend&gt;Job Details&lt;/legend&gt;
&lt;div class="row"&gt;
&lt;label for="Job Title"&gt;Job Title:&lt;/label&gt;
&lt;asp:TextBox ID="jobtitleTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Posted Date"&gt;Posted Date:&lt;/label&gt;
&lt;asp:TextBox ID="posteddateTB" runat="server"/&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Required Qualifications"&gt;Required Qualifications:&lt;/label&gt;
&lt;asp:TextBox ID="reqQualTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Preferred Qualifications"&gt;Preferred Qualifications:&lt;/label&gt;
&lt;asp:TextBox ID="prefQualTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Responsibilities"&gt;Responsibilities:&lt;/label&gt;
&lt;asp:TextBox ID="responsibilitiesTB" runat="server" TextMode="MultiLine"/&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Start Date"&gt;Start Date:&lt;/label&gt;
&lt;asp:Calendar ID="calStartDate" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Salary"&gt;Salary:&lt;/label&gt;
&lt;asp:TextBox ID="salaryTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="ApplyInfo"&gt;Apply Information:&lt;/label&gt;
&lt;asp:TextBox ID="applyInfoTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Active"&gt;Active:&lt;/label&gt;
&lt;asp:CheckBox ID="chkActive" runat="server" /&gt;Yes (will show on home page)
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;div class="buttoncontainer"&gt;
&lt;asp:Button ID="btnAddJob" runat="server" OnClick="btnAddJob_Click" Text="Add Job" /&gt;
&lt;asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="clearFields();" /&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/fieldset&gt;
&lt;/form&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="successPH" runat="server" Visible="false"&gt;
&lt;p&gt;New Job Added&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>
<p>As you can see from the markup above, we have created the necessary ASP.NET web controls needed to capture (store) information from the user and then submit the information to our database table. Next, we need to wire up the OnClick method found on our add job button. Add the following code to addjob.aspx.cs:</p>
<pre>
<code>
namespace HumanResources.admin
{
    public partial class addjob : System.Web.UI.Page
    {
        #region Declarations
        HumanResources hr = new HumanResources();
        #endregion

        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            posteddateTB.Text = DateTime.Now.ToString();
        }
        protected void btnAddJob_Click(object sender, EventArgs e)
        {
            hr.postingDate = DateTime.Now;
            hr.jobTitle = jobtitleTB.Text;
            hr.requiredQual = reqQualTB.Text;
            hr.requiredQual = prefQualTB.Text;
            hr.responsibilities = responsibilitiesTB.Text;
            hr.startDate = calStartDate.SelectedDate;
            hr.salary = salaryTB.Text;
            hr.applyInfo = applyInfoTB.Text;
            hr.active = chkActive.Checked;
            hr.AddJob();
            formPH.Visible = false;
            successPH.Visible = true;
        }
        #endregion
    }
}
</code>
</pre>
<p>As you can see from the code above, we:</p>
<ol>
<li>Create a region named declarations and create an instance of your human resources object.</li>
<li>In the page load event, you set the posted date text field to .NET Date time function.</li>
<li>On your add job button click method, you set each of your object's properties to their appropriate form fields.</li>
<li>We call the add job method.</li>
<li>If successful, you hide your initial form and show your success message.</li>
</ol>
<h3>Run the project</h3>
<p>Save your project and press F5 to run the project. You'll have to append the URL as follows: http://localhost{portNumber}/addjob.aspx. As you can see, when the browser opens, it will open to local host and a port number. Simply append on the addjob.aspx and give the form a try and make sure everything works as intended. After you hit the add job button a few times, you should have the same number of records in your database table.</p>
<h3>Add markup to viewjob.aspx</h3>
<p>From inside the solution, double click viewjob.aspx and add the following markup:</p>
<pre>
<code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;
&lt;head runat="server"&gt;
&lt;title&gt;Human Resources &#8212; View Job&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="form1" runat="server"&gt;
&lt;asp:FormView ID="mainTbl" runat="server" Visible="true"&gt;
&lt;ItemTemplate&gt;
&lt;tr&gt;
&lt;td id="header" colspan="2"&gt;Fake Company&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td id="left"&gt;
&lt;ul id="navigation"&gt;
&lt;li&gt;&lt;a href="default.aspx"&gt;Job Listings&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;About Us&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;Contact&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="javascript:;"&gt;Maps&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/td&gt;
&lt;td id="content"&gt;
&lt;h2&gt;Viewing Job &#8212; &lt;%#Eval("JobTitle")%&gt;&lt;/h2&gt;
&lt;h4&gt;Posting Date&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("PostingDate","{0:D}")%&gt;&lt;/p&gt;
&lt;h4&gt;Start Date&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("StartDate", "{0:D}")%&gt;&lt;/p&gt;
&lt;h4&gt;Required Qualifications&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("RequiredQual") %&gt;&lt;/p&gt;
&lt;h4&gt;Preferred Qualifications&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("PreferredQual") %&gt;&lt;/p&gt;
&lt;h4&gt;Responsibilities&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("Responsibilities")%&gt;&lt;/p&gt;
&lt;h4&gt;Salary&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("Salary")%&gt;&lt;/p&gt;
&lt;h4&gt;Apply Information&lt;/h4&gt;
&lt;p&gt;&lt;%#Eval("ApplyInfo") %&gt;&lt;/p&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;/ItemTemplate&gt;
&lt;FooterTemplate&gt;
&lt;tr&gt;
&lt;td id="footer" colspan="2"&gt;Copyright (c). 2010&lt;/td&gt;
&lt;/tr&gt;
&lt;/FooterTemplate&gt;
&lt;/asp:FormView&gt;
&lt;asp:PlaceHolder ID="phFailure" runat="server" Visible="false"&gt;
&lt;p class="error"&gt;Sorry, no job exists&lt;/p&gt;
&lt;p class="center"&gt;&lt;a href="Default.aspx"&gt;Back to job listings&lt;/a&gt;&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</code>
</pre>
<p>As you can see from the code above, you have a form view.</p>
<h3>Adding view job functionality</h3>
<p>In order to view a specific job, we first need to add the ability to view a job based on a guid. Add the following to our HumanResources.cs:</p>
<pre>
<code>
public static List&lt;HumanResources&gt; ViewAllJobs()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["your_key"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spHumanResourcesViewAllJobs", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            List&lt;HumanResources&gt; jobs = new List&lt;HumanResources&gt;();
            try
            {
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    HumanResources hr = new HumanResources();
                    hr.jobTitle = rdr["JobTitle"].ToString();
                    Guid guid = new Guid(rdr["Guid"].ToString());
                    hr.guid = guid;
                    jobs.Add(hr);
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
            return jobs;
        }
</code>
</pre>
<p>As you can see from the code archive, you create:</p>
<ol>
<li>A static method</li>
<li>A connection object and pass in your configuration key</li>
<li>A command object and call your stored procedure</li>
<li>A list object casted as your human resources class</li>
</ol>
<p>If for any reason you can't connect to the database or you can't read records, you wrap the methods inside a try/catch to handle exceptions as follows:</p>
<ol>
<li>Call the open method of your connection object.</li>
<li>Create a data reader object and set the command object's execute reader method to it.</li>
<li>Inside your while loop, create a new instance of your human resources class and add it to your list object.</li>
<li>Call the dispose method of your connection object and the close method of your connection object.</li>
</ol>
<p> In our code-behind file for viewjob.aspx add the following code:</p>
<pre>
<code>
namespace HumanResources
{
    public partial class viewjob : System.Web.UI.Page
    {
        #region Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            //check for guid in query string
            try
            {
                Guid uniqueid = new Guid(Request.QueryString["guid"].ToString());
                List&lt;HumanResources&gt; viewjob = HumanResources.ViewJob(uniqueid);
                mainTbl.DataSource = viewjob;
                mainTbl.DataBind();
            }
            //if guid doesn't exist, toss up error messages
            catch 
            {
                mainTbl.Visible = false;
                phFailure.Visible = true;
            }
        }
        #endregion
    }
}
</code>
</pre>
<p>As you can see from the code archive within your page load event, you:</p>
<ol>
<li>Create a list object casted as your human resources class, and call the appropriate methods from your class file</li>
<li>Set the data source of your control to the appropriate list object and data bind</li>
</ol>
<p>Save your file and preview the results.</p>
<p>In this article you learned how to create a relatively simple job-listing HR system with ASP.NET. Furthermore, you learned the following:</p>
<ul>
<li>spHumanResourcesAddJob: Used for adding a job to your table</li>
<li>spHumanResourcesViewAllJob: Used for viewing all active jobs from the home page that's accessible to everyone</li>
<li>spHumanResourcesViewJob: Used for viewing a specific job in detail</li>
<li>spHumanResourcesViewInactiveJob: Used for viewing all inactive jobs</li>
<li>Active field: A Boolean field that determines whether you show the job as active</li>
</ul>
<h3>A Word About Stored Procedures</h3>
<p>A quick note about stored procedures: In databases, you can think of them as blocks of SQL code that have been executed against the database, in other words, cached. This is great for multiple reasons including:</p>
<ol>
<li>Because the SQL code is executed against the database, it's already indexed on the database and knows the tables it needs, which means performance is enhanced.</li>
<li>Because we're calling the function in your application, you aren't executing a SQL query from your application, which is faster than embedding SQL.</li>
<li>If you need to change the query, you change it in the saved SQL file rather than in the business layer.</li>
</ol>
<ol>
<li>What stored procedures are and why you use them</li>
</ol>
<p>Take the knowledge gained in this article and expand your HR system to meet any needs you may have. </p>
<p>If you have questions,<a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>