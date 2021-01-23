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
//    var positionWanted: Array<String>
}
