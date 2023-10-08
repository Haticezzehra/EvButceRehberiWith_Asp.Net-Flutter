using DataAccess;
using DataAccess.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace API.Controllers
{
    
    public class KullaniciController : ApiController
    {
        KullaniciRepository kullanıcıRepository = new KullaniciRepository();


        //GET api/<controller>?pageCount=0&name=jhon
        public IHttpActionResult GetAllKullanıcı(int? pageCount = 0, string name = "")
        {
            var t = kullanıcıRepository.GetAll();
            return Ok(t);
        }

        // GET api/<controller>/id
        public IHttpActionResult GetKullanıcı(int id)
        {
            Kullanici kullanıcı = kullanıcıRepository.GetEntity(id);
            if (kullanıcı == null)
            {
                return BadRequest("Bu Id'de kayıt bulunmuyor");
            }

            return Ok(kullanıcı);
        }

        // POST api/<controller>
        public IHttpActionResult AddKullanıcı(Kullanici kullanıcı)
        {
            try
            {
                kullanıcıRepository.Add(kullanıcı);
            }
            catch
            {
                return BadRequest("Kitap Eklenemedi");
            }


            return Ok("Kitap Eklendi");
        }

        // PUT api/<controller>/id
        public IHttpActionResult Put(int id, Kullanici kullanıcı)
        {
            try
            {
                kullanıcı.ID = id;
                kullanıcıRepository.Update(kullanıcı);
            }
            catch
            {
                return BadRequest("!!!!Kullanıcı Güncellenemedi");
            }

            return Ok("Kulanıcı Guncellendi");
        }

        // DELETE api/<controller>/id
        public IHttpActionResult Delete(int id)
        {
            try
            {
                kullanıcıRepository.Delete(id);
            }
            catch
            {
                return BadRequest("Kullanıcı Silinemedi");
            }

            return Ok("Kullanıcı Silindi");
        }
    }
}