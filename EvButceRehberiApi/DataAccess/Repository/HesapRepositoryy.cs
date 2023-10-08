using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public class HesapRepository
    {
        public void Add(Hesaplar hesap)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {


                hesap.KayitTarihi = DateTime.Now;
                context.Hesaplar.Add(hesap);
                context.SaveChanges();
            }
        }

        public void Delete(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                Hesaplar hesap = context.Hesaplar.Where(n => n.ID == Id).First();

                context.Hesaplar.Remove(hesap);
                context.SaveChanges();
            }
        }


        public HesapModel GetEntity(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                var varlik = context.Hesaplar.Where(n => n.ID == Id).First();

                HesapModel hesap = new HesapModel();
                hesap.ID = varlik.ID;
                hesap.Name = varlik.Name;
                hesap.Description = varlik.Description;
                hesap.Miktar = varlik.Miktar;
                hesap.KullaniciID = varlik.KullaniciID;
                hesap.KayitTarihi = (DateTime)varlik.KayitTarihi;
                hesap.KayitYapan = varlik.KayitYapan;

                hesap.KayitTarihi = Convert.ToDateTime(varlik.KayitTarihi);



                return hesap;
            }

        }



        public List<HesapModel> GetAll()
        {

            using (EvButceRehberiEntities context = new EvButceRehberiEntities())//Using kullanımı newlenen nesneyi kullanıktan sonr siler
            {
                List<HesapModel> varliklar = new List<HesapModel>();
                foreach (var varlik in context.Hesaplar.ToList())
                {
                    varliklar.Add(new HesapModel
                    {
                        ID = varlik.ID,
                        Name = varlik.Name,
                        Description = varlik.Description,
                        Miktar = varlik.Miktar,
                        KullaniciID = varlik.KullaniciID,
                        KayitTarihi = Convert.ToDateTime(varlik.KayitTarihi),
                        KayitYapan = varlik.KayitYapan,

                    });
                }
                return varliklar;
            }

        }

        public void Update(Hesaplar varlik)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                Hesaplar varlikk = context.Hesaplar.Where(n => n.ID == varlik.ID).First();
                if (varlikk != null)
                {

                    varlikk.Name = varlik.Name;
                    varlikk.Description = varlik.Description;
                    varlikk.Miktar = varlik.Miktar;
                    varlikk.DegisiklikTarihi = DateTime.Now;
                }
              
                    context.SaveChanges();
                
            

            }
        }
    }
}
