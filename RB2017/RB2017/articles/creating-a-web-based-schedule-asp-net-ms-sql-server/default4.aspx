<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default4.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server.default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Create Stored Procedure</h3>
<p>Stored procedures in databases can be thought of as blocks of SQL code that have been executed against the database. This is great for multiple reasons including:</p>
<ol>
<li>Since the SQL code is executed against the database, it's already indexed on the database and knows the tables it needs, which means performance is enhanced.</li>
<li>Since we're calling the function in our application, we aren't executing a SQL query from our application, which is faster than embedding SQL.</li>
<li>If a change is needed to the query, you change it in the saved SQL file, rather than in our business layer.</li>
</ol>
<h3>Create the Stored Procedure for Class Schedule</h3>
<p>From the object explorer, follow these steps to create the procedure for class schedule:</p>
<ol>
<li>Expand the plus sign (+) next to our database, mwd.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code, with the following as shown below:</p>
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
CREATE PROCEDURE spClassScheduleDisplay 
   -- Add the parameters for the stored procedure here
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   SELECT SectionName.SectionName,SectionName.[Synonym],ClassSchedule.CreditHrs,
   ClassSchedule.Title, ClassSchedule.TotalSeats,ClassSchedule.RemainingSeats,
   ClassSchedule.MeetInformation,Room.Room,ClassSchedule.Days,
   ClassSchedule.StartTime,ClassSchedule.EndTime,Instructor.InstFName + ' ' + Instructor.InstLName AS InstFullName,
   Location.Location
   FROM ClassSchedule
   INNER JOIN Location ON ClassSchedule.LocationID=Location.ID
   INNER JOIN Instructor ON ClassSchedule.InstructorID=Instructor.ID
   INNER JOIN Room ON ClassSchedule.RoomNumberID=Room.ID
   INNER JOIN SectionName ON ClassSchedule.SectionNameId=SectionName.ID
END
GO
</code></pre>
<p>As you can see from the code above, we do the following: create a procedure named spClassScheduleDisplay. Since our main table relates to four child tables, we need to query from all five tables. There are two ways to do this: (1) an implicit join, sometimes referred to as a Cartesian join, or (2) an explicit join. A Cartesian join isn't recommended because it will join all five tables together, look for the primary-foreign key relationship, and then bring back the entire result set-based on matching criteria, which for huge data results, can be a significant performance hit. An explicit join using the SQL keyword INNER JOIN, is the best option. It will explicitly join the five tables-based on the primary-foreign key reference, filter explicitly on that relationship and only bring back an exact result set.</p>
<p>As a result we've used INNER JOIN in our query. When using INNER JOIN, you simply match parent table -- primary key to child table -- foreign key. Once you have completed this, save your stored procedure by following these steps:</p>
<ol>
<li>From the main menu, choose File:Save As.</li>
<li>In the Save As dialog, type spClassScheduleDisplay and then left click OK.</li>
</ol>
<p>Minimize the SQL Server Management Studio; we're done with it for the time being.</p>
<h3>Open Visual Studio and Create the Project</h3>
<p>Let's go ahead and open Visual Studio (or your editor) from the desktop: Start:Programs:Microsoft Visual Studio.</p>
<p>From the main menu, create a new project by following these steps:</p>
<ol>
<li>File:New:Project.</li>
<li>In the New Project window, under the Visual C# tree, choose Web, then ASP.NET Web Application.</li>
<li>In the name text box, name our project ClassSchedule.</li>
<li>In the location drop down list, leave as is.</li>
<li>In the solution text box, leave as is.</li>
<li>Leave Create a directory for solution checked.</li>
<li>Click OK.</li>
</ol>
<p>Once the project is created, you'll have one ASPX file and a web.config.</p>
<h3>Open web.config</h3>
<p>From the solution explorer, double click web.config and look for &lt;connectionStrings&gt;. Replace the default markup with the following as shown below:</p>
<pre><code>
&lt;connectionStrings&gt;
&lt;add name="mwd" connectionString="Data Source=P425\SQLExpress;Initial Catalog=mwd;Integrated Security=SSPI;"/&gt;
&lt;/connectionStrings&gt;
</code></pre>
<p>Simply replace the value inside the double quotes for connection string with your settings. Once completed, save your file.</p>
<h3>Open default.aspx</h3>
<p>Let's tackle the ASPX file first by double clicking on it from the solution explorer. Once open, delete everything inside the opening and closing &lt;form runat= "server"&gt; tag. Next, right below the opening &lt;form&gt; tag, let's create a grid view data control as shown below:</p>
<pre><code>
&lt;asp:GridView ID="gridView_Schedule" runat="server"&gt;
&lt;/&lt;asp:GridView&gt;
</code></pre>
<p>Since we need to create a tabular view of our data, grid view control will render a table. Right now the properties are as follows:</p>
<ol>
<li>ID
<ul>
<li>Gives our control a unique name</li>
</ul>
</li>
<li>Runat=server
<ul>
<li>Tells us this control will be run by the server first, then resulting html output will be sent to the browser</li>
</ul>
</li>
</ol>
<h3>Creating Columns Manually</h3>
<p>Since we don't want our grid view to automatically generate every column from our query (default behavior), we'll manually create our columns within the grid view; adjust our grid view as shown below:</p>
<pre><code>
&lt;asp:GridView ID="gridView_Schedule" runat="server" AutoGenerateColumns="false">
   &lt;Columns>
        &lt;asp:BoundField DataField="sectName" HeaderText="Section Name" /&gt;
        &lt;asp:BoundField DataField="synonym" HeaderText="Synonym" /&gt;
        &lt;asp:BoundField DataField="credhrs" HeaderText="Credit Hours" /&gt;
        &lt;asp:BoundField DataField="title" HeaderText="Title" /&gt;
        &lt;asp:BoundField DataField="totalSeats" HeaderText="Total Seats" /&gt;
        &lt;asp:BoundField DataField="remainSeats" HeaderText="Remaining Seats" /&gt;
        &lt;asp:BoundField DataField="meetInfo" HeaderText="Meeting Information" /&gt;
        &lt;asp:BoundField DataField="room" HeaderText="Room" /&gt;
        &lt;asp:BoundField DataField="days" HeaderText="Days" /&gt;
        &lt;asp:BoundField DataField="startTime" HeaderText="Start Time" /&gt;
        &lt;asp:BoundField DataField="endTime" HeaderText="End Time" /&gt;
        &lt;asp:BoundField DataField="instFullName" HeaderText="Instructor" /&gt;
        &lt;asp:BoundField DataField="location" HeaderText="Location" /&gt;
    &lt;/Columns&gt;
&lt;/asp:GridView&gt;
</code></pre>
<p>As you can see from the code above, we set the property, AutoGenerateColumns to false. Nested within the grid view, we create a columns tag, followed by a(n) bound column for reach column we wish to show. This tag takes two properties:</p>
<ol>
<li>DataField
<ul>
<li>Value used comes from our class level variables</li>
</ul>
</li>
<li>HeaderText
<ul>
<li>Value used is what displays in the browser as header cells</li>
</ul>
</li>
</ol>
<p>Save your file.</p>
<p>We'll continue by creating our class file <a href="default5.aspx">next</a>.</p>
</asp:Content>