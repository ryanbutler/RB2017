<%@ Page Title="Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.sending_a_html_and_plain_text_e_newsletter_asp_net.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)</h2>
<h3>Adding the HTML markup to our bodyHTML variable</h3>
<p>To put the HTML markup of our finished page into our variable, we set our variable to accept a literal (verbatim) string as shown below:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net", txtTo.Text); 
   mailMsg.Subject = "Company E-Newsletter"; 
   mailMsg.IsBodyHtml = true; 
   bodyHTML = @""; 
} 
</code></pre>
<p>As you can see from the code above, we set our variable to accept a literal (verbatim) string of text by using the at (@) sign, following by two double quotes. In other words, using the at (@) symbol allows C# to read our html markup exactly as we have it.</p>
<p>Next, to get our finished web page into our variable, follow these steps:</p>
<ol>
<li>Open the finished web page in a browser</li>
<li>Right click and select View Source</li>
<li>Press Cntrl + A on your keyboard to select all the markup</li>
<li>With the markup highlighted, right click and select Copy</li>
</ol>
<p>In our code behind file, place your mouse cursor in the double quotes of our variable, right click and select Paste. You'll notice the code behind file doesn't like the html markup. The reason for this is simple, we haven't escaped our double and single quotes correctly. To resolve the conflicts, use default_htmlversion.aspx as a reference. As you can see by looking at the example file, our finished web page is simply copied inside the double quotes of our variable, thus we replaced the double quotes from our original html markup with single quotes. Now would be a good time to save your changes.</p>
<h3>Working with images in emails</h3>
<p>You may have noticed in the reference file that we linked directly to our images by using an absolute path. As mentioned earlier in the article, when sending newsletters in html format, you generally want to use images sparingly. For the contents of the email, you don't want to force the recipients to download multiple images, because they might have a slower Internet connection, or more importantly, most email clients, including Outlook by Microsoft, block images by default because they can contain malicious code. In this scenario, once an image is downloaded that contains malicious code, the code can then be used to take over the computer and use it as a zombie to attack other computers, or do a variety of other tasks that you don't know about. Unfortunately, there's nothing from a code point of view to force recipients to unblock images, you're simply at the mercy of the person viewing the email.</p>
<p>From a code point of view, you have another option in ASP.NET other than the absolute method to send images in email. Instead of using an absolute path, you could embed the image in the email by creating a linked resource variable. In this case, the image becomes part of the actual email stream in memory. This may seem like a better alternative because you're instructing ASP.NET that the email will contain an image as part of the email, rather than relying on a hard coded path. However, this can become problematic when sending the email. In this case, since the image becomes part of the email, it will increase the overall size of the email being sent. While this may not appear to be a big issue, it can become one in certain situations.</p>
<p>For example, if you decide to send this email to 50 plus people, each time the mail server creates the email message, it not only creates enough memory to send the email, but it also includes enough memory to embed the image. In other words, an email message that may be 11 kilobytes (in our case) using the direct linking option, may end up being double that because you're embedding the image in the same memory stream as the email, which can cause time out errors. And to complicate matters, some hosts don't allow embedded images in code because of security limitations in a shared hosting environment. This is one of many reasons you want to use the new mail space instead. As a result, this is why it's generally a better option to link directly to an image instead of embedding.</p>
<h3>Create the alternative view</h3>
<p>At this point, we have created the variable that holds the contents of our e- newsletter, as well as creating the mail message object that allows us to send the newsletter to a receipient. However, we still need to add an HTML view so that our mail message object knows how to handle the email when sending it to an email client. In other words, just because we have our finished web page in a variable, we haven't told ASP.NET how to handle the variable when sending it to the mail message object. We do this by adding the following right below our existing code as shown below:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net", txtTo.Text); 
   mailMsg.Subject = "Company E-Newsletter"; 
   mailMsg.IsBodyHtml = true; 
   bodyHTML = @""; 
AlternateView htmlView = AlternateView.CreateAlternateViewFromString(bodyHTML, null, "text/html"); 
} 

</code></pre>
<p>As you can see from the code above, we create an htmlView variable from the AlternateView class, and set it to the CreateAlternateViewFromString method that accepts three parameters: (1) the variable that you're creating the view on, (2) the encoding type, which can be null, and (3) the MIME type, which in our case is HTML. Next, we need to add this view to our mail message object as shown below:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net", txtTo.Text); 
   mailMsg.Subject = "MWD E-Newsletter"; 
   mailMsg.IsBodyHtml = true; 
   bodyHTML = @""; 
AlternateView htmlView = AlternateView.CreateAlternateViewFromString(bodyHTML, null, "text/html"); 
mailMsg.AlternateViews.Add(htmlView); 
} 

</code></pre>
<p>As you can see from the code above, we use our mail message object, set its property, AlternateViews, and then call it's add method, and pass in our htmlView variable.</p>
<h3>Creating the SMTP object, setting the port, host and sending the mail</h3>
<p>At this point, we have everything we need in preparation of sending the email. To send the email, we need to create an smtp object that will let us authenticate to our smtp server, set our port, host, and send our email to our recipients. We do this by adding the following code:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net", txtTo.Text); 
   mailMsg.Subject = "MWD E-Newsletter"; 
   mailMsg.IsBodyHtml = true; 
   bodyHTML = @""; 
AlternateView htmlView = AlternateView.CreateAlternateViewFromString(bodyHTML, null, "text/html"); 
mailMsg.AlternateViews.Add(htmlView); 
SmtpClient smtp = new SmtpClient(); 
smtp.Port = 25; 
smtp.Host = "mail.domain.net"; 
smtp.Send(mailMsg); 
} 

</code></pre>
<p>As you can see from the code above, we instaniated a new object of the smtp client class by using its constructor method. Next, we set the port to the standard 25 by using the port property of our smtp object. Continuing, we set the host to our mail server by using the host property of our object. Finally, we send our mail message by using the send method and passing in our mail message object as a parameter. It should be noted at this point to check with your host for specifics on how to send emails from a script, specifically if they require additional steps to authenticate to their SMTP server, since the above is a generic way of looking at it.</p>
<p>Before saving the file and closing it, we need to set our label control to a literal text string of &quot;success&quot; and clear out our text field after the email is sent by adding the following code:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net", txtTo.Text); 
   mailMsg.Subject = "MWD E-Newsletter"; 
   mailMsg.IsBodyHtml = true; 
   bodyHTML = @""; 
AlternateView htmlView = AlternateView.CreateAlternateViewFromString(bodyHTML, null, "text/html"); 
mailMsg.AlternateViews.Add(htmlView); 
SmtpClient smtp = new SmtpClient(); 
smtp.Port = 25; 
smtp.Host = "mail.domain.net"; 
smtp.Send(mailMsg); 
lblMessage.Text = "success"; 
txtTo.Text = ""; 
} 
</code>
</pre>
<p>Setting the text property of our label control serves as a visual indicator that our email was sent successfully. Setting the text property of our receipient text box control (our text field) to an empty value, gives a better visual experience to our user allowing them to send the newsletter to another email address.</p>
<h3>Sending the email</h3>
<p>For the purposes of this article, it's assumed you're sending this email from a remote host. With that, all we need to do is upload the finished file to your remote host, type the full address to request the page, and you should see the following display:</p>
<p class="alignCenter"><img src="images/sendemail_browser_view.jpg" width="288" height="208" alt="Send Email Browser View" /></p>
<p>Type the desired recipient in the text field, and after clicking the "Send Email" button, you should see the success message appear after a few seconds:</p>
<p class="alignCenter"><img src="images/sendemail_browser_success.jpg" width="288" height="207" alt="Send Email Browser View Success" /></p>
<p>If everything went right, you should receive an email in a few minutes. If you don't, and you received no errors when executing the script, follow a few simple steps before contacting your host:</p>
<ul>
<li>Verify the recipient email address is correct</li>
<li>Set a break point inside the send mail event handler and run the page from Visual Studio as shown below:</li>
</ul>
<p class="alignCenter"><img src="images/debug_visual_studio.jpg" width="424" height="95" alt="Debug in Visual Studio" /></p>
<p>The red dot shown in the image above indicates a break point. When clicking the "Send Email" button, if an error occurs in code, control of the page will revert from the browser back to Visual Web Developer Express showing you the error. As a last resort:</p>
<ul>
<li>Make sure you're authenticating properly, which may involve asking your host for further details</li>
</ul>
<h3>Houston, we have a problem...</h3>
<p>At this point, if you refresh your browser, either by clicking the refresh button within the browser or by pressing F5 on your keyboard it would send another email to the recipient. The reason for this is a bit technical but understandable if we take it in steps. First, when we initially clicked the send email button, that caused a post back because the onclick attribute is associated to a server side event, which subsequently sends the email. However, since you're still in the "state" of a post back, refreshing your browser or pressing F5 on your keyboard causes the send mail event to execute again because refreshing the page is considered a &quot;full&quot; post back.</p>
<p>At this point, the only way to prevent the mail from being sent again is to use your mouse and left click in the address bar and press enter on your keyboard to return to an &quot;original state&quot;. Obviously, this is an issue. If the person using the script kept hitting the refresh button thinking they would go back to the "original state", they would in fact send the email again to the same person. As a result, we need a way to refresh the page without sending the email again. We have two solutions that work: 1) create a database table with a date time column associated to the recipients email address. Then using Structured Query Language (SQL) we update the date time column with the current date from our C# script, or 2) use Ajax server side controls to control what part of the page we want to refresh without causing a full page post back. Since the first solution will be part two of the series, we'll go with solution two for this article.</p>
<h3>Adding the AJAX server side controls</h3>
<p>Double click default.aspx to open our web form and add the following code to the existing markup:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt; 
&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt; 
&lt;head runat="server"&gt; 
    &lt;title&gt;&lt;/title&gt; 
&lt;/head&gt; 
&lt;body&gt; 
    &lt;form id="form1" runat="server"&gt; 
    &lt;asp:ScriptManager ID="ScriptManager1" runat="server"/&gt; 
    &lt;asp:UpdatePanel ID="UpdatePanel1" runat="server"&gt; 
        &lt;ContentTemplate&gt; 
            &lt;asp:TextBox ID="txtTo" runat="server"/&gt; 
            &lt;asp:Button ID="sendEmailBtn" runat="server" Text="Send Email" OnClick="sendEmailBtn_Click"/&gt; 
            &lt;asp:Label ID="lblMessage" runat="server"/&gt; 
        &lt;/ContentTemplate&gt; 
    &lt;/asp:UpdatePanel&gt; 
    &lt;/form&gt; 
&lt;/body&gt; 
&lt;/html&gt; 
</code>
</pre>
<p>As you can see from the code above, we added two Ajax server side controls. Briefly, Ajax stands for Asynchronous JavaScript and XML and is a way for developers to instruct a web page when to initiate between a client or server side request. This becomes very efficient when working with complex web applications and limiting when the application needs to make a server side request.</p>
<p>Continuing, from the above code, we can see that we first added a script manager control. In order to use any Ajax server side control in ASP.NET, you must have one script manager tag. This tag acts as a gate keeper for our page and manages all client side scripts (JavaScript) needed to handle asynchronous calls from a server. Next, we added an update panel control. This control contains two children tags, content template and triggers. In our case, we added a content template tag, which essentially makes any content inside, such as our existing web form controls Ajax enabled. Save your changes, and we'll explain how this solves our problem.</p>
<p>So, here's how the Ajax server side control solves our problem: think of our entire page as a box, then think of our update panel as another smaller box within our larger box. When a visitor clicks the send email button, it causes the update panel to execute the click event associated to the button, which sends the email. After this, when we refresh our page, the only part of our page which refreshes is our update panel, known as a partial page post back. As a result, there's no full page post back, thus, no duplicate email is sent.</p>
<p>We'll continue the article by explaining how to include a web version of the email <a href="default3.aspx">next</a>.</p>

</asp:Content>
