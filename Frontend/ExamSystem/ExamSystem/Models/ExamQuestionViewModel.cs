namespace ExamSystem.Models
{
    public class ExamQuestionViewModel
    {
        public int ExamId { get; set; }
        public int QuestionId { get; set; }
        public string QuesDescription { get; set; }
        public List<OptionViewModel> Options { get; set; } = new();
    }
}
