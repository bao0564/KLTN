using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Data.Models
{
	[Table("DbCart")]
	public class DbCart:DbAbstract
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int IdSp { get; set; }
		public int IdKh { get; set; }
		public int ProductQuantity { get; set; }
		public int ColorId { get; set; }
		public int SizeId { get; set; }

		public virtual DbProduct? product { get; set; }
		public virtual DbCustomer? customer { get; set; }
        public virtual DbSize? size { get; set; }
        public virtual DbColor? color { get; set; }
    }
}
