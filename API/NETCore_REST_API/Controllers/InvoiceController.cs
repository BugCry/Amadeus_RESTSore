using Microsoft.AspNetCore.Mvc;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InvoiceController : ControllerBase
    {
        // GET: api/Invoice
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/Invoice/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/Invoice
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/Invoice/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/Invoice/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
