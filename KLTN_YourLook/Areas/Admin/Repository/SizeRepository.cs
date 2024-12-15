using Dapper;
using System.Data;

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
        public async Task<int> CreateSize(string masize, string namesize, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@masize", masize);
            parameters.Add("@namesize", namesize);
            parameters.Add("@createby", createby);
            parameters.Add("@createdate", DateTime.Now);
            parameters.Add("@ret", dbType: DbType.Int32, direction: ParameterDirection.Output); // Thêm tham số OUT

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("size_insert", parameters, commandType: CommandType.StoredProcedure);

            // Lấy kết quả từ tham số OUT
            int result = parameters.Get<int>("@ret");
            return result;
        }
        //sửa danh mục
        public async Task<int> UpdateSize(int idsize, string masize, string namesize, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                idsize,
                masize,
                namesize,
                modifiedby,
                modifieddate = DateTime.Now
            };
            var result = await _dbConnection.ExecuteAsync("size_update", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        //Xóa danh mục
        public async Task<int> DeleteSize(int idsize)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new { idsize };
            var result = await _dbConnection.ExecuteAsync("size_delete", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
