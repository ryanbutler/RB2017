<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create the Style Sheet and the Markup</h3>
<p>Take these steps to creat a style sheet:</p>
<ol>
<li>From the Solution Explorer, right click our project name and choose Add:New Item</li>
<li>From the Add New Item window, select Style sheet.</li>
<li>In the name text box, type "style.css" and click OK.</li>
</ol>
<p>To focus a bit more attention on the code and other new aspects in this article, let's just copy and paste the markup below:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;div class="row"&gt;
&lt;label for="firstName"&gt;First Name:&lt;/label&gt;    
&lt;asp:TextBox ID="fnameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="lastName"&gt;Last Name:&lt;/label&gt;
&lt;asp:TextBox ID="lnameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="email"&gt;Email:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="severity"&gt;Severity:&lt;/label&gt;
&lt;asp:DropDownList ID="ddlSeverity" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="status"&gt;Status:&lt;/label&gt;
&lt;asp:DropDownList ID="ddlStatus" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="department"&gt;Department:&lt;/label&gt;
&lt;asp:DropDownList ID="ddlDept" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="employee"&gt;Assigned to:&lt;/label&gt;
&lt;asp:DropDownList ID="ddlEmp" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="comments"&gt;Comments:&lt;/label&gt;
&lt;asp:TextBox ID="commentsTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /&gt;
&lt;asp:Button ID="btnClear" runat="server" Text="Clear" OnClientClick="clear_Fields();" /&gt;
&lt;/div&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, we added div tags with a class name of row for each row of data. Note that the two button controls at the end serve two different purposes. The first button -- for submission help desk tickets -- has a server-side event handler, which is denoted by the onClick attribute. This means the event handler for this button will be placed in the code behind file default.aspx.</p>
<p>The second button is to reset our form fields to their initial values. We could reset them using a server-side event but we don't need that server-side event. As a result, we have used a client-side event handler, which is denoted by the OnClientClick attribute. This means the event handler for this button will be placed in a JavaScript file and be ran only on the client.</p>
<p>Let's add the neccessary CSS as shown below:</p>
<pre><code>
body
{
}
label{
      float:left;
      width:200px;
      margin:6px;
}
#form1{
      width:420px;
      margin:0 auto;
}
div.row{
      clear:left;
}
#commentsTB{
      width:200px;
      height:100px;
}
</code></pre>
<p>In our default.aspx page, add the reference to our style sheet as shown below:</p>
<pre><code>
&lt;head runat="server"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "styles.css";
&lt;/style&gt;
</code></pre>
<p>If you haven't saved your file(s) yet, now is a good time to do so.</p>
<h3>Creating the JavaScript File</h3>
<p>Because creating the JavaScript file is the easiest of the work left, we'll do this next. From the Solution Explorer, follow these steps:</p>
<ol>
<li>Right click on the project name.</li>
<li>Choose Add:New Item.</li>
<li>In the Add New Item window, select Jscript File.</li>
<li>In the name text box, name the file clear.js.</li>
</ol>
<h3>Reference the JavaScript File</h3>
<p>We need to reference the JavaScript file so our page knows JavaScript is there. Let's add the code to do this as shown below:</p>
<pre><code>
&lt;head runat="server"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "styles.css";
&lt;/style&gt;
&lt;script type="text/javascript" src="clear.js"&gt;
&lt;/script&gt;
&lt;/head&gt;
</code></pre>
<p>As you can see from the code above, we reference our JavaScript file right below our ending style tag.</p>
<h3>Writing the JavaScript Reset Functionality</h3>
<p>From the Solution Explorer, double click clear.js to open the file and add the following code:</p>
<pre><code>
function clear_Fields() {
    document.getElementById("fnameTB").value = '';
    document.getElementById("lnameTB").value = '';
    document.getElementById("emailTB").value = '';
    document.getElementById("ddlSeverity").options.length = 0;
    document.getElementById("ddlStatus").options.length = 0;
    document.getElementById("ddlDept").options.length = 0;
    document.getElementById("commentsTB").value = '';
    document.getElementById("ddlEmp").options.length = 0;
}
</code></pre>
<p>As you can see from the code above, we create a function named clear_Fields. Inside the fucntion, we grab each of our controls by its unique ID and set its value to an empty string (except for our dropdown lists, which we set to zero). Save your file(s).</p>
<h3>Preview the projects solution</h3>
<p>Before we can preview the page, we need to add the code that's associated to our Submit button. Let's add this by adding the following code:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
  {
  }
</code></pre>
<p>Save your file. When you initially run the project, you'll see the window in Figure 3.</p>
<p class="alignCenter"><img src="images/DebuggingNotEnabled.jpg" width="494" height="234" alt="Debugging Not Enabled" /></p>
<p>Click OK and you should be able to enter data in each control; press the Clear button and each control should be reset to its initial value(s). When you're done, return to Visual Studio and press the Stop button (Shift + F5). Minimize Visual Studio for the time being.</p>
<p>We'll continue by populating the drop down lists <a href="default4.aspx">next</a>.</p>
</asp:Content>