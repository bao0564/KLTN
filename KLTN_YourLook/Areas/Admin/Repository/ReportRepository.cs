using System.Data;
using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class ReportRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public ReportRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //báo cáo tồn kho
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
        //bc doanh thu
        public async Task<List<Report_Revenue_ViewModel>> Search_Report_Revenue(DateTime? date, DateTime? todate)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@date", date);
            parameters.Add("@todate", todate);

            var data = await _dbConnection.QueryAsync<Report_Revenue_ViewModel>("Report_Revenue", parameters, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        //gợi ý mactsp trong bc tồn kho
        public async Task<List<Sugget_Mactsp>> Sugget_Mactsp(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);

            var data = await _dbConnection.QueryAsync<Sugget_Mactsp>("sp_sugget_mactsp", parameters, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
    }
}
