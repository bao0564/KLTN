using Data.Models;

namespace KLTN_YourLook.Interface
{
    public interface Isanpham
    {
        DbProduct Add(DbProduct dbProduct);
        DbProduct Update(DbProduct dbProduct);
        DbProduct Delete(string Masp);
        DbProduct Search(string Masp);
        IEnumerable<DbProduct> GetAllProduct();
    }
    public class Product : Isanpham
    {
        private readonly YourlookContext _context;
        public Product(YourlookContext context)
        {
            _context = context;
        }
        public DbProduct Add(DbProduct dbProduct)
        {
            _context.DbProducts.Add(dbProduct);
            _context.SaveChanges();
            return dbProduct;
        }

        public DbProduct Delete(string Masp)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<DbProduct> GetAllProduct()
        {
            return _context.DbProducts;
        }

        public DbProduct Search(string Masp)
        {
            return _context.DbProducts.Find(Masp);
        }

        public DbProduct Update(DbProduct dbProduct)
        {
            _context.Update(dbProduct);
            _context.SaveChanges();
            return dbProduct;
        }
    }
}
