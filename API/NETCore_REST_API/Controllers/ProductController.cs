using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        public readonly string? con;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public ProductController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("StringConnection");
        }

        // GET: api/Product
        [HttpGet]
        public IEnumerable<Products> Get()
        {
            List<Products> products = new List<Products>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from vProducts", connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader()) 
                    {
                        while (reader.Read())
                        {
                            Products prod = new Products
                            {
                                Id = Convert.ToInt32(reader["prod_id"]),
                                TypeId = Convert.ToInt32(reader["prodt_id"]),
                                TypeName = Convert.ToString(reader["prodt_name"]),
                                Name = Convert.ToString(reader["prod_name"]),
                                Price = Convert.ToDecimal(reader["prod_price"]),
                                Condition = Convert.ToString(reader["prod_condition"]),
                                Description = Convert.ToString(reader["prod_description"]),
                                Brand = Convert.ToString(reader["prod_brand"]),
                                Status = Convert.ToBoolean(reader["prod_status"])
                            };

                            products.Add(prod);
                        }
                    }
                }
            }
            return products;
        }

        // GET api/Product/5
        [HttpGet("{id}")]
        public IEnumerable<Products> Get(int id)
        {
            List<Products> products = new List<Products>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from Products where prod_id = " + id, connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Products prod = new Products
                            {
                                Id = Convert.ToInt32(reader["prod_id"]),
                                TypeId = Convert.ToInt32(reader["prodt_id"]),
                                Name = Convert.ToString(reader["prod_name"]),
                                Price = Convert.ToDecimal(reader["prod_price"]),
                                Condition = Convert.ToString(reader["prod_condition"]),
                                Description = Convert.ToString(reader["prod_description"]),
                                Brand = Convert.ToString(reader["prod_brand"]),
                                Status = Convert.ToBoolean(reader["prod_status"])
                            };

                            products.Add(prod);
                        }
                    }
                }
            }
            return products;
        }

        // POST api/Product
        [HttpPost]
        public JsonResult Post([FromBody] Products prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("InsertProduct", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prodt_id", prod.TypeId);
                    command.Parameters.AddWithValue("@prod_name", prod.Name);
                    command.Parameters.AddWithValue("@prod_price", prod.Price);
                    command.Parameters.AddWithValue("@prod_condition", prod.Condition);
                    command.Parameters.AddWithValue("@prod_description", prod.Description);
                    command.Parameters.AddWithValue("@prod_brand", prod.Brand);
                    command.Parameters.AddWithValue("@prod_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Added Successfully");
        }

        // PUT api/Product/5
        [HttpPut("{id}")]
        public JsonResult Put(int id, [FromBody] Products prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("UpdateProduct", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prod_id", id);
                    command.Parameters.AddWithValue("@prodt_id", prod.TypeId);
                    command.Parameters.AddWithValue("@prod_name", prod.Name);
                    command.Parameters.AddWithValue("@prod_price", prod.Price);
                    command.Parameters.AddWithValue("@prod_condition", prod.Condition);
                    command.Parameters.AddWithValue("@prod_description", prod.Description);
                    command.Parameters.AddWithValue("@prod_brand", prod.Brand);
                    command.Parameters.AddWithValue("@prod_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Modified Successfully");
        }

        // DELETE api/Product/delete/5
        [HttpPost("delete/{id}")]
        public JsonResult Delete(int id, [FromBody] Products prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                 connection.Open();
                using (SqlCommand command = new ("DeleteProduct", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prod_id", id);
                    command.Parameters.AddWithValue("@prod_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Deleted Successfully");
        }
    }
}
