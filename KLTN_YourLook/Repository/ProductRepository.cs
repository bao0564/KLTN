using System.Data;
using Azure.Core;
using Dapper;
using KLTN_YourLook.Areas.Admin.Models;
using Newtonsoft.Json;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
namespace KLTN_YourLook.Repository
{
    public class ProductRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public ProductRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all sản phẩm
        public async Task<List<AllProductViewModel>> GetAllProduct()
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst = await _dbConnection.QueryAsync<AllProductViewModel>("EXEC dbo.product_showall");
            return lst.ToList();
        }
        ////tạo sản phẩm mới
        //public async Task<int> CreateProduct(AddProductViewModel prd)
        //{
        //    if (_dbConnection == null)
        //    {
        //        throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
        //    }

        //    var parameters = new DynamicParameters();
        //    parameters.Add("@masp", prd.MaSp, DbType.String);
        //    parameters.Add("@iddm", prd.IdDm, DbType.String);
        //    parameters.Add("@tensp", prd.TenSp, DbType.String);
        //    parameters.Add("@saodanhgia", prd.SaoDanhGia, DbType.Int32);
        //    parameters.Add("@nhomid", prd.NhomId, DbType.Int32);
        //    parameters.Add("@anhsp", prd.AnhSp, DbType.String);
        //    parameters.Add("@pricemax", prd.PriceMax, DbType.Decimal);
        //    parameters.Add("@giamgia", prd.GiamGia, DbType.Int32);
        //    parameters.Add("@pricemin", prd.PriceMin, DbType.Decimal);
        //    parameters.Add("@luotxem", prd.LuotXem, DbType.Int32);
        //    parameters.Add("@luotban", prd.LuotSold, DbType.Int32);
        //    parameters.Add("@motasp", prd.MoTaSp, DbType.String);
        //    parameters.Add("@iactive", prd.IActive, DbType.Boolean);
        //    parameters.Add("@ifeature", prd.IFeature, DbType.Boolean);
        //    parameters.Add("@ihot", prd.IHot, DbType.Boolean);
        //    parameters.Add("@isale", prd.ISale, DbType.Boolean);
        //    parameters.Add("@createby", prd.CreateBy, DbType.String);
        //    parameters.Add("@createdate", prd.CreateDate, DbType.DateTime);

        //    // Chuyển đổi Images và Details
        //    parameters.Add("@Images", string.Join(";", prd.Images), DbType.String);
        //    parameters.Add("@Details", JsonConvert.SerializeObject(prd.Details), DbType.String);

        //    // Thực thi stored procedure và lấy ID sản phẩm mới
        //    var newProductId = await _dbConnection.ExecuteScalarAsync<int>(
        //        "dbo.product_create",
        //        parameters,
        //        commandType: CommandType.StoredProcedure
        //    );

        //    return newProductId;
        //}


    }
}
