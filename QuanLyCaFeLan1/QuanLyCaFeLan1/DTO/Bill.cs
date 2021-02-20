using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyCaFeLan1.DTO
{//them dau cham hoi cho phep data Null
    public class Bill
    {
        public Bill(int id,DateTime ? dateCheckin ,DateTime ? dateCheckOut,int status)
        {
            this.ID = iD;
            this.dateCheckIn = dateCheckin;
            this.DateCheckOut = dateCheckOut;
            this.Status = status;
        }
        public Bill(DataRow row)
        {
            this.ID = (int)row["iD"];
            this.dateCheckIn = (DateTime?)row["dateCheckin"];

            var dateCheckOutTemp = row["dateCheckOut"];
            if (dateCheckOutTemp.ToString() != "")
            this.DateCheckOut = (DateTime?)dateCheckOutTemp;

            this.Status =(int)row["status"];
        }
        private int iD;
        public int ID
        {
            get
            {
                return iD;
            }

            set
            {
                iD = value;
            }
        }

        private DateTime? dateCheckIn;
        public DateTime? DateCheckIn
        {
            get
            {
                return dateCheckIn;
            }

            set
            {
                dateCheckIn = value;
            }
        }

        private DateTime? dateCheckOut;
        public DateTime? DateCheckOut
        {
            get
            {
                return dateCheckOut;
            }

            set
            {
                dateCheckOut = value;
            }
        }

        private int status;
        public int Status
        {
            get
            {
                return status;
            }

            set
            {
                status = value;
            }
        }
    }
}
