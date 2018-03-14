<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create the Style Sheet and the Markup</h3>
<p>Take these steps to create a style sheet:</p>
<ol>
<li>From the Solution Explorer, right click our project name and choose Add:New Item</li>
<li>From the Add New Item window, from the left pane, choose Web.</li>
<li>From the right pane, choose Style Sheet</li>
<li>In the name text box, type style.css and click OK.</li>
</ol>
<p>To focus a bit more attention on the code and other new aspects in this article, let's just copy and paste the markup below
inside our first place holder control:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="phForm" runat="server" Visible="true"&gt;
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
&lt;label for="title"&gt;Title:&lt;/&lt;label&gt;
&lt;asp:TextBox ID="titleTB" runat="server" /&gt;
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
&lt;label for="summary"&gt;Summary:&lt;/label&gt;
&lt;asp:TextBox ID="summaryTB" runat="server" TextMode="MultiLine" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /&gt;
&lt;input type="reset" value="Reset" /&gt;
&lt;/div&gt;
&lt;/asp:Placeholder&gt;
&lt;asp:PlaceHolder ID="phSuccess" runat="server" Visible="false"&gt;
&lt;p&gt;Ticket submitted successfully.&lt;/&lt;p&gt;
&lt;p&gt;&lt;a href="Default.aspx"&gt;Submit another ticket&lt;/&lt;a&gt;&lt;/&lt;p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, we added div tags with a class name of row for each row of data. 
Note that the two button controls at the end serve two different purposes. The first button -- for submission help desk tickets -- 
has a server-side event handler, which is denoted by the onClick attribute. This means the event handler for this button 
will be placed in the code behind file default.aspx.</p>
<p>The second button is to reset our form fields to an empty value.</p>
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
#summaryTB{
      width:200px;
      height:100px;
}
</code></pre>
<p>In our default.aspx page, add the reference to our style sheet as shown below:</p>
<pre><code>
&lt;head runat="server"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
</code></pre>
<p>If you haven't saved your file(s) yet, now is a good time to do so.</p>
<h3>Preview the projects solution</h3>
<p>Before we can preview the page, we need to add the code that's associated to our Submit button. Let's add this by adding the following code:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
  {
  }
</code></pre>
<p>Save your file. Run your project by pressing F5 and you should be able to enter data in each control; 
press the Reset button and each control should be reset to its initial value(s). 
When you're done, return to Visual Studio and press the Stop button (Shift + F5). Minimize Visual Studio for the time being.</p>
<p>We'll continue by populating the drop down lists <a href="default4.aspx">next</a>.</p>
</asp:Content>