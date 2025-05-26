using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KLTN_YourLook.Areas.Admin.Repository
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
        //lấy all danh mục+ tìm kiếm
        public async Task<IEnumerable<AllCategoryViewModel>> SearchCategory(string keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters= new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<AllCategoryViewModel>("category_search",parameters,commandType:CommandType.StoredProcedure);            
        }
        //tạo danh mục
        public async Task<(string msg,string error)> CreateCategory(string madm,string tendm, string anhdaidien, string createby)
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

            parameters.Add("@msg", dbType: DbType.String,size:500, direction: ParameterDirection.Output); 
            parameters.Add("@error", dbType: DbType.String,size:500, direction: ParameterDirection.Output); 

            // Thực thi stored procedure
            await _dbConnection.ExecuteAsync("category_insert", parameters, commandType: CommandType.StoredProcedure);

            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
        //sửa danh mục
        public async Task<(string msg,string error)> UpdateCategory(int iddm, string tendm, string anhdaidien, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@iddm", iddm);
            parameters.Add("@tendm", tendm);
            parameters.Add("@anhdaidien", anhdaidien);
            parameters.Add("@modifiedby", modifiedby);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("category_update", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
        //Xóa danh mục
        public async Task<(string msg,string error)> DeleteCategory(int iddm)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@iddm", iddm);

            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("category_delete", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg,error);
        }
    }
}
