<%@ Page Title="Creating a Application for admission and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="RB2017.articles.creating_a_asp_net_registration_and_confirmation_system._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Application for admission and Confirmation System with ASP.NET and MS SQL Server</h2>
<p>In today's academia websites, having a way for propsective students to apply for admission online is essential.
Developing a web application that allows for propspective students to apply for admission by collecting a variety of information
 and storing that information in a database can be completed using ASP.NET & MS SQL Server.</p>
<p>When planning to develop this type of application, several requirements are creating a form that collects: (1) Social Security Number, (2) First and Last name, (3) email, (4) age, (5) mailing address, (6) phone number, (7) high school, (8) the year they plan to enroll, and (9) will they graduate. </p>
<p>When they submit the information, you store that information in a database, as well as send them an 
email confirming those details. When storing social security we need to make sure that we collect this over secure HTTP, and then normalize the data in the corresponding database table. When emailing the information, we need to ensure to personalize the email for each applicant.</p>
<p>If you would like to learn how to build an application like this, read on. To follow along with this article, you'll need Visual Studio, as well as SQL Server.</p>
<h3>Create the Database</h3>
<p> From the desktop, follow these steps to open SQL Server:</p>
<ol>
<li>Start : Programs : SQL Server : SQL Server Management Studio. </li>
<li>Connect to your local database server.</li>
<li>Create your database by right clicking on databases and selecting New database as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig1.PNG" width="338" height="104" alt="New Database" /></p>
<ol start="4">
<li>Give your database a name of ApplicantAdmission and click OK. </li>
</ol>
<h3>Create the Main Table</h3>
<p>To create your tables, follow these steps:</p>
<ol>
<li>Click the plus (+) sign next to your database as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig2.png" width="198" height="84" alt="Picture of database" /></p>
<ol>
<li>Right click on Tables, and select "New Table" as shown below: </li>
</ol>
<p class="alignCenter"><img src="images/RegConfSys_ASP.NET_Fig3.png" width="262" height="136" alt="New Table" /></p>
<p>Create your table, Applicants, first. We need the following columns as outlined below::</p>
<table class="define_Db_Table">
<tr>
<td>Column Name</td>
<td>Data Type</td>
<td>Not null/null</td>
<td>Primary Key</td>
</tr>
<tr>
<td>ID</td>
<td>Int</td>
<td>Not null</td>
<td>Yes</td>
</tr>
<tr>
<td>SSN_3</td>
<td>Varchar(3)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>SSN_2</td>
<td>Varchar(2)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>SSN_4</td>
<td>Varchar(4)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>FName</td>
<td>Varchar(50)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>LName</td>
<td>Varchar(50)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Email</td>
<td>Varchar(50)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Street_Address</td>
<td>Varchar(100)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Phone_Area_Code_3</td>
<td>Varchar(3)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Phone_Num_3</td>
<td>Varchar(3)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Phone_Num_4</td>
<td>Varchar(4)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Year_Intend_Enroll_Id</td>
<td>Int</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Curr_High_School_Student</td>
<td>Varchar(3)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>Grad_From_High_School</td>
<td>Varchar(3)</td>
<td>Null</td>
<td>No</td>
</tr>
<tr>
<td>High_School_Id</td>
<td>Int</td>
<td>Null</td>
<td>No</td>
</tr>
</table>
<p>Before continuing, make sure to set the primary key by right clicking the column and choosing Set Primary Key as shown below:</p>
<p class="alignCenter"><img width="210" height="51" alt="Set Primary Key" src="images/SetPrimaryKey.gif"></p>
<p>While we're at it, let's set the seed on this column as well by setting the Identity Specification to Yes as shown below:</p>
<p class="alignCenter"><img src="images/IDSpec2Yes.gif" width="616" height="65" alt="Identity Seed"></p>
<p>I'll explain why we need one additional table shortly, but let's proceed to create the high school and year intend to enroll tables using the same steps as previously outlined. Just change the table column names as outlined below:</p>
<h3>High School</h3>
<table class="define_Db_Table">
<tr>
<td>Column Name</td>
<td>Data Type</td>
<td>Not null/null</td>
<td>Primary Key</td>
</tr>
<tr>
<td>High_School_Id</td>
<td>Int</td>
<td>Not null/null</td>
<td>Yes</td>
</tr>
<tr>
<td>High_School_Name</td>
<td>Varchar(50)</td>
<td>Null</td>
<td>No</td>
</tr>
</table>
<h3>Year Intend Enroll</h3>
<table class="define_Db_Table">
<tr>
<td>Column Name</td>
<td>Data Type</td>
<td>Not null/null</td>
<td>Primary Key</td>
</tr>
<tr>
<td>Year_Intend_Enroll_Id</td>
<td>Int</td>
<td>Not null/null</td>
<td>Yes</td>
</tr>
<tr>
<td>Year_Intend_Enroll_Year</td>
<td>Varchar(4)</td>
<td>Null</td>
<td>No</td>
</tr>
</table>
<p>Make sure you set the primary key and seed on the ID column for this table as well.</p>
<p>We'll continue by explaining relational databases <a href="default2.aspx">next</a>.</p>
</asp:Content>