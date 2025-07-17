using System.Data;
using Dapper;
using Data.Models;
using KLTN_YourLook.Models;
using Microsoft.EntityFrameworkCore;

namespace KLTN_YourLook.Repository_YL
{
    public class SP_User
    {
        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        private readonly YourlookContext _context;
        public SP_User(IDbConnection dbConnection, YourlookContext context)
        {
            _dbConnection = dbConnection;
            _context = context;
        }
        //chi tiết người dùng 
        public async Task<int> User_Detail(int idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync("user_detail", new { idkh = idkh }, commandType: CommandType.StoredProcedure);
            return lstraw.FirstOrDefault();
        }
        //tạo người dùng mới
        public async Task<(string msg, string error)> Create_User(string tenkh, string sdt, string email, string pass, string confirmpass, bool isexternalaccount)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameter = new DynamicParameters();
            parameter.Add("@tenkh", tenkh);
            parameter.Add("@sdt", sdt);
            parameter.Add("@email", email);
            parameter.Add("@pass", pass);
            parameter.Add("@confirmpass", confirmpass);
            parameter.Add("@IsExternalAccount", isexternalaccount);

            parameter.Add("@newidkh", dbType: DbType.Int32, direction: ParameterDirection.Output);
            parameter.Add("@newmakh", dbType: DbType.String, size: 10, direction: ParameterDirection.Output);
            parameter.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameter.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("create_user", parameter, commandType: CommandType.StoredProcedure);

            string msg = parameter.Get<string>("@msg");
            string error = parameter.Get<string>("@error");
            return (msg, error);
        }
        //chỉnh sửa thông tin người dùng 
        public async Task<(string msg, string error)> Update_User(int idkh, string tenkh, string img, string sex, string sdt, string email, string pass, string confirmpass)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameter = new DynamicParameters();
            parameter.Add("@idkh", idkh);
            parameter.Add("@tenkh", tenkh);
            parameter.Add("@img", img);
            parameter.Add("@sex", sex);
            parameter.Add("@sdt", sdt);
            parameter.Add("@email", email);
            parameter.Add("@pass", pass);
            parameter.Add("@confirmpass", confirmpass);

            parameter.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameter.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("update_user", parameter, commandType: CommandType.StoredProcedure);
            string msg = parameter.Get<string>("@msg");
            string error = parameter.Get<string>("@error");

            return (msg, error);
        }
        //thêm sản phẩm vào bảng yêu thích
        public async Task<int> Create_Favorite_Product(int idsp, int idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@idsp", idsp);
            parameters.Add("@idkh", idkh);

            var result = await _dbConnection.ExecuteAsync("create_favorite_product", parameters, commandType: CommandType.StoredProcedure);
            return result;
        }
        //hiển thị sp yêu thích của khách hàng
        public async Task<List<ViewAllDetail>> FavoriteProductShowAll(int idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewAllDetailRaw>("favorite_product_showall", new { idkh = idkh });
            var favoriteProductIds = _context.DbFavoriteProducts //lấy các sp yêu thích trong bảng sp yêu thích của kahchs hàng
                                    .Where(x => x.IdKh == idkh)
                                    .Select(x => x.IdSp)
                                    .ToList();
            var lst = lstraw.Select(x => new ViewAllDetail
            {
                IdSp = x.IdSp,
                MaSp = x.MaSp, 
                TenSp = x.TenSp,
                AnhSp = x.AnhSp,
                PriceMax = x.PriceMax,
                GiamGia = x.GiamGia,
                PriceMin = x.PriceMin,
                IFavorite = favoriteProductIds.Contains(x.IdSp),//đánh dấu là sản phẩm yêu thích
                LuotXem = x.LuotXem,
                Sizes = x.Sizes.Split(';')//tách lần 1
                        .Select(y =>
                        {
                            var s = y.Split(',');//tách lần 2
                            return new ViewSize
                            {
                                SizeId = int.Parse(s[0]),
                                NameSize = s[1]
                            };
                        }).DistinctBy(s => s.SizeId)//loại bỏ trùng lặp
                        .ToList(),
                Colors = x.Colors.Split(';')
                        .Select(y =>
                        {
                            var c = y.Split(',');
                            return new ViewColor
                            {
                                ColorId = int.Parse(c[0]),
                                NameColor = c[1],
                                MaColor = c[2],
                                MaHex = c[3]
                            };
                        }).DistinctBy(c => c.ColorId)
                        .ToList()
            });
            return lst.ToList();
        }
        //lịch sử đơn hàng 
        public async Task<List<ViewCustomerHistoryOrder>> UserHistoryOrder(int idkh)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<ViewCustomerHistoryOrderRaw>("customer_order_showall", new { idkh = idkh }, commandType: CommandType.StoredProcedure);
            var lst = lstraw.Select(x => new ViewCustomerHistoryOrder
            {
                IdDh = x.IdDh,
                MaDh = x.MaDh,
                PaymentName = x.PaymentName,
                soluong = x.soluong,
                TongTienThanhToan = x.TongTienThanhToan,
                InforSP = x.InforSP.Split(';')
                            .Select(y =>
                            {
                                var z = y.Split('"');
                                return new ViewInforOrder
                                {
                                    AnhSp = z[0],
                                    TenSp = z[1],
                                    NameColor = z[2],
                                    NameSize = z[3],
                                    PriceBy = decimal.Parse(z[4]),
                                    SoLuongSp = int.Parse(z[5])
                                };
                            }).ToList(),
                CreateDate = x.CreateDate,
                ODSuccess = x.ODSuccess,
                ODReadly = x.ODReadly,
                ODTransported = x.ODTransported,
                Complete = x.Complete,
                ODHuy = x.ODHuy,
                ODReturn = x.ODReturn,
                ODCompleteDate= x.ODCompleteDate,                
                Israted = _context.DbRatings.Any(r => r.IdDh == x.IdDh)
            });
            return lst.ToList();
        }
        //những Sản phẩm cần đánh giá trong đơn hàng  
        public async Task<List<Product_Rating>> Product_Rating(int iddh )
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<Product_Rating_Raw>("view_product_rating", new { iddh = iddh }, commandType: CommandType.StoredProcedure);
            var lst = lstraw.Select(x => new Product_Rating
            {
                IdDh = iddh,
                IdSp= x.IdSp,
                AnhSp= x.AnhSp,
                TenSp= x.TenSp,
                ColorSize=x.ColorSizes.Split(',')
                        .Select(y=> new Product_Rating_SizeColor
                        {
                            ColorSize=y
                        }).ToList()
            });
            return lst.ToList();
        }
        //Địa chỉ người dùng 
        public async Task<List<DbAddress>> User_Adress(int idkh)  
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var lstraw = await _dbConnection.QueryAsync<DbAddress>("adress_showall", new { idkh = idkh }, commandType: CommandType.StoredProcedure);
            return lstraw.ToList();
        }
        //thêm địa chỉ người dùng
        public async Task<(string msg, string error)> Create_Adress(int idkh, string tennguoinhan, string sdt, string adress, string city, string quanhuyen, string phuongxa, string ghichu, bool idefault)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var paramesters = new DynamicParameters();
            paramesters.Add("@idkh", idkh);
            paramesters.Add("@tennguoinhan", tennguoinhan);
            paramesters.Add("@sdt", sdt);
            paramesters.Add("@adress", adress);
            paramesters.Add("@city", city);
            paramesters.Add("@quanhuyen", quanhuyen);
            paramesters.Add("@phuongxa", phuongxa);
            paramesters.Add("@ghichu", ghichu);
            paramesters.Add("@idefault", idefault);

            paramesters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            paramesters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("create_customer_adress", paramesters, commandType: CommandType.StoredProcedure);
            string msg = paramesters.Get<string>("@msg");
            string error = paramesters.Get<string>("@error");
            return (msg, error);
        }
        //người dùng đánh giá đơn hàng 
        public async Task<int> Create_Rating(int iddh,int idsp,int idkh,int rate,string colorsize,string danhgia)
        {

            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var paramesters = new DynamicParameters();
            paramesters.Add("@iddh", iddh);
            paramesters.Add("@idsp", idsp);
            paramesters.Add("@idkh", idkh);
            paramesters.Add("@rate", rate);
            paramesters.Add("@colorsize", colorsize);
            paramesters.Add("@danhgia", danhgia);
            
            return await _dbConnection.ExecuteAsync("creat_rating", paramesters, commandType: CommandType.StoredProcedure);
        }
    }
}
