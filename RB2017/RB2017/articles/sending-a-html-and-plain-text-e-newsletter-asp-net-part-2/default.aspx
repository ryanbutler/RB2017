<%@ Page Title="Sending an HTML and Plain Text E-newsletter with ASP.NET (ASPX), Part 2" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.sending_a_html_and_plain_text_e_newsletter_asp_net_part_2._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Sending an HTML and Plain Text E-newsletter with ASP.NET (ASPX), Part 2</h2>
<p>In my previous article, <a href="../sending-a-html-and-plain-text-e-newsletter-asp-net/default.aspx">Sending an HTML and Plain Text E-newsletter with ASP.NET</a>, I discussed the steps involved in creating an ASP.NET page capable of sending a HTML or plain text email to a specified recipient. Furthermore, I demonstrated the Ajax toolset for preventing an email from being sent to the specified recipient more than once.</p>
<p>Now, it would be nice to re-engineer this page to send an email to multiple recipients when they click the submit button. In order to do this, you'll need a repository such as a database to store recipients' email addresses, and then you can use SQL queries to determine when to send the emails.</p>
<p>Knowing these specifications, you need to do the following:</p>
<ol>
<li>Create a database, preferably SQL Server (version doesn't matter)</li>
<li>Create a table with three fields</li>
<li>Re-engineer your web form to connect to the database table</li>
<li>Use SQL to query email recipients and then email them one by one</li>
</ol>
<p>f you would like to scrap your non-customized, off-the-shelf solution for a solution that you can modify and control as you see fit, then follow along.</p>
<h3>Open Microsoft SQL Server Management Studio</h3>
<p>In order to interact with your database, you need to have Microsoft's SQL Server Management Studio installed. If you don't have the professional version, you can use the free version by typing Microsoft SQL Server Management Studio in a Google search.</p>
<h3>Connect to the Database Server</h3>
<p>With SQL Server Management Studio open, you will be prompted with a database connection dialog screen (this one is displaying the default settings for my remote database server):</p>
<p class="alignCenter"><img src="images/SSMgtStudio_ServerConnex.jpg" width="410" height="312" alt="Connect To SQL Server Management Studio" /></p>
<p>The following fields are the ones you need to change:</p>
<ul>
<li>Server name: The name of your database server (Can be a qualified name or an IP address)</li>
<li>Authentication: Two types, SQL Server authentication or Windows authentication (For the purposes of this article, it will be the former.)</li>
<li>Login: Your user name</li>
<li>Password: The password associated with the above user name</li>
</ul>
<p>When all these fields are filled in, left-click the Connect button. When you are done, in the left-hand pane of SQL Server Management Studio, you should see your database server listed as shown below:</p>
<p class="alignCenter"><img src="images/DBServerListed.jpg" width="254" height="148" alt="Database server listed in SQL Server Management Studio" /></p>
<h3>Create the Database</h3>
<p>When you have connected to your database server, you can create your database by following these steps:</p>
<ol>
<li>Right-click databases</li>
<li>In the menu that shows, select New database.</li>
</ol>
<p>The new database window shows:</p>
<p class="alignCenter"><img src="images/NewDBWindow.jpg" width="693" height="626" alt="New Database Window" /></p>
<p>At the top of the window, there's one text field: database name. Simply type EmailRecipientsDB and left-click OK.</p>
<p>The newly created database should show in the tree under databases.</p>
<h3>Create the Table</h3>
<p>Now you can create a table:</p>
<ol>
<li>Left-click on the database.</li>
<li>Right-click on a table, which shows a context menu.</li>
<li>Select New Table, which shows the table window:</li>
</ol>
<p class="alignCenter"><img src="images/NewTableWindow.jpg" width="343" height="65" alt="New Table Window" /></p>
<p>In this table, add the following columns, along with their data types, as shown below:</p>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Allow Nulls: no</li>
<li>Identity: yes</li>
</ul>
</li>
</ol>
<p>To set the primary key, right-click on the ID column and left-click to select primary key. To set the identity, you must be inside the column window. From there, look in the column properties window that displays and select the plus (+) node next to Identity Specification as shown below:</p>
<p class="alignCenter"><img src="images/IdentitySpecificationNode.jpg" width="494" height="136" alt="Select Identity Specification Node" /></p>
<p>Simply click inside the second drop down list (Is Identity) and a drop menu icon will appear. Left-click and select Yes as shown below:</p>
<p class="alignCenter"><img src="images/Yes4(Is_Identity).jpg" width="497" height="96" alt="Yes Is Identity" /></p>
<p>From this point forward, each new record that is inserted into your table will have an automatic seed set, ensuring no two records are the same.</p>
<ol>
<li>Email
<ul>
<li>Data type: varchar</li>
<li>Field length: 50</li>
<li>Allow nulls: yes</li>
</ul>
</li>
</ol>
<ol>
<li>DateTime
<ul>
<li>Data type: datetime</li>
<li>Allow nulls: yes</li>
</ul>
</li>
</ol>
<p>When you have created the columns, enter a couple of email addresses and leave the date/time column null.</p>
<h3>Open the Project Solution</h3>
<p>If you have not opened Visual Studio, open it now from the desktop</p>
<ol>
<li>From the main menu, select File>Open Project/Solution.</li>
<li>Navigate to the solution file, SendEmail.sln.</li>
<li>Left-click to select OK.</li>
</ol>
<p>From the project solution, locate your web.config file in the solution explorer and double click the file to open it. Inside your configuration file, you should see the following near the top:</p>
<pre><code>
&lt;appSettings/&gt; 
&lt;connectionStrings /&gt; 
&lt;system.web&gt; 
</code></pre>
<p>You are concerned with the middle tag, connection strings. Modify the tag with the following code:</p>
<pre><code>
&lt;appSettings/&gt; 
&lt;connectionStrings&gt; 
  &lt;add name="mwdConnectionString" connectionString="Data Source=Remote Address;Initial Catalog=EmailRecipientsDB;User ID=user_name;Password=password" 
providerName="System.Data.SqlClient" /&gt; 
&lt;/connectionStrings&gt; 
&lt;system.web&gt; 
</code></pre>
<p>As you can see from the code above, I added a connection key (mwdConnectionString) to the connection string parent tag. You can change the connection if you want. The connection string is currently set to the following parameters:</p>
<ol>
<li>Data source: Set to your database server (qualified name or IP address)</li>
<li>Initial catalog: Set to the name of your database name</li>
<li>User ID: Set to your user name</li>
<li>Password: Set to your password</li>
</ol>
<p>From this point forward, you only need to reference the name of your key from any ASPX page that needs to connect to this database. This is handy because a normal web application might have multiple ASPX pages that need to work with this database. In my ASPX pages, I simply reference the mwdConnectionString key. This also alleviates maintenance headaches if your database server changes. Before closing the file, make sure you save your changes.</p>
<h3>Manipulate the sendemailsstart.aspx File</h3>
<p>In this file, replace this:</p>
<pre><code>
&lt;body&gt;
    &lt;form id="form1" runat="server"&gt;
    &lt;div&gt;
    
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/body&gt;
</code></pre>
<p>With this:</p>
<pre><code>
&lt;body&gt;
&lt;form id="form1" runat="server"&gt;
&lt;asp:Button ID="sendEmailBtn" runat="server" Text="Send Email" OnClick="sendEmailBtn_Click"/&gt;
&lt;/form&gt;
</code></pre>
<p>You simply added a server-side button control with an onclick event.</p>
<h3>Open sendemailsstart.aspx.cs and Add Name Spaces</h3>
<p>At the top of the c-sharp code-behind file, add the following using statements:</p>
<pre><code>
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
</code></pre>
<p>As you can see from the example above, by importing the first namespace, I can reference your configuration file, while the second namespace allows us to connect to a SQL Server database.</p>
<p>We'll continue by connecting to our database within C# sharp code <a href="default2.aspx">next</a>.</p>
</asp:Content>