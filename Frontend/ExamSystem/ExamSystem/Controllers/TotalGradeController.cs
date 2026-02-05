using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ExamSystem.Models;
using System.Data;
using System.Data.SqlClient;

namespace ExamSystem.Controllers
{
    public class TotalGradeController : Controller
    {
            private readonly string _connectionString;

            public TotalGradeController(IConfiguration configuration)
            {
                _connectionString = configuration.GetConnectionString("ExamDB");
            }

            public IActionResult Result(int studentId, int examId)
            {
                StudentExamTotalGrade model = null;

                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    string query = @"SELECT Student_Id, Exam_Id, Total_Grade
                             FROM Student_Exam
                             WHERE Student_Id = @StudentId AND Exam_Id = @ExamId";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    cmd.Parameters.AddWithValue("@ExamId", examId);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        model = new StudentExamTotalGrade
                        {
                            StudentId = (int)reader["Student_Id"],
                            ExamId = (int)reader["Exam_Id"],
                            TotalGrade = (int)reader["Total_Grade"]
                        };
                    }
                }

            return View("showTotalGrade", model);
        }
        }
    }

