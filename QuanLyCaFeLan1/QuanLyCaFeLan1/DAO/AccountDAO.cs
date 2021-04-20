using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Security.Cryptography;
using QuanLyCaFeLan1.DTO;
namespace QuanLyCaFeLan1.DAO
{
    class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get
            {
                if (instance == null) instance = new AccountDAO();
                return instance;
            }

            private set
            {
                instance = value;
            }
        }
        private AccountDAO() { }
        //function Login
        public bool Login(string userName,string passWord)
        {
            //lay ra mot mang byte tu kieu chuôi
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(passWord);
            byte[] hasData = new MD5CryptoServiceProvider().ComputeHash(temp);

            string hasPass = "";
            foreach(byte item in hasData)
            {
                hasPass += item;
            }

            string query = "USP_Login @userName , @passWord";
            DataTable result = DataProvider.Instance.ExcuteQuery(query,new object[] { userName,hasPass});

            return result.Rows.Count > 0;
        }
        public bool UpdateAccount(string userName, string displayName, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExcuteNonQuery("exec USP_UpdateAccount @userName , @displayName , @password , @newPassword ",new object[]{userName, displayName, pass, newPass});
            return result > 0;
        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExcuteQuery("Select UserName, DisplayName, Type from Account");
        }
        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExcuteQuery("select * from account where username = '" + userName + "'");
            foreach(DataRow item in data.Rows)
            {
                return new Account(item);
            }
            return null;
        }

        public bool InsertAccount(string name,string displayName,int type)
        {
            string query = string.Format("INSERT dbo.Account ( UserName, DisplayName, Type, password )VALUES  ( N'{0}', N'{1}', {2}, N'{3}')", name, displayName, type, "1962026656160185351301320480154111117132155");
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
        public bool UpdateAccount(string name, string displayname, int type)
        {
            string query = string.Format("UPDATE dbo.Account SET  DisplayName = N'{1}', Type = {2} WHERE UserName = '{0}'", name, displayname, type);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
        public bool DeleteAccount(string name)
        {
            string query = string.Format("Delete Account where UserName = N'{0}'", name);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
        public bool ResetPassword(string name)
        {
            string query = string.Format("Update Account set password = N'1962026656160185351301320480154111117132155' where UserName = N'{0}'", name);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
    }

}
