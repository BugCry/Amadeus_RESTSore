using System.ComponentModel.DataAnnotations;

namespace NETCore_REST_API.Models
{
    public class Users
    {
        public int Id { get; set; }

        public int TypeId { get; set; }
        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? TypeName { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Name { get; set; }
        [MaxLength(15, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? UserName { get; set; }
        [MaxLength(15, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Password { get; set; }

        public DateOnly BirthDate { get; set; }
        [MaxLength(50, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Address { get; set; }
        [MaxLength(50, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? City { get; set; }
        public int ZipCode { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Email { get; set; }

        public long? Phone { get; set; }

        public Boolean Status { get; set; }
    }
}
