using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace QuanLyCaFeLan1.DTO
{
    public class Menu
    {
        public Menu(string foodName,int count,float price,float totalPrice = 0)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price = price;
            this.TotalPrice = totalPrice;
        }
        public Menu(DataRow row)
        {
            this.FoodName=(string)row["Name"];
            this.Count =(int) row ["count"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
            this.TotalPrice = (float)Convert.ToDouble(row["totalPrice"].ToString());
        }
        private string foodName;
        public string FoodName
        {
            get
            {
                return foodName;
            }

            set
            {
                foodName = value;
            }
        }

        private int count;
        public int Count
        {
            get
            {
                return count;
            }

            set
            {
                count = value;
            }
        }

        private float price;
        public float Price
        {
            get
            {
                return price;
            }

            set
            {
                price = value;
            }
        }

        private float totalPrice;
        public float TotalPrice
        {
            get
            {
                return totalPrice;
            }

            set
            {
                totalPrice = value;
            }
        }
     
    }
}
