using Dapper;
using KLTN_YourLook.Areas.Admin.Models;
using System.Data;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class OrderRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public OrderRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all đơn hàng
        public async Task<List<AllOrderViewModle>> GetAllOrder()
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst = await _dbConnection.QueryAsync<AllOrderViewModle>("order_showall", commandType: CommandType.StoredProcedure);
            return lst.ToList();
        }
        //tìm kiếm dơn hàng
        public async Task<IEnumerable<AllOrderViewModle>> SearchOrder(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<AllOrderViewModle>("order_search", parameters, commandType: CommandType.StoredProcedure);

        }
        //lấy all đơn hàng theo trạng thái
        public async Task<List<AllOrderViewModle>> GetAllOrderFilter(bool? odsuccess,bool? odreadly, bool? odtranport, bool? complete)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parames = new DynamicParameters();
            parames.Add("@odsuccess", odsuccess);
            parames.Add("@odreadly", odreadly);
            parames.Add("@odtranport", odtranport);
            parames.Add("@complete", complete);
            var lst = await _dbConnection.QueryAsync<AllOrderViewModle>("order_showall_filter", parames,commandType:CommandType.StoredProcedure);
            return lst.ToList();
        }
        //lấy ra chi tiết đơn hàng 
        //public async Task<OrderDetailViewModel>
    }
}
