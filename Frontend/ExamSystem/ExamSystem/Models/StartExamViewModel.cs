namespace ExamSystem.Models
{
        public class StartExamViewModel
        {
            public string StudentName { get; set; }
            public int CourseId { get; set; }

            public List<Course> Courses { get; set; } = new();
        }

}
