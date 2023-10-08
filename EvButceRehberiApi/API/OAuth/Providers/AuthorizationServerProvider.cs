using DataAccess.Crypto;
using DataAccess.LoginProges;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;

namespace API.OAuth.Providers
{
    public class AuthorizationServerProvider : OAuthAuthorizationServerProvider
    {

        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }
        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            // validation işlemlerini ve kontrollerini bu kısımda yapıyoruz, örnek olması için sabit değerler verildi ,
            //bu kısmı db den okuyacak şekilde bir yapı kurgulanabilir.

            if (LoginProcess.LoginControl(context.UserName, /*Sifrele.Encrypt*/context.Password))
            {
                //eğer başarılı ise ClaimsIdentity (Kimlik oluşturuyoruz)
                var identity = new ClaimsIdentity(context.Options.AuthenticationType);
                identity.AddClaim(new Claim("sub", context.UserName));//Identity özelliklerini ekliyoruz.
                identity.AddClaim(new Claim("role", "admin"));

                context.Validated(identity);//Doğrulanmış olan kimliği context e ekliyoruz.
            }
            else
            {
                //eğer hata var ise bir hata mesajı gönderiyoruz. hata ve açıklaması şeklinde.
                context.SetError("Oturum Hatası", "Kullanıcı adı ve şifre hatalıdır");
            }
        }
    }
}