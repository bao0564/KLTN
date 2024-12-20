using System.Data;
using Azure.Core;
using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Models;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
using Newtonsoft.Json;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
namespace KLTN_YourLook.Areas.Admin.Repository
{
    //phương thức dùng Procedure
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
        //tìm kiếm sp
        public async Task<IEnumerable<AllProductViewModel>> SearchProduct(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<AllProductViewModel>("product_search",parameters,commandType:CommandType.StoredProcedure);
            
        }
        //tạo sản phẩm mới
        //lưu vào bảng sản phẩm
        public async Task<int> CreateProduct(string masp, int iddm, string tensp, int nhomid, string anhsp, decimal pricemax, int giamgia, decimal pricemin, string motasp, bool iactive, bool ifeature, bool ifavorite, bool ihot, bool isale, string createby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@masp", masp);
            parameters.Add("@iddm", iddm);
            parameters.Add("@tensp", tensp);
            parameters.Add("@nhomid", nhomid);
            parameters.Add("@anhsp", anhsp);
            parameters.Add("@pricemax", pricemax);
            parameters.Add("@giamgia", giamgia);
            parameters.Add("@pricemin", pricemin);
            parameters.Add("@motasp", motasp);
            parameters.Add("@iactive", iactive);
            parameters.Add("@ifeature", ifeature);
            parameters.Add("@ifavorite", ifavorite);
            parameters.Add("@ihot", ihot);
            parameters.Add("@isale", isale);
            parameters.Add("@createby", createby);
            parameters.Add("@createdate", DateTime.Now);
            parameters.Add("@NewProductId", dbType: DbType.Int32, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("product_insert", parameters, commandType: CommandType.StoredProcedure);
            int newProductId = parameters.Get<int>("@NewProductId");
            return newProductId;
        }
        //lưu ảnh vào bảng ảnh
        public async Task<int> CreateImg(int idsp, string img)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idsp", idsp);
            parameters.Add("@img", img);
            int i = await _dbConnection.ExecuteAsync("img_insert", parameters, commandType: CommandType.StoredProcedure);
            return i;
        }
        //lưu chi tiết sản phẩm vào bảng chi tiết sản phẩm
        public async Task<int> CreateProductDetail(int idsp, int colorid,string namecolor, int sizeid,string namesize, decimal gialoai, int soluong)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idsp", idsp);
            parameters.Add("@colorid", colorid);
            parameters.Add("@namecolor", namecolor);
            parameters.Add("@sizeid", sizeid);
            parameters.Add("@namesize", namesize);
            parameters.Add("@gialoai", gialoai);
            parameters.Add("@soluong", soluong);
            int ctsp = await _dbConnection.ExecuteAsync("productdetail_insert", parameters, commandType: CommandType.StoredProcedure);
            return ctsp;
        }
        //hiển thị thông tin sản phẩm 
        public async Task<DbProduct> Product_Find(int idsp)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            return await _dbConnection.QueryFirstOrDefaultAsync<DbProduct>("product_find", new {idsp=idsp}, commandType: CommandType.StoredProcedure);
        }
        //hiển thị thông tin ảnh sản phẩm
        public async Task<IEnumerable<DbImg>> Product_Img_Find(int idsp)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            return await _dbConnection.QueryAsync<DbImg>("product_img_find", new { idsp = idsp }, commandType: CommandType.StoredProcedure);
        }
        //hiển thị thông tin chi tiết sản phẩm
        public async Task<IEnumerable<View_SP_ProductDetail>> Product_ProductDetail_Find(int idsp)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            return await _dbConnection.QueryAsync<View_SP_ProductDetail>("product_productdetail_find", new { idsp = idsp }, commandType: CommandType.StoredProcedure);

        }
        //Sửa thông tin sản phẩm trên bảng Dbproduct
        public async Task<int> UpdateProduct(int idsp, string masp, int iddm, string tensp, int nhomid, string anhsp, decimal pricemax, int giamgia, decimal pricemin, string motasp, bool iactive, bool ifeature, bool ifavorite, bool ihot, bool isale, string modifiedby)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                idsp,
                masp,
                iddm,
                tensp,
                nhomid,
                anhsp,
                pricemax,
                giamgia,
                pricemin,
                motasp,
                iactive,
                ifeature,
                ifavorite,
                ihot,
                isale,
                modifiedby,
                modifieddate=DateTime.Now
            };
            var result=await _dbConnection.ExecuteAsync("product_update",parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        //sửa thông tin ảnh sản phẩm trên bảng DbImg
        public async Task<int> UpdateImg(int idsp,string img)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                idsp,
                img
            };
            var result=await _dbConnection.ExecuteAsync("img_update",parameters,commandType: CommandType.StoredProcedure);
            return result;
        }
        //Sửa thông tin chi tiết Sản phẩm trong bảng Dbproductdetail
        public async Task<int> UpdateProductDetail(int idsp,int colorid,int sizeid,decimal gialoai,int soluong)
        {
            if( _dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new
            {
                idsp,
                colorid,
                sizeid,
                gialoai,
                soluong
            };
            var result = await _dbConnection.ExecuteAsync("productdetail_update", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        
    }
}
