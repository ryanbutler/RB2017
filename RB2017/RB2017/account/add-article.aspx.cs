using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.account.BO;
namespace RB2017.account
{
    public partial class add_article : System.Web.UI.Page
    {
        Article a = new Article();
        protected void Page_Load(object sender, EventArgs e)
        {
        
        }

        protected void Add_Article(object s, EventArgs e)
        {
            a.Article_Name = articleNameTB.Text;
            a.InsertArticleName();
            Response.Redirect("default.aspx");
        }
    }
}