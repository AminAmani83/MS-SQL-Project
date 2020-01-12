using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LibraryWebApp.BusinessLayer
{
    public class Book
    {
        public int bkId { get; set; }
        public string bkTitle { get; set; }
        public int bkPageCount { get; set; }
        public double bkPrice { get; set; }
        public int bkAuthorId { get; set; }
        public string bkAuthorFirstName { get; set; }
        public string bkAuthorLasstName { get; set; }
        public int bkTypeId { get; set; }
        public string bkTypeName { get; set; }
    }
}