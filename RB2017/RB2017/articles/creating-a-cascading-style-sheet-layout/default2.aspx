<%@ Page Title="Creating a Cascading Style Sheet Layout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.creating_a_cascading_stylesheet_layout.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Cascading Style Sheet Layout</h2>
<h3>Analyzing  our layout</h3>
<p> From  creating our Fireworks document, we arrive at the following structural  requirements for our web page:</p>
<ol>
<li>Header</li>
<li>Navigation</li>
<li>Right Column</li>
<li>Footer</li>
</ol>
<p>Our header will identify our website. Additionally, our navigation will have an  unordered list styled with Cascading Style Sheets to simulate buttons and the right column will  hold our content. Our footer will contain copyright information for our  website.</p>
<h3>Open our web page</h3>
<p> Open index.html in your text editor and observe the following structure:</p>
<pre><code>
&lt;div id="wrapper"&gt;
&lt;header&gt;
&lt;/header&gt;
&lt;nav&gt;
&lt;/nav&gt;
&lt;div id="rightcontent"&gt;
&lt;/div&gt;
&lt;footer&gt;
&lt;/footer&gt;
&lt;/&lt;div&gt;
</code></pre>
<p>Looking  at our mark-up each DIV should be clear as to its purpose. With the introduction of HTML 5, we can take advantage of logical markup, including &lt;header&gt;, &lt;nav&gt; and &lt;footer&gt;. However, our  beginning DIV, wrapper, has a different purpose. Remember from our Fireworks  layout we need a way to simulate equalizing columns. When we sliced our two  columns, we used one slice named wrapper which encompassed both columns. When  we write our CSS rule, we repeat this image along the y-axis and as content is  added; our image will expand or contract vertically to simulate equalizing  columns. This is how one image can span two distinct areas of a layout and  simulate equalizing columns using Cascading Style Sheets CSS.</p>
<p>Finally,  we have provided the basic structure for our web page so that we can: </p>
<ol>
<li>Focus on creating and writing our CSS </li>
<li>How CSS is a method for separating structure from presentation</li>
</ol>
<h3>Open and  attaching the style sheet</h3>
<p> A  default style sheet has been provided via the project files download link.  We&rsquo;ll attach our style sheet via the link method.  Between the opening and closing &lt;/head&gt; tags, add the following:</p>
<pre><code>
&lt;/head&gt;
&lt;link href=&quot;style.css&quot; rel=&quot;stylesheet&quot; type=&quot;text/css&quot; media=&quot;screen&quot; /&gt;
&lt;/head&gt;
</code></pre>
<p>Now would be a good time to save your HTML file.</p>
<h3>Styling  our page background</h3>
<p>Open style.css; we notice our web page will have a subtle repeating background image applied. In our style  sheet, add the following:</p>
<pre><code>body{
background-image:url(images/background.jpg);
background-color:#999999;
background-repeat:repeat;
font-family:Arial,  Helvetica, sans-serif;
font-size:101%;
margin:20px  0;
padding:0;
}
</code></pre>
<p>Using  our body selector, we set the following property-values:</p>
<ol>
<li>Background-image:
<ol>
<li>Sets a background image</li>
</ol>
</li>
<li>
Background-color:
<ol>
<li>Set a page background that matches our image background</li>
</ol>
</li>
<li>
Background-repeat:
<ol>
<li>Set to repeat</li>
</ol>
</li>
<li>
Font-family:
<ol>
<li>Set to Arial</li>
</ol>
</li>
<li>
Font-size:
<ol>
<li>Set to a proportional unit of measurement of 101%</li>
</ol>
</li>
<li>
Margin:
<ol>
<li>Top and bottom set to a fixed width of 20 pixels</li>
<li>Left and right set to 0</li>
</ol>
</li>
<li>
Padding:
<ol>
<li>Set to zero</li>
</ol>
</li>
</ol>
<p>We  set a page background color which matches our repeating image for visitors who  have a slow Internet connection. While the image is being retrieved, the  visitors are presented with the default background color. We set padding to  zero because browsers apply default margins and padding to Hypertext Markup Language">HTML elements.  Setting this globally ensures all elements will not have any value unless  specifically written. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_body.html" target="_blank">Body rule applied</a> </p>
<h3>Inserting  our header image</h3>
<p> We&rsquo;ll  complete two orders of business here:</p>
<ol>
<li>Write a CSS rule to apply our header image</li>
<li>Write a CSS rule to hide our heading one &lt;h1&gt; from browsers</li>
</ol>
<p>The  reason we insert a heading one tag is to:</p>
<ol>
<li>Avoid non-semantic       standards of an empty DIV tag</li>
<li>Format the tag for a       printed version of a page if necessary</li>
</ol>
<p>We&rsquo;ll  write a rule to hide the heading one from our web version. First, let&rsquo;s write  the CSS rule to show our image:</p>
<pre><code>header{
width:760px;
height:100px;
background-image:url(images/header.jpg);
}</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We use our &lt;header&gt; as our selector, and assign the following:
<ol>
<li>Property of width, with a value of 760 pixels</li>
<li>Property of height, with a value of 100 pixels. </li>
</ol>
</li>
</ol>
<pre><code>header h1{
display:none;
}</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We use a descendent selector to target all heading one tags in an element header, and assign the following:
<ol>
<li>Property of display, with a value of none</li>
</ol>
</li>
</ol>
<p>As a side note, by setting an element to display of none, we remove the element from showing and the physical space it occupies. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_header.html" target="_blank">Header rule</a> </p>
<h3>Writing  our #wrapper</h3>
<p> In  order for our two columns to expand and contract vertically, we&rsquo;ll write a CSS  rule for our wrapper:</p>
<pre><code>#wrapper{
width:760px;
margin:20px  auto;
background-image:url(images/wrapper.jpg);
background-repeat:repeat-y;
}</code></pre>
<p>The  following property-values are:</p>
<ol>
<li>
Width:
<ol>
<li>Set to a fixed width of 760 pixels</li>
</ol>
</li>
<li>
Margin:
<ol>
<li>Top and bottom set to a fixed width of 20 pixels</li>
<li>Left and right set to auto</li>
</ol>
</li>
<li>
Background-image:
<ol>
<li>Set to our wrapper image</li>
</ol>
</li>
<li>
Background-repeat:
<ol>
<li>Set to repeat down the y-axis</li>
</ol>
</li>
</ol>
<p>We  set width on our wrapper to the same width of our wrapper image. In a fixed  width layout, setting left and right margins to auto will center our layout in  modern browsers. By setting our image to repeat down the y-axis, as content is  added or removed from either left or right columns, our columns will expand or  contract accordingly. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_wrapper.html" target="_blank">Wrapper rule</a> </p>
<p>Do  note there is a harmonic balance between the widths used in our Fireworks  layout and the CSS rules were are writing. If the images are off by even one  pixel, our layout will break. If you&rsquo;re not familiar with CSS to recalculate  any math needed to change our layout, please leave the widths used in this  article as is.</p>
<h3>Create navigation and right column</h3>
<p>We  know from our Fireworks design that our navigation is 260 pixels wide and our  right is 500 pixels wide. Furthermore, we know that we want to position these  content areas as &ldquo;columns.&rdquo; When you position elements in CSS you take them out  of the normal flow of the document. Therefore, we will position only these two  content areas by using the float property. Add the following Cascading Style Sheets CSS rules to your  style sheet:</p>
<pre><code>
nav{
float:left;
width:240px;
padding:10px; 
}</code></pre>
<pre><code>#rightcontent{
float:left;
width:480px;
padding:10px;
}</code></pre>
<p>If our  navigation is 260 pixels and our right column is 500 pixels in Fireworks, then  why do the widths say otherwise?</p>
<p>We'll continue with the box model calculation <a href="default3.aspx">next</a>.</p>
</asp:Content>
