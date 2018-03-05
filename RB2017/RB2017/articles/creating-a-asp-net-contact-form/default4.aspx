<%@ Page Title="Creating a ASP.NET Contact Form (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_contact_form.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET Contact Form (ASPX)</h2>
<h3>Creating required fields in ASP.NET</h3>
<p>Generally, in PHP and ASP, you create a separate JavaScript file that contains functions to check fields for empty values. Then, within your page, usually at the top, you would provide server-side validation to ensure those same fields do in fact contain a value. In essence, you have two files. In the ASP.NET environment, they made this process much easier and a bit more intuitive. When Microsoft created ASP.NET, they decided to package it with an additional set of controls that are effectively grouped together in a set of validation controls. Out of this group and arguably the easiest to use are required field validators, which do exactly what they are called: they require that certain fields are filled in before allowing the form to submit, more importantly however, they produce the JavaScript automatically for us. Let's go back to contact.aspx and modify our code as shown below:</p>
<pre><code>
&lt;table id="contact" cellspacing="0"&gt;
&lt;tr&gt;
&lt;td&gt;First Name:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="FNameTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvFName" runat="server" ControlToValidate="FNameTB" ErrorMessage="First Name is required" Display="Dynamic" /&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Last Name:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="LNameTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvLName" runat="server" ControlToValidate="LNameTB" ErrorMessage="Last Name is required" Display="Dynamic" /&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Email:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="EmailTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="EmailTB" ErrorMessage="Email is required" Display="Dynamic" /&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Comments:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="CommentsTB" runat="server" TextMode="MultiLine" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvComments" runat="server" ControlToValidate="CommentsTB" ErrorMessage="Comments are required" Display="Dynamic" /&gt;
&lt;/td&gt;
</code></pre>
<p>As you can see from the example above, we have used required field validators to validate each text box. The validation controls parts are:</p>
<ol>
<li>ID: Each control must have a unique ID which allows us to identify it if the need arises</li>
<li>Runat=server: Instructs this control to be run by the server</li>
<li>ControlToValidate: Instructs our validation controls which control (s) we want to validate, in our case, each corresponding text box control</li>
<li>ErrorMessage: Provides error messages to our visitors informing them of the errors present</li>
<li>Display=Dynamic: Is set to ensure the error messages would not be in source code until they are executed.</li>
</ol>
<p>After saving your file with the new controls, refresh your page in your browser, leave all fields empty and click the submit button, you should have four error messages as shown below:</p>
<p class="alignCenter"><img src="images/validation.jpg" width="305" height="152" alt="Validation"/></p>
<p>It should be noted the placement of these controls is essential. The error messages for the controls will show wherever the control is placed. Since we placed the validation controls right before the closing table cell for each web control, the error messages are shown right after the controls.</p>
<h3>Enabling server-side validation</h3>
<p>Even though we have established client-side validation, if JavaScript is disabled in a visitor's browser, the validation controls that produce JavaScript will fail. Fortunately, ASP.NET makes the server-side check quite easy to implement. Switch back to your code-behind file and modify the send mail event to the following as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        if (!IsValid)
        {
            return;
        }
        else
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(EmailTB.Text);
            mail.To.Add("myemail@domain.com");
            mail.Subject = "Contact Us";
            mail.IsBodyHtml = true;
            mail.Body = "First Name: " + FNameTB.Text + "<br />";
            mail.Body += "Last Name: " + LNameTB.Text + "<br />";
            mail.Body += "Email: " + EmailTB.Text + "<br />";
            mail.Body += "Comments: " + CommentsTB.Text + "<br />";
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "your_mail_server";
            smtp.Send(mail);
        }
    }

</code></pre>
<p>As you can see from the example above, we perform a conditional check within our send mail event. Inside the check, we perform a Boolean check on the IsValid property, which essentially checks the values of all our controls in our page. As a result, if any of the controls come back as false, meaning they're empty, we issue a return statement that stops the rest of the event from firing and provides our visitor with an error message as to what went wrong. If all controls that we require come back as true, meaning they're filled in, then the rest of our send mail event is allowed to execute, and subsequently, send our email message. Save your file, disable JavaScript and leave a few fields blank, and the error messages should show. At this point, we have a completed file that is ready and working.</p>
<h3>Sending a test email</h3>
<p>Presuming the SMTP client is configured correctly on the remote server, go ahead and fill in our fields, click submit, and you should get an email from our form delivered to your inbox in a few minutes.</p>
<h3>View State</h3>
<p>One more important concept should be mentioned before finishing the article. By default, the web is a stateless environment. In essence, when you visit a website and navigate between different pages, the website has no idea what page you last visited. Often times, when writing websites that have dynamic activity such as displaying categories, and their associated products, web programmers will use a query string so that a web page can remember where it came from, and then display the associated content.</p>
<p>In our case, when visitors submit form fields with validation enforced, if errors occur, the page post backs to the server and any existing information in the fields is lost. In PHP or ASP, the only way around this was to create a variable for each form field, and set it to the request value of the form field, and then evaluate the variable value out, which is a pain.</p>
<p>With ASP.NET, they have resolved this issue by a concept called view state. In essence, view state is enabled when you use a form tag, which if you remember from earlier in the article, form tags are created by default on all web forms. More importantly, view state is a hidden input tag with a special value used by the ASP.NET engine that keeps the values of our web controls stored in memory. This is important when you enforce validation on your web forms. Instead of creating additional variables, ASP.NET does the hard work for us. If you visit our file in the browser, fill in a couple fields, but leave the other two empty, press submit, you'll notice when the page posts back to the server, the existing information in the first two fields is still there, done automatically by ASP.NET!</p>
<p>However it should be noted that view state doesn't solve the problem of websites remembering the last page visited through a stateless environment, such as the query string method mentioned in our earlier category to products example. Also, it should be noted that additional web controls produce a larger view state, which can affect performance, something to keep in mind as you continue your work with web controls.</p>
<h3>Summary</h3>
<p>From the knowledge gained in this article, one should be able to take this simple web form, identify the information needed, be able to validate form fields, as well as send information collected to a specified email address. As a result, this web form could be modified to meet the needs of any web application for a business, company or organization to meet the needs of their customers, keep needless email from spamming our system, in a more intuitive, reliable and secure method.</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>