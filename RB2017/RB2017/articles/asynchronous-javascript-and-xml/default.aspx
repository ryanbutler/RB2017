<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.asynchronous_javascript_and_xml._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Explanation of long running form submit</h2>
<p>
When working with various types of form submissions, you’re likely to encounter an experience where a
web or desktop application seems to hang or just
sit idle
. In most cases, the application isn’t hung or idle,
it’s just blocked the user interface and its users from performing any other operations or processes (a
thread) until the current operation is finished, which leads users to be misled on what is occurring with the
application.
</p>
<h3>Threads</h3>
<p>
In computer programming, a thread is considered an execution of the smallest sequence of programmed
instructions that is managed independently by an operating system. Threads are similar to a process;
however, processes are generally independent, whereas a thread exists as a child of a process.
</p>
<p>
In computer applications, when a user interface component requests operations from a server, whether it’s
a database or other types of processes, such as sending an email, these occur within threads. Sometimes,
depending on the operations, these threads can take time to process and return an appropriate result to the
visual component. As a result, these threads are locked so that other competing resource, such as a
success message or a grid control being filled on the user interface doesn’t interrupt the previous thread.
</p>
<p>
While the locked thread is working, the user interface and user are left wondering, why is my action that
was performed appear to be idle? The answer lies in the user interface - it doesn’t know natively that an
operation is occurring behind the scenes. In essence its dumb to the idea there’s a locked thread running a
time-sensitive operation. As a result, we need a way to instruct visually to the user that the application is
processing a long running operation and needs time to finish before the next operation - visually
indicating to the user the operation is complete - can occur.
</p>
<h3>What solutions are available?</h3>
<p>The solutions available depend on what operations are being performed.</p>
<p>
In a case such as <a href="../creating-a-asp-mvc-contact-form/default.aspx">Creating a ASP.NET MVC Contact Form</a>, the long running process is sending the mail
message via the send method of the Simple Mail Transfer Protocol (SMTP) class. SMTP servers are generally chatty Cathy’s for a variety of reasons including:
</p>
<ol>
<li>Timeouts on the SMTP server</li>
<li>Validation of the email for the SMTP server</li>
<li>Rules in place to prevent sending emails on timed intervals</li>
<li>Serializing the email in order for it to be sent across the Internet</li>
</ol>
<p>To remedy the long running process, you have a couple different options including:</p>
<ol >
<li>
Send the emails to a temporary location on the sending SMTP server. Once delivered, we could
write additionally logic to read from the queue and send mail
</li>
<li>
Implement a little bit of JavaScript logic to hook into the submission process. Once implemented,
on the form submission, the screen would fade out and present the user with a processing
message, and once the thread/process is finished, redirect them to a success message
</li>
</ol>
<p>
In this specific case, the latter solution is probably the only option, since most people use shared hosting
and most providers wouldn’t allow you to access or write messages to their SMTP servers.
</p>
<p>In database operations, the latter solution is still probably the best option, if you need it.</p>
<p>One implementation approach for a web application can be found at:</p>
<p><a href="http://blog.tkglaser.net/2012/02/waiting-spinner-for-long-running-form.html" target="_blank">http://blog.tkglaser.net/2012/02/waiting-spinner-for-long-running-form.html</a></p>
<p> I've used this before on this site and it worked.<p>
<p>If you’d like additional examples/ideas, a simple Google search query such as long running form submits will deliver additional options if you’re dealing with a desktop application.</p>
<h3>Summary</h3>
<p>
In this tutorial, we examined why users and the interface of a desktop or web application are often viewed
as hanging or sitting idle. We explained what a thread is, what the application is doing with that thread,
and how the user interface becomes misleading to users with long running operations. We provided a
couple different options for handing this, which included implementing a JavaScript solution for a web
application, or using Google to search for additional implementation ideas.
</p>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>
