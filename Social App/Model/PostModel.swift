import SwiftUI

struct PostModel : Identifiable {
    
    var id: String
    var title : String
    var category: String
    var pic: String
    var time : Date
    var user: UserModel
    var userString: String
    var appliedBy: Array<String>
<<<<<<< HEAD
=======
    var positionWanted: Array<String>
>>>>>>> bfeecfe42de735fc225e76a356a945437f92c829
}
