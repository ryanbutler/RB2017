using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.admin.BO;
namespace RB2017.admin
{
	public partial class _default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			List<Article> articles = Article.ViewAllArticles();
			rpSubmittedArticles.DataSource = articles;
			rpSubmittedArticles.DataBind();
		}
	}
}