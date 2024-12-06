using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InventoryController : ControllerBase
    {
        public readonly string? con;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public InventoryController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("StringConnection");
        }

        // GET: api/Inventory
        [HttpGet]
        public IEnumerable<Inventory> Get()
        {
            List<Inventory> Inventory = new List<Inventory>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from vInventory", connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Inventory inv = new Inventory
                            {
                                Id = Convert.ToInt32(reader["inv_id"]),
                                ProductId = Convert.ToInt32(reader["prod_id"]),
                                Quantity = Convert.ToInt32(reader["inv_quantity"]),
                                ProductName = Convert.ToString(reader["prod_name"]),
                                ProductCondition = Convert.ToString(reader["prod_condition"]),
                                ProductPrice = Convert.ToDecimal(reader["prod_price"]),
                                ProductTypeId = Convert.ToInt32(reader["prodt_id"]),
                                ProductTypeName = Convert.ToString(reader["prodt_name"]),
                                UserId = Convert.ToInt32(reader["usr_id"]),
                                UserName = Convert.ToString(reader["usr_name"]),
                                ModificationDate = Convert.ToDateTime(reader["inv_mod_date"]),
                                Status = Convert.ToBoolean(reader["inv_state"])
                            };

                            Inventory.Add(inv);
                        }
                    }
                }
            }
            return Inventory;
        }

        // GET api/Inventory/5
        [HttpGet("{id}")]
        public IEnumerable<Inventory> Get(int id)
        {
            List<Inventory> Inventory = new List<Inventory>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from Inventory where inv_id = " + id, connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Inventory inv = new Inventory
                            {
                                Id = Convert.ToInt32(reader["inv_id"]),
                                ProductId = Convert.ToInt32(reader["prod_id"]),
                                ProductName = Convert.ToString(reader["prod_name"]),
                                ProductCondition = Convert.ToString(reader["prod_condition"]),
                                ProductPrice = Convert.ToDecimal(reader["prod_price"]),
                                ProductTypeId = Convert.ToInt32(reader["prodt_id"]),
                                ProductTypeName = Convert.ToString(reader["prodt_name"]),
                                UserId = Convert.ToInt32(reader["usr_id"]),
                                UserName = Convert.ToString(reader["usr_name"]),
                                ModificationDate = Convert.ToDateTime(reader["inv_mod_date"]),
                                Status = Convert.ToBoolean(reader["inv_state"])
                            };

                            Inventory.Add(inv);
                        }
                    }
                }
            }
            return Inventory;
        }

        // POST api/Inventory
        [HttpPost]
        public JsonResult Post([FromBody] Inventory inv)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("InsertInventory", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prod_id", inv.ProductId);
                    command.Parameters.AddWithValue("@inv_quantity", inv.Quantity);
                    command.Parameters.AddWithValue("@usr_id", inv.UserId); 
                    command.Parameters.AddWithValue("@inv_mod_date", DateTime.Now);
                    command.Parameters.AddWithValue("@inv_state", inv.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Added Successfully");
        }

        // PUT api/Inventory/5
        [HttpPut("{id}")]
        public JsonResult Put(int id, [FromBody] Inventory inv)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("UpdateInventory", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@inv_id", id);
                    command.Parameters.AddWithValue("@prod_id", inv.ProductId);
                    command.Parameters.AddWithValue("@inv_quantity", inv.Quantity);
                    command.Parameters.AddWithValue("@usr_id", inv.UserId);
                    command.Parameters.AddWithValue("@inv_state", inv.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Modified Successfully");
        }

        // DELETE api/Inventory/delete/5
        [HttpPost("delete/{id}")]
        public JsonResult Delete(int id, [FromBody] Inventory inv)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("DeleteInventory", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@inv_id", id);
                    command.Parameters.AddWithValue("@inv_state", inv.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Deleted Successfully");
        }
    }
}
