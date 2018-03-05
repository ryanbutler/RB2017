<%@ Page Title="Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.sending_a_html_and_plain_text_e_newsletter_asp_net.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Sending a HTML & Plain Text E-Newsletter in ASP.NET (ASPX)</h2>
<h3>Providing a web version of the email</h3>
<p>One additional detail you can do for users who have difficulty reading the html version in their email client, is to provide a link at the top of the newsletter that will point readers to a web version of the newsletter for easier viewing. If you want to implement this, view default_webversion.aspx.</p>
<h3>Creating a plain text version of the email</h3>
<p>You may be asking the question: what if my users will only accept plain text in emails? Fortnately, there's a way to accommodate this in ASP.NET. Let's create a plain text version in steps as follows using default_plaintext.aspx as a reference:</p>
<ul>
<li>First, right below our variable that holds our html content, create another variable to hold our plain text content as shown below:</li>
</ul>
<pre><code>
protected void sendEmailBtn_Click(object sender, EventArgs e) 
 { 
   string bodyHTML = string.Empty; 
   string bodyPlain = string.Empty; 

</code></pre>
<p>As you can see from the code above, we create another variable, bodyPlain, and set its value to an empty string, which makes the variable read only.</p>
<ul>
<li>Second, right after ending our html content, we add our content to our plain text variable as shown below:</li>
</ul>
<pre><code>
&lt;body&gt;
&lt;html&gt;'";
bodyPlain =@"...plain text version here";
</code></pre>
<p>As you can see from the code above, we applied the same at (@) sign to our string as we did for our html content. Recall from earlier, the at (@) sign is treated as a literal (verbatim) string, allowing C# to read our plain text string exactly as we have it. Continuing, we needed a way to indicate navigation. We simply used hyphens for this. Additionally, we need a way to separate our headings logically. The easiest way to do this is to use asterisks before and after each heading to denote a change in the flow of content. You can of course, use any logic or flow process you want. Finally, to account for the images, we provide the absolute link, that way, users can easily click the link if they choose to.</p>
<ul>
<li>Third, we need to create the plain text view for our email, which is shown below:</li>
</ul>
<pre><code>
AlternateView plainView = AlternateView.CreateAlternateViewFromString(bodyPlain, null, "text/plain");
</code></pre>
<p>As you can see from the code above, we create a plainView variable from the AlternateView class, and set it to the CreateAlternateViewFromString method that accepts three parameters: (1) the variable that you're creating the view on, (2) the encoding type, which can be null, and (3) the MIME type, which in our case is plain text.</p>
<ul>
<li>Fourth and finally, we need to add this view to our mail message object as shown below:</li>
</ul>
<pre><code>
mailMsg.AlternateViews.Add(plainView);
</code></pre>
<p>As you can see from the code above, we use our mail message object, set its property, AlternateViews, and then call it's add method, and pass in our plainView variable.</p>
<h3>Testing the plain text version</h3>
<p>If you want to see the plain text version of your email, comment out the line that adds the html view to the mail message object as shown below:</p>
<pre><code>
//mailMsg.AlternateViews.Add(htmlView);
</code></pre>
<p>Save your file and send the mail. You should receive the plain text version only.</p>
<h3>Spam</h3>
<p>Before finishing the article, it should be mentioned, in most cases, our email shouldn't be treated as spam or be blocked. However, there's no guarantee that wouldn't happen. Depending on the rules set on the firewall or router of the recipients account, our e-newsletter could be blocked or treated as spam. This could be especially true if the receiving email servers only accept emails from trusted senders. If this is the case, the only option you have is to talk with your system administrator to see what options you may have.</p>
<h3>Summary</h3>
<p>In this article you learned how to take a finished web page and integrate it into an ASP.NET page that's capable of sending an html and plain text newsletter to any specified recipient. Furthermore, you learned the following:</p>
<ul>
<li>How to structure the html version for maximized compatibility of email clients</li>
<li>How to create a send mail event and add the following code inside:
<ul>
<li>Variables to hold html and plain text versions of the email</li>
<li>Mail message object used to store who's sending the mail, the receipient, subject and indicating the mail message contains html</li>
<li>How to include images in our email without creating additional file size</li>
<li>How to create an SMTP object and set corresponding values</li>
<li>How to work with Ajax server side controls to prevent sending multiple emails to the same person</li>
</ul>
</li>
</ul>
<p>In part two of this series, we'll look at how you can adjust the existing ASP.NET page to send the same email to multiple recipients using a database table, which will involve modifying our existing ASP.NET page and using structured query language (SQL). For now, take the knowledge gained in this article and use it to create any email newsletter of your dreams!</p>
<p>If you have quesitons, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>