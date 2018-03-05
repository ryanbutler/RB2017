<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a ASP.NET MVC Contact Form</h2>
<h3>Adjusting CSS</h3>
<p>From the solution explorer, open the CSS file by following these steps:</p>
<ol>
<li>Expand Content, and double -click Site.css</li>
</ol>
<p>Let’s first tackle our form fields. In Site.css, at line 427, comment out the following CSS:</p>
<pre><code>
/*input, textarea {
border: 1px solid #e2e2e2;
background: #fff;
color: #333;
font-size: 1.2em;
margin: 5px 0 6px 0;
padding: 5px;
width: 300px;
}
*/
</code></pre>
<p>Next, at line 453, comment out the following CSS:</p>
<pre><code>
/*input[type="submit"],
input[type="button"],
button {
background-color: #d3dce0;
border: 1px solid #787878;
cursor: pointer;
font-size: 1.2em;
font-weight: 600;
padding: 7px;
margin-right: 8px;
width: auto;
}
*/
</code></pre>
<p>Save your changes, and preview the results in a browser. It should look like this:</p>
<p class="alignCenter"><a href="images/14.png" data-lightbox="image-14"><img src="thumbs/14.png")" alt="Preview of Finished form" width="250" height="139" /></a></p>
<p>Once finished, return to Visual Studio and stop debugging by pressing the stop button or by pressing Shift + F5.</p>
<p>Add the following CSS at the end of our style sheet:</p>
<pre><code>
/* new styles */
div.row
{
clear:left;
margin:6px;
}
label
{
float:left;
width:200px;
}
textarea
{
width:200px;
height:100px;
}
div.buttons
{
margin-left:150px;
margin-top:16px;
}
</code></pre>
<p>As you can see from the code above, we:</p>
<ol>
<li>Create a class named row and assign the following property-values:
<ol type="A">
<li>Clear: set to left</li>
<li>Margin: set to 6 pixels</li>
</ol>
<li>Select our label form field and assign the following:
<ol type="A">
<li>Float: set to left</li>
<li>Width: set to 200 pixels</li>
</ol>
<li>Select our textarea form field, and assign the following:
<ol type="A">
<li>Width: set to 200 pixels</li>
<li>Height: set to 100 pixels</li>
</ol>
<li>Create a class named buttons, and assign the following:
<ol type="A">
<li>Margin left: set to 150 pixels</li>
<li>Margin top: set to 16 pixels</li>
</ol>
</li>
</ol>
<p>Save your changes. Results should be as illustrated in a web browser.</p>
<p class="alignCenter"><a href="images/15.png" data-lightbox="image-14"><img src="thumbs/15.png" alt="" width="250" height="170" /></a></p>
<p>Once finished, return to Visual Studio and stop debugging by pressing Stop or Shift + F5. Close Site.css within Visual Studio.</p>
<h3>Working with our controller</h3>
<p>As you might recall from earlier, our controller includes actions that cause our razor pages to display within the ASP MVC framework. When previewing our contact razor page, the reason it works initially is because we have an implicit GET action that returns our view. We can see this code by opening our HomeController.cs by following these steps:</p>
<p>From the solution explorer, expand Controllers, and then double - click HomeController.cs. In our controller, we see three implicit GET actions: (1) Index, (2) About, and (3) Contact. They simply
return a view, in our case, razor pages.</p>
<p>In ASP MVC, actions are either get or post. GET as already mentioned is the implied choice. A POST is when you cause a post back to occur on the server. The concept of post back is best described as code that we want to run on the server, such as validation of our form fields, emailing the recipient of a contact form results, or performing database operations. Put in another context, when posting to a server, a specific kind of business logic is occurring on the server before the resulting output is sent to the browser. In our case, the business logic is the initial validation check on our required fields, and then sending the mail to the specified recipient once validation passes. </p>
<h3>Adding the post action within our controller</h3>
<p>In HomeController.cs, add the following name space:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Mail;
</code></pre>
<p>The System.Net.Mail name space allows us to work with the mail and SMTP client class, which handles various functionality related to e-mailing the form’s results to a specified recipient. While we’re at it, let’s add a reference to our model:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Mail;
using Mvc4ContactForm.Models;
</code></pre>
<p>We'll continue by adding validation to our controller <a href="default4.aspx">next</a>.</p>
</asp:Content>