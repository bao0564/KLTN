using System.Data;
using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class ReportRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public ReportRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        public async Task<(List<Report_Inventory_ViewModel> data, string msg, string error)> Search_Report_Inventory(string? keyword, int quantity)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            parameters.Add("@quantity", quantity);
            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            var data = (await _dbConnection.QueryAsync<Report_Inventory_ViewModel>("Report_Inventory", parameters, commandType: CommandType.StoredProcedure)).ToList();
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (data, msg, error);
        }
    }
}
