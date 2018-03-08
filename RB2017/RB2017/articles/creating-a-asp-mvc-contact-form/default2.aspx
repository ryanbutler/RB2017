<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET MVC Contact Form</h2>
<h3>Adjusting our contact view</h3>
<p>
In the MVC paradigm, views are a special type of file that contain HTML 5 markup, and are capable of including razor syntax that can be used to work with models.
</p>
<p>From the solution explorer, open Contact.cshtml by expanding Views: Home, and then double-click Contact.cshtml. Remove the initial HTML 5 markup, and add the following:</p>
<pre><code>
@{
    ViewBag.Title = "Contact";
    Layout = "~/Views/Shared/_Layout.cshtml";
}
</code></pre>
<p>As you can see, we assign our title using the dynamic object ViewBag, and assign our base template. While in the editor, press F5 to preview your website, which should show an empty screen. If you left-click contact, you should see an empty page. Stop debugging by pressing the Stop button or Shift + F5.</p>
<p>Inside our razor file, just below the closing curly brace, add the following:</p>
<pre><code>
&lt;h1&gt;contact us&lt;/h1&gt;
@using (Html.BeginForm())
{
}
 </code></pre>
<p>As you can see, we added:</p>
<ol>
<li>A heading one tag, to serve as our page title</li>
<li>A using statement, followed by Html.BeginForm, which instructs MVC to create an opening &lt;form&gt; and closing &lt;/form&gt; tags.</li>
</ol>
<p>Save your changes. </p>
<p>From the contact screen, right-click, and choose View Source. In the source of the markup, you’ll see the changes as illustrated:</p>
<p class="alignCenter"><a href="images/view_browser.png" data-lightbox="image-7"><img src="thumbs/view_browser.png" alt="View Source" width="400" height="80" /></a></p>
<h3>Adding model reference to contact.cshtml</h3>
<p>For our form fields to bind the data entered to our model, we need to add a reference to our model from our razor web page. We do this by adding the following snippet to the top of our razor web page:</p>
<pre><code>
@model MvcContactForm.Models.ContactModels
</code>
</pre>
<p>Inside our using block, add the following HTML markup:</p>
<pre><code>
@using (Html.BeginForm())
{
&lt;div class="row"&gt;
  @Html.LabelFor(model => model.FirstName, "First Name")
  @Html.EditorFor(model => model.FirstName)
&lt;/div&gt;
</code></pre>
<p>As you can see:</p>
<ol>
<li>We added a DIV with a class of row
<li>Used razor’s built-in Html helper object for both the label and edit control and then passed in our model and corresponding class variable using a lambda expression</li>
</ol>
<p>Save your changes. Results should be as illustrated in a web browser.</p>
<p class="alignCenter"><a href="images/11.png" data-lightbox="image-11"><img src="thumbs/11.png" alt="Preview results" width="250" height="163" /></a></p>
<p>If we view source on our razor web page, we see the following illustrated:</p>
<p class="alignCenter"><a href="images/12.png" data-lightbox="image-12"><img src="thumbs/12.png" alt="Code view" width="279" height="30" /></a></p>
<p>As you can see from the illustration above, our helper Html object generated HTML 5 markup, with the appropriate attributes. When finished previewing, return to Visual Studio and stop debugging by either pressing the stop button or pressing Shift + F5. </p>
<p>Inside in our razor view, let’s finish the remaining three form fields by adding the following code:</p>
<pre><code>
@using (Html.BeginForm())
{
&lt;div class="row"&gt;
  @Html.LabelFor(model => model.FirstName, "First Name")
  @Html.EditorFor(model => model.FirstName)
&lt;/div>
&lt;div class="row"&gt;
@Html.LabelFor(model=>model.LastName, "Last Name")
@Html.EditorFor(model=>model.LastName)
&lt;/div>
&lt;div class="row"&gt;
@Html.LabelFor(model=>model.Email, "Email")
@Html.EditorFor(model=>model.Email)
&lt;/div>
&lt;div class="row"&gt;
@Html.LabelFor(model=>model.Comment, "Comments")
@Html.TextAreaFor(model=>model.Comment)
&lt;/div>
&lt;div class="row"&gt;
&lt;input type="submit" value="submit"/&gt;
&lt;input type="reset" value="reset"/&gt;
&lt;/div>
}
</code></pre>
<p>One item to note in the above code is the use of the text area built-in control. We use this control instead of our editor to allow our visitors more room for comments than a regular text field would allow. </p>
<p>Save your changes. Results should be as illustrated in a web browser.</p>
<p class="alignCenter"><a href="images/13.png" data-lightbox="image-13"><img src="thumbs/13.png" alt="Code view" width="250" height="180" /></a></p>
<p>As you can see, from a GUI perspective our form is essentially finished. Return to Visual Studio and stop debugging. </p>
<p>Now let’s tackle some cascading style sheets (CSS) changes to adjust the look and feel a bit better.</p>
<p>We'll continue by adjusting our CSS <a href="default3.aspx">next</a>.</p>
</asp:Content>