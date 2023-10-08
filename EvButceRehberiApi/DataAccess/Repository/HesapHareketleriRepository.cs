using Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public class HesapHareketleriRepository
    {

        public void Add(HesapHareketleri hareket)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {

                int yil = DateTime.Now.Year;
                int ay = DateTime.Now.Month;
                int gun = DateTime.Now.Day;

                DateTime date = new DateTime(yil, ay, gun);

                hareket.KayitTarihi = date;
                context.HesapHareketleri.Add(hareket);
                context.SaveChanges();
            }
        }

        public void Delete(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                HesapHareketleri gelir = context.HesapHareketleri.Where(n => n.ID == Id).First();

                context.HesapHareketleri.Remove(gelir);
                context.SaveChanges();
            }
        }


        public HesapHareketleriModel GetEntity(int Id)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                var gelir = context.HesapHareketleri.Where(n => n.ID == Id).First();

                HesapHareketleriModel gelirr = new HesapHareketleriModel();
                gelirr.ID = gelir.ID;
                gelirr.Name = gelir.Name;
                gelirr.Description = gelir.Description;
                gelirr.HesapID = gelir.HesapID;
                gelirr.HesapAdi = context.Hesaplar.Where(n => n.ID == gelir.HesapID).First().Name;
                gelirr.Miktar = gelir.Miktar;
                gelirr.KullaniciID = gelir.KullaniciID;
                gelirr.HareketTuru = gelir.HareketTuru;

                gelirr.KayitTarihi = Convert.ToDateTime(gelir.KayitTarihi);
                gelirr.KayitYapan = gelir.KayitYapan;





                return gelirr;
            }

        }

        public Object GetAllFiltreli(FiltreliParametre parametreler)
        {
            DataTable data;
           if (parametreler==null)
            {
                string sqlSrg = "SELECT hh.*, h.Name as HesapAdi FROM HesapHareketleri hh INNER JOIN Hesaplar h ON hh.HesapId = h.Id";
                 data = SqlQuery.GetData(sqlSrg);

                return new
                {
                    data,
                };
            }

            // SQL sorgusunu oluştur
            string sqlSorgusu = "SELECT hh.*, h.Name as HesapAdi FROM HesapHareketleri hh INNER JOIN Hesaplar h ON hh.HesapId = h.Id WHERE 1 = 1";

            if (!string.IsNullOrEmpty(parametreler.BaslangicTarihi))
            {

                sqlSorgusu += $@" AND hh.KayitTarihi >= '{parametreler.BaslangicTarihi}'";

            }

            if (!string.IsNullOrEmpty(parametreler.BitisTarihi))
            {
                sqlSorgusu += $@" AND hh.KayitTarihi <= '{parametreler.BitisTarihi}'";
            }

            if (!string.IsNullOrEmpty(parametreler.HareketTuru))
            {
                sqlSorgusu += $@" AND hh.HareketTuru = '{parametreler.HareketTuru}'";
            }

            if (parametreler.HesapId > 0)
            {
                sqlSorgusu += $@" AND hh.HesapId = {parametreler.HesapId}";
            }

             data = SqlQuery.GetData(sqlSorgusu);

            return new
            {
                data,
            };
        }
        public List<HesapHareketleriModel> GetAll(string query = "", int? pageCount = 0)
        {

            using (EvButceRehberiEntities context = new EvButceRehberiEntities())//Using kullanımı newlenen nesneyi kullanıktan sonr siler
            {
                List<HesapHareketleriModel> gelirler = new List<HesapHareketleriModel>();
                foreach (var gelir in context.HesapHareketleri.ToList())
                {
                    gelirler.Add(new HesapHareketleriModel
                    {
                        ID = gelir.ID,
                        Name = gelir.Name,
                        KayitTarihi = Convert.ToDateTime(gelir.KayitTarihi),
                        KayitYapan = gelir.KayitYapan,
                        Description = gelir.Description,
                        Miktar = gelir.Miktar,
                        HesapID = gelir.HesapID,
                        KullaniciID = gelir.KullaniciID,
                        HareketTuru = gelir.HareketTuru,
                        HesapAdi = context.Hesaplar.Where(n => n.ID == gelir.HesapID).First().Name,
                    });
                }
                return gelirler;
            }

        }

        public void Update(HesapHareketleri gelir)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())
            {
                HesapHareketleri gelirr = context.HesapHareketleri.Where(n => n.ID == gelir.ID).First();
                if (gelirr != null)
                {
                    gelirr.DegisiklikTarihi = DateTime.Now;
                    gelirr.DegisiklikYapan = gelir.DegisiklikYapan;
                    gelirr.Description = gelir.Description;
                    gelirr.Name = gelir.Name;
                    gelirr.HesapID = gelir.HesapID;
                    gelirr.Miktar = gelir.Miktar;
                    gelirr.HareketTuru = gelir.HareketTuru;
                }
                context.SaveChanges();
            }
        }
    }
}

