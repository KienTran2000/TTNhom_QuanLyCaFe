using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyCaFeLan1.DAO;
using QuanLyCaFeLan1.DTO;

namespace QuanLyCaFeLan1.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get
            {
                if (instance == null)
                    instance = new BillDAO();
                return BillDAO.instance;
            }

            private set
            {
                instance = value;
            }
        }
        private BillDAO() { }
        //Thành công -> billId, thất bại -> -1
        //tra ra id cua bill hoac tra ra bill
        public int GetUnCheckBillIDByTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExcuteQuery("SELECT * FROM DBO.Bill WHERE idTable ="+ id +" AND status = 0");
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;
        }
        public void CheckOut(int id,int discount)
        {
            string query = "update dbo.Bill set status = 1, " + "discount = " + discount + "where id = " + id;
            DataProvider.Instance.ExcuteNonQuery(query);
        }

        public void InsertBill(int id)
        {
            DataProvider.Instance.ExcuteNonQuery("exec USP_InsertBill @idTable", new object[] { id });
        }

        public int GetMaxIDBill()
        {
            try
            {

            return (int)DataProvider.Instance.ExcuteScalar("select Max(id) from dbo.Bill");
            }
            catch
            {
                return 1;
            }
        }
    }
}
