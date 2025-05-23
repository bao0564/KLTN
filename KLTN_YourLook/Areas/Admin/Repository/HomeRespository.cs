﻿using System.Data;
using Dapper;
using Data.Models;
using KLTN_YourLook.Areas.Admin.Models;
using static Azure.Core.HttpHeader;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;

namespace KLTN_YourLook.Areas.Admin.Repository
{
    public class HomeRespository
    {

        private readonly IDbConnection _dbConnection;//dùng như dbcontext
        public HomeRespository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }
        //lấy all khách hàng + tìm kiếm
        public async Task<IEnumerable<DbCustomer>> SearchCustomer(string keyword)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@keyword", keyword);
            return await _dbConnection.QueryAsync<DbCustomer>("customer_search", parameters, commandType: CommandType.StoredProcedure);
        }
        //tạo mới admin
        public async Task<(string msg, string error)> CreateAdmin(string emaildn, string namedn, string passdn, string chucvu, string quyen)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }
            var parameters = new DynamicParameters();
            parameters.Add("@emaildn", emaildn);
            parameters.Add("@namedn", namedn);
            parameters.Add("@passdn", passdn);
            parameters.Add("@chucvu", chucvu);
            parameters.Add("@quyen", quyen);
            parameters.Add("@msg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
            parameters.Add("@error", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);

            await _dbConnection.ExecuteAsync("create_admin", parameters, commandType: CommandType.StoredProcedure);
            var msg = parameters.Get<string>("@msg");
            var error = parameters.Get<string>("@error");

            return (msg, error);
        }
        //số liệu doanh thu tổng quan
        public async Task<View_Revenue> RevenueAll(int month, int year)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@Month", month);
            parameters.Add("@Year", year);
            var lstraw = await _dbConnection.QueryAsync<View_Revenue_Raw>("revenue_showall", parameters, commandType: CommandType.StoredProcedure);
            var lst = lstraw.Select(x => new View_Revenue
            {
                Thang = x.Thang,
                Nam = x.Nam,
                Thangtrc = x.Thangtrc,
                NamTrc = x.NamTrc,
                CoutDH = x.CoutDH,
                DoanhThu = x.DoanhThu,
                PrevDoanhThu = x.PrevDoanhThu,
                DHTranpost = x.DHTranpost,
                DHComplete = x.DHComplete,
                DHHuy = x.DHHuy,
                DoanhThuThangTheoNam = x.DoanhThuTongHop.Split('|')
                                        .Select(y =>
                                        {
                                            var s = y.Split(':');
                                            return new DoanhThuChartItem
                                            {
                                                Thang = int.Parse(s[0]),
                                                DoanhThu = decimal.Parse(s[1])
                                            };
                                        }).ToList()
            });
            return lst.FirstOrDefault();
        }
        //số liệu doanh thu
        public async Task<View_Revenue> Revenue(int month,int year)
        {
            if (_dbConnection == null)
            {
                throw new Exception("Kết nối cơ sở dữ liệu chưa được khởi tạo.");
            }

            var parameters = new DynamicParameters();
            parameters.Add("@Month", month);
            parameters.Add("@Year", year);
            //parameters.Add("@monthnow", dbType:DbType.Int32,direction:ParameterDirection.Output);
            //parameters.Add("@yearnow", dbType:DbType.Int32,direction:ParameterDirection.Output);
            //parameters.Add("@monthprev", dbType:DbType.Int32,direction:ParameterDirection.Output);
            //parameters.Add("@yearprev", dbType:DbType.Int32,direction:ParameterDirection.Output);
            return await _dbConnection.QuerySingleAsync<View_Revenue>("revenue", parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
