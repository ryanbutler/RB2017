<%@ Page Title="Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_registration_and_confirmation_system_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Writing the Toggle Functionality</h3>
<p>Before you can see whether your form functions as intended, you need to write a simple toggle (show or hide) for your placeholders, reflecting whether your alumni are attending or not. Right after your submit event handler, let's write the following code:</p>
<pre><code>
protected void AttendingChoice()
{
string attending = rbAttending.SelectedValue.ToString();
      switch (attending)
      {
         case "Yes":
            phAttending.Visible = true;
            phWhyNotAttending.Visible = false;
            break;
            case "No":
            phWhyNotAttending.Visible = true;
            phAttending.Visible = false;
            break;
            default:
            phAttending.Visible = false;
            phWhyNotAttending.Visible = false;
            break;
            }
 }
</code></pre>
<p>As you can see from the code above, you store the value the visitor selects in a string variable named attending. Then you use a switch statement on the variable to implement the following: </p>
<ol>
<li>If yes is selected, show attending placeholder and hide not attending</li>
<li>If no is selected, show not attending and hide attending </li>
<li>If neither is selected, show the attending and hide not attending</li>
</ol>
<p>A switch statement is different from if/else in terms of how it's evaluated. With the former, as soon as the switch hits the pertinent line of code, it executes what is needed and then kicks out. With the latter, regardless of what line of code it hits, it always hits the else, even if it kicks out. As a result, switch statements often lead to more efficient and readable code in some situations.</p>
<p>In your page load event, add the following call to this method:</p>
<pre><code>
protected void Page_Load(object sender, EventArgs e)
        {
            AttendingChoice();
        }
</code></pre>
<p>As you can see from the code above, you simply call the method on page load. Save your file(s) and you can now preview the page and demo the functionality. Selecting either radio button should show or hide the appropriate placeholder.</p>
<h3>Creating and Writing Registration Class</h3>
<p>You could very easily write the insert functionality directly inside your code behind file. However, if you ever needed to provide additional features such as update or delete functionality, writing this in the code behind file wouldn't lend itself very well to reusability. An object-oriented approach would. So, we'll create a simple class that could be reused later if needed. Follow these steps to create the registration class:
</p>
<ol>
<li>From the solution explorer, right click and select Add : New Item.</li>
<li>In the add new item window, select class.</li>
<li>In the name text field, type "Registration" and then click Add.</li>
</ol>
<p>In order to work with a database, you need to import some namespaces in the class. At the top of the class, add the following code:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace Registration
{
    public class Registration
    {
    }
}
</code></pre>
<p>As you can see, you added three. The first allows you to work with stored procedures in ADO.NET, the second allows you to reference a connection key from your configuration file, and the last allows you to connect to SQL Server.</p>
<h3>Creating Your Declarations</h3>
<p>Let's first add class-level variables so that you can get or set your data. Add the following code as shown:</p>
<pre><code>
namespace Registration
{
    public class Registration
    {
        #region Declaration
        public string fname { get; set; }
        public string lname { get; set; }
        public string email { get; set; }
        public bool attending { get; set;}
        public string dinner { get; set; }
        public string mail { get; set; }
        public string whynotattend { get; set; }
        public string howmanyattend { get; set; }
        public double totalCost { get; set; }
        #endregion
}
}
</code></pre>
<p>As you can see from the code above, you added a region that holds your class-level variables. These variables match your columns from the database table.</p>
<h3>Creating Your Method</h3>
<p>Due to the way your system works, your method doesn't expect any parameters except what the stored procedure needs. Your method simply needs to insert the data, which is done by adding the following code:</p>
<pre><code>
#region Methods
        public void InsertRegistration()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("spRegistrationInsert", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter parameterFName = new SqlParameter("@FName", SqlDbType.VarChar, 50);
            SqlParameter parameterLName = new SqlParameter("@LName", SqlDbType.VarChar, 50);
            SqlParameter parameterEmail = new SqlParameter("@Email", SqlDbType.VarChar, 50);
            SqlParameter parameterAttending = new SqlParameter("@Attending", SqlDbType.Bit);
            SqlParameter parameterDinner = new SqlParameter("@Dinner", SqlDbType.VarChar,50);
            SqlParameter parameterMail = new SqlParameter("@MailAddress", SqlDbType.VarChar, 100);
            SqlParameter parameterWhyNotAttend = new SqlParameter("@WhyNotAttend", SqlDbType.VarChar, 100);
            SqlParameter parameterHowManyAttend = new SqlParameter("@HowManyAttending", SqlDbType.VarChar, 50);
            SqlParameter parameterTotalCost = new SqlParameter("@TotalCost", SqlDbType.Money);
            SqlParameter parameterDate = new SqlParameter("@Date", SqlDbType.DateTime);
            parameterFName.Value = fname;
            parameterLName.Value = lname;
            parameterEmail.Value = email;
            parameterAttending.Value = attending;
            parameterDinner.Value = dinner;
            parameterMail.Value = mail;
            parameterWhyNotAttend.Value = whynotattend;
            parameterHowManyAttend.Value = howmanyattend;
            parameterTotalCost.Value = totalCost;
            parameterDate.Value = DateTime.Now;
            cmd.Parameters.Add(parameterFName);
            cmd.Parameters.Add(parameterLName);
            cmd.Parameters.Add(parameterEmail);
            cmd.Parameters.Add(parameterAttending);
            cmd.Parameters.Add(parameterDinner);
            cmd.Parameters.Add(parameterMail);
            cmd.Parameters.Add(parameterWhyNotAttend);
            cmd.Parameters.Add(parameterHowManyAttend);
            cmd.Parameters.Add(parameterTotalCost);
            cmd.Parameters.Add(parameterDate);
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
               
        #endregion
</code></pre>
<p>In the code above, you do the following: </p>
<ol>
<li>Create a connection object and pass in your configuration key.</li>
<li>Create a command object and pass in your stored procedure and your connection object</li>
<li>Set your command object to accept a stored procedure.</li>
<li>Create SQL parameters to each of your database table columns, specify a parameter name and a database data type</li>
<li>Set each parameter's value to the appropriate variable.</li>
<li>Add each SQL parameter to the parameter's collection of your command object.</li>
</ol>
<p>If for any reason you can't connect to the database or execute your query, you wrap that inside a try/catch block and do the following:</p>
<ol>
<li>Call the open method of your connection object.</li>
<li>Call the execute non query method of your command object, which inserts the record.</li>
<li>Catch and throw an exception if necesarry.</li>
<li>If everything succeeds, call the dispose method of the command object, and the close method of your connection object.</li>
</ol>
<p>We'll continue by writing our registration object and writing our submit functionality <a href="default3.aspx">next</a>.</p>
</asp:Content>