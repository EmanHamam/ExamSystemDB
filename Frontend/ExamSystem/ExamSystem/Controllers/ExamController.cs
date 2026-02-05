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

            // 1️⃣ save answers
            foreach (var ans in answers)
            {
                var cmd = new SqlCommand("studentanswer", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StudentId", studentId);
                cmd.Parameters.AddWithValue("@ExamId", examId);
                cmd.Parameters.AddWithValue("@QuestionId", ans.QuestionId);
                cmd.Parameters.AddWithValue("@Answer", ans.AnswerText ?? "");
                cmd.ExecuteNonQuery();
            }

            // 2️⃣ get student name from id
            string fullName = "";
            using (var nameCmd = new SqlCommand(
                   "SELECT CONCAT(FName, ' ', LName) FROM Student WHERE Id = @StudentId", conn))
            {
                nameCmd.Parameters.AddWithValue("@StudentId", studentId);
                fullName = nameCmd.ExecuteScalar()?.ToString();
            }

            if (string.IsNullOrWhiteSpace(fullName))
                return Content("Student not found");

            // Trim whitespace
            fullName = fullName.Trim();

            // Call SP
            SqlCommand correctionCmd = new SqlCommand("EXAM_CORRECTION", conn);
            correctionCmd.CommandType = CommandType.StoredProcedure;
            correctionCmd.Parameters.AddWithValue("@E_ID", examId);
            correctionCmd.Parameters.AddWithValue("@S_NAME", fullName);

            int totalGrade = Convert.ToInt32(correctionCmd.ExecuteScalar());

            // 4️⃣ show result
            return RedirectToAction("Show", "TotalGrade", new { grade = totalGrade });
        }
    }
}


