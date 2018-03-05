<%@ Page Title="Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.sending_a_html_and_plain_text_e_newsletter_asp_net._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)</h2>
<p>When developing a website, especially for advertising, marketing, or recruiting agency, the ability to keep in touch with your audience through an attractive e-newsletter that provides information about current events and news surrounding your company is essential to keep your visitors in touch, in tune and wanting more. Most of the time, developers in charge of the website purchase mailing list programs that can be expensive, difficult to customize, both in appearance and in the script, and hard to setup on the remote server. The reason for this is simple; they don't have the knowledge or experience to develop one from scratch.</p>
<p>However, if you're familiar with HTML and CSS, using ASP.NET, you can develop an e-newsletter easily as long as you keep the expectations of what can be achieved visually through email within reason. In this article, we'll take a completed web page and learn how to integrate the HTML markup into an ASP.NET web form that will send the email to a recipient of our choice. Throughout the article, we'll identify the following: best methods used for the layout, formatting the visual appearance of the newsletter with CSS, recommended practices for using images, and last, how to write a script that will send both an HTML and plain text version of the newsletter.</p>
<p>If you would like to learn how to create an e-newsletter using the skills and software programs you already have in a practical context please do follow along below.</p>
<h3>Examining the finished web page: Layout</h3>
<p>Since this article's purpose is about integrating and sending an e-newsletter through ASP.NET, we'll focus on moving the finished newsletter into an ASP.NET page. As you can see from looking at the newsletter in a browser, there's nothing extraordinary about the design or the code behind it. Continuing, if you look at the source of the web page, you'll notice a fairly archaic markup that is reminiscent of the early 90's when web developers thought that using inline styles for CSS and table layouts were here to stay. Obviously, that has changed, and today developers are pushing the limits on pure CSS layouts. However, we didn't do that in the newsletter. Our reason is simple; support for advanced CSS such as positioning in email clients is marginal at best. As a result, it's recommended to keep the layout in tables and use CSS, in our case, inline styles to format other characteristics of the page, such as headings, paragraphs, etc.</p>
<h3>Examining the finished web page: Inline styles</h3>
<p>You'll notice there are no linked style sheets or embedded styles, that's because some email clients strip those out, so we'll stick with inline styles.</p>
<h3>Examining the web page: Images</h3>
<p>You'll notice we limited our use of images. There are several reasons for this. For starters, images take time to download and display in an email client. If you send a large size image through email to a visitor with a slower Internet connection, the image will take several seconds if not minutes to download and display, which could result in an unpleasant viewing experience. Furthermore, and arguably more important, images that are large in file size take time to be processed by the server that is sending the email, and by the server that is receiving the email. As a result, the desired number of images used in e-newsletters need to be limited. Also, it should be mentioned we're using an absolute path to retrieve our images. The reason(s) for this will be explained when moving our finished web page into the code behind file of our ASP.NET page.</p>
<h3>Requirements for ASP.NET</h3>
<p>Before creating our project and corresponding ASP.NET page, make sure you have the latest version of .NET installed on your development machine. </p>
<h3>Creating the project & ASP.NET page</h3>
<p>In order to create the ASP.NET page that will have access to the Ajax server side controls, we'll need to create a new project through Microsoft Visual Studio. For the purposes of this article, we'll use the former, since it's a free download. From the program, follow these steps to create the new web project:</p>
<ol>
<li>From the main menu, select File:New Project</li>
<li>For project type, select Visual C#, and then Web</li>
<li>For templates, select ASP.NET web application</li>
<li>In the name field, type SendEmail</li>
<li>Choose an appropriate directory for your solution</li>
<li>Left click OK</li>
</ol>
<p>Your new web project will be created with a web form (default.aspx), and its corresponding code behind file, as well as a configuration file, web.config. Modify default.aspx as follows:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" &gt;
&lt;head runat="server"&gt;
    &lt;title&gt;&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;h3&gt;Send E-Newsletter&lt;/h3&gt;
    &lt;form id="form1" runat="server"&gt;
    &lt;asp:TextBox ID="txtTo" runat="server"/&gt;
&lt;asp:Button ID="sendEmailBtn" runat="server" Text="Send Email" OnClick="sendEmailBtn_Click"/&gt;&lt;asp:Label ID="lblMessage" runat="server"/&gt;
    &lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>
<p>As you can see from the code above, we added the following:</p>
<ol>
<li>&lt;h3&gt;
<ul>
<li>Gives our page a title of Send E-Newsletter</li>
</ul>
</li>
<li>&lt;form runat=&quot;server&quot;&gt;
<ul>
<li>Every ASP.NET web form must have a form tag with an attribute of runat equal to server</li>
</ul>
</li>
<li>&lt;asp:TextBox
<ul>
<li>A server side text box control with the following parts:</li>
<li>ID=&quot;txtTo&quot;
<ul>
<li>Gives our text box control a unique name so we can reference it in our code behind file</li>
</ul>
</li>
<li>Runat=&quot;server&quot;
<ul>
<li>Allows our button control to be run from the server with the resulting output being read by the browser</li>
</ul>
</li>
</ul>
</li>
<li>&lt;asp:Button
<ul>
<li>A server side button control with the following parts:
<ul>
<li>ID=&quot;sendEmailBtn&quot;
<ul>
<li>Gives our button control a unique name so we can reference it in our code behind file</li>
</ul>
</li>
</ul>
<ul>
<li>Runat=&quot;server&quot;
<ul>
<li>Allows our button control to be run from the server with the resulting output being read by the browser</li>
</ul>
</li>
</ul>
<ul>
<li>Text=&quot;Send Email&quot;
<ul>
<li>Gives our button a visual text to indicate to our visitors what the button can do</li>
</ul>
</li>
</ul>
<ul>
<li>OnClick=&quot;SendEmailBtn_Click&quot;/&gt;
<ul>
<li>Gives our button control a server-side event handler that will be used to send our newsletter</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
<li>&lt;asp:Label&gt;
<ul>
<li>A server side label with the following parts:
<ul>
<li>ID=&quot;lblMessage&quot;
<ul>
<li>Gives our label control a unique name so we can reference it in our code behind file</li>
</ul>
</li>
</ul>
<ul>
<li>Runat=&quot;server&quot;
<ul>
<li>Allows our button control to be run from the server with the resulting output being read by the browser</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
</ol>
<p>The label control is used to indicate whether our email was sent successfully. Its text property will be set to a literal text string from our code behind file after the email has been sent. Save your changes and keep the file open.</p>
<h3>Adding the send email event handler</h3>
<p>When moving the HTML markup to our code behind file (done later in the article), we need to place it within our send mail event handler. In order to do this, let's first add an event handler to our code behind file. To do this, double click the send email button from default.aspx. After double clicking the button, the code behind file should open automatically and insert the following code:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e)
 {
}
</code></pre>
<p>As you can see from the code above, by double clicking the button, the program automatically added the correct event handler, sendEmailBtn_Click, which is the same name as our onClick attribute of our button control, with the appropriate parameters.</p>
<h3>Add the mail name space</h3>
<p>To eventually send the e-newsletter in an email, we need to add the name space that will allow us to create a mail message object. In our code behind file, add the following below the existing name spaces:</p>
<pre><code>
using System.Net.Mail
</code></pre>
<p>As you can see from the code above, we added System.Net.Mail name space in order to expose the mail message class.</p>
<h3>Create variable for html email and mail message object</h3>
<p>Continuing, let's create the variable that will hold our HTML markup from our fnished page, as well as create a mail message object that will be used to specify who the email is from and who the email is going to. In our code behind file, in the send email event handler, add the following code:</p>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   MailMessage mailMsg = new MailMessage("webmaster@domain.net",txtTo.Text); 
   mailMsg.Subject = "Company E-Newsletter"; 
   mailMsg.IsBodyHtml = true;} 

</code></pre>
<p>As you can see from the code above, we added the following: a string variable named bodyHTML and set its value to empty. This makes the contents of our variable read-only. Continuing, we create an instance of a new object, mailMsg from the mail message class and pass in two parameters. The mail message class constructor accepts two parameters at a minimum, which can include any of the following: the sender of the email, the receipient of the email, the subject, or the body. In our case, for the sender, we used an email address. It's important to note here that hosts will not let you send an email from an account that isn't active on your domain. As a result, create a generic name, such as webmaster@domain.net to serve as the sender. For the receipient, we used our text box control, which allows us to send our e-newletter to any email address we choose. Lastly, we use the subject property of the mail message object and set it to &quot;Company E-Newsletter&quot;, and set the IsBodyHtmlproperty to true, since this is an HTML email. Before moving on, now would be a good time to save your changes.</p>
<p>We'll look at adding the HTML markup to our bodyHTML variable <a href="default2.aspx">next</a>.</p>
</asp:Content>