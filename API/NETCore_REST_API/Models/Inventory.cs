using System.ComponentModel.DataAnnotations;

namespace NETCore_REST_API.Models
{
    public class Inventory
    {
        public int Id { get; set; }

        public int ProductId { get; set; }
        
        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? ProductName { get; set; }
       
        [MaxLength(15, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? ProductCondition { get; set; }
        public decimal ProductPrice { get; set; }
        public int ProductTypeId { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? ProductTypeName { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]

        public int? Quantity { get; set; }
        public int UserId { get; set; }

        [MaxLength(150, ErrorMessage = "The field {0] must be max {1} characters")]
        public string? UserName { get; set; }
        public DateTime? ModificationDate { get; set; }

        public Boolean Status { get; set; }
    }
}
