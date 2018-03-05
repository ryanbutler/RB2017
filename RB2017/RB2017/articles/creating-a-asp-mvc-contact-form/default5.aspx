<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default5.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form.default5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET MVC Contact Form</h2>
<h3>Adding mail functionality to our controller</h3>
<p>
With the implementation of our view and model complete, we can close both of those files from inside Visual Studio. Let’s finish by adding the functionality to e-mail the results of the form to the specified recipient. Add the following code to our HomeController.cs, specifically the [HttpPost] method:
</p>
<pre><code>
[HttpPost]
public ActionResult Contact(ContactModels c)
{
if (ModelState.IsValid)
{
try
{
MailMessage msg = new MailMessage();
SmtpClient smtp = new SmtpClient();
MailAddress from = new MailAddress(c.Email.ToString());
StringBuilder sb = new StringBuilder();
msg.To.Add("youremail@email.com");
msg.Subject = "Contact Us";
msg.IsBodyHtml = false;
smtp.Host = "mail.yourdomain.com";
smtp.Port = 25;
sb.Append("First name: " + c.FirstName);
sb.Append(Environment.NewLine);
sb.Append("Last name: " + c.LastName);
sb.Append(Environment.NewLine);
sb.Append("Email: " + c.Email);
sb.Append(Environment.NewLine);
sb.Append("Comments: " + c.Comment);
msg.Body=sb.ToString();
smtp.Send(msg);
msg.Dispose();
return View("Success");
}
catch (Exception)
{
return View("Error");
}
}
return View();
}
</code></pre>
<p>As you can see, quite a bit is going on, so let’s dissect it:</p>
<ol>
<li>If our model validation passes, we create a try/catch block which will handle server—side error handling. Inside the try block we do the following:
<ol type="A">
<li>Create an object from the mail message class</li>
<li>Create an object from the mail address class</li>
<li>Create an object from the string builder class</li>
<li>Create an object from the SMTP client message class </li>
<li>From the mail object, we assign: 
<ol>
<li>Whether our e-mail will contain HTML</li>
<li>An e-mail address of the recipient</li>
<li>A subject</li>
<li>Concatenate (append) our form field values from our model to the string builder object, with appropriate carriage returns </li>
</ol>
</li>
<li>After concatenation is complete, we assign the body of our mail message to the contents of our string builder object</li>
<li>From the SMTP object, we assign: 
<ol>
<li>Our host</li>
<li>Port number</li>
<li>Call the send method, and pass in our mail object</li>
<li>We dispose of the mail object and show a success view</li>
</ol>
</li>
</ol>
</li>
<li>If sending our e-mail fails, we display a user friendly razor web page</li>
<li>If validation errors occur, we re-display our initial razor web page with appropriate error messages.</li>
</ol>

<h3>Attention Gmail and/or Outlook (Hotmail) users</h3>
<p>For the purposes of this article, if you’re using Gmail and/or Outlook (Hotmail), we’ll need to update the above code to the following (we’ll use Gmail as an example):</p>
<pre><code>
SmtpClient client = new SmtpClient();
// We use gmail as our smtp client
client.Host = "smtp.gmail.com";
client.Port = 587;
client.EnableSsl = true;
client.DeliveryMethod=SmtpDeliveryMethod.Network;
client.Credentials = new System.Net.NetworkCredential("your gmail email address", "your gmail email address password");
</code></pre>
<p>As you can see, we:</p>
<ol>
<li>Switch out the host and port</li>
<li>Add the property EnableSsl and set it to true</li>
<li>Add the property DeliveryMethod and set it to SmtpDeliveryMethod.Network</li>
<li>Add the property Credentials and create a new network credentials object which we pass in our desired Gmail email address along with password</li>
</ol>
<p>In case you’re wondering, since we place our Gmail email address and password in server-side code, it would be very difficult for a malicious attack to intercept the request and corresponding response to know these sensitive details.</p>
<p>Continuing, when using Gmail for the first time, you’re more than likely to receive the following exception locally:</p>
<p><strong>Gmail Error: The SMTP server requires a secure connection or the client was not authenticated. The server response was: 5.5.1 Authentication Required</strong></p>
<p>
Follow this link at Stack Overflow for resolution:
<a href="http://stackoverflow.com/questions/20906077/gmail-error-the-smtp-server-requires-a-secure-connection-or-the-client-was-not" target="_blank">http://stackoverflow.com/questions/20906077/gmail-error-the-smtp-server-requires-a-secure-connection-or-the-client-was-not</a>
</p>
<h3>Adding our success view</h3>
<p>
Since our error view is already created (Views:Shared) we’ll just create our success view by following these steps:
</p>
<ol>
<li>Right click in our controller inside the try block, and choose Add View</li>
</ol>
<p class="alignCenter"><a href="images/19.png" data-lightbox="image-19"><img src="thumbs/19.png" alt="Add View" width="250" height="214" /></a></p>
<ol>
<li>From the Add View window:
<ul>
<li>In View Name text field, type Success</li>
<li>In Use a layout or master page, leave checked, and left click the ellipses button, and
choose _Layout.cshtml
</li>
</ul>
</li>
</ol>
<p>Once finished, your window should look as illustrated:</p>
<p class="alignCenter"><a href="images/20.png" data-lightbox="image-20"><img src="thumbs/20.png" alt="Success View" width="250" height="248" /></a></p>
<p>Left click Add.</p>
<p>In the view, add the following as shown below:</p>
<p class="alignCenter"><a href="images/razor7.png" data-lightbox="image-razor7"><img src="thumbs/razor7.png" alt="Razor Syntax 7" width="300" height="51" /></a></p>
<p>Save your solution and give it a run.</p>
<h3>Some loose ends</h3>
<p>There are a few items that need to be done when using this solution in a production environment:</p>
<ol>
<li>Verify your hosting provider’s SMTP host address and port number</li>
<li>Verify your hosting provider’s current  MVC and .NET version</li>
<li>Verify your hosting provider’s current MVC and .NET version</li>
<li>Upload the following files to your public web directories:
<ol type="a">
<li>Bin\Mvc4ContactForm.dll</li>
<li>Views\Home\Contact.cshtml</li>
<li>Views\Home\Success.cshtml</li>
<li>Views\Home\_Layout.cshtml</li>
<li>Views\Home\Error.cshtml</li>
<li>Scripts - Upload all files</li>
</ol>
</li>
<li>Content\Site.css</li>
</ol>
<h3>Slower than molasses in January</h3>
<p>You may have noticed that when you submit the form to process and send the email message to the desired recipient, it takes considerable time for the success view to appear. In other words, after clicking the submit button, our application appears to hang, before showing the success view. There’s a reason for this and will be discussed in <a href="/articles/asynchronous-javascript-and-xml/default.aspx">explanation of long running form submit</a></p>
<h3>Summary</h3>
<p>
In this article, I covered how to create an ASP MVC contact form, specifically the following:
</p>
<ol>
<li>What prerequisites were needed to create a ASP MVC solution</li>
<li>The differences between Views, Models, and Controllers</li>
<li>How validation works within an MVC paradigm</li>
<li>Differences between unobtrusive and obtrusive JavaScript</li>
<li>How to send mail using the provided .NET native mail class</li>
</ol>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>