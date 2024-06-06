import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack (spacing: 10) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 10, height: 20)
                .padding()
                .background(Color(.white))
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
