<%@ Page Title="Creating a Cascading Style Sheet Web Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.creating_a_cascading_style_sheet_web_form._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Cascading Style Sheet Web Form</h2>
<p>
When creating web forms, there generally two ways to control the layout: (1) Using tables, or (2)
using CSS. Developers who are familiar with CSS can easily position a web form. This increases
structural (HTML mark-up) and visual (styling form fields) appeal to your web page that is easy
to achieve with a little bit of ingenuity.
</p>
<p>
In this article, we’ll examine how to use HTML and CSS to control the layout of our form. We’ll
briefly cover how we can extend the style sheet to style form fields. As a result, we’ll have a web
form which looks great structurally and visually, works in all modern browsers, and learn some
cool CSS concepts and techniques.
</p>
<p>
If you would like to follow along with positioning and styling a web form’s step-by-step
development, you’ll find the project file link helpful.
</p>
<p class="alignCenter"><a href="examples/index_finished.html" target="_blank">See Demo</a></p>
<table class="articles" summary="project files">
<tr>
<td colspan="2" class="header">Download Project Files </td>
</tr>
<tr>
<td colspan="2" class="caption"><a href="https://github.com/ryanbutler/creating-a-cascading-style-sheet-web-form/tree/creating-a-cascading-style-sheet-web-form" target="_blank">GitHub Source</a></td>
</tr>
</table>
<h3>Open the web form</h3>
<p>From the project downloads, open index.html and have a look at the following mark-up:</p>
<pre><code>
&lt;head&gt;
&lt;link href=&quot;style.css&quot; rel=&quot;stylesheet&quot; type=&quot;text/css&quot; media=&quot;screen&quot;/&gt;
&lt;/head&gt;
</code></pre>
<p>As you can see from the mark-up above, we have attached a base style sheet.</p>
<h3>Styling the body tag</h3>
<p>Open style.css and set a base font family & size on our form with our body selector:</p>
<pre><code>
body
{
font-family:Arial, Helvetica, Sans-Serif;
font-size:.85em;
}
</code></pre>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_body.html" target="_blank">Body</a></p>
<h3>Structuring our web form</h3>
<p>
Since we want the web form to have a table-row based look and feel, we’ll use a technique in
CSS where we duplicate row markup that has a label and input fields for collection of user data:
</p>
<pre><code>
div.row
{
width:500px;
margin:4px auto;
}
</code></pre>
<p>As you can see from the CSS rules above:</p>
<ol>
<li>
Create a class named row, and select it’s descendent DIV and then we assign the following property-values:
<ol>
<li>Width: Set to 200 pixels.</li>
<li>Margin: Set to top and bottom value of 4 pixels, and left and right of auto.</li>
</ol>
</li>
</ol>
<p>
As a side note, when we assigned a fixed width on an element, setting left and right margins to
auto, will center the element.
</p>
<p>Save your file. Results should be as illustrated.</p>
<p>If you have questions, please follow the link below.</p>
<p class="alignCenter"><a href="examples/index_row.html" target="_blank">Row</a></p>
<h3>Floating our labels</h3>
<p>To achieve a better presentational feel, we will float our labels:</p>
<pre><code>
label
{
float:left;
width:200px;
}
</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We select our label selector and assign the following property-values:
<ol>
<li>Float: Set to left</li>
<li>Width: Set to 200 pixels</li>
</ol>
</li>
</ol>
<p>
An item to note, when you float an element left or right, we are removing this element from the
normal flow of the document. This technique is often used when floating two &quot;columns&quot; side by
side in a regular CSS positioned website.
</p>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_label.html" target="_blank">Label</a></p>
<h3>Positioning our radio buttons and check boxes</h3>
<p>
When dealing with radio buttons and check boxes in CSS, relying on their native behaviors to
align themselves correctly in the web page won’t work. In other words, we need a way to tame
them. We do this by surrounding them in unordered lists. As a result, presentational wise, you get
the default bullet point appearance. In order to remedy that, we write the following CSS rule:
</p>
<pre><code>
ul li
{
list-style-type:none;
margin-left:160px;
}
</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We select list items inside their parent unordered list and assign the following property-values:
<ol>
<li> List style type: Set to none</li>
<li>Margin left: Set to 160 pixels</li>
</ol>
</li>
</ol>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_bullets.html" target="_blank">Bullets</a></p>
<h3>Adjusting width and height of the text area</h3>
<p>
When working with comment fields in the past, we would typically use the attribute cols or rows
on the text area. Rather than use that deprecated technique, let’s use CSS to define the width and
height:
</p>
<pre><code>
textarea
{
width:200px;
height:100px;
}
</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We select our textarea, and assign the following property-values:
<ol>
<li>Width: Set to 200 pixels</li>
<li>Height: Set to 100 pixels</li>
</ol>
</li>
</ol>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_textarea.html" target="_blank">Textarea</a></p>
<h3>Styling form fields</h3>
<p>There are a variety of items you can do to spice up your page, including but not limited to:</p>
<ol>
<li>Styling the input tags, which can be done by doing this:</li>
</ol>
<pre><code>
input
{
background-color:#c90;
color:#fff;
}
</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We use the input tag as our selector, and assign the following property-values:
<ol>
<li>Background-color: set to gold</li>
<li>Color: Set to white</li>
</ol>
</li>
</ol>
<p>
A tradeoff to this approach is that we will also style radio buttons (Internet Explorer 11), which
may be an undesirable result. You could get around that by adjusting the rule above into a class
and just styling your text fields.
</p>
<p>You can also style the following elements used within a form:</p>
<ol>
<li>Field sets</li>
<li>The background of a web page, separated from the form</li>
<li>Option elements</li>
</ol>
<h3>Modern approaches to styling form fields</h3>
<p>We can style form fields in a more modern way using CSS 3 behaviors. These items include styling your input and text areas with rounded corners, and changing border colors on hover or focus of each field. Let’s add the following to our existing style sheet:</p>
<pre><code>
input {
transition: all 0.25s ease-in-out;
-webkit-transition: all 0.25s ease-in-out;
-moz-transition: all 0.25s ease-in-out;
border-radius:3px;
-webkit-border-radius:3px;
-moz-border-radius:3px;
border:1px solid rgba(0,0,0, 0.2);
}
input:focus {
box-shadow: 0 0 5px #c90;
-webkit-box-shadow: 0 0 5px #c90; 
-moz-box-shadow: 0 0 5px #c90;
border:1px solid #c90; 
}
</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We target our input selector and assign the following property-values:
<ol>
<li>Transition: set to .25 seconds</li>
<li>Border-radius: set to 3 pixels</li>
</ol>
</ol>
<p>We target the focus pseudo-class of our input selector and assign the following property-values:</p>
<ol>
<li>Box-shadow: Set to 5 pixels, with a color of gold</li>
</ol>
<p>A few items to note: (1) -Webkit and -Moz properties are used to simulate CSS 3 behaviors in Google Chrome and Apple Safari and Mozilla based web browsers for their respective property-values. Also, these CSS 3 behaviors are only supported by modern browsers which support CSS 3 behaviors.</p>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_css3.html" target="_blank">CSS 3</a></p>
<h3>Summary</h3>
<p>
In this article you learned how to position & style a web form with CSS. More importantly you
learned how to:
</p>
<ol>
<li>How to simulate table rows with CSS</li>
<li>
How to control radio buttons and check boxes with an unordered list and position
appropriately
</li>
<li>How to control width and height of a text area with CSS</li>
<li>How you could style other elements of a form</li>
</ol>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>