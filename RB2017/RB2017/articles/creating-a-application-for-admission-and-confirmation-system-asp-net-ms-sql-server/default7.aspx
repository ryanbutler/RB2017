<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default7.aspx.cs" Inherits="RB2017.articles.creating_a_application_for_admission_and_confirmation_system_asp_net_ms_sql_server.default7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $('#articles').addClass('articles');
</script>
<h2>Creating a Application for admission and Confirmation System with ASP.NET and MS SQL Server</h2>
<h3>Creating Your Applicant Object and Writing Your Submit Functionality</h3>
<p>Switch back to default.aspx.cs, and create your applicant object as shown below:</p>
<pre><code>
namespace ApplicantAdmission
{
    protected void btnSubmit_Click(object sender, EventArgs e)
        {
			Applicant applicant = new Applicant();
        }
}
</code></pre>
<p>As you can see from the code above, you create a new instance of your applicant object, which contains references to the variables needed to make a database submission. Next, you need to capture the submission (applicant) functionality, by adding the following code:</p>
<pre><code>
protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Applicant applicant = new Applicant();
            applicant.SSN_3 = ssn_3TB.Text;
			applicant.SSN_2 = ssn_2TB.Text;
			applicant.SSN_4 = ssn_4TB.Text;
			applicant.FName = FNameTB.Text;
			applicant.LName = LNameTB.Text;
			applicant.Email = emailTB.Text;
			applicant.Street_Address = streetAddressTB.Text;
			applicant.Phone_Area_Code_3 = phoneAreaCodeTB.Text;
			applicant.Phone_Num_3 = phoneNum3TB.Text;
			applicant.Phone_Num_4 = phoneNum4TB.Text;
			applicant.Year_Term_Intend_Enroll_Id = Convert.ToInt32(ddlyearIntendToEnroll.SelectedIndex);
			applicant.Curr_High_School_Student = rblCurrentHighSchoolStudent.SelectedItem.ToString();
			applicant.Grad_From_High_School = rblGraduatingHighSchool.SelectedItem.ToString();
			applicant.High_School_Id = Convert.ToInt32(ddlHighSchoolAttend.SelectedIndex);
			applicant.Date_Submitted = DateTime.Now;
			applicant.InsertApplicant();
            phApplication.Visible = false;
			phSuccess.Visible = true;
        }
</code></pre>
<p>In the code above, you do the following:</p>
<ol>
<li>Set each of our variables to the appropriate Web control value's property in order to get its current value.</li>
<li>Call the insert applicant method of your applicant object.</li>
<li>Set your initial form's visbility to false and your success to visible.</li>
</ol>
<p>Restore Visual Studio, and press F5 to run the project. Demo the functionality and press submit to ensure the toggle's work and you get a record inserted in the database table. When finished, press the stop button in Visual Studio.</p>

<h3>Writing the Email Message</h3>
<p>Even though you have a record of the applicant, you need a way to email them a confirmation. You'll do this from your code-behind file. Open default.aspx.cs and add the following name spaces:</p>
<pre><code>
sing System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Text;
</code></pre>
<p>As you can see from the code above, you added two name spaces: </p>
<ol>
<li>System.Net.Mail: this for working with mail objects</li>
<li>System.Text: this is for using the string builder class</li>
</ol>
<p>Right below your submit event handler, write a method that will build your email message, as shown below:</p>
<pre><code>
protected void BuildEmailMsg(Applicant applicant)
        {
             applicant.ViewAdmissionApplicant(applicant.Id);

			StringBuilder sb = new StringBuilder();
			sb.Append("First Name: " + applicant.FName.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Last Name: " + applicant.LName.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Email: " + applicant.Email.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Street Address: " + applicant.Street_Address.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Area code: " + applicant.Phone_Area_Code_3.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Phone number: + " + applicant.Phone_Num_3.ToString() + "-" + applicant.Phone_Num_4.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Current High School Student? " + applicant.Curr_High_School_Student.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("Year you intend to enroll? " + applicant.Year_Intend_Enroll_Year.ToString());
			sb.Append(Environment.NewLine);
			sb.Append("High School from where you are graduating from? " + applicant.High_School_Name.ToString()); 

            MailMessage msg = new MailMessage(applicant.Email.ToString(),"college@admissions.com");
			msg.IsBodyHtml = false;
			msg.Subject = "Applicant for Admission";
			msg.Body = sb.ToString();
			SmtpClient smtp = new SmtpClient();
			smtp.Host = "mail.admissions.com";
			smtp.Send(msg);       
        }
</code></pre>
<p>As you can see from the code above, you do the following:</p>
<ol>
<li>Create a method named BuildEmailMsg and pass in our applicant class</li>
<li>Use the instance of our applicant class to call ViewAdmissionApplicant and pass in the id we got from our SCOPE_IDENTITY call from earlier</li>
<li>Use string builder object sb and its append method and pass in all fields except social security number</li>
<li>Create a msg object from the MailMessage class and do the following:
<ul>
<li>Pass in the email the applicant entered as the from address, and then send the message to the desired email address</li>
<li>Set the IsBodyHtml to false</li>
<li>Set the subject to a literal string of your choice</li>
<li>Set the body to the string builder object</li>
</ul>
 </li>
<li>Create an object from the SmtpClient class and do the following
<ul>
<li>Set the host to an appropriate mail host</li>
<li>Call the send method and pass our mail message object</li>
</ul>
</li>
</ol>
<p>You are using a string builder object instead of concatenation because performance tests have shown that anytime you need to concatenate five or more lines, string builder is faster and more efficient than manual concatenation.</p>
<h3>Some caveats</h3>
<p>The most important caveat to make note of is if this were accepting real entries, you would need to place these files on a secured web server. Furthermore, the data entered would need to be stored on a secured database server. Lastly, we didn't include the "fake" social security numbers in the confirmation email because we can't guarantee that the email(s) are transferred or communicated over a secured mail server.</p>
<h3>Summary</h3>
<p>In this article you learned how to create a registration event system, as well as a confirmation email message. Take the knowledge you gained in the article and use it to meet any requirement or need you may have. </p>
<p>If you have questions, <a href="../../contact.aspx">contact me</a>.</p>
</asp:Content>