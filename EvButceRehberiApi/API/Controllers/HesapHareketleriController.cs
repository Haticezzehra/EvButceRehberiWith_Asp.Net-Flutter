using DataAccess;
using DataAccess.Repository;
using Entity;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace API.Controllers
{
    public class HesapHareketleriController : ApiController
    {
        HesapHareketleriRepository hesapHareketleri = new HesapHareketleriRepository();


        //GET api/<controller>?pageCount=0&name=jhon
        public IHttpActionResult GetAllKullanıcı()
        {
            var t = hesapHareketleri.GetAll();
            return Ok(t);
        }
       
        [HttpPost]
        [Route("api/Filtreli")]

        public IHttpActionResult GetAllFiltreli([FromBody] FiltreliParametre parametreler)
        {
            // Burada parametreler objesini kullanarak istediğiniz işlemi gerçekleştirin
            // Örneğin, parametreleri kullanarak veritabanından veri sorgulayabilirsiniz.

            // Örnek bir sorgu:
            var t = hesapHareketleri.GetAllFiltreli(parametreler);

            return Ok(t);
        }

        // GET api/<controller>/id
        public IHttpActionResult GetKullanıcı(int id)
        {
            HesapHareketleriModel gelir = hesapHareketleri.GetEntity(id);
            if (gelir == null)
            {
                return BadRequest("Bu Id'de kayıt bulunmuyor");
            }

            return Ok(gelir);
        }

        // POST api/<controller>
        public IHttpActionResult AddKullanıcı(HesapHareketleri hareket)
        {
            try
            {
                hesapHareketleri.Add(hareket);
            }
            catch
            {
                return BadRequest("gelir Eklenemedi");
            }


            return Ok("gelir Eklendi");
        }

        // PUT api/<controller>/id
        public IHttpActionResult Put(int id, HesapHareketleri hareket)
        {
            try
            {
                hareket.ID = id;
                hesapHareketleri.Update(hareket);
            }
            catch(Exception e)
            {
                return BadRequest("!!!!gelir Güncellenemedi");
            }

            return Ok("gelir Guncellendi");
        }

        // DELETE api/<controller>/id
        public IHttpActionResult Delete(int id)
        {
            try
            {
                hesapHareketleri.Delete(id);
            }
            catch
            {
                return BadRequest("gelir Silinemedi");
            }

            return Ok("gelir Silindi");
        }
    }
}
