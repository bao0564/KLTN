using Dapper;
using KLTN_YourLook.Areas.Admin.Models;
using System.Data;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class OrderRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public OrderRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all đơn hàng
        public async Task<List<AllOrderViewModle>> GetAllOrder()
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lst = await _dbConnection.QueryAsync<AllOrderViewModle>("order_showall", commandType: CommandType.StoredProcedure);
            return lst.ToList();
        }
        //tìm kiếm dơn hàng
        public async Task<IEnumerable<AllOrderViewModle>> SearchOrder(string? keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<AllOrderViewModle>("order_search", parameters, commandType: CommandType.StoredProcedure);

        }
        ////lấy all đơn hàng theo trạng thái
        //public async Task<List<AllOrderViewModle>> GetAllOrderFilter(bool? odsuccess, bool? odreadly, bool? odtranport, bool? complete)
        //{
        //    if (_dbConnection == null)
        //    {
        //        throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
        //    }
        //    var parames = new DynamicParameters();
        //    parames.Add("@odsuccess", odsuccess);
        //    parames.Add("@odreadly", odreadly);
        //    parames.Add("@odtranport", odtranport);
        //    parames.Add("@complete", complete);
        //    var lst = await _dbConnection.QueryAsync<AllOrderViewModle>("order_showall_filter", parames, commandType: CommandType.StoredProcedure);
        //    return lst.ToList();
        //}
        //lấy ra chi tiết đơn hàng 
        public async Task<List<OrderDetailViewModel>> ShowOrderDetail(int iddh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstRaw =await _dbConnection.QueryAsync<OrderDetailViewModelRaw>("show_orderdetail", new { iddh = iddh }, commandType: CommandType.StoredProcedure);
            var lst = lstRaw.Select(x => new OrderDetailViewModel
            {
                MaDh = x.MaDh,
                InForSp = x.InForSp.Split(';')
                            .Select(y =>
                            {
                                var s = y.Split('"');
                                return new ViewInForSP
                                {
                                    MaSp = s[0],
                                    TenSp = s[1],
                                    AnhSp = s[2],
                                    NameColor = s[3],
                                    NameSize = s[4],
                                    SoLuongSp = int.Parse(s[5]),
                                    GiaLoai=decimal.Parse(s[6])
                                };
                            }).ToList(),
                IdKh=x.IdKh,
                TenKh=x.TenKh,
                NguoiNhan=x.NguoiNhan,
                DiaChi=x.DiaChi,
                GhiChu=x.GhiChu,
                TongTien=x.TongTien,
                GiamGia=x.GiamGia,
                Ship=x.Ship,
                TongTienThanhToan=x.TongTienThanhToan
            });
            return lst.ToList();
        }
        //Cập nhật đơn hàng 
        public async Task<(string msg,string error)> UpdateOrder(int iddh,bool odsuccess,bool odreadly,bool odtransported,bool complete,bool odhuy)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@iddh", iddh);            
            parameters.Add("@odsuccess", odsuccess);            
            parameters.Add("@odreadly", odreadly);            
            parameters.Add("@odtransported", odtransported);            
            parameters.Add("@complete", complete);            
            parameters.Add("@odhuy", odhuy);

            parameters.Add("@msg", dbType: DbType.String, size: 500,direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("orderupdate", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
    }
}
