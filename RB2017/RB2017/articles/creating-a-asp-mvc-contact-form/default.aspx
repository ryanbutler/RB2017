<%@ Page Title="Creating a ASP.NET MVC Contact Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.creating_a_asp_mvc_contact_form._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a ASP.NET MVC Contact Form</h2>
<p>Over the last few years, Microsoft’s investment in transforming Active Server Pages from a basic scripting language into an object oriented language with .NET integration has been remarkable. Some noteworthy features in traditional web forms are the ability to maintain page state on a page refresh, the ability to bind (associate) data to a standard set of web controls, and separation of code between a web form and code-behind.</p>
<p>Microsoft has invested resources lately into transforming traditional ASP.NET web forms into a new paradigm. ASP MVC (Model View Controller) is the new programming model that developers use, and it provides:</p>
<ol>
<li>Complete n-tier separation of responsibilities with regard to data from a model</li>
<li>Complete control of our presentational markup with semantic HTML 5 markup from a view</li>
<li>A business logic to map model, view together in the form of a controller</li>
<li>A JavaScript library (JQuery)</li>
</ol>
<p>In this article we’ll create a simple ASP MVC contact form that will validate and email the message contents to any desired recipient. You will have a functional MVC contact form with validation, providing a means to lead visitors to your form again and again. </p>
<table class="articles" summary="project files">
<tr>
<td colspan="2" class="header">Download Project Files </td>
</tr>
<tr>
<td colspan="2" class="caption"><a href="" target="_blank">Source Files</a></td>
</tr>
</table>
<h3>Download and Install .NET Framework</h3>
<p>Open a web browser, and type download .net framework. Pick the latest version of the framework and the offline installer.</p>
<h3>Download and Install Visual Studio</h3>
<p>Open a web browser, and type download visual studio community edition. Choose the first link that shows in the search results and then download Visual Studio Community.</p>
<h3>Start Visual Studio</h3>
<p>From the desktop:</p>
<ol>
<li>Start Microsoft Visual Studio</li>
<li>From the start page, left click File : New : Project</li>
<li>From the New Projects window, choose Web and ASP.NET MVC Web Application (.NET Framework):</li>
</ol>
<p>In the name, location and solution name text fields, choose the following:</p>
<ol>
<li>In the Name text field, type MvcContactForm</li>
<li>In the Location text field, choose a directory (the root of a directory works best)</li>
<li>From the bottom right side of the screen, underneath the browse button, leave Create directory for solution checked</li>
<li>Click OK</li>
<li>In the New ASP.NET Web Application window, choose MVC</li>
<li>Click OK</li>
</ol>
<p>Visual Studio will work in the background for a bit and once finished, we’ll have a complete solution created</p>
<h3>The Solution Explorer</h3>
<p>Before moving forward, it’s important to understand the structure and files created in an ASP MVC project. Let’s use the following table for a brief, but concise explanation of the folders and files created: </p>
<table class="crud">
<tr>
<td>Folder Created</td>
<td>Explanation of contents</td>
</tr>
<tr>
<td>App_Start</td>
<td>Contains specific configuration files including but not limited to RouteConfig.cs, which allows
us to customize how uniform resource locators (URL’s) look in a browser’s address bar.</td>
</tr>
<tr>
<td>Content:</td>
<td>Contains all content related files, such as style sheets, word/pdf documents, and web pages that
are not razor syntax.</td>
</tr>
<tr>
<td>Controllers</td>
<td>Contains all action related files. In the MVC paradigm, controllers determine which razor pages
display based on controller actions. These files are usually named with the following convention:
HomeController.cs, or AboutController.cs, which can be catered to your needs, but is
recommended you stick to the naming conventions used in Visual Studio, which end in
&lt;NameofController&gt;Controller.cs.</td>
</tr>
<tr>
<td>Models:</td>
<td>Contains all database related files. In the MVC paradigm, models handle database calls namely, Microsoft SQL Server – LINQ calls and validation of form fields that are passed to a controller and then the appropriate view. These files are usually named with the following convention: HomeModel.cs, or AboutModel.cs, which can be catered to your needs, but is recommended you stick to the naming conventions used in Visual Studio, which end in &lt;NameofModel&gt;Models.cs.
</tr>
<tr>
<td>Scripts:</td>
<td>Contains JavaScript files, namely JQuery library. You can use any JavaScript library you choose.</td>
</tr>
<tr>
<td>Views:</td>
<td>Contains razor HTML 5 web pages. These files are always named with a .CSHTML extension,
and are used in conjunction with our controllers to determine which pages display based on
actions.</td>
</tr>
<tr>
<td>Global.asax and web.config files are as follows:</td>
<td>Global.asax: maps App_Start configuration files for the entire solution. Web.config: configuration file that contains information specific to connecting to a database
engine, which version of .NET framework you’re using, and whether or not we have unobtrusive
JavaScript enabled.</td>
</tr>
</table>
<h3>A few things to note…</h3>
<p>We have removed the default _ViewStart.cshtml file from the solution, and taken its one line razor snippet and placed at the top of our index, contact, and about razor files which reside in Views: Home directory of our solution.</p>
<h3>Create the model</h3>
<p>In order to bind and validate our HTML 5 form fields, we need to create a model. Models in MVC are where you create class level variables that will pass the data collected to a view or controller. Models also allow us to validate input and make sure required fields are not empty, as well as handling regular expressions, and setting or checking minimum/maximum length.</p>
<p>For our form, we’ll have four fields:</p>
<ol>
<li>First Name</li>
<li>Last Name</li>
<li>Email</li>
<li>Comments</li>
</ol>
<p>Let’s create our model by following these steps:</p>
<ol>
<li>From the solution explorer, right click Models : Add : Class</li>
</ol>
<p class="alignCenter"><a href="images/21.png" data-lightbox="image-21"><img src="thumbs/21.png" alt="Models Add Class" width="285" height="141" /></a></p>
<ol>
<li>In the Add new item window, type ContactModels.cs, in the name text field</li>
</ol>
<p class="alignCenter"><a href="images/6.png" data-lightbox="image-6"><img src="thumbs/6.png" alt="Create model" width="228" height="147" /></a></p>
<p>Click Add.</p>
<p>In our new model class, let’s create our form field’s variables:</p>
<pre><code>
public class ContactModels
{
public string FirstName { get; set; }
public string LastName { get; set; }
public string Email { get; set; }
public string Comment { get; set; }
}
</code></pre>
<p>As you can see, we now have four public string-class variables to hold the data entered from our form. Save your changes.</p>
<p>We'll continue with adjusting our <a href="default2.aspx">view next</a>.</p>
</asp:Content>