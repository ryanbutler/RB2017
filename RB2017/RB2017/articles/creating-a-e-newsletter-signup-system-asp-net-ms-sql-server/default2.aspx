<%@ Page Title="Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_e_newsletter_signup_system_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Create an E-newsletter Signup System with ASP.NET (ASPX) and MS SQL Server</h2>
<p>I've created labels and server-side controls for the information you need. To achieve a tabular look, add the following CSS:</p>
<pre><code>
#formLayout{
      width:400px;
      margin:20px auto;
      padding:10px;
}
</code></pre>
<p>As you can see, you give your container DIV the following property values:</p>
<ol>
<li>width of 400 pixels</li>
<li>top and bottom margin of 20 pixels</li>
<li>left and right of auto, which centers the form in your browser</li>
<li>padding of 10 pixels</li>
</ol>
<p>Continue by adding the following:</p>
<pre><code>
#formLayout label{
      float:left;
      padding:6px;
      margin:4px;
      font-size:.8em;
      width:200px;
}
</code></pre>
<p>In the code above, you float each label left, set padding to 6 pixels, set margin to 4 pixels, set font size to .8em, and set width to 200 pixels. Setting width to 200 pixels will force each of the corresponding text boxes to line up in unison. Save both your files.</p>
<p>Next, touch up the form a bit more by adding the following CSS:</p>
<pre><code>
#formLayout input{
      margin-top:10px;
}
.clear{
      clear:left;
}
legend{
      font-size:1.2em;
      color:#000;
}
h2{
      font-size:1.2em;
      text-align:center;
}</code>
</pre>
<p>In the code above, you set a top margin on your text boxes, create a class named clear and set it to clear left floats (your labels), set your legend to a slightly larger font size and color of black, and lastly, set your success message to an appropriate font size and center the text in the browser. After saving your CSS, add the following to your ASPX page:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;div id="formLayout"&gt;
&lt;fieldset&gt;
&lt;legend&gt;Enewletter   Sign Up&lt;/legend&gt;
&lt;label for="fName"&gt;First name:&lt;/label&gt;
&lt;asp:TextBox ID="fNameTB" runat="server" /&gt;
&lt;br class="clear" /&gt;
&lt;label for="lName"&gt;Last name:&lt;/label&gt;
&lt;asp:TextBox ID="lNameTB" runat="server" /&gt;
&lt;br class="clear" /&gt;
&lt;label for="email"&gt;E-mail Address:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;br class="clear" /&gt;
&lt;label for="newsletter"&gt;Subscribe to your newsletter?&lt;/label&gt;
&lt;asp:CheckBox ID="subscribeChkBox" runat="server"/&gt;
&lt;br class="clear"/&gt;
&lt;asp:Button ID="btnSubscribe" runat="server" OnClick="subscribe_Click" Text="Subcribe" /&gt;
&lt;/fieldset&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
</code></pre>
<p>Forcing each new label to clear the float above it emulates table rows visually. Save both files. Before you can preview the results, you need to open the code behind file for your ASPX page and add the following:</p>
<pre><code>
protected void subscribe_Click(object sender, EventArgs e)
{
}
</code></pre>
<p>Because you had an onclick attribute associated to your button, you have to add the corresponding server-side event handler. Otherwise, you will receive a run-time error when previewing. With this completed, save your files and preview the results.</p>
<h3>Validating Your Form</h3>
<p>For your purposes, you would like to ensure you get a first and a last name, along with an e-mail address. Validation typically takes place at two levels: (1) the client and (2) the server side. On the client side, you validate with JavaScript, because it provides instant feedback and incurs very little overhead. However, JavaScript validation can easily be circumvented because all modern browsers allow you to disable JavaScript, which leaves your form vulnerable. Server-side validation accounts for this. With server-side validation, you perform identical validation checks but on the server when you process the request to submit the information. The only tradeoff is the overhead you incur, which is usually negligible.</p>
<p>Before ASP.NET, the only option you had to perform client-side validation was creating a separate JavaScript file to do this in ASP. However, with ASP.NET, you can perform client-side validation with validation controls and then in your code behind file you can verify the same checks but use server-side validation. ASP.NET provides many different controls that make your life easier. It should be noted that you can still use other JavaScript tools such as JQuery but generally speaking, there's no need to in ASP.NET.</p>
<p>Validation can get very specific, but for your purposes, all you want to ensure is that the fields are not empty. Fortunately, the validation controls provided by the framework will work just fine.</p>
<h3>Create the Required Field Validator</h3>
<p>In your ASPX file, right below your first text box control, add the following control:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;div id="formLayout"&gt;
&lt;fieldset&gt;
&lt;legend&gt;Enewletter   Sign Up&lt;/legend&gt;
&lt;label for="fName"&gt;First name:&lt;/label&gt;
&lt;asp:TextBox ID="fNameTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvFName" runat="server" ControlToValidate="fNameTB" ErrorMessage="You must enter a first name!" /&gt;
&lt;br class="clear" /&gt;
</code></pre>
<p>As you can see from the code above, you have created a new control called required field validator with the following properties:</p>
<ol>
<li>ID=rfvName
<ul>
<li>Gives your control a unique name file</li>
</ul>
</li>
<li>Runat=server
<ul>
<li>Tells you this control is processed by the server, with HTML output sent back to the browser</li>
</ul>
</li>
<li>ControlToValidate=fNameTB
<ul>
<li>Tells you to validate your first name text box</li>
</ul>
</li>
<li>ErrorMessage
<ul>
<li>If a visitor leaves first name empty and presses submit, the error message shows in red</li>
</ul>
</li>
</ol>
<p>It should be noted that error messages will appear where the validation control resides. Add the other two as shown below in your complete form:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;asp:PlaceHolder ID="formPH" runat="server" Visible="true"&gt;
&lt;div id="formLayout"&gt;
&lt;fieldset&gt;
&lt;legend&gt;Enewletter   Sign Up&lt;/legend&gt;
&lt;label for="fName"&gt;First name:&lt;/label&gt;
&lt;asp:TextBox ID="fNameTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvFName" runat="server" ControlToValidate="fNameTB" ErrorMessage="You must enter a first name!" /&gt;
&lt;br class="clear" /&gt;
&lt;label for="lName"&gt;Last name:&lt;/label&gt;
&lt;asp:TextBox ID="lNameTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvLName" runat="server" ControlToValidate="lNameTB" ErrorMessage="You must enter a last name!" /&gt;
&lt;br class="clear" /&gt;
&lt;label for="email"&gt;E-mail Address:&lt;/label&gt;
&lt;asp:TextBox ID="emailTB" runat="server" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="emailTB" ErrorMessage="You must enter an email address!"/&gt;
&lt;br class="clear" /&gt;
&lt;label for="newsletter"&gt;Subscribe to your newsletter?&lt;/label&gt;
&lt;asp:CheckBox ID="subscribeChkBox" runat="server"/&gt;
&lt;br class="clear"/&gt;
&lt;asp:Button ID="btnSubscribe" runat="server" OnClick="subscribe_Click" Text="Subcribe" /&gt;
&lt;/fieldset&gt;
&lt;/div&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="successPH" runat="server" Visible="false"&gt;
&lt;h2&gt;You have successfully signed up for your newsletter!&lt;/h2&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>Note that you may want to use a regular expression on your e-mail address, just to ensure you have a valid pattern, but that's beyond the scope of this article. Check out regexlib.com for multiple examples. Save your file, preview the results, leave a couple of fields empty, and click subscribe. You should see error messages in red. If you want to reduce their font sizes, add the following to your style sheet:</p>
<pre><code>
span{
      font-size:.7em;
}
</code></pre>
<p>Save your style sheet and ASPX file.</p>
<p>We'll continue by establishing a connection to our database server <a href="default3.aspx">next</a>.</p>
</asp:Content>