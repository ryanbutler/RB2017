<%@ Page Title="Creating a ASP.NET Contact Form (ASPX)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_contact_form._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET Contact Form (ASPX)</h2>
<p>When developing a website for business, personal or organizational use, having a reliable, secure and intuitive way of ascertaining information from your visitors to better meet their needs, creating and developing a contact form is essential. Creating a form allows website owners to ask for specific information from the visitor in an effort to respond back to them in a way that seems meaningful and useful. However, if precautions are not taken, creating these forms can lead to abuse, misuse and incorrect information getting back to the business, person or organization, and in most cases, leading to a mess of unsolicited electronic mail that wreaks havoc on email systems.
</p>
<p>In this article, we will look at creating a ASP.NET contact form that will allow us to capture specific information that we need, validate form fields using client and server side languages to ensure that fields are not empty and then send the results to a specified recipient (s) that will allow them to respond to the visitor in depth when time and information permits. To do this, we need to download and install the .NET framework, understand client-server architecture and its relation to web programming. If you would like to learn how to create such a form, as well as learning about these concepts in-depth please follow along with the article below.</p>
<h3>Download and Install .NET Framework</h3>
<p>Open a web browser, and type download .net framework. Pick the latest web installer available from the search results.</p>
<h3>Download and Install Visual Studio</h3>
<p>Open a web browser, and type download visual studio community edition. Pick a relevant link that allows an operation to occur.</p>
<h3>Create the project solution</h3>
<p>Open Visual Studio, and from the main menu complete the following:</p>
<ol>
<li>File : New : Project</li>
<li>Choose Visual C#</li>
<li>Choose Web</li>
<li>ASP.NET Web Application (.NET Framework)</li>
<li>In the name text field, type Contact_Form</li>
<li>In the location, select a folder named Contact_Form</li>
<li>In the solution text field, Contact_Form is listed</li>
<li>Leave Create direction for solution checked</li>
<li>Click Ok</li>
</ol>
<h3>Creating the Web Form</h3>
<p>With the project solution open in Visual Studio, in order to create our contact form, complete the following steps:</p>
<ol>
<li>Right click on the solution</li>
<li>Choose Add : New Item</li>
<li>In the Add New Item Window, choose Web, Web Form with Master Page, and in the name text field, name the file contact.aspx</li>
<li>Click Add</li>
</ol>
<p>You will notice when the editor created our file, it created two:</p>
<ol>
<li>Contact.aspx</li>
<li>Contact.aspx.cs</li>
</ol>
<p>
The first file contains our presentational logic, such as HTML, CSS, JavaScript, our web and validation controls, while the second file contains our business logic such as event handlers that will send the email message to our specified recipient, and perform client and server-side validation.
</p>
<h3>Working with our presentation file (contact.aspx) first</h3>
<p>Even though these files are associated together, it often helps to work with them separately, and more importantly, work with the presentational file first, and then focus on making the form do what we want later. For the purposes of this article, we'll be working strictly from code view, as that's the best way to learn how the environment works.</p>
<h3>Creating and analyzing the form</h3>
<p>Inside the file, you'll notice that it looks just like any other HTML page. It has a normal HTML structure that you would expect, but behind this ordinary markup, there's a wealth of power and flexibility we'll tap into. You'll notice that by default our editor created a &lt;form&gt; tag. By default, all ASP.NET web forms have a form tag and we'll understand why that's important later in the article. Inside the opening and closing form tag, let's create a basic table structure that will collect first and last name, email, and comments from our visitor as shown below:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt; 
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt; 
&lt;head runat="server"&gt; 
&lt;title&gt;&lt;/title&gt; 
&lt;/head&gt; 
&lt;body&gt; 
&lt;form id="form1" runat="server"&gt; 
&lt;h3&gt;My Contact Form&lt;/h3&gt; 
&lt;table id="contact" cellspacing="0"&gt; 
&lt;tr&gt; 
&lt;td&gt;First Name:&lt;/td&gt; 
&lt;td&gt;&lt;/td&gt; 
&lt;/tr&gt; 
&lt;tr&gt; 
&lt;td&gt;Last Name:&lt;/td&gt; 
&lt;td&gt;&lt;/td&gt; 
&lt;/tr&gt; 
&lt;tr&gt; 
&lt;td&gt;Email:&lt;/td&gt; 
&lt;td&gt;&lt;/td&gt; 
&lt;/tr&gt; 
&lt;tr&gt; 
&lt;td&gt;Comments:&lt;/td&gt; 
&lt;td&gt;&lt;/td&gt; 
&lt;/tr&gt; 
&lt;/table&gt; 
&lt;/form&gt; 
&lt;/body&gt; 
&lt;/html&gt;
</code></pre>
<p>As you can see from the example above, we're dealing with an ordinary table with an ID that we can use for controlling the presentational aspect of our page, that is, a style sheet. However, for the purposes of this article, we'll focus on the ASP.NET environment in relation to the form.</p>
<h3>Client-server architecture demystified</h3>
<p>In the web environment, everything is initiated by using protocols, requests for services or a combination of both. Specifically, when working with server-side technologies on the web developers work in client-server architectures. That is, a client such as a local computer requests through an HTTP protocol that a file be sent to it from a server. In response, a server receives the request, accepts it, and finds the file and returns the file to the client.</p>
<p>In some website environments, the only responsibility the server has is accepting the request, and delivering the file to the client. In other website environments, when dynamic pages exist, such as pages that end in ASP, ASPX, the server accepts the request, notices the page has an ASP extension, and as a result, knows that it needs to read, interpret and parse any server-side code before sending the file back to the client with the parsed HTML included. For a little added clarity, the illustration below clarifies the process.</p>
<p class="alignCenter"><img src="images/client-server.gif" width="420" height="210" alt="Client - server architecture" /></p>
<p>At this point, you may be wondering how the server knows what to do with these special files. It all boils down to Internet Services Application Program Interface (ISAPI). Every web server has the ability for files to interface with it, specifically by installing dynamic link libraries (DLL) that contain code functions that instruct the web server to interpret the request, and if the file has certain extensions, then parse the server-side code before sending the result back to the browser.</p>
<h3>Understanding web controls</h3>
<p>If you're coming from the traditional ASP or PHP environment, the way you're used to developing form fields is vastly different in ASP.NET. Instead of using &lt;input&gt; tags, we use web controls. When Microsoft created ASP.NET, it basically reinvented web controls that run on the server-side, and then sends back an HTML equivalent. For example, a text box control is a web control that when parsed by the server generates an HTML input tag. When the generated HTML comes back from the server, the ASP.NET engine includes special values for each control, such as the name attribute, which comes from the ID of the control. We'll see more on that shortly. The most common types of web controls include:</p>
<ol>
<li>Text boxes</li>
<li>Radio buttons</li>	
<li>Drop down lists</li>
<li>Check boxes</li>
</ol>
<p>To create our ordinary input fields, we'll be using text box web controls. Let's add three of them to our file by using the code below:</p>
<pre><code>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head runat="server"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="form1" runat="server"&gt;
&lt;h3&gt;My Contact Form&lt;/h3&gt;
&lt;table id="contact" cellspacing="0"&gt;
&lt;tr&gt;
&lt;td&gt;First Name:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="FNameTB" runat="server" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Last Name:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="LNameTB" runat="server" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Email:&lt;/td&gt;
&lt;td&gt;&lt;asp:TextBox ID="EmailTB" runat="server" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Comments:&lt;/td&gt;
&lt;td&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>
<p>As you can see from the example above, our web control(s) look a bit odd, but really they're simple. Using the first one as an example, let's analyze it:</p>
<pre><code>
&lt;td&gt;&lt;asp:TextBox ID="FNameTB" runat="server" /&gt;&lt;/td&gt;
</code></pre>
<p>We nest the web control inside a table cell. The web control parts are:</p>
<ol>
<li>&lt;asp:TextBox&lt;/li&gt;
<ol>
<li>Instructs the ASP.NET engine to parse this control as in input field in HTML</li>
</ol>
</li>
<li>ID=FNameTB
<ol>
<li>Each web control must have a unique name. This also serves the purpose of accessing the controls properties and methods in our code-behind file</li>
</ol>
</li>
<li>Runat=server
<ol>
<li>Instructs the control to be run at the server</li>
</ol>
</li>
</ol>
<p>We purposely left the comments field alone for the moment, but we'll get to it in a moment.</p>
<p>We'll tackle viewing the results <a href="default2.aspx">next</a>.</p>
</asp:Content>