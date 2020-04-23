import UIKit

class Meal  {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // Initialization
    
    init?(name: String, photo: UIImage?, rating: Int){
    
// Initialization should fail if there is no name or if rating is negative.
        
        // the name must not be empty
        guard !name.isEmpty else {
            return nil
            
        }
    
        guard (rating>=0) && (rating<=5) else {
            return nil
        }
        
        // Initialize store properties
           self.name = name
           self.photo = photo
           self.rating = rating
        }
}
