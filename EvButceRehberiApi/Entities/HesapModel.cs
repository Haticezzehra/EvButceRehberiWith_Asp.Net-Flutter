using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class HesapModel:BaseEntity
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public Nullable<int> Miktar { get; set; }
        public Nullable<int> KullaniciID { get; set; }
      
        public virtual ICollection<HesapHareketleriModel> HesapHareketleri { get; set; }
        public virtual Kullanici Kullanici { get; set; }
    }
}
