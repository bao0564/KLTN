using System.Data;
using Dapper;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class GroupRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public GroupRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        //tạo nhóm
        public async Task<(string msg, string error)> CreateGroup(string manhom, string tennhom, string anhdaidien, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@manhom", manhom);
            parameters.Add("@tennhom", tennhom);
            parameters.Add("@anhdaidien", anhdaidien);
            parameters.Add("@createby", createby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("group_insert", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
        //sửa nhóm
        public async Task<(string msg, string error)> UpdateGroup(int idnhom, string tennhom, string manhom, string anhdaidien, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idnhom", idnhom);
            parameters.Add("@tennhom", tennhom);
            parameters.Add("@manhom", manhom);
            parameters.Add("@anhdaidien", anhdaidien);
            parameters.Add("@modifiedby", modifiedby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("group_update", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
        //Xóa nhóm
        public async Task<(string msg, string error)> DeleteGroup(int idnhom)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idnhom", idnhom);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("group_delete", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
    }
}
