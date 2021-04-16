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
        public fAdmin()
        {
            InitializeComponent();
            Load();
        }
        #region methods
        void Load()
        {
            dtgvFood.DataSource = foodList;
            LoadDateTimePickerBill();
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListFood();
            LoadCategoryIntoCombobox(cbFoodCategory);
            AddFoodBinding();
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
            txbFoodName.DataBindings.Add(new Binding("Text",dtgvFood.DataSource, "Name"));
            txbFoodID.DataBindings.Add(new Binding("Text",dtgvFood.DataSource, "ID"));
            nmFoodPrice.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "Price"));
        }
        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        #endregion

        #region events
        private void btnViewBill_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDate.Value,dtpkToDate.Value);
        }
        #endregion

        private void btnShowFood_Click(object sender, EventArgs e)
        {

        }

        private void txbFoodID_TextChanged(object sender, EventArgs e)
        {
            //tu datagridviewFood -> tro den mot o -> tro den dong chua o do co gia tri IDCategory-> lay value
            if (dtgvFood.SelectedCells.Count > 0)
            {
            int id=(int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryID"].Value;
                Category category = CategoryDAO.Instance.GetCategoryByID(id);
                cbFoodCategory.SelectedItem = category;

                int index = -1;
                int i = 0;
                foreach(Category item in cbFoodCategory.Items)
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
    }
}