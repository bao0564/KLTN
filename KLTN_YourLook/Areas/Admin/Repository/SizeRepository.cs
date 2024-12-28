using Dapper;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class SizeRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public SizeRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        //tạo danh mục
        public async Task<(string msg,string error)> CreateSize(string masize, string namesize, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@masz", masize);
            parameters.Add("@namesz", namesize);
            parameters.Add("@createby", createby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("size_insert", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
        //sửa danh mục
        public async Task<(string msg,string error)> UpdateSize(int idsize, string masize, string namesize, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@masz", masize);
            parameters.Add("@namesz", namesize);
            parameters.Add("@modifiedby", modifiedby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            await _dbConnection.ExecuteAsync("size_update", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
        //Xóa danh mục
        public async Task<(string msg, string error)> DeleteSize(int idsz)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@idsz", idsz);
            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            await _dbConnection.ExecuteAsync("size_delete", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
    }
}
