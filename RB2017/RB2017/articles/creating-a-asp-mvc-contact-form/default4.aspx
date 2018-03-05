<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a ASP.NET MVC Contact Form</h2>
<h3>Adding validation to our controller</h3>
<p>Adding client-side and server-side validation to an MVC form is easy. First, let’s add the following code to our controller:</p>
<pre><code>
[HttpPost]
public ActionResult Contact(ContactModels c)
{
if (ModelState.IsValid)
{
}
return View();
}
</code></pre>
<p>By doing so, we:</p>
<ol>
<li>Annotate our method by using [HttpPost], which means we’re posting back to a server</li>
<li>Pass in our contact model class as a method parameter</li>
<li>Check our model state, using the model’s method call IsValid:
<ol type="A">
<li>If it’s true, we’ll try and send the e-mail</li>
<li>If it’s false, we’ll re-display the form and appropriate error messages</li>
</ol>
</li>
</ol>
<p>Save your changes.</p>
<h3>Adding validation to our model</h3>
<p>Let’s add the following name space:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
</code></pre>
<p>As you can see, we add System.ComponentModel.DataAnnotations, which gives us data annotations used in outputting error messages to our form using semantic HTML markup. </p>
<p>Next, we add the following annotations to our first name class variable:</p>
<pre><code>
public class ContactModels
{
[Required(ErrorMessage="First Name is required")]
public string FirstName { get; set; }
public string LastName { get; set; }
public string Email { get; set; }
public string Comment { get; set; }
}
</code></pre>
<p>We annotate our class variable with a required attribute followed by an appropriate error message.</p>
<h3>Adding validation to our form</h3>
<p>In our razor web page, add the following:</p>
<p class="alignCenter"><a href="images/razor6.png" data-lightbox="image-razor6"><img src="thumbs/razor6.png" alt="Razor Syntax 6" width="265" height="59" /></a></p>
<p>As you can see from the code above, we add:</p>
<ol>
<li>A validation summary at the beginning of the form and suppress the unordered list that would be shown by passing in the Boolean true.</li>
<li>A validation message to our form field that will output the error message from our model next to the field in error.</li>
</ol>
<p>Save your changes and view the results in a browser. When the form loads it’s OK as before. If we leave the form unfilled and press the submit button the following error message shows:</p>
<p class="alignCenter"><a href="images/16.png" data-lightbox="image-16"><img src="thumbs/16.png" alt="" width="250" height="143" /></a></p>
<p>Looking at our razor web page HTML markup we see the following:</p>
<p class="alignCenter"><a href="images/17.png" data-lightbox="image-17"><img src="thumbs/17.png" alt="" width="250" height="29" /></a></p>
<p>As shown above we have:</p>
<ol>
<li>A validation summary suppressed or not visible</li>
<li>An error message from the model written in a span tag</li>
<li>A CSS class that is styled to show a distinct error message next to the field in question</li>
</ol>
<p>One item to note is in our style sheet, if we look for field-validation-error, we’ll see existing CSS styles applied to it. This is so we can change our error messaging styling if needed.</p>
<h3>Unobtrusive JavaScript</h3>
<p>It should be noted that MVC is providing unobtrusive JavaScript validation natively. Unobtrusive JavaScript means we don’t have JavaScript form validation embedded in our razor page or HTML markup having an explicit onclick event. Instead, we have a &lt;span&gt; class that is injected with the correct CSS class used to style our error message in a clean, semantic output. </p>
<p>We can toggle this setting in our web.config located in the root of our solution, and shown below:</p>
<p class="alignCenter"><a href="images/22.png" data-lightbox="image-22"><img src="thumbs/22.png" alt="" width="266" height="53" /></a></p>
<p>Once finished, return to Visual Studio and stop debugging by pressing Stop or Shift + F5, and close web.config if opened.</p>
<h3>Summarizing validation model in MVC</h3>
<p>With our initial validation in place, let’s use the following illustration to clarify how validation is working in the MVC paradigm:</p>
<p class="alignCenter"><a href="images/18.png" data-lightbox="image-18"><img src="thumbs/18.png" alt="" width="250" height="113" /></a></p>
<p>Validation works in three steps:</p>
<ol>
<li>The visitor leaves required fields (first name) empty and presses submit button</li>
<li>The submit button calls our annotated HttpPost method, which checks the state of our model to determine if our form field is valid</li>
<li>During the model check, if no data is found, our model sends our error message back to the controller, which returns our initial view back to the screen, which gives us our error message</li>
</ol>
<p>Before moving forward, finish out the rest of the validation, ensuring the remaining fields are required. Use the existing solution file if you need guidance.</p>
<p>We'll continue by adding mail functionality to our controller <a href="default5.aspx">next</a>.</p>
</asp:Content>