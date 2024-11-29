using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KLTN_YourLook.Repository
{
    public class CategoryRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public CategoryRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all danh mục
        public async Task<List<AllCategoryViewModel>> GetAllCategory()
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst = await _dbConnection.QueryAsync<AllCategoryViewModel>("EXEC dbo.category_showall");
            return lst.ToList();
        }
        //tạo danh mục
        public async Task<int> CreateCategory(string madm, string tendm, string anhdaidien, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@madm", madm);
            parameters.Add("@tendm", tendm);
            parameters.Add("@anhdaidien", anhdaidien);
            parameters.Add("@createby", createby);
            parameters.Add("@createdate", DateTime.Now);
            parameters.Add("@ret", dbType: DbType.Int32, direction: ParameterDirection.Output); // Thêm tham số OUT

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("category_insert", parameters, commandType: CommandType.StoredProcedure);

            // Lấy kết quả từ tham số OUT
            int result = parameters.Get<int>("@ret");
            return result;
        }
        //sửa danh mục
        public async Task<int> UpdateCategory(int iddm,string madm, string tendm, string anhdaidien, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                iddm = iddm,
                madm = madm,
                tendm = tendm,
                anhdaidien = anhdaidien,
                modifiedby = modifiedby,
                modifieddate = DateTime.Now
            };
            var result= await _dbConnection.ExecuteAsync("category_update",parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        //Xóa danh mục
        public async Task<int> DeleteCategory(int iddm)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new {iddm = iddm};
            var result=await _dbConnection.ExecuteAsync("category_delete",parameters,commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
