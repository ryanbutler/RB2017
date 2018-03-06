using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using RB2017;
namespace RB2017
{
    public partial class Contact : Page
    {
		protected void Page_Load(object sender, EventArgs e)
        {
			if (!IsPostBack)
			{
				LoadData();
			}
		}

		protected void Send_Mail(object sender, EventArgs e)
		{
			if (IsValid)
			{

				SmtpClient smtpClient = new SmtpClient("ryanbutler.ws", 25);
				string email = EmailTB.Text.ToString();
				Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
				Match match = regex.Match(email);
				if (match.Success)
				{
					MailAddress from = new MailAddress(email);
					smtpClient.Credentials = new System.Net.NetworkCredential("--replace with email", "--replace with password");
					smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;

					MailMessage mailMessage = new MailMessage(EmailTB.Text.ToString(), "--replace with email");
					mailMessage.Subject = "Contact Me";
					mailMessage.IsBodyHtml = false;
                    StringBuilder sb = new StringBuilder();
					sb.Append("First Name: " + FNameTB.Text);
					sb.Append(Environment.NewLine);
					sb.Append("Last Name: " + LNameTB.Text);
					sb.Append(Environment.NewLine);
					sb.Append("Email: " + EmailTB.Text);
					sb.Append(Environment.NewLine);
					sb.Append("Which article? " + ddlWhichArticle.SelectedItem.Text.ToString());
					sb.Append(Environment.NewLine);
					sb.Append("Comments: " + CommentsTB.Text);
					sb.Append(Environment.NewLine);
					mailMessage.Body = sb.ToString();

					try
					{
						smtpClient.Send(mailMessage);
						formPH.Visible = false;
						successPH.Visible = true;
					}

					catch (Exception ex)
					{
						throw new Exception(ex.Message.ToString());
					}
				}
				else
				{
					formPH.Visible = true;
					successPH.Visible = false;
					invalidEmailFormat.Visible = true;
				}
			}
		}

		protected void LoadData()
		{
			//call method to fill drop down list
			List<RB> articles = RB.ViewArticles();
			//need to add data text field and data value field for bindings to work on drop down list
			ddlWhichArticle.DataTextField = "Article_Name";
			ddlWhichArticle.DataValueField = "Id";
			ddlWhichArticle.DataSource = articles;
			ddlWhichArticle.DataBind();
		}
    }
}