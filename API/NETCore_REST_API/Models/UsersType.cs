using System.ComponentModel.DataAnnotations;

namespace NETCore_REST_API.Models
{
    public class UsersType
    {
        
        public int Id { get; set; }
        
        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Name { get; set; }
        
        [MaxLength(250, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Description { get; set; }
        
        public Boolean Customer { get; set; }
        public Boolean Admin { get; set; }
        public Boolean Status { get; set; }
    }

}
