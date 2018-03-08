<%@ Page Title="Creating a Cascading Style Sheet Print Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.creating_a_cascading_style_sheet_page._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Cascading Style Sheet Print Page</h2>
<p>Today’s web sites implore many different aspects including standards-compliant markup, advanced CSS techniques, and mobile functionality. Often times the need for printer - friendliness is misplaced, although it’s a must. If you design your site with HTML 5 and CSS, designing a separate print style sheet is relatively easy. In this article I’ll show you how to make your web site look great visually and produce great-looking print output as well.</p>
<p class="alignCenter"><a href="examples/index_finished.html" target="_blank">See Demo</a> </p>
<table cellspacing="0" class="articles" summary="project files">
<tr>
<td colspan="2" class="header">Download Project Files </td>
</tr>
<tr>
<td colspan="2" class="caption"><a href="CSSPrint.zip" target="_blank">Zip File</a></td>
</tr>
</table>
<h3>Analysis</h3>
<p> Before we dig in let&rsquo;s examine some key issues to consider  when dealing with printed material:</p>
<h3>Graphics</h3>
<p>One of the fundamental features of web design; without graphics, web sites simply do not hold viewer interest. The problem is that when working with  printed material, graphics tend to use a lot of color, be rather large (both in file size and on the page), and generally the look does not translate well to print output. People often do not want to waste their color ink cartridges just to print your web graphics. If you must have graphics in the print output, it’s advisable limiting your graphics to the bare minimum.</p>
<h3>Color</h3>
<p>It&rsquo;s pretty much mandatory for your web site, and the appropriate use of color is what makes a web site distinctive. But again, in the print world color ink is expensive and you shouldn&rsquo;t assume visitors want a color copy of your web site. Best practice would always advise to stick with black and white as a default; this works best for most standard desktop printers.</p>
<h3>Navigation</h3>
<p>It&rsquo;s essential to have consistent, easy to use navigation on your website.&nbsp; Using a clean, practical and common sense approach to the organization and tools that drive your navigation will ensure your users will find pertinent information quickly and easily.&nbsp; These navigational tools can range from horizontal or vertical drop down menu&rsquo;s created with JavaScript, CSS or a combination of both to simple textual links that are styled with CSS. However, displaying the navigational tools that drive your website is not important when printing the page. If visitors are printing your web page it is because they want to reference your content, not your navigation. As a web developer, the path to the page they printed is always placed at the bottom of the print out. This way, if changes are required, you can use this as a reference to the location of the page on       the website.</p>
<h3>Fonts  &amp; Sizes</h3>
<p>Though font families and sizes are determined by the browser&rsquo;s default style sheet and settings, default settings tend to be Times New     Roman and 12 pixels. It is to some degree, hit and miss depending on browser specific settings determined by the user.&nbsp; With this said, when working with font families and sizes on the web, it is recommended you use Arial, Times New Roman or Verdana and relative font sizes, such as em, % or px.&nbsp; When dealing with printed web pages, it is recommended you use physical or absolute font sizes such as pt, inch, and cm. We will be working with pt in this article.</p>
<h3>Relative vs. Physical (Absolute) Font Sizes</h3>
<p>Relative font sizes means that a visitor can adjust font settings in their browser to suit their preference. Some visitors, including the elderly might need a larger font size setting whereas younger audiences might want a smaller font size than originally specified by the web developer. Absolute font sizes are fixed in nature. This is why they are used in print.&nbsp; Leaving your users without the option of       adjusting font sizes is not the best strategy, especially in terms of accessibility.</p>
<h3>The Page</h3>
<p>The best way to demonstrate how to make a printed style sheet is to use the layout from Creating a CSS Layout. Let’s see how you can convert this page to hard-copy format. Take a look at the finished web version of our page here:</p>
<p class="alignCenter"><a href="examples/index_finished.html" target="_blank">Index Finished</a></p>
<p>Let’s define some goals for the conversion process:</p>
<p>1).We need to remove the:</p>
<ol>
<li>Logo</li>
<li>Navigation</li>
<li>Touch up fonts</li>
<li>Reduce the presence of the copyright</li>
<li>Emphasize the email</li>
</ol>
<p>In our case, the list above ought to cover what we need to do, so let’s get started.</p>
<h3>Open the File</h3>
<p>Open up your favorite text editor and open the file index.html and have a look at the following mark-up:</p>
<pre><code>
&lt;link href=&quot;style.css&quot; rel=&quot;stylesheet&quot; type=&quot;text/css&quot; media=&quot;screen&quot; /&gt;
&lt;link href=&quot;print.css&quot; rel=&quot;stylesheet&quot; type=&quot;text/css&quot; media=&quot;print&quot;/&gt;
</code></pre>
<p>
In order to make a website printer friendly, we need to add a reference to a print only style sheet,
and apply a different value for the media attribute. Save your work.
</p>
<h3>Print preview in browsers</h3>
<p>Open index.html, it should look fine in a web browser on a computer screen:</p>
<p class="alignCenter"><a href="examples/index.html" target="_blank">Print preview</a></p>
<p>When printing a web page without a print style sheet, normally its not too attractive. Let’s start working with our print
style sheet.</p>
<h3>Setting a base font family and color</h3>
<p>Open print.css and set a base font family and color for our print style sheet as shown below:</p>
<pre><code>
body
{
font-family:'Times New Roman';
color:#000;
}
</code></pre>
<p>As you can see from the code above:</p>
<ol>
<li>We use our body selector, and assign the following property-values:
<ol>
<li>Font-family: Set to Times New Roman</li>
<li>Color: Set to black</li>
</ol>
</li>
</ol>
<p>Save your work. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_body.html" target="_blank">Body</a></p>
<h3>Hiding the logo</h3>
<p>
You will notice in our HTML markup, we have an image that signifies our logo. However, when
viewing this page using our print style sheet, it’s too prominent, and doesn’t belong. We need to
remove the logo from our print style sheet with the following CSS rule as shown below:
</p>
<pre><code>
img.noprint
{
display:none;
}
</code></pre>
<p>As you can see from the rule above, we:</p>
<ol>
<li>Create a class named noprint, that’s a descendent of img selector and assign the following property-values:
<ol>
<li>Display: Set to none</li>
</ol>
</li>
</ol>
<p>
We do this because our image tag in our  HTML has a class attribute with the same name. Save
your work. Results should be as illustrated.
</p>
<p class="alignCenter"><a href="examples/index_logo.html" target="_blank">Logo</a></p>
<h3>Hiding navigation</h3>
<p>Since the side bar has a logical &lt;nav&gt; selector in HTML, we can easily manipulate this in our print style sheet to hide it as shown below:</p>
<pre><code>
nav
{
display:none;
}
</code></pre>
<p>As you can see from the code above:</p>
<ol>
<li>We use our nav selector and assign the following property-values:
<ol>
<li>Display: Set to none</li>
</ol>
</li>
</ol>
<p>Save your work. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_navigation.html" target="_blank">Navigation</a></p>
<h3>Difference between display and visibility</h3>
<p>
You might have noticed we used display instead of visibility. The difference between display and
visibility is the former will hide the element visually from displaying and removes the physical
space the element occupied. Visibility on the other hand, will hide the element visually from
displaying; however, it will preserve the physical space the element occupied.
</p>
<h3>Adjusting heading two and three tags</h3>
<p>
In order for us to retain a title that’s prominent on each web page, we just adjust the font size on
our heading two and three tags respective to each other. Also, we give it a different font family
than our web style sheet, and set the default color to black. We do all of this with these rules as
shown below:
</p>
<pre><code>
h2
{
font-size:16pt;
}
h3
{
font-size:13pt;
}
</code></pre>
<p>Save your work. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_heading.html" target="_blank">Heading</a></p>
<h3>Copyright</h3>
<p>
Our copyright is lacking. Since we can’t use colors, let’s bring visual significance to the
copyright through another means as shown below:
</p>
<pre><code>
footer p
{
font-size:10pt;
font-style:italic;
}
</code></pre>
<p>As you can see from the code above:</p>
<ol>
<li>We use our footer selector and target our descendent paragraph element and assign the following property -values:
<ol>
<li>Font-size: Set to 10pt</li>
<li>Font-style: Set to italic</li>
</ol>
</li>
</ol>
<p>Save your work. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_copyright.html" target="_blank">Copyright</a></p>
<h3>Summary</h3>
<p>
As you can see, converting a web site to a printer friendly version is not difficult. Now you know
how to:
</p>
<ol>
<li>Handle graphics, colors, navigation, and font size issues when creating print style sheets</li>
<li>
See your print styles without wasting loads of paper for each change by using print
preview in each browser
</li>
<li>Hide graphics and navigation of your page from a print style sheet</li>
<li>
Logically and semantically represent the logo and page titles through heading tags and
logical  HTML 5 tags such as &lt;nav&gt; and &lt;footer&gt;
</li>
</ol>
<p>Now your pages will slide out of your printer looking as they’re supposed to look!</p>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>