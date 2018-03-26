<%@ Page Title="Creating a Application for admission and Confirmation System with ASP.NET and MS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default6.aspx.cs" Inherits="RB2017.articles.creating_a_application_for_admission_and_confirmation_system_asp_net_ms_sql_server.default6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Application for admission and Confirmation System with ASP.NET and MS SQL Server</h2>
<h3>Creating the Applicant Class</h3>
<p>You could very easily write the insert functionality directly inside your code behind file. However, if you ever needed to provide additional features such as update or delete functionality, writing this in the code behind file wouldn't lend itself very well to reusability. An object-oriented approach would. So, we'll create a simple class that could be reused later if needed. Follow these steps to create the applicant class:
</p>
<ol>
<li>From the solution explorer, right click and select Add : New Item.</li>
<li>In the add new item window, select class.</li>
<li>In the name text field, type Applicant and then click Add.</li>
</ol>
<p>In order to work with a database, you need to import some namespaces in the class. At the top of the class, add the following code:</p>
<pre><code>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace Applicant
{
    public class Applicant
    {
    }
}
</code></pre>
<p>As you can see from the code above, we added three below System.Web. They are as follows:</p>
<ol>
<li>System.Data: allows us to work with stored procedures in ADO.NET</li>
<li>System.Configuration: allows us to reference a connection key from our configuration file</li>
<li>System.Data.SqlClient: allows us to connect to SQL Server</li>
</ol>
<h3>Creating Our Declarations</h3>
<p>Let's first add our class-level variables so that we can get or set our data. Add the following code:</p>
<pre><code>
namespace ApplicantAdmission
{
	public class Applicant
	{
		#region Declarations
        public int Id { get; set; }
		public string SSN_3 { get; set; }
		public string SSN_2 { get; set; }
		public string SSN_4 { get; set; }
		public string FName { get; set; }
		public string LName { get; set; }
		public string Email { get; set; }
		public string Street_Address { get; set; }
		public string Phone_Area_Code_3 { get; set; }
		public string Phone_Num_3 { get; set; }
		public string Phone_Num_4 { get; set; }
		public int Year_Term_Intend_Enroll_Id { get; set; }
		public string Curr_High_School_Student { get; set; }
		public string Grad_From_High_School { get; set; }
		public int High_School_Id { get; set; }
		#endregion
	}
}
</code></pre>
<p>As you can see from the code above, you added a region that holds your class-level variables. These variables match your columns from the database table.</p>
<h3>Creating Your Method</h3>
<p>In order to insert our admission applicant, we need one method that will accept our parameters and insert the record. We do this by adding the following code:</p>
<pre><code>
        #region Methods
		public void InsertApplicant()
		{
			SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["aa"].ConnectionString);
			SqlCommand cmd = new SqlCommand("spInsertApplicant", conn);
			cmd.CommandType = CommandType.StoredProcedure;
			SqlParameter parameterSSN_3 = new SqlParameter("@SSN_3", SqlDbType.VarChar, 3);
			SqlParameter parameterSSN_2 = new SqlParameter("@SSN_2", SqlDbType.VarChar, 2);
			SqlParameter parameterSSN_4 = new SqlParameter("@SSN_4", SqlDbType.VarChar, 4);
			SqlParameter parameterFName = new SqlParameter("@FName", SqlDbType.VarChar, 100);
			SqlParameter parameterLName = new SqlParameter("@LName", SqlDbType.VarChar, 100);
			SqlParameter parameterEmail = new SqlParameter("@Email", SqlDbType.VarChar, 100);
			SqlParameter parameterStreet_Address = new SqlParameter("@Street_Address", SqlDbType.VarChar, 100);
			SqlParameter parameterPhone_Area_Code_3 = new SqlParameter("@Phone_Area_Code_3", SqlDbType.VarChar, 3);
			SqlParameter parameterPhone_Num_3 = new SqlParameter("@Phone_Num_3", SqlDbType.VarChar, 3);
			SqlParameter parameterPhone_Num_4 = new SqlParameter("@Phone_Num_4", SqlDbType.VarChar, 4);
			SqlParameter parameterYear_Term_Intend_Enroll_Id = new SqlParameter("@Year_Term_Intend_Enroll_Id", SqlDbType.Int, 1);
			SqlParameter parameterCurr_High_School_Student = new SqlParameter("@Curr_High_School_Student", SqlDbType.VarChar, 3);
			SqlParameter parameterGrad_From_High_School = new SqlParameter("@Grad_From_High_School", SqlDbType.VarChar, 3);
			SqlParameter parameterHigh_School_Id = new SqlParameter("@High_School_Id", SqlDbType.Int, 1);
			SqlParameter parameterDate_Submitted = new SqlParameter("@Date_Submitted", SqlDbType.DateTime);

			parameterSSN_3.Value = SSN_3;
			parameterSSN_2.Value = SSN_2;
			parameterSSN_4.Value = SSN_4;
			parameterFName.Value = FName;
			parameterLName.Value = LName;
			parameterEmail.Value = Email;
			parameterStreet_Address.Value = Street_Address;
			parameterPhone_Area_Code_3.Value = Phone_Area_Code_3;
			parameterPhone_Num_3.Value = Phone_Num_3;
			parameterPhone_Num_4.Value = Phone_Num_4;
			parameterYear_Term_Intend_Enroll_Id.Value = Year_Term_Intend_Enroll_Id;
			parameterCurr_High_School_Student.Value = Curr_High_School_Student;
			parameterGrad_From_High_School.Value = Grad_From_High_School;
			parameterHigh_School_Id.Value = High_School_Id;
			parameterDate_Submitted.Value = Date_Submitted;

			cmd.Parameters.Add(parameterSSN_3);
			cmd.Parameters.Add(parameterSSN_2);
			cmd.Parameters.Add(parameterSSN_4);
			cmd.Parameters.Add(parameterFName);
			cmd.Parameters.Add(parameterLName);
			cmd.Parameters.Add(parameterEmail);
			cmd.Parameters.Add(parameterStreet_Address);
			cmd.Parameters.Add(parameterPhone_Area_Code_3);
			cmd.Parameters.Add(parameterPhone_Num_3);
			cmd.Parameters.Add(parameterPhone_Num_4);
			cmd.Parameters.Add(parameterYear_Term_Intend_Enroll_Id);
			cmd.Parameters.Add(parameterCurr_High_School_Student);
			cmd.Parameters.Add(parameterGrad_From_High_School);
			cmd.Parameters.Add(parameterHigh_School_Id);
			cmd.Parameters.Add(parameterDate_Submitted);

			try
			{
				conn.Open();
				Id = Convert.ToInt32(cmd.ExecuteScalar());
			}
			catch (Exception ex)
			{
				throw new Exception(ex.ToString());
			}
			finally
			{
				cmd.Dispose();
				conn.Close();
			}
		}

		#endregion
</code></pre>
<p>In the code above, you do the following: </p>
<ol>
<li>Create a connection object and pass in your configuration key.</li>
<li>Create a command object and pass in your stored procedure and your connection object</li>
<li>Set your command object to accept a stored procedure.</li>
<li>Create SQL parameters to each of your database table columns, specify a parameter name and a database data type</li>
<li>Set each parameter's value to the appropriate variable.</li>
<li>Add each SQL parameter to the parameter's collection of your command object.</li>
</ol>
<p>If for any reason you can't connect to the database or execute your query, you wrap that inside a try/catch block and do the following:</p>
<ol>
<li>Call the open method of your connection object.</li>
<li>Call the execute scalar method of your command object, which inserts the record and returns back the unique id that our database table generated. (This will be useful when emailing the applicant a confirmation statement).</li>
<li>Catch and throw an exception if necesarry.</li>
<li>If everything succeeds, call the dispose method of the command object, and the close method of your connection object.</li>
</ol>
<h3>Create the Stored Procedure for Employee Directory</h3>
<p>If you still have the database on your task menu, simply restore it. From the object explorer, follow these steps to create the procedure for recording the registration:</p>
<ol>
<li>Expand the plus sign (+) next to your database, ApplicantAdmission.</li>
<li>Expand the plus sign (+) next to programmability.</li>
<li>Expand the plus sign (+) next to stored procedures.</li>
<li>Right click on stored procedures and select new stored procedure.</li>
</ol>
<p>Modify the generated code with the following as shown:</p>
<pre><code>
use ApplicantAdmission
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
CREATE PROCEDURE spInsertApplicant
   -- Add the parameters for the stored procedure here
   @SSN_3 varchar(3),
   @SSN_2 varchar(2),
   @SSN_4 varchar(4),
   @FName varchar(50),
   @LName varchar(50),
   @Email varchar(50),
   @Street_Address varchar(100),
   @Phone_Area_Code_3 varchar(3),
   @Phone_Num_3 varchar(3),
   @Phone_Num_4 varchar(4),
   @Year_Term_Intend_Enroll_Id int,
   @Curr_High_School_Student varchar(3),
   @Grad_From_High_School varchar(3),
   @High_School_Id int,
   @Date_Submitted datetime
AS
BEGIN
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   SET NOCOUNT ON;
    -- Insert statements for procedure here
   INSERT INTO Applicant(SSN_3, SSN_2, SSN_4, FName, LName, Email, Street_Address, Phone_Area_Code_3, Phone_Num_3, Phone_Num_4, Year_Term_Intend_Enroll_Id, Curr_High_School_Student, Grad_From_High_School, High_School_Id, Date_Submitted)
   VALUES(@SSN_3, @SSN_2, @SSN_4,@FName,@LName,@Email,@Street_Address,@Phone_Area_Code_3,@Phone_Num_3,@Phone_Num_4,@Year_Term_Intend_Enroll_Id,@Curr_High_School_Student,@Grad_From_High_School,@High_School_Id,@Date_Submitted);Select NEWID=SCOPE_IDENTITY()
END
GO
</code></pre>
<p>As you can see from the code above, you create a procedure named spInsertApplicant, give it parameters that correspond to each column in the database, and then write your insert statement. You'll notice at the end of our INSERT statement we have used a new concept called scope identity. The reason we use SCOPE_IDENTITY() will explained a little later in the article but for now just understand that when calling scope identity after a insert statement guarantees us that we'll capture the unique id generated by the database table during the insert transaction scope. Before running the stored procedure on the database, from the main menu follow these steps to save the stored procedure:</p>
<ol>
<li>From the main menu, choose File : Save As.</li>
<li>In the Save As dialog, type "spInsertApplicant" and then click OK.</li>
</ol>
<p>When completed, run the stored procedure by clicking execute right below the main menu. If ran succesfully, SQL Server will report "Commands executed successfully." Minimize SQL Server Management Studio for the time being.</p>
<p>We'll finish the article by writing the insert functionality and emailing a confirmation message <a href="default7.aspx">next</a>.</p>
</asp:Content>