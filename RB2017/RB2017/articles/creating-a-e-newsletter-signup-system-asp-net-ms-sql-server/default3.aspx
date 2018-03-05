<%@ Page Title="Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_e_newsletter_signup_system_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Writing the Connection Object</h3>
<p>Since you need to send the emails from a query, you first need to add the code to connect to your database. Start by adding that code right below where your SMTP object sets your host as shown below:</p>
<pre><code>
smtp.Host = "mail.yourdomain.net";
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
   }
</code></pre>
<h3>Write the Subscribe Code</h3>
<p>When your visitor fills in appropriate information and clicks subscribe, you need to capture the corresponding information. You could add this code directly to the code behind file, but because you need to add update functionality later, creating a class to handle this would be better. It leads to more modularity in code and lends itself to object-oriented programming.</p>
<p>Create a separate class that will handle this functionality. Right click on your project, and select "add new item" and then class. Type "Newsletter.cs" and click add. Double click the file to open it and add the following at the top of the class file:</p>
<pre><code>
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
</code></pre>
<p>In the code above, you import the necessary namespaces (libraries) to work with active database objects (ADO), which is essentially database access and your web configuration file. In your class definition, add the following code:</p>
<pre><code>
public class Newsletter
{
        #region Declarations
        public string FName{get;set;}
        public string LName { get; set; }
        public string Email { get; set; }
        public bool Subscribe { get; set; }
        public string ErrorMsg { get; set; }
        #endregion       
}
</code></pre>
<p>First, you create a region, so that you can cleary indicate in your code that you're declaring class-level variables. You set the variable to public so that your code behind file will see them, and give them an appropriate data type. Another way of doing class-level variables is setting them to private and then accessing them through public properties. Each way has its positives and negatives.</p>
<p>Next, add the method for inserting the record into the database right below your end region:</p>
<pre><code>
public class Newsletter
    {
        #region Declarations
        public string FName{get;set;}
        public string LName { get; set; }
        public string Email { get; set; }
        public bool Subscribe { get; set; }
        public string ErrorMsg { get; set; }
        #endregion
        #region Methods
        public void InsertSubscription()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("INSERT INTO EmailRecipients(FName,LName,Email,Subscribe)VALUES(@FName,@LName,@Email,@Subscribe)", conn);
            SqlParameter parameterFName = new SqlParameter("@FName", SqlDbType.VarChar, 50);
            parameterFName.Value = FName;
            cmd.Parameters.Add(parameterFName);
            SqlParameter parameterLName = new SqlParameter("@LName", SqlDbType.VarChar, 50);
            parameterLName.Value = LName;
            cmd.Parameters.Add(parameterLName);
            SqlParameter parameterEmail = new SqlParameter("@Email", SqlDbType.VarChar, 50);
            parameterEmail.Value = Email;
            cmd.Parameters.Add(parameterEmail);
            SqlParameter parameterSubscribe = new SqlParameter("@Subscribe", SqlDbType.Bit);
            parameterSubscribe.Value = Subscribe;
            cmd.Parameters.Add(parameterSubscribe);
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
<p>In the code above, you do the following: create a connection object and set it to your connection key name that comes from your configuration file. Next, you create a command object, which accepts two parameters: your SQL insert statement and your connection object. You may wonder why on the second part of the insert statement you used the at symbol (@). In ASP.NET, the at @ symbol is a parameter and it helps prevent SQL injection attacks.</p>
<p>After your insert statement, you create parameter variables that tell you what each of your column's data types are. This way, if someone tries to enter an unknown data type in your fields, your application will throw an exception (you'll see how to display this error later in the article). Obviously, your validation should handle this, but this approach provides even more protection for your applications and data, ensuring you get what you expect.</p>
<p>After you add each parameter variable to your command object's parameters collection, you use a try/catch block, open your connection to the database, and call the ExecuteNonQuery method of your command object. You use this method because you don't need to see the results; you're saying just perform the operation. If you can't open the connection or execute the query, you catch the exception. You then dispose (discard) your command object and close your connection object by using its close method in your finally code block. Make sure you save your file before continuing.</p>
<p>In your ASPX code behind, create an instance of the newsletter class as shown below:</p>
<pre><code>
public partial class signup : System.Web.UI.Page
    {
        Newsletter nl = new Newsletter();
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
</code></pre>
<p>In this code above, you simply create an instance (object) of the newsletter class and name it nl.</p>
<p>In your event handler, add the following code:</p>
<pre><code>
public partial class signup : System.Web.UI.Page
    {
        Newsletter nl = new Newsletter();
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void subscribe_Click(object sender, EventArgs e)
        {
            nl.FName = fNameTB.Text;
            nl.LName = lNameTB.Text;
            nl.Email = emailTB.Text;
            nl.Subscribe = subscribeChkBox.Checked;
            nl.InsertSubscription();
successPH.Visible = true;
            formPH.Visible = false;        
}
    }
</code></pre>
<p>In the code above, you simply set the properties of your newsletter object to your user form controls, and then you call your insert method. If it's successful, toggle the visibility of your Placeholder controls. Before moving forward, save your file.</p>
<h3>Hooking Up the Validation</h3>
<p>Currently, if JavaScript is disabled and you preview your form and click subscribe with the form fields empty, the form will submit and you'll get a blank record. In order to get validation working on the server side, simply adjust the code behind event handler you worked on above to this:</p>
<pre><code>
protected void subscribe_Click(object sender, EventArgs e)
{
if (!IsValid)
      {
         return;
}
      else{
         nl.FName = fNameTB.Text;
            nl.LName = lNameTB.Text;
            nl.Email = emailTB.Text;
            nl.Subscribe = subscribeChkBox.Checked;
            nl.InsertSubscription();
successPH.Visible = true;
            formPH.Visible = false;
          }
}
</code></pre>
<p>In the adjusted code behind event handler, you added an "is valid" check and negated the statement. So, the translation is: "If the page isn't valid, stop execution of code and display your error messages. Otherwise, record the information in the database table."</p>
<p>Save your page and try again. This time, click subscribe while leaving fields empty and make sure the error messages show. Then fill them in individually, and when those are complete, click subscribe and then the information should be recorded.</p>
<p>In summation, ASP.NET's built-in validations controls provide you with instant client-side validation, while your "is valid" check provides your server-side validation ensuring all your controls are valid before allowing the form to submit if JavaScript is disabled.</p>
<h3>Handling and Displaying the Exception</h3>
<p>Right now, if an exception occurs, your page will show an ugly error message. A user does not need to see this scary warning. What they need is a generic page informing them something went wrong. Fortunately, ASP.NET has a clever way of handling this: custom errors. In your web configuration file, look for &lt;customErrors&gt;. Simply change the default markup with the following:</p>
<pre><code>
&lt;customErrors mode="RemoteOnly" defaultRedirect="GenericErrorPage.htm"/&gt;
</code></pre>
<p>Make sure you create a HTML page within your solution. The nice part about this implementation is when users throw an exception remotely, they see this generic error page, which you can customize to fit your needs. Meanwhile, you as the developer can step through the exception and fix the problem locally.</p>
<h3>Writing the Unsubscribe Code</h3>
<p>In your e-mail that gets sent to your subscribers, you need to provide a mechanism to allow your subcribers to unsubcribe from periodic e-mails. The easiest implementation is to provide a link at the bottom of your e-mail that, when clicked, sends your subcribers to an unsubcribe page. From this page, you'll let them enter their e-mail address and, if you find it, you'll change the column in your database table to false. The ASPX page for unsubcribing is already completed, so you'll just work with the code behind and your class file.</p>
<h3>Work with Your Class File</h3>
<p>Right above your end region for methods, add a method for updating subscribers. Add the following code:</p>
<pre><code>
public void UpdateSubcribers()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwd"].ConnectionString);
            SqlCommand cmd = new SqlCommand("UPDATE EmailRecipients SET Subscribe=@Subscribe WHERE Email=@Email)", conn);
            SqlParameter parameterEmail = new SqlParameter("@Email", SqlDbType.VarChar, 50);
            parameterEmail.Value = Email;
            cmd.Parameters.Add(parameterEmail);
            SqlParameter parameterSubscribe = new SqlParameter("@Subscribe", SqlDbType.Bit);
            parameterSubscribe.Value = Subscribe;
            cmd.Parameters.Add(parameterSubscribe);
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
<p>In this code, you added a new query. You set the subscribe column to false (you'll see that shortly) where the e-mail matches that entered by the visitor. Save your class file. In your code behind file, add the following code:</p>
<pre><code>
protected void unsubscribe_Click(object sender, EventArgs e)
{
    if (!IsValid)
    {
       return;
    }
    else
    {
       nl.Email = emailTB.Text;
       nl.Subscribe = false;
       nl.UpdateSubcribers();
    successPH.Visible = true;
       formPH.Visible = false;
    }
}
</code></pre>
<p>In this code, you set the subscribe field to false and then call the appropriate method. Save your files and preview the results.</p>
<h3>Customizing sendemails.aspx</h3>
<p>For the purposes of this article, you will walk through the changes you need to make in the mail script from my second <a href="../sending-a-html-and-plain-text-e-newsletter-asp-net-part-2/default.aspx">Sending an HTML and Plain Text E-newsletter with ASP.NET, Part 2</a>. Open the code behind file and observe line 47:</p>
<pre><code>
&lt;h1&gt;Dear {Name}&lt;/&lt;h1&gt;
</code></pre>
<p>You added an introduction to your e-mail. The squiggly brackets ({}) serve as an anchor in string replacement, so that individual e-mails sent have the person's name included. You'll see how string replacement works shortly.</p>
<p>At line 61, hit the enter key once and at line 62, insert this code snippet:</p>
<pre><code>
&lt;p style='font-family:Arial, Helvetica, sans-serif;font-size:.8em;color:#000; line-height:1.5em;'>If you would like to unsubscribe from furture e-mails, please &lt;a href='unsubscribe.aspx'>click here&lt;/&lt;a&gt;&lt;/&lt;p&gt;.
</code></pre>
<p>At line 123, hit the enter key twice and at line 125, insert this code snippet:</p>
<pre><code>
**If you would like to unsubscribe from furture e-mails, please &lt;a href='unsubscribe.aspx'&gt;click here&lt;/a&gt;.**
</code></pre>
<p>In line 130:</p>
<pre><code>
using (SqlCommand cmd = new SqlCommand("SELECT ID, FName, LName, Email, DateTime FROM EmailReceipients WHERE DateTime IS NULL AND Subscribe=1", conn))
</code></pre>
<p>You adjusted the query to check for a subscription in SQL, checking a boolean field is done by 0 or 1.</p>
<p>In lines 134-136:</p>
<pre><code>
while (rdr.Read())
{
string name = rdr["FName"].ToString() + " " + rdr["LName"].ToString();
</code></pre>
<p>In your first while loop, you create a string variable and set it equal to the concatented result of your data reader object that contains the first and last name from your database table.</p>
<p>In lines 137-138:</p>
<pre><code>
bodyHTML = bodyHTML.Replace("{Name}", name.ToString());
bodyPlain = bodyPlain.Replace("{Name}", name.ToString());
</code></pre>
<p>You simply take the existing variables that hold your HTML or plain text content, and then use the replace function. This function takes two parameters:</p>
<ol>
<li>The old value you're looking for (in your case {Name})</li>
<li>The replaced value (in your case, your name variable)</li>
</ol>
<p>Save your file and run the example. In a few minutes, you should receive e-mails with a personal introduction.</p>
<h3>Summary</h3>
<p>In this article you learned how to create a form allowing users to fill out basic information and choose whether they want to receive periodic e-mails or not. Along the way, you learned the following:</p>
<ol>
<li>Modifying an existing database table</li>
<li>Working with bit fields in SQL</li>
<li>Validation between the client and server sides</li>
<li>Creating validation controls</li>
<li>Creating a class file:
<ul>
<li>Creating variables and methods</li>
<li>How to prevent SQL injection and working with parameters</li>
</ul>
</li>
<li>Create an object of that class in your code behind file</li>
<li>How to personalize the e-mail</li>
<li>How to handle and display friendly error messages</li>
<li>Providing unsubscribe functionality</li>
</ol>
<p>Take the knowledge you gained in this article and give your subscribers the flexibility they need.</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>