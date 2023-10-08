using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Kullanici:BaseEntity
    {
        public int ID { get; set; }
        public string KullaniciAdi { get; set; }
        public string Sifre { get; set; }
        public virtual ICollection<HesapHareketleriModel> HesapHareketleri { get; set; }
     
        public virtual ICollection<HesapModel> Hesaplar { get; set; }

    }
}
