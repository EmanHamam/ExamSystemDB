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



    // GET: StartExam
    public IActionResult StartExam()
    { return View(new StartExamViewModel()); }

    [HttpPost]
    public IActionResult StartExam(StartExamViewModel model, string actionType)
    {
        using var conn = new SqlConnection(_connectionString);
        conn.Open();

        
        if (string.IsNullOrWhiteSpace(model.StudentName))
        {
            ModelState.AddModelError("", "Please enter your name");
            return View(model);
        }

        int studentId, trackId;

        using (var cmd = new SqlCommand(
            "SELECT Id, Track_Id FROM Student WHERE CONCAT(FName,' ',LName)=@name", conn))
        {
            cmd.Parameters.AddWithValue("@name", model.StudentName);
            using var reader = cmd.ExecuteReader();
            if (!reader.Read())
            {
                ModelState.AddModelError("", "You are not exist");
                return View(model);
            }
            studentId = (int)reader["Id"];
            trackId = (int)reader["Track_Id"];
        }

        
        model.Courses.Clear();
        using (var cmd = new SqlCommand(
            @"SELECT c.Id, c.Course_Name
          FROM Course c
          INNER JOIN Course_Track ct ON c.Id = ct.Course_Id
          WHERE ct.Track_Id = @trackId", conn))
        {
            cmd.Parameters.AddWithValue("@trackId", trackId);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                model.Courses.Add(new Course
                {
                    Id = (int)reader["Id"],
                    Course_Name = reader["Course_Name"].ToString()
                });
            }
        }

       
        if (actionType == "SelectCourse")
        {
            if (model.CourseId == 0)
            {
                ModelState.AddModelError("", "Please select a course");
                return View(model);
            }

      
            bool allowed;
            using (var cmd = new SqlCommand(
                @"SELECT COUNT(*) FROM Course_Track WHERE Track_Id=@tid AND Course_Id=@cid", conn))
            {
                cmd.Parameters.AddWithValue("@tid", trackId);
                cmd.Parameters.AddWithValue("@cid", model.CourseId);
                allowed = (int)cmd.ExecuteScalar() > 0;
            }

            if (!allowed)
            {
                ModelState.AddModelError("", "You are not enrolled in this course");
                return View(model);
            }

            int examId;
            using (var cmd = new SqlCommand(
                "SELECT TOP 1 Exam_Id FROM Exam WHERE COURSE_ID=@cid ORDER BY EXDate DESC", conn))
            {
                cmd.Parameters.AddWithValue("@cid", model.CourseId);
                var result = cmd.ExecuteScalar();
                if (result == null)
                {
                    ModelState.AddModelError("", "No exam for this course");
                    return View(model);
                }
                examId = Convert.ToInt32(result);
            }

            // Redirect to TakeExam
            return RedirectToAction("TakeExam", new { examId, studentId });
        }

       
        return View(model);
    }

    public IActionResult TakeExam(int examId, int studentId)
    {
        var questions = new List<ExamQuestionViewModel>();

        using var conn = new SqlConnection(_connectionString);
        conn.Open();

        using var cmd = new SqlCommand("AssignExamToStudent", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@StudentId", studentId);
        cmd.Parameters.AddWithValue("@ExamId", examId);

        using var reader = cmd.ExecuteReader();

        while (reader.Read())
        {
            var qid = (int)reader["Question_Id"];

            var q = questions.FirstOrDefault(x => x.QuestionId == qid);

            if (q == null)
            {
                q = new ExamQuestionViewModel
                {
                    ExamId = examId,
                    QuestionId = qid,
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

        return View(questions);
    }


    [HttpPost]
    public IActionResult SubmitExam(int studentId, int examId, List<AnswerViewModel> answers)
    {
        using var conn = new SqlConnection(_connectionString);
        conn.Open();


        foreach (var ans in answers)
        {
            using var cmd = new SqlCommand("studentanswer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@ExamId", examId);
            cmd.Parameters.AddWithValue("@QuestionId", ans.QuestionId);

            cmd.Parameters.AddWithValue("@Answer",
                string.IsNullOrEmpty(ans.AnswerText)
                ? (object)DBNull.Value
                : ans.AnswerText);

            cmd.ExecuteNonQuery();
        }


        string fullName;

        using (var nameCmd = new SqlCommand(
            "SELECT CONCAT(FName,' ',LName) FROM Student WHERE Id=@id", conn))
        {
            nameCmd.Parameters.AddWithValue("@id", studentId);
            fullName = nameCmd.ExecuteScalar()?.ToString();
        }

        using var correctionCmd = new SqlCommand("EXAM_CORRECTION", conn);
        correctionCmd.CommandType = CommandType.StoredProcedure;
        correctionCmd.Parameters.AddWithValue("@E_ID", examId);
        correctionCmd.Parameters.AddWithValue("@S_NAME", fullName);

        var result = correctionCmd.ExecuteScalar();

        int grade = Convert.ToInt32(result);

        return RedirectToAction("Result", new { grade });
    }


    public IActionResult Result(int grade)
    {
        ViewBag.Grade = grade;
        return View();
    }
}
