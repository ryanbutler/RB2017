<%@ Page Title="Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.articles.creating_a_registration_and_confirmation_system_asp_net_ms_sql_server.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Writing the Clear Fields Functionality</h3>
<p>You could write this functionality server-side but it's a hit you don't need to incur. You can do it client-side with JavaScript. Create your JavaScript file by following these steps:</p>
<ol>
<li>From the solution explorer, right click the project and select Add : New Item.</li>
<li>In the add new item window, select Jscript.</li>
<li>In the name text field, type "clear" and then click Add.</li>
</ol>
<p>In the JavaScript file, add the following code as shown below:</p>
<pre><code>
function clear_Fields() {
    document.getElementById("fnameTB").value = '';
    document.getElementById("lnameTB").value = '';
    document.getElementById("emailTB").value = '';
    var radList = document.getElementsByName('rbAttending');
    var radDinnerList = document.getElementsByName("rbDinnerOpt");
    if (radList[0].checked) {
        radList[0].checked = false;
        document.getElementById("mailTB").value = '';
        if (radDinnerList[0].checked) {
            radDinnerList[0].checked = false;
        }
        if (radDinnerList[1].checked) {
            radDinnerList[1].checked = false;
        }
        if (radDinnerList[2].checked) {
            radDinnerList[2].checked = false;
        }
    document.getElementById("howmanyAttendingTB").value='';
    } 
    if (radList[1].checked) {
        document.getElementById("whyNotTB").value = '';
        radList[1].checked = false;
    }
}
</code></pre>
<p>As you can see from the code above, you do the following:</p>
<ol>
<li>Create a function named "clear_Fields."</li>
<li>Set the value of your first, last, email, and how many are attending controls to an empty string by grabbing their unique IDs.</li>
</ol>
<p>You create two variables, which in JavaScript is done by using the keyword var, followed by the name of the variable. You then grab the element name of your radio button and checkbox controls and do the following:</p>
<ol>
<li>If the radio button for attending is yes:
<ul>
<li>Set the radio button for attending to false. </li>
<li>Set the mailing address text box to an emtpy string. </li>
<li>Set the dinner list checkboxes to false if any are checked.</li>
</ul>
</li>
<li>If the radio button for attending is no:
<ul>
<li>Set the radio button for attending to false.</li>
<li>Set the why not text to an empty string.</li>
</ul>
</li>
</ol>
<p>Before previewing the functionality, you need to create a reference to the JavaScript file. Open default.aspx and add the following code:</p>
<pre><code>
&lt;head&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
&lt;script type="text/javascript" src="clear.js"&gt;
&lt;/script&gt;
&lt;/head&gt;
</code></pre>
<p>As you can see from the code above, you create a reference to your file by using the script tag and setting the following attribute/value pairs:</p>
<ol>
<li>Setting type to text/javascript, which tells the browser this file contains JavaScript code</li>
<li>Setting src to clear.js, which tells the browser where to find the file</li>
</ol>
<p>Save your file and give it a test run to make sure clearing out the fields works as intended.</p>
<h3>Writing the Email Notification</h3>
<p>Even though you have a record of the visitor registrating for the event, you need a way to email them a confirmation. You'll do this from your code-behind file. Open default.aspx.cs and add the following name spaces:</p>
<pre><code>
sing System;u
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Text;
</code></pre>
<p>As you can see from the code above, you added two name spaces: the first is for working with mail objects and the second is for using the string builder class (you'll understand why in a little bit).</p>
<p>Expand the region that contains your declarations and add one new one as shown below:</p>
<pre><code>
#region Declarations
        Registration reg = new Registration();
        StringBuilder sb = new StringBuilder();
        double totalCost = 0;
#endregion
</code></pre>
<p>As you can see from the code above, you create a new instance of the string builder class. You'll use this to build the email message for your registrant. Right below your submit event handler, write a method that will build your email message, as shown below:</p>
<pre><code>
protected void BuildEmailMsg()
        {
            sb.AppendLine("First Name: " + reg.fname.ToString());
            sb.AppendLine("Last Name: " + reg.lname.ToString());
            sb.AppendLine("Email: " + reg.email.ToString());
            string dinner = rbDinnerOpt.SelectedValue.ToString();
            string attending = rbAttending.SelectedValue.ToString();
            switch (attending)
            {
                case "Yes":
                sb.AppendLine("Attending: " + "Yes");
                sb.AppendLine("Mailing address: " + "\r\n" + reg.mail.ToString());
                switch (dinner)
                {
                    case "20":
                        sb.AppendLine("Dinner option: 20$ Steak");
                        break;
                    case "30":
                        sb.AppendLine("Dinner option: 30$ Chicken");
                        break;
                    case "40":
                        sb.AppendLine("Dinner option: 40$ Seafood");
                        break;
                }
                sb.AppendLine("How many are attending? " + reg.howmanyattend.ToString());
                sb.AppendLine("Total Cost: " + String.Format("{0:c}",totalCost));
                break;
                case "No":
                sb.AppendLine("Attending: " + "No");
                sb.AppendLine("Why are you not attending? " + reg.whynotattend.ToString());
                break;
            }         
        }
</code></pre>
<p>In the code above, you do the following:</p>
<ol>
<li>Create a method named "BuildEmailMsg".</li>
<li>Use your string builder object sb and its append line method, and pass in:
<ul>
<li>A literal string, followed by the appropriate registration object property</li>
</ul>
</li>
<li>Create two string variables for capturing the attending and dinner choice your visitor selects.</li>
<li>Create a switch statement for attending:
<ul>
<li>If the visitor is attending dinner, append the appropriate information, including a nested switch statement, which determines which dinner choice they selected.</li>
<li>If the visitor is NOT attending dinner, append the appropriate information.</li>
</ul>
</li>
</ol>
<p>You are using a string builder object instead of concatenation because performance tests have shown that anytime you need to concatenate five or more lines, string builder is faster and more efficient than manual concatenation.</p>
<p>In your submit event handler in between your call to the registration object and toggling your placeholder's, you need to create a mail message object that will capture your email message and send it to the appropriate recipient as shown below:</p>
<pre><code>
reg.InsertRegistration();
MailMessage msg = new MailMessage();
msg.To.Add(reg.email.ToString());
MailAddress from = new MailAddress("webmaster@localhost.com", "Alumni Reunion");
msg.From = from;
msg.Subject = "Registration Confirmation";
msg.IsBodyHtml = false;
BuildEmailMsg();
msg.Body = sb.ToString();
phForm.Visible = false;
phSuccess.Visible = true;
</code></pre>
<p>As you can see from the code above, you do the following:</p>
<ol>
<li>You create an instance of the mail message object, msg.</li>
<li>You then add the recipient's email address to the object.</li>
<li>In order for your recipient to know who sent the email, you create an instance of the mail address object from and pass in the email address of the email sender, as well as the display name.</li>
<li>Set the from property of the msg object to the from object from your mail address class.</li>
<li>Set the subject and body HTML properties of your msg object to the appropriate values.</li>
<li>Call your build email msg method.</li>
<li>Set the body property of your msg object to the contents of your string builder object</li>
</ol>
<p>Before we're able to send the email, you need to create an instance of the SMTP class as shown below:</p>
<pre><code>
msg.Body = sb.ToString();
SmtpClient smtp = new SmtpClient();
smtp.Host = mail.your_server.net;
smtp.Send(msg); 
</code></pre>
<p>As you can see from the code above, you do the following:</p>
<ol>
<li>Create an instance of the SMTP client, named "smtp".</li>
<li>Set the host to localhost, which serves as your transport mechanism. You could also set this to a mail server, which you would do in a production environment.</li>
<li>Send the email by using the send method and passing in the msg object.</li>
</ol>
<h3>Summary</h3>
<p>In this article you learned how to create a registration event system, as well as a confirmation email message. Take the knowledge you gained in the article and use it to meet any requirement or need you may have. </p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>