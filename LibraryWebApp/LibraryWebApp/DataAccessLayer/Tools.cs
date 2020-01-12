using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LibraryWebApp.DataAccessLayer
{
    public class Tools
    {
        public static string getConnectionString()
        {   // taking the DB name from web.config
            return System.Configuration.ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;
        }


        public static string InsertStudent(BusinessLayer.Student newStudent)
        {
            SqlConnection conn;
            using (conn = new SqlConnection(getConnectionString()))
            {
                string sql = "SP_insertStudent";
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    SqlParameter[] param = new SqlParameter[6];
                    param[0] = new SqlParameter("@studentId", System.Data.SqlDbType.Int);
                    param[1] = new SqlParameter("@firstName", System.Data.SqlDbType.NVarChar, 50);
                    param[2] = new SqlParameter("@lastName",  System.Data.SqlDbType.NVarChar, 50);
                    param[3] = new SqlParameter("@birthdate", System.Data.SqlDbType.Date);
                    param[4] = new SqlParameter("@gender",    System.Data.SqlDbType.Char, 1);
                    param[5] = new SqlParameter("@class",     System.Data.SqlDbType.NVarChar, 50);

                    param[0].Value = newStudent.stId;
                    param[1].Value = newStudent.stFirstName;
                    param[2].Value = newStudent.stLastName;
                    param[3].Value = newStudent.stBirthDate;
                    param[4].Value = newStudent.stGender;
                    param[5].Value = newStudent.stClass;

                    for (int i = 0; i < param.Length; i++)
                    {
                        cmd.Parameters.Add(param[i]);
                    }

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    // cmd.ExecuteNonQuery(); // run this if no return expected
                    return cmd.ExecuteScalar().ToString();
                }

            }

        }

        public static string InsertBook(BusinessLayer.Book newBook)
        {
            SqlConnection conn;
            using (conn = new SqlConnection(getConnectionString()))
            {
                string sql = "SP_insertBook";
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    SqlParameter[] param = new SqlParameter[6];
                    param[0] = new SqlParameter("@bookTitle", System.Data.SqlDbType.NVarChar, 50);
                    param[1] = new SqlParameter("@bookPageCount", System.Data.SqlDbType.Int);
                    param[2] = new SqlParameter("@bookPrice", System.Data.SqlDbType.Float);
                    param[3] = new SqlParameter("@authorFirstName", System.Data.SqlDbType.NVarChar, 50);
                    param[4] = new SqlParameter("@authorLastName", System.Data.SqlDbType.NVarChar, 50);
                    param[5] = new SqlParameter("@typeName", System.Data.SqlDbType.NVarChar, 50);

                    param[0].Value = newBook.bkTitle;
                    param[1].Value = newBook.bkPageCount;
                    param[2].Value = newBook.bkPrice;
                    param[3].Value = newBook.bkAuthorFirstName;
                    param[4].Value = newBook.bkAuthorLasstName;
                    param[5].Value = newBook.bkTypeName;

                    for (int i = 0; i < param.Length; i++)
                    {
                        cmd.Parameters.Add(param[i]);
                    }

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    // cmd.ExecuteNonQuery(); // run this if no return expected
                    return cmd.ExecuteScalar().ToString();
                }

            }

        }

        public static string BorrowBook(BusinessLayer.Student borrowingStudent, BusinessLayer.Book requestedBook)
        {
            SqlConnection conn;
            using (conn = new SqlConnection(getConnectionString()))
            {
                string sql = "SP_borrow";
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    SqlParameter[] param = new SqlParameter[2];
                    param[0] = new SqlParameter("@studentId", System.Data.SqlDbType.Int);
                    param[1] = new SqlParameter("@bookId", System.Data.SqlDbType.Int);

                    param[0].Value = borrowingStudent.stId;
                    param[1].Value = requestedBook.bkId;

                    for (int i = 0; i < param.Length; i++)
                    {
                        cmd.Parameters.Add(param[i]);
                    }

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    // cmd.ExecuteNonQuery(); // run this if no return expected
                    return cmd.ExecuteScalar().ToString();
                }

            }

        }

        public static string ReturnBook(BusinessLayer.Student returningStudent, BusinessLayer.Book returnedBook)
        {
            SqlConnection conn;
            using (conn = new SqlConnection(getConnectionString()))
            {
                string sql = "SP_return";
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    SqlParameter[] param = new SqlParameter[2];
                    param[0] = new SqlParameter("@studentId", System.Data.SqlDbType.Int);
                    param[1] = new SqlParameter("@bookId", System.Data.SqlDbType.Int);

                    param[0].Value = returningStudent.stId;
                    param[1].Value = returnedBook.bkId;

                    for (int i = 0; i < param.Length; i++)
                    {
                        cmd.Parameters.Add(param[i]);
                    }

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    // cmd.ExecuteNonQuery(); // run this if no return expected
                    return cmd.ExecuteScalar().ToString();
                }

            }

        }

        public static DataSet GetStudentBooks(BusinessLayer.Student returningStudent)
        {
            SqlConnection conn;
            using (conn = new SqlConnection(getConnectionString()))
            {
                string sql = "SP_getStudentBooks";
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.Add(new SqlParameter("@studentId", returningStudent.stId));
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    
                    return ds;
                }

            }

        }


    }
}