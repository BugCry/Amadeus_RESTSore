using System.ComponentModel.DataAnnotations;

namespace NETCore_REST_API.Models
{
    public class Products
    {
        public int Id { get; set; }
        
        public int TypeId { get; set; }
        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? TypeName { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Name { get; set; }
        
        public decimal Price { get; set; }
        
        [MaxLength(15, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Condition { get; set; }
        
        [MaxLength(250, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Description { get; set; }
        
        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? Brand { get; set; }
        
        public Boolean Status { get; set; }
    }
}
