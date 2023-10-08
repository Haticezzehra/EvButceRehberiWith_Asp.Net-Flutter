
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.LoginProges
{
   public class LoginProcess
    {
        public static bool LoginControl(string kullanıcıAdı, string parola)
        {
            using (EvButceRehberiEntities context = new EvButceRehberiEntities())//Using kullanımı newlenen nesneyi kullanıktan sonr siler
            {
                Kullanici kullanici = context.Kullanici.FirstOrDefault(n => n.KullaniciAdi == kullanıcıAdı && n.Sifre == parola);
                if (kullanici != null)
                    return true;
            }
            return false;
        }
    }
}
