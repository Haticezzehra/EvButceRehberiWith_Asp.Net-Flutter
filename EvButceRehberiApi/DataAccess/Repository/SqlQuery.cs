using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
 

    
        public static class SqlQuery
        {
            public static int dataCount { get => 10; }

            public static DataTable GetData(String queryString)
            {

                DataTable dt = new DataTable();
            using (SqlConnection connection = new SqlConnection("Server=HATICEZZEHRA\\SQLEXPRESS;Database=EvButceRehberi;Integrated Security=True;"))
            {
                    connection.Open();

                    using (SqlCommand cmd = new SqlCommand(queryString, connection))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            dt.Load(reader);
                            reader.Close(); // SqlDataReader'ı kapat
                        }
                    }

                    connection.Close(); // SqlConnection'ı kapat
                }


                return dt;
            }
        }


    

}
