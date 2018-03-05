using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
namespace RB2017
{
    public class RB
    {
		#region Declarations
		public int Id { get; set; }
		public string Article_Name { get; set; }
		#endregion

		#region Methods
		public static List<RB> ViewArticles()
		{
			SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["rb"].ConnectionString);
			SqlCommand cmd = new SqlCommand("spContactFormViewArticleList", conn);
			cmd.CommandType = CommandType.StoredProcedure;
			List<RB> articles = new List<RB>();
			try
			{
                RB r = new RB();
                r.Id = 0;
                r.Article_Name = "---select one---";
                articles.Add(r);
				conn.Open();
				SqlDataReader rdr = cmd.ExecuteReader();
				while (rdr.Read())
				{
					RB rb = new RB();
					rb.Id = Convert.ToInt32(rdr["Id"]);
					rb.Article_Name = rdr["Article_Name"].ToString();
					articles.Add(rb);
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.ToString());
			}
			finally
			{
				cmd.Dispose();
				conn.Close();
			}
			return articles;
		}
		#endregion
	}
}