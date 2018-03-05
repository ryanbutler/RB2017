<%@ Page Title="Creating a Cascading Style Sheet Layout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.creating_a_cascading_stylesheet_layout.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Cascading Style Sheet Layout</h2>
<h3>Formatting  our menu</h3>
<p> We  have definitely saved the best part for last, styling our menu to simulate  button behavior. We need to do the following:</p>
<ol>
<li>Remove default indentation</li>
<li>Remove bullets</li>
<li>Provide a width for our list items</li>
<li>Make them simulate buttons</li>
<li>Center them in our left column</li>
</ol>
<p>Let&rsquo;s  get to it!</p>
<h3>Remove  default indentation</h3>
<p> List  items by default have indentation applied to them. We write the following rule  to turn this indentation off:</p>
<pre><code>nav ul{
margin:0;
padding:0;
}</code></pre>
<p>Padding  set to zero satisfies Internet Explorer and Opera, while margin set to zero  satisfies Mozilla.</p>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_ulindentation.html" target="_blank">Remove list item indentation</a> </p>
<h3>Remove  bullets</h3>
<p>List  items by default have bullets. We don&rsquo;t want these if we simulate buttons, so  we turn these off with the following rule:</p>
<pre><code>nav ul li{
list&#8212;style&#8212;type:none;
}</code></pre>
<p>Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_ulbullets.html" target="_blank">Removing list item bullets</a> </p>
<h3>Create our  buttons</h3>
<p>In  order for our link text to simulate a button, we need to declare a global  selector on our anchor tag inside our unordered list:</p>
<pre><code>nav ul li a{
display:block;
width:180px;
margin:12px  auto;
padding:4px;
text&#8212;align:center;
background&#8212;color:#CC9900;
color:#000000;
border:1px  solid #000;
font&#8212;size:.8em;
}</code></pre>
<p>This  rule is so massive it must do something important, and it most certainly does. The property-values are:</p>
<ol>
<li>
Display:
<ol>
<li>Set to block will make the entire link text clickable or &ldquo;hot&rdquo;</li>
</ol>
</li>
<li>
Width:
<ol>
<li>Sets each link button to a fixed width of 180 pixels</li>
</ol>
</li>
<li>
Margin:
<ol>
<li>Top and bottom set to a fixed width of 12 pixels to provide vertical off-set between each link button</li>
<li>Left and right set to auto will center our link buttons in our left column</li>
</ol>
</li>
<li>
Padding:
<ol>
<li>Set to a fixed width of 4 pixels to provide space inside our link button text</li>
</ol>
</li>
</ol>

<p>The  remaining property-values are straight forward. Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_ullinkbutton.html" target="_blank">Link button</a> </p>
<h3>Creating  our link states</h3>
<p>In  order for CSS to simulate button behavior and rollover effects without the use  of JavaScript we need to create the four states to our buttons as follows:</p>
<pre><code>nav ul a:link{
background&#8212;color:#CC9900;
color:#000000;
}
nav ul a:visited{
background&#8212;color:#990000;
color:#ffffff;
}
nav ul a:hover, nav ul a:active{
background&#8212;color:#CCCCCC;
color:#000000;
}</code></pre>
<p>We  provide appropriate background color and a foreground color to suit our layout.  Save your file. Results should be as illustrated.</p>
<p class="alignCenter"><a href="examples/index_ullinkbuttonstates.html" target="_blank">Link button states</a> </p>
<h3>Create a  &ldquo;you are here&rdquo; marker</h3>
<p>Most  websites today provide a visual indicator to their visitor as to which page  they&rsquo;re currently viewing. Adding this to our web page is a cinch with the  following addition:</p>
<pre><code>nav ul li a.current{
background&#8212;color:#990000;
color:#ffffff;
}</code></pre>
<p>We  create a class named current, which  is nested inside both a list item and an unordered tag. Before previewing, add  the class to the first list item button:</p>
<pre><code>
&lt;ul&gt;
&lt;li&gt;&lt;a href=&quot;javascript:;&quot; class=&quot;current&quot;&gt;menu  one&lt;/a&gt;&lt/li&gt;
&lt;li&gt;&lt;a href=&quot;javascript:;&quot;&gt;menu one&lt;/a&gt;&lt/li&gt;
&lt;li&gt;&lt;a href=&quot;javascript:;&quot;&gt;menu one&lt;/a&gt;&lt/li&gt;
&lt;li&gt;&lt;a href=&quot;javascript:;&quot;&gt;menu one&lt;/a&gt;&lt/li&gt;
&lt;/ul&gt;</code> </pre>
<p>Save your file. Results should be as illustrated. </p>
<p class="alignCenter"><a href="examples/index_youarehere.html" target="_blank">You are here marker</a> </p>
<h3>Summary</h3>
<p>In  this article you learned how to create and design a web page using CSS. You  also learned:</p>
<ol>
<li>How to create our layout in Fireworks</li>
<li>How to optimize our individual graphics in Fireworks</li>
<li>How to export our  graphics to be used in our website</li>
<li>Create a logical structure for our web page using logical HTML 5 markup</li>
<li>Simulate equalizing columns</li>
<li>Position columns using floats</li>
<li>Box Model Calculation</li>
<li>Make our footer extend to the bottom of our page</li>
<li>Format various elements our page </li>
<li>Create and simulate buttons using an unordered list</li>
<li>Create a you are here marker to indicate to our visitor what page they&rsquo;re currently visiting</li>
</ol>
<p>After  this article, you have learned the fundamentals relating to creating a layout  in Fireworks and then using CSS to create your web page. Take the knowledge  acquired in this article to create and design any layout of your imagination! </p>
<p>If you have questions, <a href="/contact.aspx">contact me</a>.</p>
</asp:Content>
