<%@ Page Title="Creating a ASP.NET Contact Form (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_contact_form.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET Contact Form (ASPX)</h2>
<h3>Setting the email recipient of our mail object</h3>
<p>For our clients to reach us, we need to send the email result to a specified recipient. We do this by adding the following code as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(EmailTB.Text);
        mail.To.Add("myemail@domain.com");
    }
</code></pre>
<p>As you can see from the example above, we first set the property, to, of our mail object that specifies a collection, that is, a collection of email address(s) that this message could be sent to. For example, you could send this email to other recipients. Then we use the add method to add the specified email address to our mail object's collection and pass in a literal string of an appropriate email address.</p>
<h3>Setting the subject line of our mail object</h3>
<p>In most cases, we'll want to have a pre-defined subject line so that when our clients do email us, we'll be easily able to identify what the message is about. To do this, we modify our code as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(EmailTB.Text);
        mail.To.Add("myemail@domain.com");
        mail.Subject = "Contact Us";
    }
</code></pre>
<p>As you can see from the example above, we set the subject property of our mail object to a literal string of our choice.</p>
<h3>Setting the content type of our mail object</h3>
<p>When sending an email message from a contact form, you have the option of specifying whether it will be plain text or HTML. Some people choose not to accept HTML encoded emails because they can contain malicious code that can be used to capture sensitive information or spread viruses and/or worms on a person's computer. However, since we're sending this email to ourselves, we know the content will be legitimate; therefore, we'll go ahead and specify that this email can contain HTML by modifying the code as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(EmailTB.Text);
        mail.To.Add("myemail@domain.com");
        mail.Subject = "Contact Us";
        mail.IsBodyHtml = true;
    }
</code></pre>
<p>As you can see from the example above, we set the IsBodyHTML property of our mail object to true, which will allow any HTML enabled email client to parse and read the HTML.</p>
<h3>Collecting the forms contents through our mail object</h3>
<p>For us to collect the information that our visitors entered in our form, we need to set our mail object's body property to a literal string that will ultimately contain a concatenated string from our form in a nicely formatted message that's readable through an email client. Concatenation is a fancy word for saying "append to an existing string". Let's add this functionality by adding the code shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
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
    }

</code></pre>
<p>As you can see from the example above, we first set the body property of our mail object to a literal string that contains "First Name:", then we concatenate by using the plus (+) sign the value entered by our visitor via our text box control by using its text property, and then to create separation for the next line in our string, we append an ordinary HTML break tag. We continue the body of the mail message by concatenating to the existing string our additional form fields, followed by their appropriate controls.</p>
<h3>Sending the email through SMTP client class</h3>
<p>Since we have set everything we need, we now need to send the mail message to our recipient. In order for us to do this, we need to create a new instance of an object based off the SMTP client class. Before moving forward, it should be noted that all our script can do is send the email message to a relay server and hope the server delivers the message. Once our web form sends the email message, all responsibility for sending the message is delegated to the relay server, in our case, IIS. With that said, let's modify our page with the code as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(EmailTB.Text);
        mail.To.Add("myemail@domain.com");
        mail.Subject = "Contact Us";
        mail.IsBodyHtml = true;
        mail.Body = "First Name: " + FNameTB.Text + "&lt;br /&gt;";
        mail.Body += "Last Name: " + LNameTB.Text + "&lt;br /&gt;";
        mail.Body += "Email: " + EmailTB.Text + "&lt;br /&gt;";
        mail.Body += "Comments: " + CommentsTB.Text + "&lt;br /&gt;";
        SmtpClient smtp = new SmtpClient();
        smtp.Host = "your_relay_mail_server";
        smtp.Send(mail);
    }
</code></pre>
<p>As you can see from the example above, we create a new instance of the SMTP client class with an object named SMTP. From there, we set its host property to a relay server. It should be noted that the way of sending email to a relay server on a production server can differ significantly between hosts. The above method is meant to be a generic look at how to do it. As a result, if the above doesn't work for you, ask your hosting provider for additional details. Lastly, to send our results from our form, we set the send method of our SMTP object and pass our mail object as an argument. Save your file. We'll send a test email a little later on.
</p>
<h3>Creating Placeholder controls</h3>
<p>Before moving on, we need to add two place holder controls to our page. Right now, if we were to submit our form, other than an email being delivered to our inbox, there would be no visual indication of a successful submission. As a result, we need to provide a message to our visitor's informing them of a successfully sent email.</p>
<p>We have two options: (1) after sending the email, use a redirect to send our visitors to a separate success page, or (2) create place holder controls that will show or hide content based on success or failure. Generally, for the sake of maintenance, it's wise to keep everything in one file. In order to create these controls, open contact.aspx and add the following controls as shown below:</p>
<pre><code>
&lt;body&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;form id="form1" runat="server"&gt;
...more code
&lt;/form&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="sucessPH" runat="server" Visible="false"&gt;
&lt;p&gt;Thank you for your submission.&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/body&gt;
</code></pre>
<p>As you can see from the example above, right after our opening body tag, we create a place holder control named formPH and set it's visibility to true. Since it has the contents of our form, we want to show it initially. Then, right before the closing body tag, we add another place holder control named successPH and set its visibility to false. Continuing, open contact.aspx.cs and add the following code as shown below:</p>
<pre><code>
smtp.Send(mail);
formPH.Visible = false;
sucessPH.Visible = true;
</code></pre>
<p>As you can see from the example above, right after sending our email message, we set our form's place holder control's visibility to false, and instead show our success message by setting its visibility to true. Save your files.</p>
<h3>Extending the reset event handler</h3>
<p>Right now, there's no way to clear our form fields of existing data. Let's fix this by adding the code shown below to our existing reset event handler:</p>
<pre><code>
protected void Reset(object s, EventArgs e)
    {
        FNameTB.Text = "";
        LNameTB.Text = "";
        EmailTB.Text = "";
        CommentsTB.Text = "";
    }

</code></pre>
<p>As you can see from the example above, we set each web control's text property to an empty string. Save your file, refresh your browser; fill in some fields and press reset.</p>
<h3>Validation</h3>
<p>Since we have created our form, and it's sending the information we need, we need to implement functionality that ensure our fields are filled in before sending the email. Generally, when you provide forms for your visitors to fill out, you want a certain amount of information entered before it's allowed to submit the email to the specified recipient. Validation can be done one of two ways or both, just depends on how much you want to foolproof your form.</p>
<p>The first way is to use client-side validation using JavaScript, which is only performed client-side, in other words, only executed on the visitor's computer. This is often done to provide instant feedback to the visitor as to any errors that occurred. There's only one disadvantage to relying on this approach: if JavaScript is disabled in a visitor's browser, then validation fails to execute, leaving your web form with empty details that you may require.</p>
<p>The second way is use server-side validation using the behaviors present within your server-side language. This method is far more reliable because even if a visitor has JavaScript disabled in a browser, server-side validation scripts can still execute from the server and provide feedback as to any errors that occurred.</p>
<p>Generally, it's recommended to use a combination of both, that is, using JavaScript to ensure instant feedback that limits post backs to the server, and then using server-side scripts to check sensitive fields to ensure that the visitor did in fact give you the information you need.</p>
<p>We'll continue with required fields <a href="default4.aspx">next</a>.</p>
</asp:Content>
