<%@ Page Title="Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_web_based_schedule_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating a web - based schedule with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Populating Tables</h3>
<p>Let's go ahead and populate our tables with some data by following these steps:</p>
<ol>
<li>Right click on Instructor, and select Open</li>
<li>Enter the following data:
<ul>
<li>Record 1
<ul>
<li>InstFName : Ryan</li>
<li>InstLName : Butler</li>
</ul>
</li>
<li>Record 2
<ul>
<li>InstFName : Kelly</li>
<li>InstLName : Brand</li>
</ul>
</li>
<li>
<ul>
<li>InstFName : Tom</li>
<li>InstLname : Stewart</li>
</ul>
</li>
</ul>
</li>
</ol>
<ol>
<li>Continuing, right click on location and select Open</li>
<li>Enter the following data:
<ul>
<li>Record 1
<ul>
<li>Location: SPG</li>
</ul>
</li>
<li>Record 2
<ul>
<li>Location: LEG</li>
</ul>
</li>
<li>Location: RVC</li>
</ul>
</li>
</ol>
<ol>
<li>Continuing, right click on room and select Open</li>
<li>Enter the following data:
<ul>
<li>Record 1
<ul>
<li>Room: TEC-104</li>
<li>Record 2
<ul>
<li>Room: RVC-230</li>
</ul>
</li>
<li>Record 3
<ul>
<li>Room: SPG-123</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
</ol>
<ol>
<li>Continuing, right click on section name and select Open</li>
<li>Enter the following data:
<ul>
<li>Record 1
<ul>
<li>Section Name : CIS-101</li>
<li>Synonym : 062514</li>
</ul>
</li>
<li>Record 2
<ul>
<li>Section Name : CIS-130</li>
<li>Synonym : 632541</li>
</ul>
</li>
<li>Record 3
<ul>
<li>Section Name : MAR-234</li>
<li>Synonym : 741254</li>
</ul>
</li>
</ul>
</li>
</ol>
<ol>
<li>Continuing, right click on class schedule and select Open</li>
<li>Enter the following data:
<ul>
<li>Record 1
<ul>
<li>SectionNameId : 2</li>
<li>CreditHrs : 3</li>
<li>Title : Web Site Development 1</li>
<li>TotalSeats : 18</li>
<li>RemainingSeats : 0</li>
<li>MeetInformation : LEC</li>
<li>RoomNumberID : 1</li>
<li>Days : TTH</li>
<li>StartTime : 5:30PM</li>
<li>EndDate : 7:20PM</li>
<li>InstructorID : 1</li>
<li>LocationID : 1</li>
</ul>
</li>
<li>Record 2
<ul>
<li>SectionNameId : 1</li>
<li>CreditHrs : 4</li>
<li>Title : Intro to Computers</li>
<li>TotalSeats : 18</li>
<li>RemainingSeats : 5</li>
<li>MeetInformation : LEC</li>
<li>RoomNumberID : 2</li>
<li>Days : MW</li>
<li>StartTime : 1:00PM</li>
<li>EndDate : 2:00PM</li>
<li>InstructorID : 2</li>
<li>LocationID : 2</li>
</ul>
</li>
<li>Record 3
<ul>
<li>SectionNameId : 1</li>
<li>CreditHrs : 4</li>
<li>Title : Networking</li>
<li>TotalSeats : 18</li>
<li>RemainingSeats : 10</li>
<li>MeetInformation : LAB</li>
<li>RoomNumberID : 1</li>
<li>Days : TTH</li>
<li>StartTime : 4:00PM</li>
<li>EndDate : 8:00PM</li>
<li>InstructorID : 1</li>
<li>LocationID : 1</li>
</ul>
</li>
</ul>
</li>
</ol>
<p>We'll continue by creating our stored procedure <a href="default4.aspx">next</a>.</p>
</asp:Content>