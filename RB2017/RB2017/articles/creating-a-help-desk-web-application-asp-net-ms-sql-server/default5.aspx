﻿<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default5.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Creating Our Method</h3>
<p>From our default.aspx.cs file, it would be nice if we could create a generic container that 
could call a method in our class file, which in turn would call a stored procedure, return the data and 
then bind to our dropdown list. We can do this by creating a static method in our severity class that 
uses a List collection, which supports methods for dealing with collections of data -- exactly what we have. 
Let's add this code:</p>
<pre><code>
namespace HelpDesk
{
    public class Status
    {
        #region Declarations
        public int StatusId { get; set; }
        public string Statuses { get; set; }
        #endregion
        #region Methods
        public static List&lt;Status&gt; GetStatuses()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["hd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spHelpDeskGetStatuses", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            List&lt;Status&gt; list = new List&lt;Status&gt;();
            try
            {
                Status s = new Status();
                s.StatusId = 0;
                s.Statuses = "--select one--";
                list.Add(s);
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Status statuses = new Status();
                    statuses.StatusId = Convert.ToInt32(rdr["StatusId"]);
                    statuses.Statuses = rdr["Status"].ToString();
                    list.Add(statuses);
                }
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
            return list;
        }
        #endregion
    }
</code></pre>
<p>As you can see from the code above, we did the following:</p>
<ol>
<li>Created a public static method, which is referencing ICollection, with a generic type of our severity class, followed by our method name</li>
<li>Created a connection object and passed in our configuration key from our web.config</li>
<li>Created a command object and passed in the stored procedure we created earlier and a connection object</li>
<li>Set our command object to accept a stored procedure</li>
<li>Created a generic list object with a type of our severity class</li>
</ol>
<p>Before moving forward, let's briefly discuss generics. A generic list object simply holds the contents of data that isn't type specific. Generics are great for dealing with collections of data. Instead of having to worry about casting to a specific type, such as an array list or others, you can make life much easier by leaving the data structure generic to a list object.</p>
<p>Moving forward, if for any reason we can't open a connection to the database or read through our data reader, we wrap it inside a try/catch block that handles exceptions. Inside our try block, we do the following:</p>
<ol>
<li>Create a new instance of our status class and set its property, StatusId and Statuses to a constant value, before adding 
it to our list object.</li>
<li>If our connection is successful, we execute the result set to our reader object, and while inside the loop we do the following:
<ul>
<li>Create a new istance of the status object.</li>
<li>Set each of its properties to the values from our database.</li>
</ul>
</li>
<li>When we finish with the loop, we dispose of our command object and close out connection.</li>
<li>Return our list object with its data.</li>
</ol>
<p>If you haven't saved your file(s), now would be a good time to do so.</p>
<h3>Creating the Load Combo Boxes Method</h3>
<p>Even though we have created the class and stored procedure to retrieve our data, we haven't "hooked up" the data to any control. 
Let's use our status class as our example. From the Solution Explorer, 
left click the plus sign (+) next to default.aspx and then double click default.aspx.cs and insert the code as shown below:</p>
<pre><code>
protected void LoadCombos()
{
   List&lt;Status&gt; statuses = Status.GetStatuses();
   ddlStatus.DataTextField = "Statuses";
   ddlStatus.DataValueField = "StatusId";
   ddlStatus.DataSource = statuses;
   ddlStatus.DataBind();
}
</code></pre>
<p>As you can see from the code above, we created a method named LoadCombos and then did the following:</p>
<ol>
<li>Created a generic reference to List and typed it as our status class</li>
<li>Called our GetStatuses method from the status class</li>
<li>Set the DataTextField of our dropdown list to our class property, statuses</li>
<li>Set the DataValueField of our dropdown list to our class property, StatusId</li>
<li>Set the DataSource of our dropdown list to our statuses list object</li>
<li>Called the DataBind method of our dropdown list</li>
</ol>
<p>In the page load event, let's add the following:</p>
<pre><code>
protected void Page_Load(object sender, EventArgs e)
{
if 
    (!IsPostBack)
      {
         LoadCombos();
      }
}
</code></pre>
<p>As you can see from the code above, if the data in the list hasn't changed, we don't need to "post back" to refresh the changes to the data. As a result, we wrap our LoadCombos method in this check to minize server hits.</p>
<h3>Creating the Other Classes</h3>
<p>We need to repeat the headings "create the stored procedure through creating the load combo boxes method" for the rest of our dropdown list(s):</p>
<ol>
<li>Departments</li>
<li>Severity</li>
</ol>
<p>The best approach would be to create each stored procedure, then the class, and then repeat the code in LoadCombos, replacing reference names as appropriate.</p>
<p>We'll continue by creating our help desk class <a href="default6.aspx">next</a>.</p>
</asp:Content>