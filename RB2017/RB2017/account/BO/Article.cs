using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace RB2017.account.BO
{
    public class Article
    {   
             #region Declarations
            public string Article_Name { get; set; }
            public Guid guid { get; set; }
            #endregion

            #region Methods
            public void InsertArticleName()
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["rb"].ConnectionString);
                SqlCommand cmd = new SqlCommand("spInsertArticleName", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parameterArticleName = new SqlParameter("@Article_Name", SqlDbType.VarChar, 100);
                parameterArticleName.Value = Article_Name;

                cmd.Parameters.Add(parameterArticleName);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message.ToLower());
                }
                finally
                {
                    cmd.Dispose();
                    conn.Close();
                }
            }

            public List<Article> ViewArticles()
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["rb"].ConnectionString);
                SqlCommand cmd = new SqlCommand("spArticleList", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                List<Article> articles = new List<Article>();

                try
                {
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        Article a = new Article();
                        a.guid = new Guid(rdr["Guid"].ToString());
                        a.Article_Name = rdr["Article_Name"].ToString();
                        articles.Add(a);
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message.ToString());
                }
                finally
                {
                    cmd.Dispose();
                    conn.Close();
                }
                return articles;
            }

            public static List<Article> ViewEditArticleName(Guid guid)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["rb"].ConnectionString);
                SqlCommand cmd = new SqlCommand("spViewArticleName", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parameterUniqueGuid = new SqlParameter("@Guid", SqlDbType.UniqueIdentifier, 36);
                parameterUniqueGuid.Value = guid;
                cmd.Parameters.Add(parameterUniqueGuid);
                List<Article> articles = new List<Article>();
                try
                {
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        Article a = new Article();
                        a.Article_Name = rdr["Article_Name"].ToString();
                        articles.Add(a);
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message.ToString());
                }
                finally
                {
                    cmd.Dispose();
                    conn.Close();
                }
                return articles;
            }

            public void UpdateArticleName(Guid guid)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["rb"].ConnectionString);
                SqlCommand cmd = new SqlCommand("spUpdateArticleName", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parameterUniqueGuid = new SqlParameter("@Guid", SqlDbType.UniqueIdentifier, 36);
                SqlParameter parameterArticleName = new SqlParameter("@Article_Name", SqlDbType.VarChar, 100);
                parameterUniqueGuid.Value = guid;
                parameterArticleName.Value = Article_Name;
                cmd.Parameters.Add(parameterArticleName);
                cmd.Parameters.Add(parameterUniqueGuid);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch(Exception e)
                {
                    throw new Exception(e.Message.ToString());
                
                }finally
                {

                cmd.Dispose();
                conn.Close();
            }
        }
            #endregion

        }
}