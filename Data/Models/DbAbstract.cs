using System.ComponentModel.DataAnnotations;

namespace Data.Models
{
    public abstract class DbAbstract
    {
        public DateTime? CreateDate { get; set; }
        [StringLength(25)]
        public string? CreateBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        [StringLength(25)]
        public string? ModifiedBy { get; set; }
    }
}
