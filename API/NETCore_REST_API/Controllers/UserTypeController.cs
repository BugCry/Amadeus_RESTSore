using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserTypeController
    {
        public readonly string? con;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public UserTypeController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("StringConnection");
        }

        // GET: api/UserType
        [HttpGet]
        public IEnumerable<UsersType> Get()
        {
            List<UsersType> products = new List<UsersType>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from UserTypes", connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UsersType usrt = new UsersType
                            {
                                Id = Convert.ToInt32(reader["usrt_id"]),
                                Name = Convert.ToString(reader["usrt_name"]),
                                Description = Convert.ToString(reader["usrt_description"]),
                                Customer = Convert.ToBoolean(reader["usrt_customer"]),
                                Admin = Convert.ToBoolean(reader["usrt_admin"]),
                                Status = Convert.ToBoolean(reader["usrt_status"])
                            };

                            products.Add(usrt);
                        }
                    }
                }
            }
            return products;
        }

        // GET api/UserType/5
        [HttpGet("{id}")]
        public IEnumerable<UsersType> Get(int id)
        {
            List<UsersType> products = new List<UsersType>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from UsersTypes where usrt_id = " + id, connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UsersType usrt = new UsersType
                            {
                                Id = Convert.ToInt32(reader["usrt_id"]),
                                Name = Convert.ToString(reader["usrt_name"]),
                                Description = Convert.ToString(reader["usrt_description"]),
                                Customer = Convert.ToBoolean(reader["usrt_customer"]),
                                Admin = Convert.ToBoolean(reader["usrt_admin"]),
                                Status = Convert.ToBoolean(reader["usrt_status"])
                            };

                            products.Add(usrt);
                        }
                    }
                }
            }
            return products;
        }

        // POST api/UserType
        [HttpPost]
        public JsonResult Post([FromBody] UsersType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("InsertUserType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usrt_name", prod.Name);
                    command.Parameters.AddWithValue("@usrt_description", prod.Description);
                    command.Parameters.AddWithValue("@usrt_customer", prod.Customer);
                    command.Parameters.AddWithValue("@usrt_admin", prod.Admin);
                    command.Parameters.AddWithValue("@usrt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Added Successfully");
        }

        // PUT api/UserType/5
        [HttpPut("{id}")]
        public JsonResult Put(int id, [FromBody] UsersType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("UpdateUserType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usrt_id", id);
                    command.Parameters.AddWithValue("@usrt_name", prod.Name);
                    command.Parameters.AddWithValue("@usrt_description", prod.Description);
                    command.Parameters.AddWithValue("@usrt_customer", prod.Customer);
                    command.Parameters.AddWithValue("@usrt_admin", prod.Admin);
                    command.Parameters.AddWithValue("@usrt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Modified Successfully");
        }

        // DELETE api/UserType/delete/5
        [HttpPost("delete/{id}")]
        public JsonResult Delete(int id, [FromBody] UsersType prod)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("DeleteUserType", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usrt_id", id);
                    command.Parameters.AddWithValue("@usrt_status", prod.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Inactive Successfully");
        }
    }
}
