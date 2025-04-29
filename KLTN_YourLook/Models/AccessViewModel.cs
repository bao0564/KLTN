namespace KLTN_YourLook.Models
{
    public class AccessViewModel
    {
    } 
    public class ForgotPasswordViewModel
    {
        public string Email { get; set; }
    }
    public class CheckCodeViewModel
    {
        public string Email { get; set; }
        public string Code { get; set; }
    }
    public class ChangePassViewModel
    {
        public string Email { get; set; }
        public string Pass { get; set; }
        public string ConfirmPass { get; set; }
    }
}
