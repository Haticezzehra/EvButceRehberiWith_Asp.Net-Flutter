using DataAccess;
using DataAccess.Repository;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace API.Controllers
{
    public class HesapController : ApiController
    {
        HesapRepository hesapRepository = new HesapRepository();


        //GET api/<controller>?pageCount=0&name=jhon
        public IHttpActionResult GetAllHesap(int? pageCount = 0, string name = "")
        {
            var t = hesapRepository.GetAll();
            return Ok(t);
        }

        // GET api/<controller>/id
        public IHttpActionResult GetHesap(int id)
        {
            HesapModel varlik = hesapRepository.GetEntity(id);
            if (varlik == null)
            {
                return BadRequest("Bu Id'de kayıt bulunmuyor");
            }

            return Ok(varlik);
        }

        // POST api/<controller>
        public IHttpActionResult AddHesap(Hesaplar hesap)
        {
            try
            {
                hesapRepository.Add(hesap);
            }
            catch
            {
                return BadRequest("Hesap Eklenemedi");
            }


            return Ok("Hesap Eklendi");
        }

        // PUT api/<controller>/id
        public IHttpActionResult Put(int id, Hesaplar hesap)
        {
            try
            {
                hesap.ID = id;
                hesapRepository.Update(hesap);
            }
            catch
            {
                return BadRequest("!!!!Hesap Güncellenemedi");
            }

            return Ok("Hesap Guncellendi");
        }

        // DELETE api/<controller>/id
        public IHttpActionResult Delete(int id)
        {
            try
            {
                hesapRepository.Delete(id);
            }
            catch
            {
                return BadRequest("Hesap Silinemedi");
            }

            return Ok("Hesap Silindi");
        }
    }
}