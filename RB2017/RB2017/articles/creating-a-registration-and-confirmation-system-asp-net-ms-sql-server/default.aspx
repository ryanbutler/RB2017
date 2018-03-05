<%@ Page Title="Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_registration_and_confirmation_system._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server</h2>
<p>In today's social networking world, relying on past methods of contact is pretty much a lost cause. More people are relying on Facebook and Twitter to stay informed. While you can use a Facebook event to let a group of acquaintances -- say, alumni from your high school graduating class -- register for an event, it's not nearly as flexible as a customized application. Developing a customized Web application that allows for registration and then sends an email confirmation is relatively simple using ASP.NET.</p>
<p>When planning to develop this type of application, one requirement is apparent: a basic form that will collect first and last name, email address, and a few other options to confirm whether the alumni are attending dinner and how much it will cost. When they submit the information, you can store that information in a database, as well as send them an email confirming those details.</p>
<p>If you would like to learn how to build an application like this, read on. You'll need Visual Studio and MS SQL Server </p>
<h3>Create the Database</h3>
<p> From the desktop, follow these steps to open SQL Server:</p>
<ol>
<li>Start : Programs : SQL Server : SQL Server Management Studio. </li>
<li>Connect to your local database server.</li>
<li>Create your database by right clicking on databases and selecting New database as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig1.PNG" width="338" height="104" alt="New Database" /></p>
<ol start="4">
<li>Give your database a name of mwd and click OK. </li>
</ol>
<h3>Create the Main Table</h3>
<p>To create your tables, follow these steps:</p>
<ol>
<li>Click the plus (+) sign next to your database as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig2.png" width="198" height="84" alt="Picture of database" /></p>
<ol>
<li>Right click on Tables, and select "New Table" as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig3.png" width="262" height="136" alt="New Table" /></p>
<p>Create your table, registration, first. You need the following columns:</p>
<ol>
<li>ID
<ul>
<li>Primary key</li>
<li>Data type: int</li>
<li>Not null</li>
</ul>
</li>
<li>FName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>LName
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>Email
<ul>
<li>Data type: varchar(50)</li>
<li>Null</li>
</ul>
</li>
<li>MailAddress
<ul>
<li>Data type: varchar(100)</li>
<li>Null</li>
</ul>
</li>
<li>Attending
<ul>
<li>Data type: bit</li>
<li>Null</li>
</ul>
</li>
<li>Dinner
<ul>
<li>Data type: varchar(2)</li>
<li>Null</li>
</ul>
</li>
<li>Date
<ul>
<li>Data type: datetime</li>
<li>Null</li>
</ul>
</li>
<li>WhyNotAttend
<ul>
<li>Data type: varchar(100) </li>
<li>Null</li>
</ul>
</li>
<li>HowManyAttending
<ul>
<li>Data type: char(1) </li>
<li>Null</li>
</ul>
</li>
<li>TotalCost
<ul>
<li>Data type: money</li>
<li>Null</li>
</ul>
</li>
</ol>
<p>Before continuing, be sure to set the primary key by right clicking the column (ID) and choosing primary key as shown below:</p>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig4.png" width="210" height="51" alt="Set Primary Key" /></p>
<p>While you're at it, set the seed on this column as well by setting Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig5.png" width="616" height="65" alt="Is Identity" /></p>
<p>Minimize SQL Server Management Studio. You're done with it for the time being.</p>
<h3>Create the Project</h3>
<p>Open Visual Studio from the desktop as follows: Start -> Programs -> Microsoft Visual Studio. From the main menu, create a new project by following these steps:</p>
<ol>
<li>File : New : Project</li>
<li>In the New Project window, under the Visual C# tree, choose Web and then ASP.NET Web Application.</li>
<li>In the name text box, name your project "Registration."</li>
<li>Leave "Create a directory for solution" checked.</li>
<li>Click OK.</li>
</ol>
<p>After the project is created, you'll have one ASPX file and a web.config.</p>
<p>From the solution explorer, double click web.config and look for &lt;connectionStrings&gt;. Replace the default markup with the following:</p>
<pre><code>
&lt;connectionStrings&gt;
&lt;add name="mwd" connectionString="Data Source=P425\SQLExpress;Initial Catalog=mwd;Integrated Security=SSPI;"/&gt;
&lt;/connectionStrings&gt;
</code></pre>
<p>Simply replace the value inside the double quotes for connection string with your settings. When completed, save your file.</p>
<p>From the solution explorer, double click default.aspx and remove everything between the opening and closing &lt;form&gt; tags. Replace with the following markup:</p>
<pre><code>
&lt;form id="form1" name="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="phForm" runat="server"&gt;
&lt;div id="formLayout"&gt;
&lt;fieldset&gt;
&lt;legend&gt;High School Reunion&lt;/legend&gt;
&lt;div class="row"&gt;
&lt;label for="FirstName"&gt;First Name:&lt;/label&gt;
&lt;asp:TextBox ID="fnameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="LastName"&gt;Last Name:&lt;/label&gt;
&lt;asp:TextBox ID="lnameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Email"&gt;Email:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Attending"&gt;Attending reunion?&lt;/label&gt;
&lt;asp:RadioButtonList ID="rbAttending" runat="server" AutoPostBack="true"&gt;
&lt;asp:ListItem Value="Yes"&gt;Yes&lt;/asp:ListItem&gt;
&lt;asp:ListItem Value="No"&gt;No&lt;/asp:ListItem&gt;
&lt;/asp:RadioButtonList&gt;
&lt;/div&gt;
&lt;asp:PlaceHolder ID="phAttending" runat="server" Visible="false"&gt;
&lt;div class="row"&gt;
&lt;label for="MailingAddress"&gt;Mailing address:&lt;/label&gt;
&lt;asp:TextBox ID="mailTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Dinner Option"&gt;Dinner option?&lt;/label&gt;
&lt;asp:RadioButtonList ID="rbDinnerOpt" runat="server"&gt;
&lt;asp:ListItem Value="20"&gt;20$ Steak&lt;/asp:ListItem&gt;
&lt;asp:ListItem Value="30"&gt;30$ Chicken&lt;/asp:ListItem&gt;
&lt;asp:ListItem Value="40"&gt;40$ Seafood&lt;/asp:ListItem&gt;
&lt;/asp:RadioButtonList&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="How Many Attending"&gt;How many are attending?&lt;/label&gt;
&lt;asp:TextBox ID="howmanyAttendingTB" runat="server"/&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phWhyNotAttending" runat="server" Visible="false"&gt;
&lt;div class="row"&gt;
&lt;label for="Why Not Attending"&gt;Why are you not attending?&lt;/label&gt;
&lt;asp:TextBox ID="whyNotTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/fieldset&gt;
&lt;div class="row"&gt;
&lt;div class="buttoncontainer"&gt;
&lt;asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="buttons" /&gt;
&lt;asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="buttons" OnClientClick="clear_Fields();" /&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phSuccess" runat="server" Visible="false"&gt;
&lt;div id="success"&gt;
&lt;p&gt;Thank you for your registration!&lt;/p&gt;
&lt;p&gt;&lt;a href="Default.aspx"&gt;Need to register again?&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phFailure" runat="server" Visible="false"&gt;
&lt;p&gt;Sorry, you have done wrong, please try again.&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, you create two placeholder controls: your initial placeholder, which contains your initial form contents, and your second, which contains your success message.</p>
<p>Your initial placeholder contains two additional placeholders: phAttending and phWhyNotAttending. The first one will show if the visitor selects the yes button on your radio button list. The other one will show if the user select the no button. The radio button list has an attribute AutoPostBack set to true, which will take care of programmatically showing or hiding the appropriate placeholders.</p>
<p>Your buttons have submit and reset options. Your submit button has an attribute of OnClick set to an appropriate method, which is a server-side event. Your reset button has an attribute of OnClientClick set to an appropriate method, which is a client-side event.</p>
<p>Before you can run the project, you need to add the submit event handler to your code behind file. From the solution explorer, click the plus sign (+) next to default.aspx and then double-click default.aspx.cs.</p>
<p>Write the submit event handler as shown below after the page load event:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
{
}
</code></pre>
<p>Save your file(s).</p>
<p>We'll continue by writing the toggle functionality <a href="default2.aspx">next</a>.</p>
</asp:Content>