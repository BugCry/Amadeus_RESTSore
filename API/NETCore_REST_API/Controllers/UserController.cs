using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        public readonly string? con;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public UserController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("StringConnection");
        }

        // GET: api/User
        [HttpGet]
        public IEnumerable<Users> Get()
        {
            List<Users> usructs = new List<Users>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from vUsers", connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Users usr = new Users
                            {
                                Id = Convert.ToInt32(reader["usr_id"]),
                                TypeId = Convert.ToInt32(reader["usrt_id"]),
                                TypeName = Convert.ToString(reader["usrt_name"]),
                                Name = Convert.ToString(reader["usr_name"]),
                                UserName = Convert.ToString(reader["usr_username"]),
                                Password = Convert.ToString(reader["usr_password"]),
                                BirthDate = DateOnly.FromDateTime(Convert.ToDateTime(reader["usr_birthdate"])),
                                Address = Convert.ToString(reader["usr_address"]),
                                City = Convert.ToString(reader["usr_city"]),
                                ZipCode = Convert.ToInt32(reader["usr_zipcode"]),
                                Email = Convert.ToString(reader["usr_email"]),
                                Phone = Convert.ToInt64(reader["usr_phone"]),
                                Status = Convert.ToBoolean(reader["usr_status"])
                            };

                            usructs.Add(usr);
                        }
                    }
                }
            }
            return usructs;
        }

        // GET api/User/5
        [HttpGet("{id}")]
        public IEnumerable<Users> Get(int id)
        {
            List<Users> usructs = new List<Users>();

            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("select * from Users vUsers usr_id = " + id, connection))
                {
                    //command.CommandType=System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Users usr = new Users
                            {
                                Id = Convert.ToInt32(reader["usr_id"]),
                                TypeId = Convert.ToInt32(reader["usrt_id"]),
                                TypeName = Convert.ToString(reader["usrt_name"]),
                                Name = Convert.ToString(reader["usr_name"]),
                                UserName = Convert.ToString(reader["usr_username"]),
                                Password = Convert.ToString(reader["usr_password"]),
                                BirthDate = DateOnly.FromDateTime(Convert.ToDateTime(reader["usr_birthdate"])),
                                Address = Convert.ToString(reader["usr_address"]),
                                City = Convert.ToString(reader["usr_city"]),
                                ZipCode = Convert.ToInt32(reader["usr_address"]),
                                Email = Convert.ToString(reader["usr_email"]),
                                Phone = Convert.ToInt64(reader["usr_phone"]),
                                Status = Convert.ToBoolean(reader["usr_status"])
                            };

                            usructs.Add(usr);
                        }
                    }
                }
            }
            return usructs;
        }

        // POST api/User
        [HttpPost]
        public JsonResult Post([FromBody] Users usr)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("InsertUser", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usrt_id", usr.TypeId);
                    command.Parameters.AddWithValue("@usr_name", usr.Name);
                    command.Parameters.AddWithValue("@usr_username", usr.UserName);
                    command.Parameters.AddWithValue("@usr_password", usr.Password);
                    command.Parameters.AddWithValue("@usr_birthdate", usr.BirthDate);
                    command.Parameters.AddWithValue("@usr_address", usr.Address);
                    command.Parameters.AddWithValue("@usr_city", usr.City);
                    command.Parameters.AddWithValue("@usr_zipcode", usr.ZipCode);
                    command.Parameters.AddWithValue("@usr_email", usr.Email);
                    command.Parameters.AddWithValue("@usr_phone", usr.Phone);
                    command.Parameters.AddWithValue("@usr_status", usr.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Added Successfully");
        }

        // PUT api/User/5
        [HttpPut("{id}")]
        public JsonResult Put(int id, [FromBody] Users usr)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("UpdateUser", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usr_id", id);
                    command.Parameters.AddWithValue("@usrt_id", usr.TypeId);
                    command.Parameters.AddWithValue("@usr_name", usr.Name);
                    command.Parameters.AddWithValue("@usr_username", usr.UserName);
                    command.Parameters.AddWithValue("@usr_password", usr.Password);
                    command.Parameters.AddWithValue("@usr_birthdate", usr.BirthDate);
                    command.Parameters.AddWithValue("@usr_address", usr.Address);
                    command.Parameters.AddWithValue("@usr_city", usr.City);
                    command.Parameters.AddWithValue("@usr_zipcode", usr.ZipCode);
                    command.Parameters.AddWithValue("@usr_email", usr.Email);
                    command.Parameters.AddWithValue("@usr_phone", usr.Phone);
                    command.Parameters.AddWithValue("@usr_status", usr.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Modified Successfully");
        }

        // DELETE api/User/delete/5
        [HttpPost("delete/{id}")]
        public JsonResult Delete(int id, [FromBody] UsersType usr)
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                connection.Open();
                using (SqlCommand command = new("DeleteUser", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@usr_id", id);
                    command.Parameters.AddWithValue("@usr_status", usr.Status);
                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Deleted Successfully");
        }
    }
}
