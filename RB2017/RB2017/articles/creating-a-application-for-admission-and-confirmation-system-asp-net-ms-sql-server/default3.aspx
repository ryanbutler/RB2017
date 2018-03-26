<%@ Page Title="Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_registration_and_confirmation_system_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Application for admission and Confirmation System with ASP.NET and MS SQL Server</h2>
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
&lt;asp:PlaceHolder ID="phApplication" runat="server" Visible="true"&gt;
&lt;div class="row"&gt;
&lt;label for="Social Security Number"&gt;Social Security Number&lt;/label&gt;
&lt;asp:TextBox ID="ssn_3" runat="server" /&gt;
&lt;asp:TextBox ID="ssn_2" runat="server" /&gt;
&lt;asp:TextBox ID="ssn_4" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="First Name"&gt;First Name&lt;/label&gt;
&lt;asp:TextBox ID="FNameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Last Name"&gt;Last Name&lt;/label&gt;
&lt;asp:TextBox ID="LNameTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Email"&gt;Email:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;Street Address&lt;/div&gt;
&lt;asp:TextBox ID="streetAddressTB" runat="server" /&gt;
&lt;div class="row"&gt;
&lt;label for="Phone Number"&gt;Phone Number&lt;/label&gt;
&lt;asp:TextBox ID="phoneAreaCodeTB" runat="server" /&gt;
&lt;asp:TextBox ID="phoneNum3TB" runat="server" /&gt;
&lt;asp:TextBox ID="phoneNum4TB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Year Intend to Enroll"&gt;Year in which you intend to enroll?&lt;/label&gt;
&lt;asp:DropDownList ID="ddlyearIntendToEnrollTB" runat="server" /&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Current High School Student"&gt;Are you a current high school student?&lt;/label&gt;
&lt;asp:RadioButtonList ID="rblCurrentHighSchoolStudent" runat="server"&gt;
&lt;asp:ListItem Text="Yes" Value="Yes" /&gt;
&lt;asp:ListItem Text="No" Value="No" /&gt;
&lt;/asp:RadioButtonList&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="Graduating from High School"&gt;Are you graduating from high school?&lt;/label&gt;
&lt;asp:RadioButtonList ID="rblGraduatingHighSchool" runat="server"&gt;
&lt;asp:ListItem Text="Yes" Value="Yes" /&gt;
&lt;asp:ListItem Text="No" Value="No" /&gt;
&lt;/asp:RadioButtonList&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;label for="High School"&gt;Where are you attending high school?&lt;/label&gt;
&lt;asp:DropDownList ID="rblHighSchoolAttend" runat="server"/&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
&lt;asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /&gt;
&lt;input type="reset" value="Reset" /&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phSuccess" runat="server" Visible="false"&gt;
&lt;div id="success"&gt;
&lt;p&gt;Thank you for your application!&lt;/p&gt;
&lt;/div&gt;
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
body {
}

label {
    float: left;
    width: 270px;
    margin: 6px;
}

#form1 {
    width: 920px;
    margin: 0 auto;
}

div.row {
    clear: left;
}

#rblCurrentHighSchoolStudent{
    width:80px;
}
#rblCurrentHighSchoolStudent td label{
    width:20px;
}
#rblCurrentHighSchoolStudent input{
    margin-top:10px;
}

#rblGraduatingHighSchool{
    width:80px;
}
#rblGraduatingHighSchool td label{
    width:20px;
}
#rblGraduatingHighSchool input{
    margin-top:10px;
}
</code>
</pre>
<p>In our default.aspx page, add the reference to our style sheet as shown below:</p>
<pre><code>
&lt;head runat="server"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;style type="text/css" media="screen"&gt;
@import "style.css";
&lt;/style&gt;
</code>
</pre>
<p>If you haven't saved your file(s) yet, now is a good time to do so.</p>
<h3>Preview the projects solution</h3>
<p>Before we can preview the page, we need to add the code that's associated to our Submit button. Let's add this by adding the following code:</p>
<pre>
<code>
protected void btnSubmit_Click(object sender, EventArgs e)
  {
  }
</code>
</pre>
<p>Save your file. Run your project by pressing F5 and you should be able to enter data in each control; 
press the Reset button and each control should be reset to its initial value(s). 
When you're done, return to Visual Studio and press the Stop button (Shift + F5). Minimize Visual Studio for the time being.</p>
<p>We'll continue by populating the drop down lists <a href="default4.aspx">next</a>.</p>
</asp:Content>