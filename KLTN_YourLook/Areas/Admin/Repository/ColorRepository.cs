using Dapper;
using System.Data;

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
        public async Task<int> CreateColor(string macl, string tencl, string img, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@macl", macl);
            parameters.Add("@tencl", tencl);
            parameters.Add("@img", img);
            parameters.Add("@createby", createby);
            parameters.Add("@createdate", DateTime.Now);
            parameters.Add("@ret", dbType: DbType.Int32, direction: ParameterDirection.Output); // Thêm tham số OUT

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("color_insert", parameters, commandType: CommandType.StoredProcedure);

            // Lấy kết quả từ tham số OUT
            int result = parameters.Get<int>("@ret");
            return result;
        }
        //sửa color
        public async Task<int> UpdateColor(int idcl, string macl, string tencl, string img, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                idcl,
                macl,
                tencl,
                img,
                modifiedby,
                modifieddate = DateTime.Now
            };
            var result = await _dbConnection.ExecuteAsync("color_update", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        //Xóa color
        public async Task<int> DeleteColor(int idcl)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new { idcl };
            var result = await _dbConnection.ExecuteAsync("color_delete", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
