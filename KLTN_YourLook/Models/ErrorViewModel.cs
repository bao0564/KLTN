using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Models 
{
    public class ErrorViewModel
    {
        public string? RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
    public class View_Register //để đăng nhập bắt buộc mật khẩu:))
    {
        public string TenKh { get; set; }
        public string Sdt { get; set; }
        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        public string Email { get; set; }
        [DataType(DataType.Password)]
        [StringLength(25)]
        public string Passwords { get; set; }
        [Display(Name = "Confirm password")]
        [Compare("Passwords", ErrorMessage = "Mật khẩu không đúng.")]
        [StringLength(25)]
        public string ConfirmPasswords { get; set; }

    }
}
