<%@ Page Title="Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.articles.creating_a_help_desk_web_application_asp_net_ms_sql_server.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a Help Desk Web Application Using ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Filling the Dropdown Lists</h3>
<p>Currently, the dropdown list(s) are not populated with data from our database table(s). We have a few different approaches we can take:</p>
<ol>
<li>Use a SQL data source in our default.aspx file and then data bind directly to our dropdown list</li>
<li>Create a new C# class and use embedded SQL to query our data</li>
<li>Create a new C# class and use a stored procedure to query our data</li>
</ol>
<p>Using our first option has two tradeoffs:</p>
<ol>
<li>You have a SQL data source that has specific attributes.</li>
<li>You are data binding to a control directly in the ASPX page, which isn't best practice.</li>
</ol>
<p>Using the second option is acceptable; the only tradeoff is that you have SQL embedded in your application logic, which is generally not a good thing unless it's referencing an interface or abstract class. Furthermore, if anything in that query changes, you shouldn't need to sift through application logic. That change should be made to the data access (DA) layer.</p>
<p>The third option is the best because it calls for using a stored procedure, which is SQL code that is executed as a function in our application logic. Plus, we'll code the operation that gets the data against a generic list collection. This means that if we ever needed to compile this class for global use, all a developer would need to do is add a reference to the DLL and know what arguments it needs or returns. So, we'll use the third option.</p>
<h3>Stored Procedures</h3>
<p>You can think of stored procedures in databases as blocks of SQL code that have been executed against the database. This is great for a number reasons, including:</p>
<ol>
<li>Because the SQL code is executed against the database, it's already indexed on the database and knows the tables it needs. This enhances performance.</li>
<li>Since we're calling the function in our application, we aren't executing a SQL query from our application, which is faster than embedding SQL.</li>
<li>If the query requires a change, you change it in the saved SQL file rather than in our business layer.</li>
</ol>
<h3>Create the Stored Procedure for Severities</h3>
<p>If you still have the database on your task menu, simply restore it. From the Object Explorer, follow these steps to create the procedure for severity:</p>
<ol>
<li>Expand the plus sign (+) next to our database, mwd.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code with the following:</p>
<pre><code>
use mwd
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
CREATE PROCEDURE spHelpDeskGetStatuses 
   -- Add the parameters for the stored procedure here
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   SELECT ID, Status
   FROM Status
END
GO
</code></pre>
<p>As you can see from the SQL above, our stored procedure is named spHelpDeskGetStatuses and then we simply query our table, status. Before running the stored procedure on the database, save the stored procedure by selecting File:Save from the main menu and then saving your stored procedure to a location of your choice. Next, run the stored procedure by clicking Execute right below the main menu. If ran succesfully, SQL Server will report Commands executed successfully.</p>
<p>Minimize SQL Server Management Studio for the time being.</p>
<h3>Creating the Severity Class</h3>
<p>From the task menu, restore Visual Studio. From the Solution Explorer, right click on the project and follow these steps:</p>
<ol>
<li>Select Add:New Item.</li>
<li>In the add new item window, select class.</li>
<li>In the name text field, type "Severity.cs".</li>
<li>Click add.</li>
</ol>
<p>Double click Severity.cs from the Solution Explorer, which will show the empty class as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace HelpDesk
{
    public class Severity
    {
    }
}
</code></pre>
<p>In order to work with our SQL database, we need to import the following libraries as shown below:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace HelpDesk
{
    public class Severity
    {
    }
}
</code></pre>
<p>As you can see from the code above, we added three libraries. The first (System.Data) allows us to work with stored procedures in ADO.NET, the second (System.Configuration) allows us to reference a connection key from our configuration file, and the last (System.Data.SqlClient) allows us to connect to SQL Server.</p>
<h3>Creating Our Declarations</h3>
<p>Let's first add class-level variables so that we can get or set our data. Add the following code:</p>
<pre><code>
namespace HelpDesk
{
    public class Severity
    {
        #region Declarations
        public int ID { get; set; }
        public string severity { get; set; }
        #endregion
    }
}
</code></pre>
<p>As you can see from the code above, we added a region that holds our two class-level variables. These two variables match our two columns from the database table.</p>
<p>We'll continue by writing our method <a href="default5.aspx">next</a>.</p>
</asp:Content>