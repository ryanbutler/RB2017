using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.account.BO;
namespace RB2017.account
{
    public partial class edit_article : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack)
            {
                UpdateData();
            }
            else
            {
                GetData();
            }
        }
        
        protected void GetData()
        {
            Guid myguid;
            if (Guid.TryParse(Request.QueryString["guid"].ToString(), out myguid))
            {
                List<Article> viewEditArticle = Article.ViewEditArticleName(myguid);
                articleNameTB.Text = viewEditArticle[0].Article_Name.ToString();
            }
        }
        protected void Update_Article(object sender, EventArgs e)
        {
            UpdateData();
        }

        protected void UpdateData()
        {
            Article a = new Article();
            Guid updateGuid;
            if (Guid.TryParse(Request.QueryString["guid"].ToString(), out updateGuid))
            {
                a.Article_Name = articleNameTB.Text;
                a.guid=updateGuid;
                a.UpdateArticleName(a.guid);
                Response.Redirect("default.aspx");
            }
        }
    }
}