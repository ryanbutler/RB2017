<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default6.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server.default6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Open default.aspx.cs</h3>
<p>Since we need to associate our list object to our grid view, we'll create another list object, call our method, and take the objects we get from that method and data bind to that. Let's first open our code behind file by following these steps:</p>
<ol>
<li>From the solution explorer, left click the plus (+) sign next to default.aspx.</li>
<li>Double click default.aspx.cs.</li>
</ol>
<p>Below our page load method, let's create another method that will bind our objects to our grid view as shown below:</p>
<pre><code>
protected void GetClassScheduleData()
        {
            List&lt;ClassSchedule&gt; schedule = ClassSchedule.GetClassScheduleData();
            gridView_Schedule.DataSource = schedule;
            gridView_Schedule.DataBind();
            //removes the default border="1" from the generated grid view
            gridView_Schedule.GridLines = GridLines.None;
            //sets cellspacing to zero
            gridView_Schedule.CellSpacing = 0;
        }
</code></pre>
<p>As you can see from the code above, we do the following: create a list object, and call the GetClassScheduleData method from our class file. We then set the data source of our grid view to our list object, and then call the data bind method to associate our data to our control. The remaining two lines deals with a rendering problem when working with CSS. We turn grid lines off which removes the default generated border on our table and set cell spacing to zero. Before saving, we need to make a call to this method from our page load method, as shown below:</p>
<pre><code>
protected void Page_Load(object sender, EventArgs e)
        {
            GetClassScheduleData();
        }
</code></pre>
<p>Save your file. Press F5 on your keyboard. Go ahead and click OK. Make sure your page looks like the following image:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig13.jpg" width="600" height="450" alt="Browser view of class schedules" /></p>
<p>Once you're done previewing your page, return to Visual Studio and press the stop button or Shift + F6 on your keyboard.</p>
<h3>Create the Style Sheet</h3>
<p>We obviously need to style up the page a bit, let's do it with CSS; follow these steps to create a style sheet:</p>
<ol>
<li>From the solution explorer, right click on the project and choose Add→New Item.</li>
<li>In the Add New Item window, from the left pane, select Web.</li>
<li>From the right pane, choose Style Sheet</li>
<li>In the name text field, type style and then left click Add.</li>
</ol>
<h3>Open the Style Sheet</h3>
<p>To open the style sheet and add some basic rules, follow these steps:</p>
<ol>
<li>From the solution explorer, double click style.css.</li>
<li>Add the following CSS as shown below:</li>
</ol>
<pre><code>
body
{
      font-family:Verdana, Helvetica, Sans-Serif;
}
div table#gridView_Schedule{
      width:985px;
      border-collapse:collapse;
      border:1px solid #ccc;
      margin:0 auto;
}
div table#gridView_Schedule th{
      font-size:.6em;
}
div table#gridView_Schedule td{
      font-size:.7em;
      text-align:center;
}
</code></pre>
<p>As you can see from the code above, we're overriding the base font family for our Web page, setting the overall table width to 985, which allows the table to 
show all information consistently, and we set the font size of our table header cells (th) and table cells (td) to an appropriate size. 
Save your file and preview the results. Once finished, close your style sheet.</p>
<p>Before continuing, in the default.aspx make sure you link to the style sheet.</p>
<h3>Determining Rows to Highlight</h3>
<p>Most Web-based schedules have indicators that alert viewers to classes that are full or have lab components by highlighting those rows in different colors. Using our grid view, this is pretty simple. First, in default.aspx, inside the opening grid view declaration, add this property-value:</p>
<pre><code>
&lt;asp:GridView ID="gridView_Schedule" runat="server" AutoGenerateColumns="false" OnRowDataBound="gridView_RowDataBound"&gt;
</code></pre>
<p>As you can see from the code above, we created a row data bound event. This means, as each row in the grid view is bound; we'll write conditional logic to highlight certain rows in different colors-based on specific criteria. Save this file and switch back to default.aspx.cs. Let's create a method for our event as shown below:</p>
<pre><code>
protected void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((int)DataBinder.Eval(e.Row.DataItem, "remainSeats")) <= 0) 
                {
                    e.Row.CssClass ="closed";
                }else if((((string)DataBinder.Eval(e.Row.DataItem,"meetInfo"))=="LAB")){
                    e.Row.CssClass = "lab"; 
                }
            }
        }
</code></pre>
<p>As you can see from the code above, we create a method named gridView_RowDataBound. You should notice that instead of EventArgs e, we pass in GridViewRowEventArgs e. Next, if the row type is that of data row, we then determine which rows we want to evaluate. We know we want the column containing remaining seats to be red if the count is less than or equal to zero. As a result, we type cast that column as an integer, use a comparison operator (<= ) and pass in zero, then use the CssClass method of e and set it to a CSS class named closed. We do the same thing for lab, except type casting it as a string, and setting the class to lab instead. Save your file.</p>
<p>Open your style sheet, and add the following code:</p>
<pre><code>
.closed{
      background-color:#FF0000;
}
.lab{
      background-color:#c90;
}
</code></pre>
<p>As you can see from the code above, we create two classes and set their background color to an appropriate color. Save your files and preview the results, which should look like the following:</p>
<p class="alignCenter"><img src="images/ClassSchedule_ASP.NET_Fig14.jpg" width="600" height="450" alt="Browser view of colored rows" /></p>
<h3>Summary</h3>
<p>In this article you learned how to build a relatively simple Web-based schedule application in ASP.NET. You learned how to do the following:</p>
<ol>
<li>Create a database
<ul>
<li>Corresponding tables</li>
<li>Create and understand stored procedures</li>
<li>Understand relationships with data</li>
<li>Create a database diagram to enforce referential integrity</li>
</ul>
</li>
<li>Create a Visual Studio project
<ul>
<li>Create a Web form with a grid view control that renders a table</li>
<li>Create a C# class, and understand the basics of generics</li>
<li>Create a method on our grid view to determine-based on criteria different row colors</li>
</ul>
</li>
</ol>
<p>Take the knowledge you gained from this article and expand your Web-based schedule application to meet any requirement you may need.</p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>