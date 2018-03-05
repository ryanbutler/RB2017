<%@ Page Title="Creating a Cascading Style Sheet Layout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.creating_a_cascading_stylesheet_layout.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Cascading Style Sheet Layout</h2>
<h3>Box Model  Calculation</h3>
<p> According  to the W3C, a box&rsquo;s true width is its declared width plus borders and padding. In our example, our mathematical calculation can be expressed as follows:</p>
<p>240 (rendered width)=260  (declared width) = 10 pixel padding (left) + 10 pixel padding (right)</p>
<p>Padding  and borders are counted twice. If your head is hurting at this slightly inept  logic your probably not the only one. Think of it in this analogy: You purchase  a package which is 60 pixels wide. When it arrives it has 10 pixels of foam  padding on the left and right side of the box. Thus, the rendered width of the  package is 40 pixels wide according to the W3C. In essence, when you declare a  width on a box which is positioned you have two widths: a declared width and a  rendered width. The latter is derived from any padding or borders which you  assign to this element and is rendered to the browser. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_float.html" target="_blank">Floating columns</a> </p>
<p>Our  page is a bit sickly looking at the moment, but we&rsquo;ll fix that next.</p>
<h3>Writing  our footer rule</h3>
<p> Currently,  the reason our footer doesn&rsquo;t extend to the bottom of our page is because it  has no height. It has no way of knowing or understanding where the content ends  for either navigation or right column. In order to give our footer the height it  needs to extend to the bottom of the page, we need to clear both floated DIVs  to get the footer back into the flow of the document. Additionally, we also  insert our footer graphic with the following CSS rule:</p>
<pre><code>footer{
clear:both;
background-image:url(images/footer.jpg);
width:760px;
height:100px;
}</code></pre>
<p>The  following property-values are:</p>
<ol>
<li>
Clear:
<ol>
<li>Set to both will clear our floated DIVs (left and right columns) and put the footer back into the normal flow of the document</li>
</ol>
</li>
<li>
Background-image:
<ol>
<li>Set to our footer image</li>
</ol>
</li>
<li>
Width:
<ol>
<li>Set to a fixed width of 760 pixels which matches our image size</li>
</ol>
</li>
<li>
Height:
<ol>
<li>Set to a fixed height of 100 pixels which matches our image size</li>
</ol>
</li>
</ol>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_clear.html" target="_blank">Clearing footer</a> </p>
<p>Our  page is really starting to take shape! </p>
<h3>Formatting  our copyright notice</h3>
<p>Our  background image in our footer makes the current text which is set to a color of  black difficult to read. Let&rsquo;s add the following rule to make it a bit easier  to read:</p>
<pre><code>footer p{
font-size:.8em;
color:#FFFFFF;
padding:20px;
}</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We set all descendent paragraphs of our footer selector, and assign the following property-values</li>
<li>Font-size: Set to .8em</li>
<li>Color: Set to white</li>
<li>Padding: Set to 20 pixels</li>
</ol>
<p>The last item is to provide some space inside each paragraph. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_copyright.html" target="_blank">Footer &amp; copyright</a> </p>
<h3>Style our  contact link footer</h3>
<p>Our  contact link in the footer is also difficult to read, let&rsquo;s add some link  states to correct this:</p>
<pre><code>footer a:link{
color:#FFFFCC;
text-decoration:underline;
}
footer a:visited{
}
footer a:hover, footer a:active{
color:#CCCCCC;
text-decoration:none;
}</code></pre>

<p>We  provide the four states for our footer contact link. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_copyrightlink.html" target="_blank">Copyright link</a> </p>
<h3>Format heading  two and three</h3>
<p>Let&rsquo;s  change the default appearance of our heading two and three tags which are  present in our right column with the following rule:</p>
<pre><code>h2{
font-size:1.4em;
color:#666666;
padding:10px;
}
h3{
font-size:1.2em;
color:#666666;
padding:10px;
}</code></pre>
<p>As you can see from the example above:</p>
<ol>
<li>We target all heading two and three tags using the selector tag, and assign the following property-values:</li>
<li>Font-size: Set to 1.4em</li>
<li>Color: Set to gray</li>
<li>Padding: Set to 10 pixels</li>
</ol>
<p>Padding is used to provide horizontal and vertical space between our headings and the edge of our right column. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_formatheadings.html" target="_blank">Format headings</a> </p>
<h3>Format  paragraphs</h3>
<p>Our  paragraphs are sitting close to our right columns edge and they are too large  and fairly difficult to read. Add the following rule to correct this:</p>
<pre><code>p{
font-size:.8em;
line-height:1.7em;
padding:10px;
}</code></pre>
<p>Some  people feel as though setting line-height on paragraphs of text makes for  easier reading. Padding is set to provide a little breathing room inside our  right column. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_paragraphs.html" target="_blank">Formatting paragraphs</a> </p>
<p>We'll finish the article by formatting our menu <a href="default4.aspx">next</a>. </p>
</asp:Content>