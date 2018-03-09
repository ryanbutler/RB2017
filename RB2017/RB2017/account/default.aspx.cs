using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.account.BO;
namespace RB2017.account
{
    public partial class _default : System.Web.UI.Page
    {
        Article a = new Article();
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Article> articles = a.ViewArticles();
            rpArticlesView.DataSource = articles;
            rpArticlesView.DataBind();
        }
    }
}