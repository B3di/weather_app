import SwiftUI

func timeConverter(_ timestamp: Double, format: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let time = dateFormatter.string(from: date)
    return time
}
