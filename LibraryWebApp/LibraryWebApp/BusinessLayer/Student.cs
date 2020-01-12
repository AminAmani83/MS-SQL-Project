using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LibraryWebApp.BusinessLayer
{
    public class Student
    {
        public int stId { get; set; }
        public string stFirstName { get; set; }
        public string stLastName { get; set; }
        public string stBirthDate { get; set; }
        public string stGender { get; set; }
        public string stClass { get; set; }
    }
}