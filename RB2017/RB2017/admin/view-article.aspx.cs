using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RB2017.admin.BO;
namespace RB2017.admin
{
	public partial class view_article : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				Guid uniqueguid = new Guid(Request.QueryString["guid"].ToString());
				
			}
			catch
			{

			}
		}
	}
}