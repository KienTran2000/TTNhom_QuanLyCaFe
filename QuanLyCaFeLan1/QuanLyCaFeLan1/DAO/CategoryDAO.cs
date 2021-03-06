﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using QuanLyCaFeLan1.DTO;
namespace QuanLyCaFeLan1.DAO
{
    class CategoryDAO
    {
        private static CategoryDAO instance;
      
        public static CategoryDAO Instance
        {
            get { if(instance==null)instance = new CategoryDAO();return CategoryDAO.instance; }
            private set { CategoryDAO.instance = value; }
        }


        private CategoryDAO() { }
        public List<Category> GetListCategory()
        {
            List<Category> list = new List<Category>();
            string query = "select * from FoodCategory";

            DataTable data = DataProvider.Instance.ExcuteQuery(query);
            foreach(DataRow item in data.Rows)
            {
                Category category = new Category(item);
                list.Add(category);
            }
            return list;
        }
        public Category GetCategoryByID(int id)
        {
            Category category = null;
            string query = "select * from FoodCategory where id = "+id;
            DataTable data = DataProvider.Instance.ExcuteQuery(query);
            foreach(DataRow item in data.Rows)
            {
                category = new Category(item);
                return category;
            }
            return category;
        }


        // insert delete update Duy
        public bool InsertCategory(string name)
        {
            string query = string.Format("Insert dbo.FoodCategory ( name)VALUES (N'{0}')", name);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
        public bool UpdateCategory(int idCategory, string name)
        {
            string query = string.Format("UPDATE dbo.FoodCategory SET name = N'{0}' WHERE id = {1}", name, idCategory);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }
        public bool DeleteCategory(int idCategory)
        {
            string query = string.Format("Delete dbo.FoodCategory where id = {0}", idCategory);
            int result = DataProvider.Instance.ExcuteNonQuery(query);
            return result > 0;
        }

    }
}
