using System.ComponentModel.DataAnnotations;

namespace KLTN_YourLook.Areas.Admin.Models
{
    public class View_Home
    {
    }
    public class View_Admin_Register
    {
        public string EmailDn { get; set; }
        public string NameDn { get; set; }
        public string PasswordDn { get; set; }
        public string ChucVu { get; set; }
        public string Quyen { get; set; }
    }
}
