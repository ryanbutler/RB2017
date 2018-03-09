<%@ Page Title="Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_searchable_online_employee_directory_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Searchable Online Employee Directory with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create the Stored Procedure for Employee Directory</h3>
<p>If you still have the database on your task menu, simply restore it. From the object explorer, follow these steps to create the procedure for searching employees:</p>
<ol>
<li>Expand the plus sign (+) next to our database, ed.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code as shown below:</p>
<pre><code>
use Emp_Dir
 -- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      &lt;Author,,Name&gt;
-- Create date: &lt;Create Date,,&gt;
-- Description:   &lt;Description,,&gt;
-- =============================================
CREATE PROCEDURE spEmployeeDirectoryViewDetail 
   -- Add the parameters for the stored procedure here
   @LName varchar(50)
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   SELECT LName + ', ' + FName as [Name], Guid
   FROM EmployeeDirectory
   WHERE LName LIKE @LName + '%'
END
GO
</code></pre>
<p>As you can see from the SQL above, our stored procedure is named spEmployeeDirectoryViewDetail, and we simply query our table, employee directory. In our query, we concatenate (append) last and first name together using the alias Name, surrounded in brackets, because Name is a reserved SQL keyword. More importantly, on the WHERE clause we search on the LName column using the LIKE keyword, which searches our database for any results containing our search term. Next, if we have two last names such as Rose, we want to return that name only if they type in R or Rose, not o. We solve this by using the wildcard character (%). Before running the stored procedure on the database, follow these steps from the main menu to save the stored procedure:</p>
<ol>
<li>From the main menu, choose File:Save As.</li>
<li>In the Save As dialog, type spEmployeeDirectoryViewDetail and then left click OK.</li>
</ol>
<p>When finished, run the stored procedure by clicking execute right below the main menu. If run successfully, SQL Server will report "Commands executed successfully." Minimize SQL Server Management Studio for the time being.</p>
<p>Restore Visual Studio and run the project by pressing F5. On the initial screen, type D or Doe and click Search. This screen should return:</p>
<p class="alignCenter"><img src="images/browser_search_executed.png" width="270" height="249" alt="Employee Search Working" /></p>
<p>If you move your mouse over the link, you'll see a GUID with a random string appended. After we implement the functionality, when a user clicks on the link, we'll pass the GUID through the query string and display additional employee detail. The reason we use a GUID is simple: an attacker could very easily cycle through primary keys in a query string to determine the structure of your database, but guessing a GUID is virtually impossible.</p>
<h3>Validating Search Text Field</h3>
<p>Currently, a visitor could type nothing or anything into our search field and it would accept it. Since we're searching only for last names, if they type nothing or a number we shouldn't execute our query. We enforce this by adding required field and regular expression validation controls. The first ensures something is typed into the search field. Because we shouldn't search unless it's a character, the second will allow searching only if a character is typed in, based on pattern matching. Let's add these two controls as shown below:</p>
<pre><code>
&lt;form id="form1" runat="server"&gt;
&lt;h2&gt;Employee Search&lt;/h2&gt;
&lt;p&gt;Search an employee by typing a last name.&lt;/p&gt;
&lt;asp:TextBox ID="txtName" runat="server"/&gt;
&lt;asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" /&gt;
&lt;asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Search cannot be empty!" Display="Dynamic" /&gt;
&lt;asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtName" ValidationExpression="^\s*[a-zA-Z,\s]+\s*$" ErrorMessage="Search can only contain letters!" Display="Dynamic" /&gt;
&lt;asp:PlaceHolder ID="phEmployeeSearch" runat="server" Visible="false"&gt;   
&lt;asp:Repeater ID="rpEmployeeSearchView" runat="server"&gt;
&lt;ItemTemplate&gt;
    &lt;p&gt;&lt;asp:HyperLink ID="hlLink" runat="server" NavigateUrl='&lt;%#Eval("guid", "viewdetail.aspx?guid={0}")%&gt;' Text='&lt;%#Eval("Name")%&gt;' /&gt;&lt;/p&gt;
&lt;/ItemTemplate&gt;
&lt;/asp:Repeater&gt;
&lt;/asp:PlaceHolder&gt;
&lt;asp:PlaceHolder ID="phNoEmployeeFound" runat="server" Visible="false"&gt;
&lt;p&gt;No Employee exists.&lt;/p&gt;
&lt;/asp:PlaceHolder&gt;
&lt;/form&gt;
</code></pre>
<p>As you can see from the code above, we have two controls: (1) required field validation, which consists of the following:</p>
<ol>
<li>ID
<ul>
<li>Gives our control a unique name</li>
</ul>
</li>
<li>Runat
<ul>
<li>Tells us the control will be run server-side first, and then HTML output will be sent to the browser when necessary</li>
</ul>
</li>
<li>ControlToValidate
<ul>
<li>Indicates which control we want to validate</li>
</ul>
</li>
<li>ErrorMessage
<ul>
<li>Message displayed to our visitor</li>
</ul>
</li>
<li>Display
<ul>
<li>Set to dynamic means the source markup for displaying will be visible only when this control is executed</li>
</ul>
</li>
</ol>
<p>And (2) regular expression validation, which consists of the following:</p>
<ol>
<li>ID
<ul>
<li>Gives our control a unique name</li>
</ul>
</li>
<li>Runat
<ul>
<li>Tells us the control will be run server-side first, and then HTML output will be sent to the browser when necessary</li>
</ul>
</li>
<li>ControlToValidate
<ul>
<li>Instructs which control we want to validate</li>
</ul>
</li>
<li>ValidationExpression
<ul>
<li>A regular expression that ensures only text is allowed in the search field</li>
</ul>
</li>
<li>ErrorMessage
<ul>
<li>Message displayed to our visitor</li>
</ul>
</li>
<li>Display
<ul>
<li>Set to dynamic means the source markup for displaying will be visible only when this control is executed</li>
</ul>
</li>
</ol>
<p>Save your file and press F5 to run the project. Try typing a number in the search field. The error message should show. Also, try leaving the search field empty and you should get an error message. Before moving to the other file, we need to ensure that when JavaScript is disabled we still check the search field appropriately. In our code-behind file, add the following:</p>
<pre><code>
protected void btnSearch_Click(object s, EventArgs e)
        {
            //check if search has valid criteria
            if (IsValid)
            {
                List&lt;EmployeeDirectory&gt; employees = ed.GetEmployeesView(txtName.Text);
                TogglePHVisibility();
                rpEmployeeSearchView.DataSource = employees;
                rpEmployeeSearchView.DataBind();
            }
        }
</code></pre>
<p>As you can see from the code above, the IsValid method checks server side to ensure the search field is not empty and contains an appropriate pattern. Save your file, run the project, turn off JavaScript and try the same scenario as before, ensuring it still works. When finished, return to Visual Studio and stop the application from running.</p>
<p>We'll continue by creating our view detail of an employee <a href="default4.aspx">next</a>.</p>
</asp:Content>