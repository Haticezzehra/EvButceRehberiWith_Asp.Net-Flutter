using DataAccess.Crypto;

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public  class KullaniciRepository
    {
        public void Add(Kullanici kullanıcı)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {


                kullanıcı.Sifre = Sifrele.Encrypt(kullanıcı.Sifre);
                kullanıcı.KayitTarihi = DateTime.Now;
                context.Kullanici.Add(kullanıcı);
                context.SaveChanges();
            }
        }

        public void Delete(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                Kullanici kullanıcı = context.Kullanici.Where(n => n.ID == Id).First();

                context.Kullanici.Remove(kullanıcı);
                context.SaveChanges();
            }
        }


        public Kullanici GetEntity(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities()) 
            {
                var kullanıcı = context.Kullanici.Where(n => n.ID == Id).First();
                kullanıcı.Sifre = kullanıcı.Sifre; // Sifrele.Descrypt(kullanıcı.Parola);
               Kullanici modelKullanici = new Kullanici();
                modelKullanici.ID = kullanıcı.ID;
                modelKullanici.KayitTarihi = Convert.ToDateTime(kullanıcı.KayitTarihi);
                modelKullanici.KayitYapan = kullanıcı.KayitYapan;
                modelKullanici.KullaniciAdi = kullanıcı.KullaniciAdi;
                modelKullanici.Sifre = kullanıcı.Sifre;
               
                return modelKullanici;
            }

        }

        public List<Kullanici> GetAll()
        {
            List<Kullanici> kullanicilar = new List<Kullanici>();
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())//Using kullanımı newlenen nesneyi kullanıktan sonr siler
            {
              
                foreach (var i in context.Kullanici.ToList())
                {
                    kullanicilar.Add(new Kullanici
                    {
                        ID = i.ID,
                       KullaniciAdi=i.KullaniciAdi,
                       Sifre= i.Sifre //Sifrele.Descrypt(i.Parola)


                    });
                }
               
            }
            return kullanicilar;

        }

        public void Update(Kullanici entity)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                Kullanici kullanici = context.Kullanici.Where(n => n.ID == entity.ID).First();
                if (kullanici != null)
                {
                    kullanici.KullaniciAdi = entity.KullaniciAdi;
                    kullanici.Sifre = Sifrele.Encrypt(entity.Sifre);
                    kullanici.DegisiklikTarihi = DateTime.Now;  
                    
                }
                context.SaveChanges();
            }
        }
    }
}
