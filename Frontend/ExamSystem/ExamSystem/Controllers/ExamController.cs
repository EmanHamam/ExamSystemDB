using ExamSystem.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

public class ExamController : Controller
{
    private readonly string _connectionString;

    public ExamController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("ExamDB");
    }

    
    public IActionResult TakeExam(int examId, int studentId)
    {
        var questions = new List<ExamQuestionViewModel>();

        using (var conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (var cmd = new SqlCommand("AssignExamToStudent", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StudentId", studentId);
                cmd.Parameters.AddWithValue("@ExamId", examId);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var q = questions.FirstOrDefault(x => x.QuestionId == (int)reader["Question_Id"]);
                        if (q == null)
                        {
                            q = new ExamQuestionViewModel
                            {
                                ExamId = examId,
                                QuestionId = (int)reader["Question_Id"],
                                QuesDescription = reader["Ques_Description"].ToString()
                            };
                            questions.Add(q);
                        }

                        if (reader["Option_Id"] != DBNull.Value)
                        {
                            q.Options.Add(new OptionViewModel
                            {
                                OptionId = (int)reader["Option_Id"],
                                Text = reader["Option_Text"].ToString()
                            });
                        }
                    }
                }
            }
        }

        return View(questions);
    }

    
    [HttpPost]
    public IActionResult SubmitExam(int studentId, int examId, List<AnswerViewModel> answers)
    {
        using (var conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            foreach (var ans in answers)
            {
                using (var cmd = new SqlCommand("studentanswer", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    cmd.Parameters.AddWithValue("@ExamId", examId);
                    cmd.Parameters.AddWithValue("@QuestionId", ans.QuestionId);
                    cmd.Parameters.AddWithValue("@Answer", ans.AnswerText ?? "");
                    cmd.ExecuteNonQuery();
                }
            }
        }

        return Content("✅ Exam submitted successfully!");
    }
}
