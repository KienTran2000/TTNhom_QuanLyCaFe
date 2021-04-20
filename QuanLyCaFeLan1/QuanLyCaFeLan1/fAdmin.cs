using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanLyCaFeLan1.DAO;
using System.Data.SqlClient;
using System.Windows.Forms;
using QuanLyCaFeLan1.DTO;

namespace QuanLyCaFeLan1
{
    public partial class fAdmin : Form
    {
        BindingSource foodList = new BindingSource();
        BindingSource accountList = new BindingSource();
        public Account loginAccount;
        public fAdmin()
        {
            InitializeComponent();
            Load();
        }
        #region methods
        void Load()
        {
            dtgvFood.DataSource = foodList;
            dtgvAccount.DataSource = accountList;
            LoadDateTimePickerBill();
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListFood();
            LoadAccount();
            LoadCategoryIntoCombobox(cbFoodCategory);
            AddFoodBinding();
            AddAccountBinding();
        }
        void AddAccountBinding()
        {
            txbUserName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "UserName", true, DataSourceUpdateMode.Never));
            txbDisplayName.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "DisplayName", true, DataSourceUpdateMode.Never));
            numericUpDown1.DataBindings.Add(new Binding("value", dtgvAccount.DataSource, "Type", true, DataSourceUpdateMode.Never));

        }
        void LoadAccount()
        {
            accountList.DataSource = AccountDAO.Instance.GetListAccount();
        }
        void LoadListBillByDate(DateTime checkIn,DateTime checkOut) 
        {
            dtgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn,checkOut);
        }
        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;
            dtpkFromDate.Value = new DateTime(today.Year,today.Month,1);
            dtpkToDate.Value = dtpkFromDate.Value.AddMonths(1).AddDays(-1);
        }
        void LoadListFood()
        {
            foodList.DataSource = FoodDAO.Instance.GetListFood();
        }
        void AddFoodBinding()
        {
            txbFoodName.DataBindings.Add(new Binding("Text",dtgvFood.DataSource, "Name", true, DataSourceUpdateMode.Never));
            txbFoodID.DataBindings.Add(new Binding("Text",dtgvFood.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmFoodPrice.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "Price", true, DataSourceUpdateMode.Never));
        }
        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        List<Food> SearchFoodByName(string name)
        {
            List<Food> listFood = FoodDAO.Instance.SearchFoodByName(name);
            return listFood;
        }
        void AddAccount(string username,string displayName, int type)
        {
            if(AccountDAO.Instance.InsertAccount(username, displayName, type))
            {
                MessageBox.Show("Add tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
            LoadAccount();
        }
        void EditAccount(string username, string displayName, int type)
        {
            if (AccountDAO.Instance.UpdateAccount(username, displayName, type))
            {
                MessageBox.Show("Update tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
            LoadAccount();
        }
        void DeleteAccount(string username)
        {
            if (loginAccount.UserName.Equals(username))
            {
                MessageBox.Show("Không được xóa tài khoản đang đăng nhập");
                return;
            }
            if (AccountDAO.Instance.DeleteAccount(username))
            {
                MessageBox.Show("Delete tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
            LoadAccount();
        }
        void ResetPass(string username)
        {
            if (AccountDAO.Instance.ResetPassword(username))
            {
                MessageBox.Show(" Reset mật khẩu thành công");
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
        }
        #endregion

        #region events
        private void btnViewBill_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDate.Value,dtpkToDate.Value);
        }

        private void btnShowFood_Click(object sender, EventArgs e)
        {
            LoadListFood();
        }

        private void txbFoodID_TextChanged(object sender, EventArgs e)
        {
            //tu datagridviewFood -> tro den mot o -> tro den dong chua o do co gia tri IDCategory-> lay value
            try
            {
                if (dtgvFood.SelectedCells.Count > 0)
                {
                    int id = (int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryID"].Value;
                    Category category = CategoryDAO.Instance.GetCategoryByID(id);
                    cbFoodCategory.SelectedItem = category;

                    int index = -1;
                    int i = 0;
                    foreach (Category item in cbFoodCategory.Items)
                    {
                        if (item.ID == category.ID)
                        {
                            index = i;
                            break;

                        }
                        i++;
                    }
                    cbFoodCategory.SelectedIndex = index;
                }
            }
            catch{}
        }

        private void btnAddFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text;
            int categoryID = (cbFoodCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;

            if (FoodDAO.Instance.InsertFood(name, categoryID, price))
            {
                MessageBox.Show("Thêm món thành công");
                LoadListFood();
                if (insertFood != null)
                    insertFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
        }

        private void btnEditFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text;
            int categoryID = (cbFoodCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;
            int id = Convert.ToInt32(txbFoodID.Text);

            if (FoodDAO.Instance.UpdateFood(id, name, categoryID, price))
            {
                MessageBox.Show("Update thành công");
                LoadListFood();
                if (updateFood != null)
                    updateFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {

            int id = Convert.ToInt32(txbFoodID.Text);

            if (FoodDAO.Instance.DeleteFood(id))
            {
                MessageBox.Show("Xóa thành công");
                LoadListFood();
                if (deleteFood != null)
                    deleteFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Đã xảy ra lỗi");
            }
        }

        private event EventHandler insertFood;
        public event EventHandler InsertFood
        {
            add { insertFood += value; }
            remove { insertFood -= value; }
        }

        private event EventHandler deleteFood;
        public event EventHandler DeleteFood
        {
            add { deleteFood += value; }
            remove { DeleteFood -= value; }
        }
        private event EventHandler updateFood;
        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { UpdateFood -= value; }
        }

        private void btnSearchFood_Click(object sender, EventArgs e)
        {
            foodList.DataSource =SearchFoodByName(txbSearchFoodName.Text);
        }
        private void btnShowAccount_Click(object sender, EventArgs e)
        {
            LoadAccount();
        }
        private void btnAddAcount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string displayName = txbDisplayName.Text;
            int type = (int)numericUpDown1.Value;

            AddAccount(userName, displayName, type);
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            DeleteAccount(userName);
        }

        private void btnEditAccount_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string displayName = txbDisplayName.Text;
            int type = (int)numericUpDown1.Value;

            EditAccount(userName, displayName, type);
        }

        #endregion

        private void btnResetPassWord_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            ResetPass(userName);
        }
    }
}