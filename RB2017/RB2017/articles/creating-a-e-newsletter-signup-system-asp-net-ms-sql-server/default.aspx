<%@ Page Title="Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_e_newsletter_signup_system_asp_net_ms_sql_server._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server</h2>
<p>Creating a custom e-newsletter with common languages such as HTML, CSS, ASP.NET, and SQL Server is great, but it leaves out a key piece: allowing users to enter their information and decide whether they want to receive these newsletters. Using the steps I laid out in my previous two articles on Sending an HTML and Plain Text E-newsletter with ASP.NET, Part 2, you would have to manually enter all recipients that wanted to receive these newsletters, which is tedious and painful.</p>
<p>A better alternative is to create a user interface that collects basic user information such as first and last names and e-mail addresses, and presents a check box that lets users decide whether they want to sign up for periodic newsletters. You can also add personalization, formatting the introduction to reads as if the newsletter is intended for a specific individual, even though you send it to hundreds.</p>
<p>Furthermore, you can then provide a link at the bottom of the page that would allow the recipient to unsubscribe at any time, rather than requiring them to e-mail you. Using this approach, you save on data-entry time and allow the user to control whether they receive periodic e-mails without the hassle of maintenance.</p>
<p>The best part of these additions is you can use an existing SQL Server table (EmailRecipients) to make it work; you just need a few modifications. Download project files and follow along through this article to learn how to do this.</p>
<h3>Modify Your Database Table</h3>
<p>In SQL Management Studio, make sure you connect to your existing database server. When connected, expand the e-mail recipients database, and then expand the table folder icon, which will show the e-mail recipients table. Right click on the e-mail recipients table and select design, which will allow you to modify this table. You currently have three fields:</p>
<ol>
<li>ID</li>
<li>Email</li>
<li>DateTime</li>
</ol>
<p>Now add three more, using first name as your example. Right click on the gray rectangle box next to e-mail and select insert column as shown below:</p>
<p class="alignCenter"><img src="images/insert_column.jpg" width="206" height="147" alt="Insert Column"/></p>
<p>Use the following for the column:</p>
<ol>
<li>FName
<ul>
<li>Varchar(50), null</li>
</ul>
</li>
</ol>
<p>Using the same method, add the two other columns:</p>
<ol>
<li>LName
<ul>
<li>Varchar(50), null</li>
</ul>
</li>
<li>Subscribe
<ul>
<li>Bit, null</li>
</ul>
</li>
</ol>
<p>Before saving these additions, left click the gray rectangle box next to subscribe, and in the properties window, set the default value to 0 (false) as shown below:</p>
<p class="alignCenter"><img src="images/column_properties.jpg" width="206" height="147" alt="Column Properties" /></p>
<p>By default, bit fields in SQL are Boolean, meaning they're either yes or no. The reason for setting this by default to 0 (false) is you don't want to send the e-mail to the recipient unless they specifically check the box in your user form.</p>
<p>Save your table, close the table by right clicking the tab that displays the table name, and then minimize SQL Management Studio.</p>
<p>Note: When saving your table, if you receive an error saying SQL Management Studio has prevented the ability to save, do the following from the main menu:</p>
<ol>
<li>Tools:Options</li>
<li>Left click Designers in the options pane</li>
<li>On the right side, uncheck Prevent saving changes that require table re-creation</li>
</ol>
<h3>Work with the Send E-mail Solution</h3>
<p>In your send e-mail solution, right click on the project and select "add new item" as shown below:</p>
<p class="alignCenter"><img src="images/new_item.jpg" width="419" height="207" alt="Add New Item" /></p>
<p>In the "add new item" window, leave web form selected and in the file name, type "signup.aspx", and then click add. Next, right click on the solution, choose "add new item", and then select style sheet. In the file name, type "style.css". Double click signup.aspx to open it and remove everything inside the opening and closing &lt;form&gt; tag.</p>
<h3>Change the Title Tag</h3>
<p>Inside the opening and closing &lt;title&gt; tags, add the following:</p>
<pre><code>
&lt;title&gt;Enewsletter signup&lt;/title&gt;
</code></pre>
<h3>Add Reference to the Style Sheet</h3>
<p>Even though you haven't written any CSS, add the reference to it as shown below:</p>
<pre><code>
&lt;head runat="server"&gt;
&lt;title&gt;Enewsletter signup&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
&lt;/head&gt;
</code></pre>
<h3>Create Placeholder Controls</h3>
<p>Inside your opening &lt;form&gt; tag, create a placeholder control that will contain your form for collecting user information as shown below:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, you create your server-side control, aptly named Placeholder, with the following properties:</p>
<ol>
<li>ID=formPH
<ul>
<li>Gives your control a unique name and allows you to reference it from the code-behind file</li>
</ul>
</li>
<li>Runat=server
<ul>
<li>This control will be run by the server first, and then the HTML output will be sent to the browser</li>
</ul>
</li>
<li>Visible=true
<ul>
<li>Sets the visibility of your form contents to show</li>
</ul>
</li>
</ol>
<p>Now, add one more Placeholder below your original Placeholder as shown below:</p>
<pre><code>
&lt;asp:PlaceHolder ID="successPH" runat="server" Visible="false"&gt;
&lt;h2&gt;You have successfully signed up for your newsletter!&lt;/h2&gt;
&lt;/asp:PlaceHolder&gt;
</code></pre>
<p>This Placeholder will be shown instead of your original one when the user submits his or her information. Think of it as a confirmation that everything was successful.</p>
<p>Your form up to this point should look like this:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="successPH" runat="server" Visible="false"&gt;
&lt;h2&gt;You have successfully signed up for your newsletter!&lt;/h2&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<h3>Create the Form</h3>
<p>You could create the form inside a table, but this form is relatively easy and so is the CSS to do it. Start by adding the following inside your Placeholder control:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;div id="formLayout"&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>I've omitted the second Placeholder for brevity. As you can see from the code above, you have created a container DIV with an ID of formLayout that will hold your form contents. Now, create the rest of the form as shown below:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;div id="formLayout"&gt;
&lt;fieldset&gt;
&lt;legend&gt;Enewletter   Sign Up&lt;/legend&gt;
&lt;label for="fName"&gt;First name:&lt;/label&gt;
&lt;asp:TextBox ID="fNameTB" runat="server" /&gt;
&lt;label for="lName"&gt;Last name:&lt;/label&gt;
&lt;asp:TextBox ID="lNameTB" runat="server" /&gt;
&lt;label for="email"&gt;E-mail Address:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;label for="newsletter"&gt;Subscribe to your newsletter?&lt;/label&gt;
&lt;asp:CheckBox ID="subscribeChkBox" runat="server"/&gt;
&lt;asp:Button ID="btnSubscribe" runat="server" OnClick="subscribe_Click" Text="Subcribe" /&gt;
&lt;/fieldset&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>We'll continue by adding the CSS to the project <a href="default2.aspx">next</a>.</p>
</asp:Content>