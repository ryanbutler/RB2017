<%@ Page Title="Creating a ASP.NET Contact Form (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_contact_form.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET Contact Form (ASPX)</h2>
<h3>Open the Web site in a browser</h3>
<p>In order to see the results of our work, open your preferred web browser and navigate to a live website, such as http://www.&lt;yourwebsite&gt;.com/contact.aspx 
Don't be concerned if the page doesn't load immediately. Since the ASP.NET environment compiles each web form into Dynamic Link Libraries (DLL), the first time you load a web form into a browser, it has to compile any code or control before it can render the page. However, as a result, since it's compiled, if there are no changes, subsequent requests for the page should speed up and no delay should be visible. Once your web page has rendered, to reiterate what the ASP.NET environment is doing, view the source of the page in your browser and you should see this:
</p>
<p>As you can see from the example above, the ASP.NET environment has automatically replaced the text box web controls with ordinary HTML input tags for first and last name, as well as email, and has used the ID of the control as the value for the name attribute. Keep note of the view state tag circled in red above, we'll get to that later in the article. Since a comment field is generally thought to contain more text than an input tag, we use a text area tag instead. Let's go ahead and create the text area tag by modifying our file as shown below:</p>
<pre><code>
&lt;tr&gt;
&lt;td&gt;Comments:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="CommentsTB" runat="server" TextMode="MultiLine" /&gt;&lt;/td&gt;
&lt;/tr&gt;
</code></pre>
<p>As you can see from the example above, in order to get a &lt;textarea&gt; tag, we use the text mode property of our text box control and set its value to multiline. Save your file and refresh your page to see the results.</p>
<h3>Create our submit and reset buttons</h3>
<p>For our contact form to send an email message to a specified recipient, we need to add buttons to our form that will trigger code to make this happen. Modify our file as shown below:</p>
<pre><code>
&lt;tr&gt;
&lt;td colspan="2"&gt;&lt;asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="SendMail"/&gt;&lt;asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="Reset"/&gt;&lt;/td&gt;
&lt;/tr&gt;
</code></pre>
<p> As you can see from the example above, we added an extra table row, and created two web control buttons, one for sending the mail, and another one for clearing the form fields. One difference in these buttons from the others includes using the text property to set their text values to submit and reset accordingly that will show a textual description for the buttons. Another important difference is the onclick property. The first confusing aspect of this property is one tends to think this is a client-side event, in this case, it's not. It's a server-side event that will trigger a server-side event to occur in our code-behind file that will ensure validation takes place, as well as emailing the results of information to our specified recipient, which we'll get to next. Save your changes and close the file. Open the code-behind file (contact.aspx.cs) and add the following event handlers below the page load event handler:></p>
<pre><code>
protected void Page_Load(object sender, EventArgs e)
    {
    }
protected void SendMail(object sender, EventArgs e)
    {
}
protected void Reset(object s, EventArgs e)
    {
}
</code></pre>
<p>As you can see from the examples above, the name of our event handler matches our onclick event in our presentational file. It should be noted that if you set an onclick event on a button without creating a corresponding event handler, your web form will throw an error. We'll discuss the code within this file shortly.</p>
<p>In typical web environments, such as PHP or ASP, when you want an action to occur, like a form submission that sends an email, you create an input button and specify its type as submit. When the button is clicked, the file that's attached to the action attribute of the form, typically a script is then executed performing the business logic. Even though an "event" is technically occurring, it's typically not considered an event, since that's the default behavior of a form.
When Microsoft created the .NET framework, and integrated ASP into it, it created the ability for any web form to respond to events, such as a button click. As a result, since our submit button has an onclick event declared, when the button is "clicked", it causes an "event" to execute on the server, thus forcing our presentation file to look for the associated code behind file, locate our "event", and execute the business logic.
</p>
<h3>Examining the code</h3>
<p>Before creating and examining our code, it's important to understand that our code-behind file is being written in C# (pronounced C-sharp). C# was created by Microsoft in an attempt to compete with Sun Microsystems Java, both of which are object-oriented languages. The idea behind C# was to leverage the power of the C constructs, while leveraging the easy syntax of Visual Basic. As a result, all code-behind files for ASP.NET are written in object-orientated languages, which are then compiled by the server into efficient binary or dynamic link libraries. Continuing, you'll see the following:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
protected void SendMail(object sender, EventArgs e)
    {
        
    }
protected void Reset(object s, EventArgs e)
    {
       
    }
}
</code></pre>
<p>Starting from the beginning of the file, you'll notice many using statements. Since ASP was integrated in the .NET framework, it has access to all the classes and libraries; you just have to import them. In C#, you give your web form access to them by declaring using statements, which imports which classes you want your web form to have. The only one we need to add is the class for email, which is found in the System.Net.Mail namespace. Simply modify the code to include an additional using statement as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
</code></pre>
<h3>Understanding event handlers</h3>
<p>As we continue through the code, let's examine the event handlers:</p>
<ol>
<li>Protected: means any variables, or actions inside this event are protected from the rest of the application and aren't in scope to the rest of the page.</li>
<li>Void: means the event handler doesn't return a value.</li>
<li>Object sender: contains information about the event that's been triggered or executed</li>
<li>EventArgs e: contains information about the control that triggered the event to execute</li>
</ol>
<h3>Extending the Send Mail Event</h3>
<p>For us to collect the information entered in our form and send the mail to our specified recipient, we'll create a mail message object. We do this by adding the code shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
    }
</code></pre>
<p>As you can see from the example above, we want to create our object from the mail message class. At this point, in object-oriented languages, when you assign a variable with the new keyword, followed by a class constructor, you are said to be creating an instance of an object of that class. As a result, our object, mail, has access to all properties and methods of the mail message class.</p>
<h3>Setting the from address of our mail object</h3>
<p>When we send the mail to the specified recipient, we want to know who contacted us so that we can follow up with them at our convenience. Since we have an email text box that's used to collect our visitor's email address, we'll use that as a way to touch base with our client when the need arises. Let's modify our code as shown below:</p>
<pre><code>
protected void SendMail(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(EmailTB.Text);
    }
</code></pre>
<p>As you can see from the example above, we set the property, from, of our mail object to a new instance of the mail address class, and pass in our email text box control as an argument.</p>
<p>We'll continue by working on the Mail Message object <a href="default3.aspx">next</a>.</p>
</asp:Content>