using Dapper;
using Data.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;

namespace KLTN_YourLook.Repository_YL
{
    public class SP_Access : Controller
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        private readonly YourlookContext _context;
        public SP_Access(IDbConnection dbConnection, YourlookContext context)
        {
            _dbConnection = dbConnection;
            _context = context;
        }
        //lưu mã quên mật khẩu 
        public async Task<string> sp_AddCodeForgotPass(int idkh,string code)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idkh", idkh);
            parameters.Add("@code", code);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("sp_forgot_pass_code", parameters, commandType: CommandType.StoredProcedure);

            var error = parameters.Get<string>("@error");
            return error;
        }
        //đặt lại mật khẩu
        public async Task<string> sp_ChangePass(string email,string pass,string confirmpass)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameter= new DynamicParameters();
            parameter.Add("@email", email);
            parameter.Add("@pass", pass);
            parameter.Add("@confirmpass", confirmpass);
            parameter.Add("@error",dbType:DbType.String,size:500,direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("sp_check_pass_code", parameter, commandType: CommandType.StoredProcedure);
            var error = parameter.Get<string>("@error");
            return error;
        }
    }
}
