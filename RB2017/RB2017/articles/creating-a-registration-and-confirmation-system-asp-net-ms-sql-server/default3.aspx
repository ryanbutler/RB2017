<%@ Page Title="Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default3.aspx.cs" Inherits="RB2017.articles.creating_a_registration_and_confirmation_system_asp_net_ms_sql_server.default3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Creating an Registration and Confirmation System with ASP.NET (ASPX) and MS SQL Server</h2>
<h3>Creating Your Registration Object and Writing Your Submit Functionality</h3>
<p>Switch back to default.aspx.cs, and create your registration object as shown below:</p>
<pre><code>
namespace Registration
{
    public partial class _Default : System.Web.UI.Page
    {
        #region Declarations
        Registration reg = new Registration();
  double totalCost = 0;
  #endregion
    }
}
</code></pre>
<p>As you can see from the code above, you create a new instance of your registration object, create a variable with a data type of double, and set its value to zero initially. This variable will be used in calculating the total cost of dinner. Next, you need to capture the submission (registration) functionality, by adding the following code:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
        {
            reg.fname = fnameTB.Text;
            reg.lname = lnameTB.Text;
            reg.email = emailTB.Text;
            string attending = rbAttending.SelectedValue.ToString();
            string dinner = rbDinnerOpt.SelectedValue.ToString();
            
            if (attending.ToString() == "Yes")
            {
                reg.mail = mailTB.Text;
                reg.dinner = dinner.ToString();
                reg.howmanyattend = howmanyAttendingTB.Text;
                totalCost = Convert.ToDouble(reg.howmanyattend) * Convert.ToDouble(reg.dinner);
                reg.totalCost = totalCost;
                reg.whynotattend = "";
            }
            else
            {
                reg.mail = "";
                reg.dinner = "";
                reg.howmanyattend = "";
                reg.whynotattend = whyNotTB.Text;
            }
            reg.InsertRegistration();
      phForm.Visible = false;
            phSuccess.Visible = true;     
        }
</code></pre>
<p>In the code above, you do the following:</p>
<ol>
<li>Set first, last and email variables to the appropriate Web control's text property.</li>
<li>Create a string variable for attending and dinner, and capture the selection the user made.</li>
<li>If the visitor has selected yes to attending, then:
<ul>
<li>You capture their mailing address, dinner choice, and how many are attending; calculate their total cost; and then set why they are not attending to an empty string.</li>
</ul>
</li>
<li>If the visitor has selected no to attending, then:
<ul>
<li>You set the why they are not attending variable to the text property of the control.</li>
<li>The rest are set to an empty string.</li>
</ul>
</li>
<li>Call the insert registration method of your registration object.</li>
<li>Set your initial form's visbility to false and your success to visible.</li>
</ol>
<p>The reason you set some variables to an empty string is your stored procedure is expecting values for each one. So, you set it to an empty value where you don't have a value selected from your form.</p>
<h3>Create the Stored Procedure for Employee Directory</h3>
<p>If you still have the database on your task menu, simply restore it. From the object explorer, follow these steps to create the procedure for recording the registration:</p>
<ol>
<li>Expand the plus sign (+) next to your database, mwd.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code with the following as shown:</p>
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
CREATE PROCEDURE spRegistrationInsert 
   -- Add the parameters for the stored procedure here
   @FName varchar(50),
   @LName varchar(50),
   @Email varchar(50),
   @MailAddress varchar(100),
   @Attending bit,
   @Dinner varchar(2),
   @WhyNotAttend varchar(100),
   @HowManyAttending char(1),
   @TotalCost money,
   @Date datetime
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   INSERT INTO Registration(FName, LName, Email, MailAddress, Attending, Dinner,WhyNotAttend,HowManyAttending,TotalCost, Date)VALUES(@FName,@LName,@Email,@MailAddress,@Attending,@Dinner,@WhyNotAttend,@HowManyAttending,@TotalCost, @Date)
END
GO
</code></pre>
<p>As you can see from the code above, you create a procedure named spRegistrationInsert, give it parameters that correspond to each column in the database, and then write your insert statement. Before running the stored procedure on the database, from the main menu follow these steps to save the stored procedure:</p>
<ol>
<li>From the main menu, choose File : Save As.</li>
<li>In the Save As dialog, type "spRegistrationInsert" and then click OK.</li>
</ol>
<p>When completed, run the stored procedure by clicking execute right below the main menu. If ran succesfully, SQL Server will report "Commands executed successfully." Minimize SQL Server Management Studio for the time being.</p>
<p>Restore Visual Studio, and press F5 to run the project. Demo the functionality and press submit to ensure both toggle options work. You will get two records inserted in the database. When finished, press the stop button in Visual Studio.</p>
<p>We'll continue by writing our clear fields functionality <a href="default4.aspx">next</a>.</p>
</asp:Content>