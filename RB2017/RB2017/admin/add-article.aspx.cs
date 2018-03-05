using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.admin.BO;
namespace RB2017.admin
{
	public partial class add_article : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnInsertArticleName_Click(object sender, EventArgs e)
		{
			Article article = new Article();
			article.Article_Name = article_Name_TB.Text;
			article.InsertArticleName();
			Response.Redirect("default.aspx");
		}
	}
}