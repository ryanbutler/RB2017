<%@ Page Title="Creating an Audit Record Application with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default2.aspx.cs" Inherits="RB2017.articles.creating_a_audit_record_application_asp_net_ms_sql_server.default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating an Audit Record Application with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Writing View Employee Functionality</h3>
<p>Before an audit can occur, we need the ability to view specific employee records. We will view and record audits from the same page, recordaudit.aspx, but separate the implementation. Let's tackle the view functionality first. From the solution explorer, do the following:</p>
<ol>
<li>Left click the plus (+) sign next to classes.</li>
<li>Double click RecordHistoryData.cs.</li>
</ol>
<p>In this file, we'll write our GetEmployeeView, which is viewable from the project downloads. As you can see from this file, we do the following:</p>
<ol>
<li>Create a connection object and pass in our configuration settings.</li>
<li>Create a command object and pass in our stored procedure and connection object.</li>
<li>Create a parameter, GUID, and pass in the appropriate data type and size.</li>
<li>Set the GUID's parameter value to the passed in variable from the query string, which came from our home page and add that to the command object's parameters collection.</li>
</ol>
<p>If for any reason you can't open a connection to the database or execute the query, you wrap this inside a try/catch block, which handles exceptions, and do the following:
</p>
<ol>
<li>Open a connection to the database.</li>
<li>Create a data reader object and set it to the command object's execute reader method.</li>
<li>If we can read data from the object, we: 
<ul>
<li>Set appropriate variable values from our reader object.</li>
<li>Otherwise, we catch and throw an exception.</li>
</ul>
</li>
</ol>
<p>Lastly, you call the dispose method of your command object and the close method of your connection object to clear resources.</p>
<p>Save your file(s).</p>
<h3>Open Recordaudit.aspx.cs</h3>
<p>Since you have written the functionality needed to display individual employees, let's add the ability to call it. From the solution explorer, do the following:</p>
<ol>
<li>Left click the plus (+) sign next to recordaudit.aspx.</li>
<li>Double click recordaudit.aspx.cs.</li>
</ol>
<p>Next, add the region named declarations and methods from the project downloads file. As you can see from the project downloads, we do the following:</p>
<ol>
<li>Add a namespace for our class, which is RecordHistory.classes.</li>
<li>Create a region named declarations. Inside, we do the following:
<ul>
<li>Create a new instance of both of our classes, and name the object appropriately.</li>
</ul>
</li>
<li>Inside our page load event, we do the following:
<ul>
<li>We check the query string to see if it's null.</li>
<li>If it IS NOT, we: 
<ul>
<li>Check for a post back with a negation operator. </li>
</ul>
</li>
</ul>
</li>
<li>If it IS, we: 
<ul>
<li>Show an error message by toggling our placeholder(s).</li>
</ul>
</li>
<li>If it IS NOT a POSTBACK, we: 
<ul>
<li>Create a new instance of a GUID object, and pass in our query string.</li>
</ul>
</li>
<li>If the GUID object IS NOT NULL: 
<ul>
<li>We call LoadData and pass in our GUID object.</li>
</ul>
</li>
<li>In our Load Data method, we: 
<ul>
<li>Pass in our GUID object using a data type of GUID in the method signature.</li>
<li>Call our method GetEmployeeView and pass in our GUID object.</li>
<li>Set a session object, named ID, and set it to the ID variable value from our record history object (rh).</li>
</ul>
</li>
</ol>
<p>Four important notes about our load data method: </p>
<ol>
<li>Even though we don't show our ID, which is the primary key from our parent table, we'll use this ID when auditing our child table, RecordHistory_Audit.</li>
<li>We view individual employees using a GUID, instead of a primary key. This way, we don't give away our database structure as easily to a hacker, and it also serves as a way to keep hackers or anyone else from easily cycling through primary keys to view other employees without following our interface.</li>
<li>Our post back check ensures when we perform the audit, we don't reload the employee information again on page load.</li>
<li>We use a session object to retain the value of the primary key that's returned from our query. Without it, we lose the value on post back, and would be forced to issue another query just for the ID of the record we want.</li>
</ol>
<p>Save your file(s).</p>
<h3>Writing Audit Functionality</h3>
<p>In order to record when an update (audit) occurs on an employee, we need the ability to capture specific information in our RecordHistory_Audit table, such as: the record index (primary key) from our parent table, the employee that's being updated, user completing the audit, as well as the date time. Let's write this functionality by first opening RecordHistoryDataAction.cs from the solution by following these steps:</p>
<ol>
<li>Left click the plus (+) sign next to classes.</li>
<li>Double click RecordHistoryDataAction.cs.</li>
</ol>
<p>With the file open, add the following namespaces: </p>
<pre><code>
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Principal;
namespace RecordHistory.classes
{
public class RecordHistoryDataActions
    {
}
</code></pre>
<p>As you can see, you added four. The first allows us to work with stored procedures in ADO.NET; the second allows us to reference a connection key from your configuration file; the third allows us to connect to SQL Server; and the fourth allows us to record which user audited the record based on their windows login credentials. Next, let's add your declarations, which you can get from the project downloads file.</p>
<p>As you can see from the code archive, you create a region named declarations, and inside you create public variables (with appropriate data types for each column from your database table) with getters and setters. Next, let's add our method InsertAuditRecord that will insert the audit to our child table, which can be found from the project downloads file.</p>
<p>As you can see from the code archive, you created a method named InsertAuditRecord and did the following:</p>
<ol>
<li>Created a connection object and passed in your configuration key</li>
<li>Created a command object and passed in your stored procedure and connection object</li>
<li>Created SQL parameters for each of our variables used in the insertion</li>
<li>Set the values of our SQL parameters to the appropriate variable values, including:
<ul>
<li>On User, we set the value to the current user's name based on the windows identity</li>
<li>On Change date, we set the value to current date time from the server</li>
<li>On Change reason, we set the value to a literal string of our choosing</li>
</ul>
</li>
<li>Added the parameters to the command object's collection</li>
</ol>
<p>If for any reason you can't open a connection to the database or execute the query, you wrap this inside a try/catch block, which handles exceptions, and do the following:</p>
<ol>
<li>Call the open method of your connection object</li>
<li>Call execute non query from our command object</li>
<li>If an exception occurs, catch it and throw the exception to the screen</li>
</ol>
<p>Lastly, you call the dispose method of your command object and the close method of your connection object to clear resources.</p>
<p>Some important notes regarding recording our audit: there are several ways to record user information to meet your application needs. A few things should be obvious however: you don't want the user auditing the information to be able to fake their credentials, change the date or the time, or have access to the database to change what the table is recording from the application. What you decide to record after these essentials are covered is entirely up to specifications set forth by business analysts or the product owners.</p>
<p>Save your file(s).</p>
<h3>Open Recordaudit.aspx.cs</h3>
<p>Since we have written the audit functionality, we simply need to call it from our code-behind file. The functionality is shown from the project downloads file. From the solution, we do the following:</p>
<ol>
<li>Left click the plus (+) sign next to recordaudit.aspx.</li>
<li>Double click recordaudit.aspx.cs.</li>
</ol>
<p>In our submit click event, we do the following:</p>
<ol>
<li>Set our rhd object, which was instantiated from RecordHistoryDataAction.cs, to the appropriate server-side form controls.</li>
<li>Set our Audit_ID variable from our object to our session object, which holds the primary key value from our parent table. This is how we're establishing the primary/foreign key relationship.</li>
<li>Call InsertAuditRecord.</li>
<li>Set our placeholder controls to their appropriate visibility.</li>
<li>Remove our session object's value.</li>
</ol>
<p>It should be noted, we remove the session object's value after each audit has occurred to ensure we don't insert the wrong primary key from our parent table, to our child table.</p>
<p>Save your file, and run the project. You should now see a listing of all employees available from our parent table. Clicking on an employee link should take you to our record audit page, showing that employee information. You should be able to change the employee information, click submit, and then see a success message that provides a link back to our home page. You can check the database to ensure the audit was recorded by doing the following:</p>
<ol>
<li>Open Microsoft SQL Server from the desktop.</li>
</ol>
<p>From Microsoft SQL Server do the following:</p>
<ol>
<li>Left click to select mwd_RecordHistory.</li>
<li>Left click on New Query.</li>
</ol>
<p>Type the following in the query window:</p>
<pre><code>
use mwd_RecordHistory
select * from RecordHistory_Audit
</code></pre>
<ol>
<li>Two tables, RecordHistory and RecordHistory_Audit.</li>
<li>Three stored procedures:
<ul>
<li>spRecordHistoryShowGrid</li>
<li>spRecordHistoryUpdate</li>
<li>spRecordHistoryViewEmployee</li>
</ul>
</li>
</ol>
<p>A few notes regarding our tables: the first one retains original records, while the second stores our audits.</p>
<h3>A Note About Stored Procedures</h3>
<p>In databases, you can think of them as blocks of SQL code that have been executed against the database, in other words, cached. This is great for multiple reasons including:</p>
<ol>
<li>Because the SQL code is executed against the database, it's already indexed on the database and knows the tables it needs, which means performance is enhanced.</li>
<li>Because we're calling the function in your application, you aren't executing a SQL query from your application, which is faster than embedding SQL.</li>
<li>If you need to change the query, you change it in the saved SQL file rather than in the business layer.</li>
</ol>
<p>You should see the newly inserted record from our previous operation.</p>
<h3>Summary</h3>
<p>In this article you learned how to implement an audit history of employee records that we updated. Furthermore, you learned the following:</p>
<ol>
<li>Restoring a database from a backup.</li>
<li>Creating an ASP.NET application.</li>
<li>Separating data handling operations into the following:
<ul>
<li>Reading data</li>
<li>Inserting data</li>
</ul>
</li>
<li>Understanding considerations for what information should be stored in an audit, and protecting this information from being tampered</li>
<li>How to work with session objects and understanding when to use them</li>
</ol>
<p>Take the knowledge gained in this article and expand your auditing system to meet any needs you may have. If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>