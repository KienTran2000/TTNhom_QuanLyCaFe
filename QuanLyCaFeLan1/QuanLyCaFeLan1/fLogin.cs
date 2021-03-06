﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyCaFeLan1.DAO;
using QuanLyCaFeLan1.DTO;
namespace QuanLyCaFeLan1
{
    public partial class fLogin : Form
    {
        public fLogin()
        {
            InitializeComponent();
        }



        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string passWord = txbPassWord.Text;
            if (Login(userName, passWord))
            {
                Account loginAccount = AccountDAO.Instance.GetAccountByUserName(userName);
                fTableManager f = new fTableManager(loginAccount);
                this.Hide();
                f.ShowDialog();//chi thao tac tren dialog, chi xu ly tren manager,khi no tat di thi login moi hien len
                this.Show();
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu !");
            }
        }
        bool Login(string userName, string passWord)
        {
            return AccountDAO.Instance.Login(userName, passWord);
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void fLogin_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thực sự muốn thoát", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

    }
}
