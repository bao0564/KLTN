using Microsoft.AspNetCore.Mvc;
using System.Data;
using KLTN_YourLook.Models;
using Dapper;

namespace KLTN_YourLook.Repository_YL
{
    public class SP_OrderCart:Controller
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public SP_OrderCart(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //hiển thị giỏ hàng
        public async Task<List<ShoppingCartItem>> Cart_View(int? idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst= await _dbConnection.QueryAsync<ShoppingCartItem>("cart_showall",new {idkh=idkh},commandType: CommandType.StoredProcedure);
            return lst.ToList();
        }
        //thêm sp vào giỏ hàng (DbCart)
        public async Task<(string msg, string error)> Add_To_Cart(int idsp,int idkh,int quantity,int colorid,int sizeid)
        {
            if(_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("idsp", idsp);
            parameters.Add("idkh",idkh);
            parameters.Add("quantity", quantity);
            parameters.Add("colorid", colorid);
            parameters.Add("sizeid",sizeid);
            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            //var result = await _dbConnection.QueryFirstOrDefaultAsync<string>("product_in_cart", parameters, commandType: CommandType.StoredProcedure);
            await _dbConnection.ExecuteAsync("product_in_cart", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");

            return (msg, error);
        }
		//Thay đổi số lượng sản phẩm trong giỏ hàng
        public async Task<bool> Update_Cart(int idsp, int idkh, int quantity, int colorid, int sizeid)
        {
			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var parameters = new DynamicParameters();
			parameters.Add("idsp", idsp);
			parameters.Add("idkh", idkh);
			parameters.Add("quantity", quantity);
			parameters.Add("colorid", colorid);
			parameters.Add("sizeid", sizeid);
			var result = await _dbConnection.ExecuteAsync("update_product_in_cart", parameters, commandType: CommandType.StoredProcedure);
			return result >0;
		}

        //Xóa sản phẩm trong giỏ hàng
        public async Task<bool> Delete_Cart(int idsp, int idkh, int colorid, int sizeid)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("idsp", idsp);
            parameters.Add("idkh", idkh);
            parameters.Add("colorid", colorid);
            parameters.Add("sizeid", sizeid);
            var result = await _dbConnection.ExecuteAsync("delete_product_in_cart", parameters, commandType: CommandType.StoredProcedure);
            return result>0;
        }
        //dặt hàng (lưu thông tin vào DbOrder)
        public async Task<(int NewIdDH, string NewMaDH)> Add_Order(int idkh,string emailkh,string nguoinhan,string sdt,string city,string district,string ward,string diachi,decimal tongtien,decimal tongtienthanhtoan,
                                        int soluong,int payid,string payname,int? idvoucher,int? valuevoucher,decimal giamgia,decimal ship,string ghichu)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            //parameters.Add("@madh", madh); madh ko phải truyền vào vì đã để tự tạo theo iddh trong sp
            parameters.Add("@idkh", idkh);
            parameters.Add("@emailkh", emailkh);
            parameters.Add("@nguoinhan", nguoinhan);
            parameters.Add("@sdt",sdt );
            parameters.Add("@city",city );
            parameters.Add("@district", district);
            parameters.Add("@ward", ward);
            parameters.Add("@diachi",diachi);
            parameters.Add("@tongtien",tongtien );
            parameters.Add("@tongtienthanhtoan",tongtienthanhtoan );
            parameters.Add("@soluong",soluong);
            parameters.Add("@payid", payid);
            parameters.Add("@payname",payname);
            parameters.Add("@idvoucher",idvoucher);
            parameters.Add("@valuevoucher",valuevoucher);
            parameters.Add("@giamgia",giamgia);
            parameters.Add("@ship",ship);
            parameters.Add("@ghichu",ghichu );

            parameters.Add("@NewIdDH", dbType: DbType.Int32, direction: ParameterDirection.Output);
            parameters.Add("@NewMaDH", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("add_order", parameters, commandType: CommandType.StoredProcedure);
            int newIdDH = parameters.Get<int>("@NewIdDH");
            string newMaDH = parameters.Get<string>("@NewMaDH");
			return (newIdDH,newMaDH);
        }
        //đặthàng (Lưu thông tin vào DbOrderDetail)
        public async Task<int> Add_OrderDetail(int iddh,string madh,int idsp,string masp,int colorid,int sizeid,decimal priceby,int soluongsp)
        {

			if (_dbConnection == null)
			{
				throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
			}
			var parameters = new DynamicParameters();
            parameters.Add("@iddh", iddh);
            parameters.Add("@madh", madh);
            parameters.Add("@idsp", idsp);
            parameters.Add("@masp", masp);
            parameters.Add("@colorid", colorid);
            parameters.Add("@sizeid", sizeid);
            parameters.Add("@priceby", priceby);
            parameters.Add("@soluongsp", soluongsp);

            return await _dbConnection.ExecuteAsync("add_orderdetail",parameters, commandType: CommandType.StoredProcedure);
		}
        ////số lượng sản phẩm trong giỏ hàng
        //public async Task<Product_Quantity_In_Cart> QuantityProductIncart(int idkh)
        //{
        //    if (_dbConnection ==null)
        //    {
        //        throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
        //    }
        //    var parameters = new DynamicParameters();
        //    parameters.Add("@idkh", idkh);
        //    return await _dbConnection.QueryFirstOrDefault<Product_Quantity_In_Cart>("view_product_in_cart",parameters,commandType: CommandType.StoredProcedure);
             
        //}
    }
}
