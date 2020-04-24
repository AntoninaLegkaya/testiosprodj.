import UIKit
import os.log

class Meal : NSObject, NSCoding  {
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Properties
    // used FileManager method urls - to look up URL for you app's documents directory. This directory where you app can save data for the user. Returns arrays
    //of URL and first parametr returns an optinal containing first URl in array
    // DocumentDerictory is static variable- only one copy of this properties can be? no matter how many instances of the Meals class you create
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("meals")
    
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    // required- modificator means this initializer must be implemented on every subclass
    // convinience- modificator means that this is a secondary initializer? and that it must call a designated initializer from the same class
    // question mark ?- means that this is a failable initializer that might return nil
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. if we cannot decode a name string, the initilizer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Mela object.", log: OSLog.default, type: .debug)
            return nil
        }
        // because photo is an optional properly of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Must call designated initializer.
        self.init( name: name, photo: photo, rating: rating)
    }


}
