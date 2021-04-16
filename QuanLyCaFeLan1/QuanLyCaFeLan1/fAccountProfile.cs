using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyCaFeLan1.DTO;
using QuanLyCaFeLan1.DAO;

namespace QuanLyCaFeLan1
{
    public partial class fAccountProfile : Form
    {
        private Account loginAccount;
        public Account LoginAccount
        {
            get { return loginAccount; }
            set { loginAccount = value; }
        }
        public fAccountProfile(Account acc)
        {
            InitializeComponent();

            loginAccount = acc;
            ChangeAccout(loginAccount);
        }
        void ChangeAccout(Account acc)
        {
            txbUserName.Text = loginAccount.UserName;
            txbDisPlayName.Text = loginAccount.DisplayName;

        }
        void UpdateAccountInfo()
        {
            string displayName = txbDisPlayName.Text;
            string password = txbPassWord.Text;
            string newpass = txbNewPass.Text;
            string userName = txbUserName.Text;

            if (newpass.Equals(ReEnterPass))
            {
                MessageBox.Show("Vui lòng nhập lại mật khẩu đúng với mật khẩu mới");                
            }
            else
            {
                if (AccountDAO.Instance.UpdateAccount(userName, displayName, password, newpass))
                {
                    MessageBox.Show("Update thành công");
                    if (updateAccount != null)

                        updateAccount(this, new AccountEvent(AccountDAO.Instance.GetAccountByUserName(userName)));
                }
                else
                {
                    MessageBox.Show("Vui lòng điền lại mật khẩu");
                }
            }
        }
        private event EventHandler<AccountEvent> updateAccount;
        public event EventHandler<AccountEvent> UpdateAccount
        {
            add { updateAccount += value; }
            remove { updateAccount-=value;}
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateAccountInfo();
        }
    }
    public class AccountEvent : EventArgs
    {
        private Account acc;

        public Account Acc
        {
            get { return acc; }
            set { acc = value; }
        }

        public AccountEvent(Account acc)
        {
            this.Acc = acc;
        }
    }
}
