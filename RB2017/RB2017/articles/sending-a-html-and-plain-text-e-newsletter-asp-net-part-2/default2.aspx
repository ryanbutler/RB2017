<%@ Page Title="Sending an HTML and Plain Text E-newsletter with ASP.NET (ASPX), Part 2" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.sending_a_html_and_plain_text_e_newsletter_asp_net_part_2.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Sending an HTML and Plain Text E-newsletter with ASP.NET (ASPX), Part 2</h2>
<h3>Writing the connection object</h3>
<p>Since you need to send the emails from a query, you first need to add the code to connect to your database. Start by adding that code right below where your SMTP object sets your host as shown below:</p>
<pre><code>
smtp.Host = "mail.yourdomain.net";
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
</code></pre>
<p>As you can from the code above, you are implementing a using block in c-sharp. Often times when accessing active data objects in c-sharp you'll see developers implementing this syntax. The reason is simple: by implementing using blocks when dealing with connection, command or data reader objects, the compiler will automatically do garbage cleanup on these objects when your applications and specifically your program are done with the code. This means you no longer have to manually call the close method of the connection object or dispose of the command object. There are some instances where you would still want to explicility call those methods in a database-intensive page, but for the purposes of this article, this implementation will work fine.</p>
<p>Continuing with the code shown above, create a connection object (conn) inside your using block by specifying your SQL connection class, and then using the new keyword, pass in your configuration file arguments. In order to access your configuration file, you use the configuration manager class, call the connection strings class, pass in the name of your key (in this case, mwdConnectionString), and then call the connection string method, followed by two closing parenthesis, and then an opening and closing bracket.</p>
<h3>Open the Connection Object, Write the Command Object and SQL Select Statement</h3>
<p>Now you have what you need to connect to the database server, as well as your database. You need to open the connection, create a command object, and write your SQL select statement to select the email addresses that have null for a date/time. You do this by adding the following code inside your using block for connection:</p>
<pre><code>
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
       conn.Open();
       using (SqlCommand cmd = new SqlCommand("SELECT ID, Email, DateTime FROM EmailRecipients WHERE DateTime IS NULL", conn))
       {
      
               
       }
   }
</code></pre>
<p>As you can see, inside your using block for your connection object, you first open your connection by using the open method. Next, you start another using block and create your command object by using the SQL command class, and then using the new keyword, followed by two parameters. The first parameter is your SQL statement, which selects all columns from your table where the date/time is null. Your mass email script works by grabbing all email addresses where the date/time is null, meaning they haven't received the latest newsletter. If this column has a date/time value, then you won't send the same email to the same recipient. The second parameter simply passes in your connection object.</p>
<h3>Writing the Data Reader Object and Executing Against the Command Object</h3>
<p>Now that you have a result set from your query that's stored in your command object, you need to be able to read it. Active Data Objects (ADO) for .NET provides a data reader object, which does what the object name implies, reads data. When you have created a data reader object, you need to call the execute reader method of your command object, so that your data reader can then read through the data. Let's add the code to do this as shown below:</p>
<pre><code>
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
       conn.Open();
       using (SqlCommand cmd = new SqlCommand("SELECT ID, Email, DateTime FROM EmailRecipients WHERE DateTime IS NULL", conn))
       {
      
            using(SqlDataReader rdr=cmd.ExecuteReader()){
   
            }
       }
   }
</code></pre>
<p>In the code above, you nested another using block for your data reader object inside your command object, and then you created a data reader object by using the SQL data reader class and setting the object to the execute reader method of the command object.</p>
<p>Now that you can read the data, you need a way to loop through it because you could have multiple emails to send. Fortunately, the data reader object provides a built-in read method that does this for you. Let's add the code as shown below:</p>
<pre><code>
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
       conn.Open();
       using (SqlCommand cmd = new SqlCommand("SELECT Email, DateTime FROM EmailRecipients WHERE DateTime IS NULL", conn))
       {
      
            using(SqlDataReader rdr=cmd.ExecuteReader()){
                while (rdr.Read())
                {
                }
            }
       }
   }
</code></pre>
<p>As you can see, you nest a while loop inside your data reader using block. Inside the while loop, you pass in your data reader object, call its read method, and then create an opening and closing bracket.</p>
<h3>Changing the Mail Message Object</h3>
<p>Before moving on with the code above, let's first modify your mail message object from before. Near the top of the event for your button click, look for this line:</p>
<pre><code>
MailMessage mailMsg = new MailMessage("webmaster@domain.com",txtTo.Text);
</code></pre>
<p>You need to take out the two parameters in this constructor, so that the mail message constructor looks like this:</p>
<pre><code>
MailMessage mailMsg = new MailMessage();
</code></pre>
<p>Then, you need to create a from message indicating who sent this email. To do this, you create a mail address object as shown below:</p>
<pre><code>
MailAddress mailAddress = new MailAddress("webmaster@domain.com");
</code></pre>
<p>In the code above, you simply create a mail address object from the mail address class and pass in your generic from email address.</p>
<p>If you haven't saved your file, do so now.</p>
<h3>Adding Mail Message Properties and Methods</h3>
<p>Let's go back to your while loop, and set up the mail message object to handle multiple email recipients as shown below:</p>
<pre><code>
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
       conn.Open();
       using (SqlCommand cmd = new SqlCommand("SELECT Email, DateTime FROM EmailRecipients WHERE DateTime IS NULL", conn))
       {
      
            using(SqlDataReader rdr=cmd.ExecuteReader()){
                while (rdr.Read())
                {
                    mailMsg.From = mailAddress;
                    mailMsg.To.Clear();
                    mailMsg.To.Add(rdr["Email"].ToString());
                    smtp.Send(mailMsg);
                }
            }
       }
   }
</code>
</pre>
<p>As you can see, you set the from property of your mail object to your mail adddress object. This way, if your email from address changes, you change it in one place. Next, you call the clear method of your mail message object. This may seem odd but when you select your result set from your table, you will have all email recipients where the date/time is null. This could be 1, 10, 50, and so on. However, you can send the mail to each individual only one at a time. The clear method will clear your result set and leave only the first item, which then allows you to send the email to one recipient. You then go through the loop again and grab the next record that has a null for date/time.</p>
<p>Next, you send the email to a specific individual by using the add method of your mail object and passing in your reader object, followed by the name of your table column (in this case, email). Then you call the to string method to ensure that you return a string for email. Finally, you call the send method of your SMTP object and pass in your mail message object to send the mail to the recipient.</p>
<h3>Writing the Update Procedure</h3>
<p>Now, you need a way to ensure the same email is not sent to an individual twice. You do this by creating a second connection and command object. This way, when the email is sent to the individual, you issue another query to the same table and update the date/time column of the record you just sent with the current date. This way, it is not null and won't be sent to the specified recipient again.</p>
<p>Add this code right after your while loop, as shown below:</p>
<pre><code>
using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
   {
       conn.Open();
       using (SqlCommand cmd = new SqlCommand("SELECT ID, Email, DateTime FROM EmailRecipients WHERE DateTime IS NULL", conn))
       {
      
            using(SqlDataReader rdr=cmd.ExecuteReader()){
                while (rdr.Read())
                {
                    mailMsg.From = mailAddress;
                    mailMsg.To.Clear();
                    mailMsg.To.Add(rdr["Email"].ToString());
                    smtp.Send(mailMsg);
 using (SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["mwdConnectionString"].ConnectionString))
                {
                    conn2.Open();
                    using (SqlCommand cmd2 = new SqlCommand("UPDATE EmailRecipients SET DateTime=@DateTime WHERE ID=@ID", conn2))
                    {
                        cmd2.Parameters.AddWithValue("@ID",rdr["ID"]);
                        cmd2.Parameters.AddWithValue("@DateTime", DateTime.Now);
                        cmd2.ExecuteNonQuery();
                    }
}
 }
          }
       }
   }

</code></pre>
<p>As you can see, you create another connection object. Next, you created yet another command object, this time using an update statement. Because you have sent the email to the first recipient, you need to know which ID in order to update the correct record with the current date/time. You do this by appending your update statement with a where clause that uses the ID of the last email sent. After that, you add both the ID and date/time to the parameters of your command object. You set the date/time column of this record to the current date/time from the server by using the now method of the date/time class provided by .NET. Because you don't need to see the result, you call the execute non query method of your second command object.</p>
<p>Save your changes.</p>
<h3>How It Works in Summation</h3>
<p>So, how does this mass email script works? Your database table contains records of your recipients' email addresses. You set your date/time column to a null value. When you request the page, and press the submit button, your first block of code executes a SQL select statement returning all records where the date/time column is null, meaning the email newsletter has not been sent. You loop through the result set, set mail object properties, and then send the email. Next, when each email has been sent, you execute a SQL update statement that will update the date/time column of the last sent email to avoid sending duplicate emails.</p>
<h3>Performance</h3>
<p>You may ask, what kind of performance hit does this place on the database server or mail server? It's true that you're hitting the database table for each record, but that shouldn't carry a huge performance hit. If the amount of data does become an issue, the best option would be a data set. The larger concern is whether your mail server can handle the volume of emails being sent. If you're on a shared hosting environment, the system administrators probably won't let you do this. If you're on a dedicated server or deploying this solution for a company that manages its own servers, then it'll just take time to send the emails.</p>
<h3>Summary</h3>
<ol>
<li>Create a database and a database table.</li>
<li>Add columns and records to the table.</li>
<li>Alter the c-sharp code to do the following:
<ul>
<li>Connect to a database server.</li>
<li>Use SQL connection, command, and data reader objects to connect, query, and read through the data from your database table.</li>
<li>Use the mail message object to send the email to each recipient.</li>
</ul>
</li>
<li>When the email was sent, use another code block to connect to the database table, and then issue an update statement.</li>
</ol>
<p>From the knowledge gained in this article and <a href="../sending-a-html-and-plain-text-e-newsletter-asp-net/default.aspx">previous one</a> you should be able to create any newsletter for your visitors and subsequently send the newsletter to multiple recipients at once.</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>