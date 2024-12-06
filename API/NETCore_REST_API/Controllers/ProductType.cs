using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductTypeController : ControllerBase
    {
        public readonly string? con;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public ProductTypeController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("StringConnection");
        }

        // GET: api/ProductType
        [HttpGet]
        public IEnumerable<ProductsType> Get()
        {
            List<ProductsType> products = new List<ProductsType>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from ProductsTypes", connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ProductsType prodt = new ProductsType
                            {
                                Id = Convert.ToInt32(reader["prodt_id"]),
                                Name = Convert.ToString(reader["prodt_name"]),
                                Description = Convert.ToString(reader["prodt_description"]),
                                Status = Convert.ToBoolean(reader["prodt_status"])
                            };

                            products.Add(prodt);
                        }
                    }
                }
            }
            return products;
        }

        // GET api/ProductType/5
        [HttpGet("{id}")]
        public IEnumerable<ProductsType> Get(int id)
        {
            List<ProductsType> products = new List<ProductsType>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from ProductsTypes where prodt_id = " + id, connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ProductsType prodt = new ProductsType
                            {
                                Id = Convert.ToInt32(reader["prodt_id"]),
                                Name = Convert.ToString(reader["prodt_name"]),
                                Description = Convert.ToString(reader["prodt_description"]),
                                Status = Convert.ToBoolean(reader["prodt_status"])
                            };

                            products.Add(prodt);
                        }
                    }
                }
            }
            return products;
        }

        // POST api/ProductType
        [HttpPost]
        public JsonResult Post([FromBody] ProductsType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("InsertProductType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prodt_name", prod.Name);
                    command.Parameters.AddWithValue("@prodt_description", prod.Description);
                    command.Parameters.AddWithValue("@prodt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Added Successfully");
        }

        // PUT api/ProductType/5
        [HttpPut("{id}")]
        public JsonResult Put(int id, [FromBody] ProductsType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("UpdateProductType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prodt_id", id);
                    command.Parameters.AddWithValue("@prodt_name", prod.Name);
                    command.Parameters.AddWithValue("@prodt_description", prod.Description);
                    command.Parameters.AddWithValue("@prodt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Modified Successfully");
        }

        // DELETE api/ProductType/delete/5
        [HttpPost("delete/{id}")]
        public JsonResult Delete(int id, [FromBody] ProductsType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("DeleteProductType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prodt_id", id);
                    command.Parameters.AddWithValue("@prodt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Inactive Successfully");
        }
    }
}
