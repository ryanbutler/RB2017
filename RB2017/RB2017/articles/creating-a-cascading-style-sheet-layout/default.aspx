<%@ Page Title="Creating a Cascading Style Sheet Layout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.creating_a_cascading_stylesheet_layout._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Cascading Style Sheet Layout</h2>
<p>Creating and developing a website with CSS is generally a straightforward task.
It gives you significant advantages structurally since you’re not embedding presentational markup in your page. It also provides advantages on the presentation side because you can control
your entire layout with one style sheet. Another important consideration is it generally makes your websites faster to load since the structural markup is clean and the presentational
file is cached on the end users computer. Lastly, it can make developing a print style sheet much easier as well.</p>
<p>In this article, we&rsquo;ll learn:</p>
<ol>
<li>How to create our layout in Fireworks</li>
<li>Slice and optimize our graphics in Fireworks</li>
<li>Create and design our website using the graphics from our layout</li>
<li>Create a logical structure for our web page using logical HTML 5 markup</li>
<li>Create our CSS which will control our layout and presentation of our website</li>
<li>Understand how CSS positioning works</li>
<li>Understand how equalizing columns work in CSS</li>
</ol>
<p>If you would like to follow this article&rsquo;s step-by-step development or even   try your hand at creating a Cascading Style Sheets Layout, you will find the project file links   helpful.</p>
<p class="alignCenter"><a href="examples/index_finished.html" target="_blank">See Demo</a></p>
<table class="articles" summary="project files">
<tr>
<td colspan="2" class="header">Download Project Files </td>
</tr>
<tr>
<td colspan="2" class="caption"><a href="CSSLayout.zip" target="_blank">Zip File</a></td>
</tr>
</table>
<h3>Create our layout - Fireworks</h3>
<p> A basic knowledge of Fireworks is needed to complete this section. If you&rsquo;re not  comfortable with this editor, you may use Photoshop. If you&rsquo;re not comfortable  with either, it&rsquo;s recommended you spend a few hours visiting either&rsquo;s help  documentation. For our purposes, we&rsquo;ll use Fireworks. Open Fireworks by  following these steps:</p>
<ol>
<li>From  the Desktop, locate the start button</li>
<li> Select Programs : Adobe : Adobe Fireworks</li>
<li>Inside  Fireworks, from the main menu, select File : New and enter the values as shown:
</ol>
<p class="alignCenter"><img src="images/newdocument.jpg" alt="Fireworks New Document" width="400" height="318" /></p>
<h3>Import  header and footer image</h3>
<p> We&rsquo;ll  import the header and footer image provided from the project files download. In  Fireworks, follow these steps:</p>
<ol>
<li>From  the main menu, select File : Import</li>
<li> Navigate  to the directory which stores the header image</li>
<li> Select OK</li>
<li> Your  mouse cursor turns to a carpenter&rsquo;s hand</li>
<li> Left  click near the top of the canvas</li>
</ol>
<p class="alignCenter"><img src="images/carpentershand.jpg" alt="Fireworks Carpenters Hand" width="186" height="170" /></p>
<ol>
<li>
Adjust the X-Y coordinates as follows:
<ol>
<li>X: 0</li>
<li>Y: 0</li>
</ol>
</li>
</ol>
<ol>
<li>Follow  the same steps to import our footer image, except adjust x-y coordinates as  follows:
<ol>
<li>X: 0</li>
<li>Y: 200</li>
</ol>
</li>
</ol>
<h3>Create the  dashed line</h3>
<p> Our  dashed line will serve as a visual separator between our left and right  &ldquo;columns.&rdquo; Follow these steps to create it:</p>
<ol>
<li>From  the main menu, select View : Rulers</li>
<li>From the Vector tool bar, select the line tool</li>
</ol>
<p class="alignCenter"><img src="images/linetool.jpg" alt="Fireworks Line Tool" width="72" height="82" /></p>
<ol>
<li>Move  your mouse cursor right below our header image to line up with 260 using the  Ruler as a guide:</li>
</ol>
<p class="alignCenter"><img src="images/260ruler.jpg" alt="Fireworks Ruler" width="157" height="231" /></p>
<ol>
<li>Press and hold the shift key while dragging the line down and release</li>
<li>In the properties panel, change the following settings:
<ol>
<li>W: 1</li>
<li>H: 298</li>
<li>X: 260</li>
<li>Y: 101</li>
</ol>
</ol>
<ol>
<li>With the object selected, change the stroke options color (1.) to #999999 (2.):</li>
</ol>
<p class="alignCenter"><img src="images/stroke.jpg" alt="Fireworks Stroke" width="165" height="234" /></p>
<ol>
<li>Locate stroke category in the properties panel:</li>
</ol>
<p class="alignCenter"><img src="images/strokecategory.jpg" alt="Fireworks Stroke Category" width="126" height="58" /></p>
<ol>
<li>Change the stroke category to hard dash:</li>
</ol>
<p class="alignCenter"><img src="images/harddash.jpg" alt="Fireworks Hard Dash Selection" width="350" height="276" /></p>
<h3>Create navigation pattern</h3>
<p> Our  navigation has a light gray background pattern to help visualize the  difference between the two columns. Follow these steps to create it:</p>
<ol>
<li>From the Vector tool bar, select the rectangle tool:</li>
</ol>
<p class="alignCenter"><img src="images/rectangletool.jpg" alt="Fireworks Rectangle Tool" width="203" height="111" /></p>
<ol>
<li>Draw a rectangle in the vicinity of the left column</li>
<li>In the properties panel, change the following settings:
<ol>
<li>W: 260</li>
<li>H: 300 </li>
<li>X: 0</li>
<li>Y: 100</li>
</ol>
</li>
<li>Select light gray as a fill option (#999999) </li>
</ol>
<h3>Create the  background</h3>
<p> Our  website has a subtle patterned image which repeats through our web page. Follow  these steps to create it:</p>
<ol>
<li>From the Vector tools bar, select the rectangle tool</li>
<li>Draw a rectangle in the vicinity of the right column area</li>
<li>In the properties  panel, change the following settings:
<ol>
<li>W: 38</li>
<li>H: 38 </li>
<li>X: 379</li>
<li>Y: 135</li>
</ol>
</li>
</ol>
<ol>
<li>With the object selected, select fill option (1.) and enter color as dark gray (2.):</li>
</ol>
<p class="alignCenter"><img src="images/stroke.jpg" alt="Fireworks Stroke" width="165" height="234" /></p>
<ol>
<li>Change texture to Mesh (1.) and set amount to 20% (2.):</li>
</ol>
<p class="alignCenter"><img src="images/mesh.jpg" alt="Fireworks Mesh" width="200" height="47" /></p>
<h3>Slicing  our graphics</h3>
<p> Each  of our web graphics will be exported as JPEG images. With this in mind, follow  these steps to set JPEG as the default export option:</p>
<ol>
<li>In the Optimize Panel, select JPEG &ndash; Better Quality:</li>
</ol>
<p class="alignCenter"><img src="images/optimize.jpg" alt="Fireworks Stroke" width="239" height="92" /></p>
<h3>Slice  header and footer</h3>
<p> We  need to slice each of these graphics independently so that we can insert them  in our web page when needed. Follow these steps to slice each one:</p>
<ol>
<li>Using the pointer tool, select the background object</li>
<li>From the main menu, choose Edit: Insert: Rectular Slice</li>
<li>In the properties  panel, give our slice a name of header:</li>
</ol>
<p class="alignCenter"><img src="images/headerslice.jpg" alt="Fireworks Header slice" width="134" height="80" /></p>
<p>Follow the same steps to slice our footer graphic, except give our slice a name of footer.</p>
<h3>Slice our  page background</h3>
<p> Follow  these steps to slice our page background:</p>
<ol>
<li>Using the pointer tool, select the background object</li>
<li>From the main menu, choose Edit: Insert : Rectular Slice</li>
<li>Width, height, x and y coordinates should match that of our graphic</li>
<li>In the properties       panel, give our slice a name of background</li>
</ol>
<h3>Slice our  columns</h3>
<p> In  order to create and simulate equalizing columns in CSS, we have to be creative  with the use of images. In our layout, we&rsquo;ll create one slice which will span  both our navigation and right columns. We&rsquo;ll then write a CSS rule which will repeat  this graphic along the y-axis. When content is added to our web page, the  graphic will repeat vertically which simulates equalizing columns. More on this  concept will be discussed later when developing our web page. Follow these  steps to slice our two columns:</p>
<ol>
<li>From the Tool bar,  select the slice tool</li>
</ol>
<p class="alignCenter"><img src="images/slicetool.jpg" alt="Fireworks Slice Tool" width="80" height="68" /></p>
<ol>
<li>Drag the slice over our layout making sure it encompasses our left and right columns:</li>
</ol>
<p class="alignCenter"><img src="images/twocolumn.jpg" alt="Fireworks Slicing two columns" width="407" height="22" /></p>
<ol>
<li>In the properties  panel, adjust the values as follows:
<ol>
<li>W: 760</li>
<li>H: 18 </li>
<li>X: 0 </li>
<li>Y: 198</li>
</ol>
</li>
<li>With the object  selected, in the properties panel, give our slice a name of wrapper</li>
</ol>
<h3>Export and  save our images</h3>
<p> In  Fireworks, we can export and save our images using the same method. Follow  these steps:</p>
<ol>
<li>From the Vector tool bar, make sure slices are turned on to ensure each graphic needed is       sliced:</li>
</ol>
<p class="alignCenter"><img src="images/slicetool.jpg" alt="Fireworks Slice tool" width="80" height="68" /></p>
<ol>
<li>From the main menu, select File : Export</li>
<li>In the Export drop down list, choose Images only</li>
<li> Leave Include Selected slices only checked</li>
<li>
Navigate to your images directory
Left click Export
</li>
</ol>
<p>Navigate  to the directory where you have stored the project files download, your images  should be present. At any time, you can modify colors, text and then export  your images to your directory and they will be reflected in your website.</p>
<h3>Save our  layout</h3>
<p> In  order to make modifications to our layout in the future, we need to save it as  a portable network graphic (PNG), which is Fireworks native editable format.  Follow these steps:</p>
<ol>
<li>From  the main menu, select File : Save</li>
<li> Navigate  to your directory where project files are stored</li>
<li> In  the File name text field, type ryan_layout</li>
<li> Left  click Save</li>
</ol>
<p>Once  completed, close Fireworks, we&rsquo;re done with it.</p>
<p>We'll continue with creating our web page <a href="default2.aspx">next</a>. </p>
</asp:Content>