using Microsoft.AspNetCore.Mvc;
using System.Data;
using KLTN_YourLook.Models;
using Dapper;

namespace KLTN_YourLook.Repository_YL
{
    public class SP_OrderCart:Controller
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public SP_OrderCart(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //hiển thị giỏ hàng
        public async Task<List<ShoppingCartItem>> Cart_View(int? idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst= await _dbConnection.QueryAsync<ShoppingCartItem>("cart_showall",new {idkh=idkh},commandType: CommandType.StoredProcedure);
            return lst.ToList();
        }
    }
}
