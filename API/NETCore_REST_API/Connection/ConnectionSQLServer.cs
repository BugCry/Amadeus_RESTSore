using Microsoft.EntityFrameworkCore;
using NETCore_REST_API.Models;

namespace NETCore_REST_API.Connection
{
    public class ConnectionSQLServer:DbContext
    {
        public ConnectionSQLServer(DbContextOptions<ConnectionSQLServer> options) : base(options) 
        {
            //
        }

        public DbSet<Products> Products { get; set; }
    }
}
