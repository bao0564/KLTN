using System.Data;
using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using static Azure.Core.HttpHeader;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class HomeRespository
    {

        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public HomeRespository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all khách hàng + tìm kiếm
        public async Task<IEnumerable<DbCustomer>> SearchCustomer(string keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<DbCustomer>("customer_search", parameters, commandType: CommandType.StoredProcedure);
        }
        //tạo mới admin
        public async Task<(string msg,string error)> CreateAdmin(string emaildn,string namedn,string passdn,string chucvu,string quyen)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@emaildn", emaildn);
            parameters.Add("@namedn", namedn);
            parameters.Add("@passdn", passdn);
            parameters.Add("@chucvu", chucvu);
            parameters.Add("@quyen", quyen);
            parameters.Add("@msg", dbType:DbType.String,size:500,direction:ParameterDirection.Output);
            parameters.Add("@error", dbType:DbType.String,size:500,direction:ParameterDirection.Output);
            
            await _dbConnection.ExecuteAsync("create_admin", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");

            return(msg, error);
        }
    }
}
