using Dapper;
using Data.Models;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Wordprocessing;
using iText.StyledXmlParser.Jsoup.Parser;
using KLTN_YourLook.Areas.Admin.Models;
using KLTN_YourLook.Models;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class OrderRepository
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        private readonly YourlookContext _context;
        public OrderRepository(IDbConnection dbConnection,YourlookContext context)
        {
            _dbConnection = dbConnection;
            _context = context;
        }
        private List<OrderDetailViewModel> MapToViewOrderDetails(IEnumerable<OrderDetailViewModelRaw> lstraw)
        {
            var lst = lstraw.Select(x => new OrderDetailViewModel
            {
                IdDh = x.IdDh,
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
                                    GiaLoai = decimal.Parse(s[6])
                                };
                            }).ToList(),
                IdKh = x.IdKh,
                TenKh = x.TenKh,
                NguoiNhan = x.NguoiNhan,
                DiaChi = x.DiaChi,
                GhiChu = x.GhiChu,
                TongTien = x.TongTien,
                GiamGia = x.GiamGia,
                Ship = x.Ship,
                TongTienThanhToan = x.TongTienThanhToan,
                Sdt = x.Sdt,
                PaymentName = x.PaymentName,
                CreateDate = x.CreateDate,
                error = x.error
            });
            return lst.ToList();
        }
        ////lấy all đơn hàng
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
        public async Task<IEnumerable<AllOrderViewModle>> SearchOrder(string? keyword, bool? odsuccess, bool? odreadly, bool? odtranport, bool? complete, bool? odhuy, string? date, string? todate)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parames = new DynamicParameters();
            parames.Add("@keyword", keyword);
            parames.Add("@odsuccess", odsuccess);
            parames.Add("@odreadly", odreadly);
            parames.Add("@odtranport", odtranport);
            parames.Add("@complete", complete);
            parames.Add("@odhuy", odhuy);
            parames.Add("@date", date);
            parames.Add("@todate", todate);
            return await _dbConnection.QueryAsync<AllOrderViewModle>("order_search", parames, commandType: CommandType.StoredProcedure);

        }
        //lấy all đơn hàng theo ngày
        public async Task<List<AllOrderViewModle>> GetAllOrderDate(DateTime date)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parames = new DynamicParameters();
            parames.Add("@date", date);
            var lst = await _dbConnection.QueryAsync<AllOrderViewModle>("order_date", parames, commandType: CommandType.StoredProcedure);
            return lst.ToList();
        }
        //lấy ra chi tiết đơn hàng 
        public async Task<List<OrderDetailViewModel>> ShowOrderDetail(int? iddh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstRaw =await _dbConnection.QueryAsync<OrderDetailViewModelRaw>("show_orderdetail", new { iddh = iddh /*?? (int?)null*/ }, commandType: CommandType.StoredProcedure);
            //bool isPrint = _context.DbOrders //lấy ra đơn hàng đã được in
            //    .Any(x => x.ODPrint == true && x.IdDh == iddh);
            //bool rePrint = _context.DbOrders //lấy ra đơn hàng đã được in lại
            //                .Any(x => x.ODReprint == true && x.IdDh == iddh);
            var order = _context.DbOrders.FirstOrDefault(x => x.IdDh == iddh);

            bool isPrint = order?.ODPrint ?? false;  // Kiểm tra đã in
            bool rePrint = order?.ODReprint ?? false;  // Kiểm tra đã in lại

            var lst = lstRaw.Select(x => new OrderDetailViewModel
            {
                IdDh = x.IdDh,
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
                                    GiaLoai = decimal.Parse(s[6])
                                };
                            }).ToList(),
                IdKh = x.IdKh,
                TenKh = x.TenKh,
                NguoiNhan = x.NguoiNhan,
                DiaChi = x.DiaChi,
                GhiChu = x.GhiChu,
                TongTien = x.TongTien,
                GiamGia = x.GiamGia,
                Ship = x.Ship,
                TongTienThanhToan = x.TongTienThanhToan,
                Sdt = x.Sdt,
                PaymentName = x.PaymentName,
                CreateDate = x.CreateDate,
                error = x.error,
                IsPrint= isPrint,
                Reprint=rePrint
            });
            return lst.ToList();
            //return MapToViewOrderDetails(lstRaw);
        }
        //in ra chi tiết đơn hàng //QueryMultipleAsync :truy vấn SQL và trả về nhiều tập kết quả 
        public async Task<(List<OrderDetailViewModel> Orders, string Error)> PrintOrderDetail(int? iddh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parames = new DynamicParameters();
            parames.Add("@iddh", iddh);
            parames.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            using (var multi = await _dbConnection.QueryMultipleAsync("sp_order_print_status", parames, commandType: CommandType.StoredProcedure))
            {
                List<OrderDetailViewModelRaw> lstRaw = new List<OrderDetailViewModelRaw>();

                if (!multi.IsConsumed)
                {
                    lstRaw = (await multi.ReadAsync<OrderDetailViewModelRaw>()).ToList();
                }
                string errorMsg = parames.Get<string>("@error");
                if (!string.IsNullOrEmpty(errorMsg) || !lstRaw.Any())
                {
                    return (new List<OrderDetailViewModel>(), errorMsg ?? "Không có đơn hàng nào hợp lệ.");
                }

                //var lstRaw = (await multi.ReadAsync<OrderDetailViewModelRaw>()).ToList();

                //string errorMsg = parames.Get<string>("@error");

                var lst = lstRaw.Select(x => new OrderDetailViewModel
                {
                    IdDh = x.IdDh,
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
                                        GiaLoai = decimal.Parse(s[6])
                                    };
                                }).ToList(),
                    IdKh = x.IdKh,
                    TenKh = x.TenKh,
                    NguoiNhan = x.NguoiNhan,
                    DiaChi = x.DiaChi,
                    GhiChu = x.GhiChu,
                    TongTien = x.TongTien,
                    GiamGia = x.GiamGia,
                    Ship = x.Ship,
                    TongTienThanhToan = x.TongTienThanhToan,
                    Sdt = x.Sdt,
                    PaymentName = x.PaymentName,
                    CreateDate = x.CreateDate,
                    error = x.error
                }).ToList();
                return (lst,null);
            }                
        }
        //in lại đơn hàng
        public async Task<(List<OrderDetailViewModel> Orders, string Error)> RePrintOrderDetail(int iddh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parames = new DynamicParameters();
            parames.Add("@iddh", iddh);
            parames.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            using (var multi = await _dbConnection.QueryMultipleAsync("sp_order_reprint_status", parames, commandType: CommandType.StoredProcedure))
            {
                List<OrderDetailViewModelRaw> lstRaw = new List<OrderDetailViewModelRaw>();

                if (!multi.IsConsumed)
                {
                    lstRaw = (await multi.ReadAsync<OrderDetailViewModelRaw>()).ToList();
                }
                string errorMsg = parames.Get<string>("@error");
                if (!string.IsNullOrEmpty(errorMsg) || !lstRaw.Any())
                {
                    return (new List<OrderDetailViewModel>(), errorMsg ?? "Không có đơn hàng nào hợp lệ.");
                }
                var lst = lstRaw.Select(x => new OrderDetailViewModel
                {
                    IdDh = x.IdDh,
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
                                        GiaLoai = decimal.Parse(s[6])
                                    };
                                }).ToList(),
                    IdKh = x.IdKh,
                    TenKh = x.TenKh,
                    NguoiNhan = x.NguoiNhan,
                    DiaChi = x.DiaChi,
                    GhiChu = x.GhiChu,
                    TongTien = x.TongTien,
                    GiamGia = x.GiamGia,
                    Ship = x.Ship,
                    TongTienThanhToan = x.TongTienThanhToan,
                    Sdt = x.Sdt,
                    PaymentName = x.PaymentName,
                    CreateDate = x.CreateDate,
                    error = x.error
                }).ToList();
                return (lst, null);
            }
        }
        //Cập nhật đơn hàng 
        public async Task<(string msg,string error)> UpdateOrder(int iddh,bool odsuccess,bool odreadly,bool odtransported,bool complete,bool odhuy,string modifiedby)
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
            parameters.Add("@modifiedby", modifiedby);

            parameters.Add("@msg", dbType: DbType.String, size: 500,direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("orderupdate", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");
            return (msg, error);
        }
        //cập nhật trạng thái in của đơn hàng 
    }
}
