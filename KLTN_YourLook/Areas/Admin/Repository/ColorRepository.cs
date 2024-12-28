using Dapper;
using System.Data;
using System.Threading;
using static Azure.Core.HttpHeader;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class ColorRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public ColorRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //tạo màu
        public async Task<(string msg,string error)> CreateColor(string namecl,string mahex, string img, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@namecl", namecl);
            parameters.Add("@mahex", mahex);
            parameters.Add("@img", img);
            parameters.Add("@createby", createby);

            parameters.Add("@newidcl", dbType: DbType.Int32, direction: ParameterDirection.Output);
            parameters.Add("@newmacl", dbType: DbType.String, size: 10, direction: ParameterDirection.Output);
            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("color_insert", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");

            return (msg,error);
        }
        //sửa color
        public async Task<(string msg, string error)> UpdateColor(int idcl, string namecl,string mahex, string img, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idcl", idcl);
            parameters.Add("@namecl", namecl);
            parameters.Add("@mahex", mahex);
            parameters.Add("@img", img);
            parameters.Add("@modifiedby", modifiedby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("color_update", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
        //Xóa color
        public async Task<(string msg,string error)> DeleteColor(int idcl)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idcl", idcl);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("color_delete", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
    }
}
