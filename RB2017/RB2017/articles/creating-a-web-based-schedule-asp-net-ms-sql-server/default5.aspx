<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default5.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server.default5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create Class File</h3>
<p>We have two options for getting data bound to our grid view: (1) put all the database and business logic in our default.aspx.cs file, or (2) create a separate class file, put all the database and business logic in this file, and then bind to the list object it returns in our default.aspx.cs file. Our second option is the best, it creates a layer of abstraction to our application, and if it's ever needed, we could compile that class as a namespace and allow another developer to use it. As a result, we'll go with the second option. Follow these steps to create our class file:</p>
<ol>
<li>From the solution explorer, right click and select Add:New Item.</li>
<li>In the Add New Item window, from the left pane, select Code.</li>
<li>From the right pane, select Class</li>
<li>In the name text field, type ClassSchedule and left click Add.</li>
</ol>
<h3>Open ClassSchedule.cs</h3>
<p>Let's go ahead and get our data access layer working. From the solution explorer, double click ClassSchedule.cs and add the following namespaces at the top as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
</code></pre>
<p>As you can see from the code above, we added three below System.Web. They are as follows:</p>
<ol>
<li>System.Data: allows us to work with stored procedures in ADO.NET</li>
<li>System.Configuration: allows us to reference a connection key from our configuration file</li>
<li>System.Data.SqlClient: allows us to connect to SQL Server</li>
</ol>
<pre><code>
namespace ClassSchedule
{
    public class ClassSchedule
    {
        #region Declarations
        public string sectName{get;set;}
        public string synonym{get;set;}
        public int credhrs{get;set;}
        public string title{get;set;}
        public int totalSeats{get;set;}      
        public int remainSeats{get;set;}
        public string meetInfo{get;set;}
        public string room{get;set;}      
        public string days{get;set;}      
        public string startTime{get;set;}
        public string endTime{get;set;}
        public string instFullName{get;set;}
        public string location{get;set;}
        #endregion
}
}
</code></pre>
<p>As you can see from the code above, we added class level variables for each column we want to show in our grid view. Next, let's create a static method so that our code behind file can directly call that method. Add the following code as shown below:</p>
<pre><code>
namespace ClassSchedule
{
    public class ClassSchedule
    {
        #region Declarations
        public string sectName{get;set;}
        public string synonym{get;set;}
        public int credhrs{get;set;}
        public string title{get;set;}
        public int totalSeats{get;set;}      
        public int remainSeats{get;set;}
        public string meetInfo{get;set;}
        public string room{get;set;}      
        public string days{get;set;}      
        public string startTime{get;set;}
        public string endTime{get;set;}
        public string instFullName{get;set;}
        public string location{get;set;}
        #endregion
        #region Methods
        public static List&lt;ClassSchedule&gt; GetClassScheduleData()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["class_schedule"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spClassScheduleDisplay", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            List&lt;ClassSchedule&gt; schedule = new List&lt;ClassSchedule&gt;();
            try
            {
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ClassSchedule cs = new ClassSchedule();
                    cs.sectName = rdr["SectionName"].ToString();
                    cs.synonym = rdr["Synonym"].ToString();
                    cs.credhrs = Convert.ToInt32(rdr["CreditHrs"]);
                    cs.title = rdr["Title"].ToString();
                    cs.totalSeats = Convert.ToInt32(rdr["TotalSeats"]);
                    cs.remainSeats = Convert.ToInt32(rdr["RemainingSeats"]);
                    cs.meetInfo = rdr["MeetInformation"].ToString();
                    cs.room = rdr["Room"].ToString();
                    cs.days = rdr["Days"].ToString();
                    cs.startTime = rdr["StartTime"].ToString();
                    cs.endTime = rdr["EndTime"].ToString();
                    cs.instFullName = rdr["InstFullName"].ToString();
                    cs.location = rdr["Location"].ToString();
                    schedule.Add(cs);
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
            return schedule;
        }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we do the following:</p>
<ol>
<li>Create a static method named GetClassScheduleData.</li>
<li>Created a connection object, passing in our configuration key.</li>
<li>Created a command object, passing in our stored procedure and connection object.</li>
<li>Set our command object to accept a stored procedure.</li>
<li>Created a generic list object.</li>
</ol>
<p>If for any reason we can't connect to our database or read the contents of our reader object, we wrap those items in a try/catch block and do the following:</p>
<ol>
<li>Call the open method of our connection object.</li>
<li>Create a reader object, and set the command object's execute reader method to it
<ul>
<li>Inside our while loop, we:
<ol>
<li>Create a new instance of our class schedule object.</li>
<li>Assign each class level variable to an appropriate data reader value.</li>
<li>Add our new instance of our class schedule object to our list object each time through the loop.</li>
</ol>
</li>
<li>Catch and throw exception if needed</li>
<li>Lastly, call the dispose method of our command object, call the close method of our connection object and return our list object</li>
</ul>
</li>
</ol>
<p>Save your file.</p>
<p>We'll continue by working with our code-behind file for default.aspx <a href="default6.aspx">next</a>.</p>
</asp:Content>