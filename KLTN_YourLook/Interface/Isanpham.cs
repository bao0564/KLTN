using Data.Models;

namespace KLTN_YourLook.Interface
{
    public interface Isanpham
    {
        DbProduct Add(DbProduct dbProduct);
        DbProduct Update(DbProduct dbProduct);
        DbProduct Delete(int idsp);
        DbProduct Search(int idsp);
        IEnumerable<DbProduct> GetAllProduct();
    }
    public class Product : Isanpham
    {
        private readonly YourlookContext _context;
        public Product(YourlookContext context)
        {
            _context = context;
        }
        public DbProduct Add(DbProduct model)
        {
            _context.DbProducts.Add(model);
            _context.SaveChanges();
            return model;
        }

        public DbProduct Delete(int idsp)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<DbProduct> GetAllProduct()
        {
            return _context.DbProducts;
        }

        public DbProduct Search(int idsp)
        {
            return _context.DbProducts.Find(idsp);
        }

        public DbProduct Update(DbProduct model)
        {
            _context.Update(model);
            _context.SaveChanges();
            return model;
        }
    }
}
