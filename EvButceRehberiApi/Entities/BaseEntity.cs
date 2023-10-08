using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
   public class BaseEntity
    {
        public string KayitYapan { get; set; }
        public DateTime KayitTarihi { get; set; }
        public string DegisiklikYapan { get; set; }
        public DateTime DegisiklikTarihi { get; set; }
    }
}
