import Foundation
import FirebaseFirestoreSwift

struct Habit: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var dateCreated: Date
    var streak: Int = 0
    var finishedDates: [Date] = []
}
