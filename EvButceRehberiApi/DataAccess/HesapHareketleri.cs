//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataAccess
{
    using System;
    using System.Collections.Generic;
    
    public partial class HesapHareketleri
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public Nullable<int> HesapID { get; set; }
        public Nullable<int> KullaniciID { get; set; }
        public Nullable<int> Miktar { get; set; }
        public string KayitYapan { get; set; }
        public Nullable<System.DateTime> KayitTarihi { get; set; }
        public string DegisiklikYapan { get; set; }
        public Nullable<System.DateTime> DegisiklikTarihi { get; set; }
        public string HareketTuru { get; set; }
    
        public virtual Hesaplar Hesaplar { get; set; }
        public virtual Kullanici Kullanici { get; set; }
    }
}
