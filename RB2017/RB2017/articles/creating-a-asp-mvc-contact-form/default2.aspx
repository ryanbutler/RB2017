<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a ASP.NET MVC Contact Form</h2>
<h3>Adjusting our contact view</h3>
<p>
In the MVC paradigm, views are a special type of file that contain HTML 5 markup, and are capable of including razor syntax that can be used to work with models.
</p>
<p>
From the solution explorer, open Contact.cshtml by expanding Views: Home, and then double-click Contact.cshtml. Remove the initial HTML 5 markup, once finished, your razor file should look like this:
</p>
<p class="alignCenter"><a href="images/razor1.png")" data-lightbox="image-razor1"><img src="thumbs/razor1.png" alt="Razor Syntax 1" width="296" height="38" /></a></p>
<p>As you can see, we assign our title using the dynamic object ViewBag, and assign our base template. While in the editor, press F5 to preview your website, which should show this screen:</p>
<p class="alignCenter"><a href="images/5.png" data-lightbox="image-5"><img src="thumbs/5.png" alt="Preview Page" width="207" height="77" /></a></p>
<p>If you left-click contact, you should see an empty page:</p>
<p class="alignCenter"><a href="images/6.1.png")" data-lightbox="image-6.1"><img src="thumbs/6.1.png" alt="Preview empty page" width="281" height="49" /></a></p>
<p>Stop debugging by pressing the Stop button or Shift + F5.</p>
<p>Inside our razor file, just below the closing curly brace, add the following:</p>
<p class="alignCenter"><a href="images/razor2.png" data-lightbox="image-razor2"><img src="thumbs/razor2.png" alt="Razor Syntax 2" width="296" height="73" /></a></p>
<p>As you can see, we added:</p>
<ol>
<li>A heading one tag, to serve as our page title</li>
<li>A using statement, followed by Html.BeginForm, which instructs MVC to create an opening &lt;form&gt; and closing &lt;/form&gt; tags.</li>
</ol>
<p>Save your changes. </p>
<p>From the contact screen, right-click, and choose View Source. In the source of the markup, you’ll see the changes as illustrated:</p>
<p class="alignCenter"><a href="images/7.png" data-lightbox="image-7"><img src="thumbs/7.png" alt="View Source" width="260" height="38" /></a></p>
<h3>Adding model reference to contact.cshtml</h3>
<p>For our form fields to bind the data entered to our model, we need to add a reference to our model from our razor web page. We do this by adding the following snippet to the top of our razor web page:</p>
<p class="alignCenter"><a href="images/razor3.png" data-lightbox="image-razor3"><img src="thumbs/razor3.png" alt="Razor Syntax 3" width="296" height="82" /></a></p>
<p>Be sure to take advantage of code hints in the razor view by first typing (at) model, then typing the name of our solution, followed by the hierarchy of classes you’re after as illustrated below:</p>
<p class="alignCenter"><a href="images/10.png" data-lightbox="image-10"><img src="thumbs/10.png" alt="View Code Hints" width="250" height="159" /></a></p>
<p>Inside our using block, add the following HTML markup:</p>
<p class="alignCenter"><a href="images/razor4.png" data-lightbox="image-razor4"><img src="thumbs/razor4.png" alt="Razor Syntax 4" width="262" height="97" /></a></p>
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
<p class="alignCenter"><a href="images/razor5.png" data-lightbox="image-razor5"><img src="thumbs/razor5.png" alt="Code view" width="300" height="215" /></a></p>
<p>One item to note in the above code is the use of the text area built-in control. We use this control instead of our editor to allow our visitors more room for comments than a regular text field would allow. </p>
<p>Save your changes. Results should be as illustrated in a web browser.</p>
<p class="alignCenter"><a href="images/13.png" data-lightbox="image-13"><img src="thumbs/13.png" alt="Code view" width="250" height="180" /></a></p>
<p>As you can see, from a GUI perspective our form is essentially finished. Return to Visual Studio and stop debugging. </p>
<p>Now let’s tackle some cascading style sheets (CSS) changes to adjust the look and feel a bit better.</p>
<p>We'll continue by adjusting our CSS <a href="default3.aspx">next</a>.</p>
</asp:Content>